package com.studentregistration.servlets;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

import dao.UserDAO;
import model.User;
import util.PasswordUtil;

@WebServlet("/password")
public class PasswordServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        this.userDAO = new UserDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect to change password page based on user type
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user.isAdmin()) {
            request.getRequestDispatcher("/admin/change-password.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/student/change-password.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate inputs
        if (newPassword == null || newPassword.isEmpty() || !newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "New passwords do not match.");
            forwardToChangePasswordPage(request, response, user);
            return;
        }

        // Verify current password
        if (!PasswordUtil.verifyPassword(currentPassword, user.getPassword())) {
            request.setAttribute("error", "Current password is incorrect.");
            forwardToChangePasswordPage(request, response, user);
            return;
        }

        // Hash and update password
        String hashedNewPassword = PasswordUtil.hashPassword(newPassword);
        if (userDAO.updatePassword(user.getUsername(), hashedNewPassword)) {
            // Update user object in session
            user.setPassword(hashedNewPassword);
            session.setAttribute("user", user);

            request.setAttribute("success", "Password changed successfully.");
        } else {
            request.setAttribute("error", "Failed to update password. Please try again.");
        }

        forwardToChangePasswordPage(request, response, user);
    }

    private void forwardToChangePasswordPage(HttpServletRequest request,
                                             HttpServletResponse response,
                                             User user)
            throws ServletException, IOException {
        if (user.isAdmin()) {
            request.getRequestDispatcher("/admin/change-password.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/student/change-password.jsp").forward(request, response);
        }
    }
}
