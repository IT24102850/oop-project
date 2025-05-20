package com.studentregistration.servlets;

import java.io.*;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.logging.Logger;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.Random;

public class SignUpServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(SignUpServlet.class.getName());
    private static final String USER_DATA_FILE = "/WEB-INF/user_data.txt";
    private static final String STUDENTS_FILE = "/WEB-INF/data/students.txt";
    private static final String DATA_DIR = "/WEB-INF/data/";
    private static final Object fileLock = new Object();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get form data with null checks
            String fullname = request.getParameter("fullname");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirm-password");

            // Validate all fields are present
            if (fullname == null || fullname.trim().isEmpty() ||
                    email == null || email.trim().isEmpty() ||
                    password == null || password.trim().isEmpty() ||
                    confirmPassword == null || confirmPassword.trim().isEmpty()) {
                logger.warning("Missing required fields: fullname=" + fullname + ", email=" + email + ", password=" + password + ", confirmPassword=" + confirmPassword);
                response.sendRedirect("signUp.jsp?error=3"); // Missing fields error
                return;
            }

            // Trim input to avoid whitespace issues
            fullname = fullname.trim();
            email = email.trim();
            password = password.trim();
            confirmPassword = confirmPassword.trim();

            // Validate passwords match
            if (!password.equals(confirmPassword)) {
                logger.warning("Password mismatch for email: " + email);
                response.sendRedirect("signUp.jsp?error=1"); // Password mismatch
                return;
            }

            // Check if email already exists in students.txt
            if (emailExists(request, email)) {
                logger.warning("Email already exists: " + email);
                response.sendRedirect("signUp.jsp?error=4"); // Email already exists
                return;
            }

            // Save user data with registration time
            LocalDateTime registrationTime = LocalDateTime.now();
            saveUserData(request, fullname, email, password, registrationTime);

            // Successful registration
            logger.info("Successful registration for email: " + email);
            response.sendRedirect(request.getContextPath() + "/login.jsp?registered=1");
        } catch (Exception e) {
            logger.severe("Signup error: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("signUp.jsp?error=2"); // Server error
        }
    }

    private boolean emailExists(HttpServletRequest request, String email) throws IOException {
        String studentsPath = request.getServletContext().getRealPath(STUDENTS_FILE);
        File file = new File(studentsPath);
        if (!file.exists()) {
            logger.warning("students.txt does not exist at: " + studentsPath);
            return false;
        }

        synchronized (fileLock) {
            try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    if (line.trim().isEmpty()) continue;
                    String[] parts;
                    String currentEmail = null;

                    // Handle both tab-separated (old format) and comma-separated (new format)
                    if (line.contains("\t")) {
                        parts = line.split("\t");
                        if (parts.length >= 3) {
                            currentEmail = parts[2].trim(); // Email in third column for tab-separated
                        }
                    } else {
                        parts = line.split(",");
                        if (parts.length >= 3) {
                            currentEmail = parts[2].trim(); // Email in third column for new format (ID,Name,Email,Password)
                        }
                    }

                    if (currentEmail != null && currentEmail.equals(email)) {
                        return true;
                    }
                }
            }
        }
        return false;
    }

    private String generateStudentId() {
        // Generate an 8-character alphanumeric ID similar to 922B14B1
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        Random random = new Random();
        StringBuilder id = new StringBuilder(8);
        for (int i = 0; i < 8; i++) {
            id.append(characters.charAt(random.nextInt(characters.length())));
        }
        return id.toString();
    }

    private void saveUserData(HttpServletRequest request, String fullname,
                              String email, String password, LocalDateTime registrationTime) throws IOException {
        // Save to primary user_data.txt
        String userDataPath = request.getServletContext().getRealPath(USER_DATA_FILE);
        synchronized (fileLock) {
            try (PrintWriter out = new PrintWriter(new FileWriter(userDataPath, true))) {
                String line = String.format("%s|%s|%s|%s", fullname, email, password, registrationTime);
                out.println(line);
                logger.info("Saved to user_data.txt: " + line);
            } catch (IOException e) {
                logger.severe("Error writing to user_data.txt: " + e.getMessage());
                throw e;
            }
        }

        // Save to individual file named with first name and timestamp
        String[] nameParts = fullname.split(" ", 2);
        String firstName = nameParts[0].replaceAll("[^a-zA-Z0-9_]", "_");
        String uniqueId = String.valueOf(registrationTime.toEpochSecond(ZoneOffset.UTC));
        String filename = firstName + "_" + uniqueId + ".txt";
        String individualFilePath = request.getServletContext().getRealPath(DATA_DIR) + filename;
        synchronized (fileLock) {
            try (PrintWriter out = new PrintWriter(new FileWriter(individualFilePath))) {
                String line = String.format("%s|%s|%s|%s", fullname, email, password, registrationTime);
                out.println(line);
                logger.info("Saved to individual file: " + individualFilePath);
            } catch (IOException e) {
                // Log error but don't fail registration
                request.getServletContext().log("Failed to write to individual user file: " + filename, e);
                logger.warning("Failed to write to individual user file: " + filename + ". Error: " + e.getMessage());
            }
        }

        // Update students.txt for authentication (format: ID,Name,Email,Password)
        String studentsPath = request.getServletContext().getRealPath(STUDENTS_FILE);
        String studentId = generateStudentId();
        synchronized (fileLock) {
            try (PrintWriter out = new PrintWriter(new FileWriter(studentsPath, true))) {
                String line = String.format("%s,%s,%s,%s", studentId, fullname, email, password);
                out.println(line);
                logger.info("Saved to students.txt: " + line);
            } catch (IOException e) {
                logger.severe("Error writing to students.txt: " + e.getMessage());
                throw e;
            }
        }
    }
}