package com.studentregistration.servlets;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class SignUpServlet extends HttpServlet {

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
                response.sendRedirect("signUp.jsp?error=3"); // Missing fields error
                return;
            }

            // Validate passwords match
            if (!password.equals(confirmPassword)) {
                response.sendRedirect("signUp.jsp?error=1"); // Password mismatch
                return;
            }

            // Save user data
            saveUserData(request, fullname, email, password);

            // Successful registration
            response.sendRedirect(request.getContextPath() + "/logIn.jsp?registered=1");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("signUp.jsp?error=2"); // Server error
        }
    }

    private void saveUserData(HttpServletRequest request, String fullname,
                              String email, String password) throws IOException {
        // Save to primary user_data.txt
        String path = request.getServletContext().getRealPath("/WEB-INF/user_data.txt");
        try (PrintWriter out = new PrintWriter(new FileWriter(path, true))) {
            out.println(fullname + "|" + email + "|" + password);
        }

        // Save to individual file named with first name and timestamp
        String[] nameParts = fullname.split(" ", 2);
        String firstName = nameParts[0].replaceAll("[^a-zA-Z0-9_]", "_");
        String uniqueId = String.valueOf(System.currentTimeMillis()); // Use timestamp for uniqueness
        String filename = firstName + "_" + uniqueId + ".txt";
        String individualFilePath = request.getServletContext().getRealPath("/WEB-INF/data/") + filename;
        try (PrintWriter out = new PrintWriter(new FileWriter(individualFilePath))) {
            out.println(fullname + "|" + email + "|" + password);
        } catch (IOException e) {
            // Log error but don't fail registration
            request.getServletContext().log("Failed to write to individual user file: " + filename, e);
        }
    }
}