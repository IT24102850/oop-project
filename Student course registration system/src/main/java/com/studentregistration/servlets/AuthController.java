package com.studentregistration.servlets;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;




import dao.UserDAO;
import dao.LoginHistoryDAO;
import model.User;
import util.PasswordUtil;

@WebServlet(name = "AuthController", urlPatterns = {"/auth/*"})
public class AuthController extends HttpServlet {

    private UserDAO userDAO;
    private LoginHistoryDAO loginHistoryDAO;

    @Override
    public void init() throws ServletException {
        this.userDAO = new UserDAO();
        this.loginHistoryDAO = new LoginHistoryDAO();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo();

        switch (action) {
            case "/register":
                handleRegistration(request, response);
                break;
            case "/login":
                handleLogin(request, response);
                break;
            case "/logout":
                handleLogout(request, response);
                break;
            case "/change-password":
                handlePasswordChange(request, response);
                break;
            case "/request-deletion":
                handleDeletionRequest(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void handleRegistration(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = PasswordUtil.hashPassword(request.getParameter("password"));
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");

        User newUser = new User(username, password, fullName, email, false, false);

        if (userDAO.createUserWithApproval(newUser)) {
            request.setAttribute("message", "Account request submitted. Waiting for admin approval.");
            request.getRequestDispatcher("/auth/registration-success.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Username already exists or invalid input.");
            request.getRequestDispatcher("/auth/register.jsp").forward(request, response);
        }
    }




    
    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = userDAO.getUser(username);

        if (user != null && PasswordUtil.verifyPassword(password, user.getPassword())) {
            if (user.isApproved()) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);

                // Record login history
                loginHistoryDAO.recordLogin(username, request.getRemoteAddr());

                if (user.isAdmin()) {
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
                } else {
                    response.sendRedirect(request.getContextPath() + "/student/dashboard.jsp");
                }
            } else {
                request.setAttribute("error", "Account pending admin approval.");
                request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "Invalid username or password.");
            request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
        }
    }

    private void handleLogout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }

    private void handlePasswordChange(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");

        if (PasswordUtil.verifyPassword(currentPassword, user.getPassword())) {
            String hashedNewPassword = PasswordUtil.hashPassword(newPassword);
            if (userDAO.updatePassword(user.getUsername(), hashedNewPassword)) {
                user.setPassword(hashedNewPassword);
                session.setAttribute("user", user);
                request.setAttribute("message", "Password changed successfully.");
            } else {
                request.setAttribute("error", "Failed to update password.");
            }
        } else {
            request.setAttribute("error", "Current password is incorrect.");
        }

        if (user.isAdmin()) {
            request.getRequestDispatcher("/admin/change-password.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/student/change-password.jsp").forward(request, response);
        }
    }

    private void handleDeletionRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (userDAO.requestAccountDeletion(user.getUsername())) {
            session.invalidate();
            request.setAttribute("message", "Account deletion requested. Admin will process your request.");
            request.getRequestDispatcher("/auth/deletion-requested.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Failed to submit deletion request.");
            if (user.isAdmin()) {
                request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("/student/dashboard.jsp").forward(request, response);
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}





//