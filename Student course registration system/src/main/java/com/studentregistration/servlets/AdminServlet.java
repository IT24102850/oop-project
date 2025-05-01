package com.studentregistration.servlets;

import com.studentregistration.dao.UserDAO;
import com.studentregistration.dao.RegistrationDAO;
import com.studentregistration.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
    private UserDAO userDao;
    private RegistrationDAO registrationDao;

    @Override
    public void init() throws ServletException {
        super.init();
        String usersPath = getServletContext().getRealPath("/WEB-INF/data/user_data.txt");
        String studentPath = getServletContext().getRealPath("/WEB-INF/data/students.txt");
        String enrollmentPath = getServletContext().getRealPath("/WEB-INF/data/enrollments.txt");
        userDao = new UserDAO(usersPath);
        registrationDao = new RegistrationDAO(usersPath, studentPath, enrollmentPath);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "forceReset":
                handleForcePasswordReset(request, response);
                break;
            case "deactivate":
                handleDeactivateAccount(request, response);
                break;
            case "purgeUnverified":
                handlePurgeUnverifiedAccounts(request, response);
                break;
            default:
                request.setAttribute("error", "Invalid action");
                request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("monitorSessions".equals(action)) {
            handleMonitorSessions(request, response);
        } else {
            request.setAttribute("error", "Invalid action");
            request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
        }
    }

    private void handleMonitorSessions(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<User> activeAdmins = userDao.getActiveAdminSessions();
        request.setAttribute("activeAdmins", activeAdmins);
        request.getRequestDispatcher("admin-sessions.jsp").forward(request, response);
    }

    private void handleForcePasswordReset(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        try {
            userDao.forcePasswordReset(username);
            request.setAttribute("message", "Password reset forced for " + username);
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
        }
        request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
    }

    private void handleDeactivateAccount(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        try {
            userDao.deactivateAccount(username);
            request.setAttribute("message", "Account deactivated: " + username);
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
        }
        request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
    }

    private void handlePurgeUnverifiedAccounts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            registrationDao.purgeExpiredUnverifiedAccounts();
            request.setAttribute("message", "Expired unverified accounts purged successfully");
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
        }
        request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
    }
}