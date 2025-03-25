package com.studentregistration.servlets;

import com.studentregistration.dao.UserDAO;
import com.studentregistration.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/signup")
public class SignUpServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Read form data
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm-password");

        // Validate passwords match
        if (!password.equals(confirmPassword)) {
            response.sendRedirect("signUp.jsp?error=1"); // Redirect with error
            return;
        }

        // Generate a unique ID for the new user
        int id = userDAO.getAllUsers().size() + 1;

        // Create a new User object
        User newUser = new User(id, username, password, "student");

        // Save the new user to users.txt
        userDAO.addUser(newUser);

        // Redirect to login page with success message
        response.sendRedirect("login.jsp?success=1");
    }
}