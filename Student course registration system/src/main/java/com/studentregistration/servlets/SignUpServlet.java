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

            // Successful registration - use correct path to login.jsp
            response.sendRedirect(request.getContextPath() + "/login.jsp?registered=1");
// OR if login.jsp is in root:
// response.sendRedirect(request.getContextPath() + "/login.jsp?registered=1");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("signUp.jsp?error=2"); // Server error
        }
    }

    private void saveUserData(HttpServletRequest request, String fullname,
                              String email, String password) throws IOException {
        String path = request.getServletContext().getRealPath("/WEB-INF/user_data.txt");
        try (PrintWriter out = new PrintWriter(new FileWriter(path, true))) {
            out.println(fullname + "|" + email + "|" + password);
        }
    }
}