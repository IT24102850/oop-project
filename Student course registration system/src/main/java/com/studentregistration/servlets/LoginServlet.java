package com.studentregistration.servlets;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.Date;
import java.util.logging.Logger;

public class LoginServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(LoginServlet.class.getName());
    private static final String STUDENTS_FILE = "/WEB-INF/data/students.txt";
    private static final String LOGIN_HISTORY_FILE = "/WEB-INF/data/login_history.txt";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Validate input
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            logger.warning("Missing required fields: email=" + email + ", password=" + password);
            request.setAttribute("error", "Email and password are required");
            request.getRequestDispatcher("logIn.jsp").forward(request, response);
            return;
        }

        email = email.trim();
        password = password.trim();

        logger.info("Login attempt - Email: " + email);

        // Authenticate user
        String studentId = authenticateUser(email, password);
        if (studentId != null) {
            // Set session attributes (consistent with AuthServlet)
            HttpSession session = request.getSession();
            session.setAttribute("userType", "student");
            session.setAttribute("username", email);
            session.setAttribute("studentId", studentId);

            // Save login data to login_history.txt
            String filePath = getServletContext().getRealPath(LOGIN_HISTORY_FILE);
            File directory = new File(getServletContext().getRealPath("/WEB-INF/data"));
            if (!directory.exists()) {
                directory.mkdirs();
                logger.info("Created directory: " + directory.getAbsolutePath());
            }
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
                String ipAddress = request.getRemoteAddr();
                String device = request.getHeader("User-Agent");
                String loginTime = new Date().toString();
                String logEntry = String.format("%s,%s,%s,%s", studentId, loginTime, ipAddress, device);
                writer.write(logEntry);
                writer.newLine();
                logger.info("Saved login history: " + logEntry);
            } catch (IOException e) {
                logger.severe("Failed to save login history: " + e.getMessage());
                request.setAttribute("error", "Failed to save login history: " + e.getMessage());
            }

            // Redirect to student dashboard
            logger.info("Login successful for email: " + email);
            response.sendRedirect("student-dashboard.jsp");
        } else {
            logger.warning("Invalid credentials for email: " + email);
            request.setAttribute("error", "Invalid email or password");
            request.getRequestDispatcher("logIn.jsp").forward(request, response);
        }
    }

    private String authenticateUser(String email, String password) {
        String studentsPath = getServletContext().getRealPath(STUDENTS_FILE);
        File file = new File(studentsPath);
        if (!file.exists()) {
            logger.severe("students.txt does not exist at: " + studentsPath);
            return null;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.trim().isEmpty()) continue;
                String[] parts = line.split(",");
                if (parts.length >= 3 && parts[0].trim().equalsIgnoreCase(email)) {
                    String storedPassword = parts[1].trim();
                    if (storedPassword.equals(password)) {
                        // Generate a student ID (for simplicity, use a prefix + hash of email)
                        String studentId = "S" + Math.abs(email.hashCode() % 10000);
                        logger.info("Authenticated user: " + email + ", Student ID: " + studentId);
                        return studentId;
                    }
                }
            }
            logger.warning("No matching email found for: " + email);
        } catch (IOException e) {
            logger.severe("Error reading students.txt: " + e.getMessage());
        }
        return null; // Authentication failed
    }
}