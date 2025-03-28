package com.studentregistration.servlets;

import com.studentregistration.model.User;
import com.studentregistration.util.PasswordUtil;
import java.io.*;
import java.net.URLEncoder;
import javax.servlet.*;
import javax.servlet.http.*;

public class SignUpServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Get and validate parameters
            String fullname = request.getParameter("fullname");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirm-password");
            String userType = request.getParameter("userType"); // "student" or "admin"

            // Validate required fields
            if (fullname == null || fullname.trim().isEmpty() ||
                    email == null || email.trim().isEmpty() ||
                    password == null || password.trim().isEmpty()) {
                redirectWithError(response, "signUp.jsp", 3, fullname, email);
                return;
            }

            // Validate password match
            if (!password.equals(confirmPassword)) {
                redirectWithError(response, "signUp.jsp", 1, fullname, email);
                return;
            }

            // Validate email format
            if (!email.matches("^[\\w-.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
                redirectWithError(response, "signUp.jsp", 5, fullname, email);
                return;
            }

            // Set default role if not specified
            if (userType == null || userType.trim().isEmpty()) {
                userType = "student";
            }

            // Check if user already exists
            if (userExists(email)) {
                redirectWithError(response, "signUp.jsp", 4, fullname, email);
                return;
            }

            // Create and save user
            User newUser = createUser(fullname, email, password, userType);
            saveUser(request, newUser);

            // Set user in session and redirect
            request.getSession().setAttribute("user", newUser);
            response.sendRedirect(request.getContextPath() + "/login.jsp?registered=1");

        } catch (Exception e) {
            e.printStackTrace();
            redirectWithError(response, "signUp.jsp", 2, null, null);
        }
    }

    private void redirectWithError(HttpServletResponse response, String page,
                                   int errorCode, String fullname, String email)
            throws IOException {
        String redirectUrl = page + "?error=" + errorCode;
        if (fullname != null) {
            redirectUrl += "&fullname=" + URLEncoder.encode(fullname, "UTF-8");
        }
        if (email != null) {
            redirectUrl += "&email=" + URLEncoder.encode(email, "UTF-8");
        }
        response.sendRedirect(redirectUrl);
    }

    private User createUser(String fullname, String email,
                            String password, String userType) {
        User user = new User();
        user.setFullName(fullname);
        user.setEmail(email);
        user.setPassword(PasswordUtil.hashPassword(password)); // Hash password
        user.setRole(userType);
        user.setActive(true);
        return user;
    }

    private boolean userExists(String email) throws IOException {
        String path = getServletContext().getRealPath("/WEB-INF/user_data.txt");
        File file = new File(path);

        if (!file.exists()) return false;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|");
                if (parts.length >= 3 && email.equals(parts[1])) {
                    return true;
                }
            }
        }
        return false;
    }

    private void saveUser(HttpServletRequest request, User user) throws IOException {
        String path = getServletContext().getRealPath("/WEB-INF/user_data.txt");
        new File(path).getParentFile().mkdirs();

        try (PrintWriter out = new PrintWriter(new FileWriter(path, true))) {
            out.println(user.toFileString());
        }
    }
}