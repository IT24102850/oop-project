package com.studentregistration.servlets;

import com.studentregistration.dao.UserDAO;
import com.studentregistration.dao.AdminDAO;
import com.studentregistration.model.User;
import com.studentregistration.model.Admin;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/auth")
public class AuthServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();
    private AdminDAO adminDAO = new AdminDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Check if user is an admin
        for (Admin admin : adminDAO.getAllAdmins()) {
            if (admin.getUsername().equals(username) && admin.getPassword().equals(password)) {
                HttpSession session = request.getSession();
                session.setAttribute("user", admin);
                response.sendRedirect("adminDashboard.jsp");
                return;
            }
        }

        // Check if user is a regular user
        for (User user : userDAO.getAllUsers()) {
            if (user.getUsername().equals(username) && user.getPassword().equals(password)) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                response.sendRedirect("dashboard.jsp");
                return;
            }
        }

        // If no match, redirect to login page with error message
        response.sendRedirect("login.jsp?error=1");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle logout
        HttpSession session = request.getSession();
        session.invalidate();
        response.sendRedirect("login.jsp");
    }
}