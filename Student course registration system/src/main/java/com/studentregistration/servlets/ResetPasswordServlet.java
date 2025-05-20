package com.studentregistration.servlets;

import com.studentregistration.dao.StudentDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

@WebServlet("/resetpassword")
public class ResetPasswordServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(ResetPasswordServlet.class.getName());
    private StudentDAO studentDao;
    private String passwordChangeHistoryFilePath;

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            String studentsPath = getServletContext().getRealPath("/WEB-INF/data/students.txt");
            studentDao = new StudentDAO(studentsPath);
            passwordChangeHistoryFilePath = getServletContext().getRealPath("/WEB-INF/data/password_change_history.txt");
            initializePasswordChangeHistoryFile();
        } catch (Exception e) {
            throw new ServletException("Failed to initialize StudentDAO or password change history file", e);
        }
    }

    private void initializePasswordChangeHistoryFile() {
        File file = new File(passwordChangeHistoryFilePath);
        if (!file.exists()) {
            try {
                file.getParentFile().mkdirs();
                file.createNewFile();
                logger.info("Initialized password change history file: " + passwordChangeHistoryFilePath);
            } catch (IOException e) {
                logger.severe("Failed to initialize password change history file: " + e.getMessage());
                throw new RuntimeException("Failed to initialize password change history file", e);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");
        String confirmNewPassword = request.getParameter("confirmNewPassword");

        // Validate inputs
        if (email == null || email.trim().isEmpty()) {
            logger.warning("Email is missing or empty for password reset");
            request.setAttribute("error", "Email is required");
            request.getRequestDispatcher("change-password.jsp").forward(request, response);
            return;
        }

        if (newPassword == null || newPassword.trim().isEmpty()) {
            logger.warning("New password is missing or empty");
            request.setAttribute("error", "New password is required");
            request.getRequestDispatcher("change-password.jsp").forward(request, response);
            return;
        }

        if (confirmNewPassword == null || !newPassword.equals(confirmNewPassword)) {
            logger.warning("Password confirmation does not match");
            request.setAttribute("error", "New password and confirm password do not match");
            request.getRequestDispatcher("change-password.jsp").forward(request, response);
            return;
        }

        try {
            // Check if the email exists in students.txt
            if (studentDao.getStudentByEmail(email) == null) {
                logger.warning("No student found with email: " + email);
                request.setAttribute("error", "No account found with this email");
                request.getRequestDispatcher("change-password.jsp").forward(request, response);
                return;
            }

            // Update the password in students.txt (store as plain text)
            updateStudentPassword(email, newPassword);

            // Log the password change event
            logPasswordChange(request, email);

            // Redirect to logIn.jsp with success message
            request.setAttribute("success", "Password changed successfully. Please log in with your new password.");
            request.getRequestDispatcher("logIn.jsp").forward(request, response);

        } catch (Exception e) {
            logger.severe("Error during password reset for email: " + email + " - " + e.getMessage());
            request.setAttribute("error", "An error occurred while changing your password. Please try again.");
            request.getRequestDispatcher("change-password.jsp").forward(request, response);
        }
    }

    private void updateStudentPassword(String email, String newPassword) throws IOException {
        String filePath = getServletContext().getRealPath("/WEB-INF/data/students.txt");
        List<String> updatedLines = new ArrayList<>();
        boolean updated = false;

        // Read the current contents of students.txt
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.trim().isEmpty()) continue;
                String[] parts = line.split(",");
                if (parts.length < 4) continue;

                String currentEmail = parts[2].trim();
                if (currentEmail.equals(email)) {
                    // Update the password (parts[3]) with the new plain text password
                    updatedLines.add(parts[0] + "," + parts[1] + "," + parts[2] + "," + newPassword);
                    updated = true;
                    logger.info("Password updated for email: " + email);
                } else {
                    updatedLines.add(line);
                }
            }
        }

        if (!updated) {
            throw new IllegalArgumentException("No student found with email: " + email);
        }

        // Write the updated contents back to students.txt
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            for (String line : updatedLines) {
                writer.write(line);
                writer.newLine();
            }
        }

        // Reload the StudentDAO cache to reflect the updated password
        studentDao.reloadStudents();
    }

    private void logPasswordChange(HttpServletRequest request, String email) throws IOException {
        String ipAddress = request.getRemoteAddr();
        String device = request.getHeader("User-Agent");
        String timestamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

        String logEntry = String.format("%s,%s,%s,%s", email, timestamp, ipAddress, device);
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(passwordChangeHistoryFilePath, true))) {
            writer.write(logEntry);
            writer.newLine();
            logger.info("Logged password change for email: " + email);
        } catch (IOException e) {
            logger.severe("Failed to log password change for email: " + email + " - " + e.getMessage());
            throw e;
        }
    }
}