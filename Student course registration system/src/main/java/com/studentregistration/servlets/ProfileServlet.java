package com.studentregistration.servlets;

import com.studentregistration.dao.UserDAO;
import com.studentregistration.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile"})
public class ProfileServlet extends HttpServlet {
    private UserDAO userDao;

    @Override
    public void init() throws ServletException {
        super.init();
        userDao = new UserDAO(); // Initialize DAO
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String userId = (String) session.getAttribute("userId");
        User user = userDao.getUserById(userId);
        if (user == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found");
            return;
        }

        request.setAttribute("user", user);
        request.getRequestDispatcher("/jsp/profile.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String userId = (String) session.getAttribute("userId");
        switch (action) {
            case "update":
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                User updatedUser = new User(userId, email, phone);
                if (userDao.updateUser(updatedUser)) {
                    response.sendRedirect("profile?success=update");
                } else {
                    response.sendRedirect("profile?error=update");
                }
                break;
            case "delete":
                if (userDao.flagForDeletion(userId)) {
                    session.invalidate(); // Logout user
                    response.sendRedirect("login.jsp?status=delete_requested");
                } else {
                    response.sendRedirect("profile?error=delete");
                }
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }
}
