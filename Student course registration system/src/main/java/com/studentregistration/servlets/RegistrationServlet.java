package com.studentregistration.servlets;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/RegisterServlet")
public class RegistrationServlet extends HttpServlet {
    private RegistrationDAO userDAO = new RegistrationDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form data
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String course = request.getParameter("course");

        // Server-side validation
        if (fullName == null || fullName.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty() ||
                !password.equals(confirmPassword) ||
                course == null || course.trim().isEmpty()) {

            request.setAttribute("errorMessage", "Invalid input. Please check your data.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Check if email already exists (optional)
        if (userDAO.emailExists(email)) {
            request.setAttribute("errorMessage", "Email already registered.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Create and save user
        User user = new User(fullName, email, password, course);
        boolean success = userDAO.saveUser(user);

        // Redirect based on result
        if (success) {
            response.sendRedirect("success.jsp"); // Registration success page
        } else {
            request.setAttribute("errorMessage", "Registration failed. Please try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}

