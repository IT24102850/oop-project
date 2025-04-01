package com.studentregistration.servlets;


import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

import dao.UserDAO;
import model.User;

@WebServlet("/admin/auth")
public class AdminAuthServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        this.userDAO = new UserDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing action parameter");
            return;
        }

        switch (action) {
            case "view-pending":
                viewPendingAccounts(request, response);
                break;
            case "view-deletion":
                viewDeletionRequests(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing action parameter");
            return;
        }

        switch (action) {
            case "approve-account":
                approveAccount(request, response);
                break;
            case "deny-account":
                denyAccount(request, response);
                break;
            case "confirm-deletion":
                confirmDeletion(request, response);
                break;
            case "cancel-deletion":
                cancelDeletion(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }

    private void viewPendingAccounts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("pendingAccounts", userDAO.getPendingAccounts());
        request.getRequestDispatcher("/admin/pending-approvals.jsp").forward(request, response);
    }

    private void viewDeletionRequests(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("deletionRequests", userDAO.getDeletionRequests());
        request.getRequestDispatcher("/admin/deletion-requests.jsp").forward(request, response);
    }

    private void approveAccount(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");

        if (username == null || username.isEmpty()) {
            request.setAttribute("error", "Username is required");
            viewPendingAccounts(request, response);
            return;
        }

        if (userDAO.approveAccount(username)) {
            request.setAttribute("success", "Account approved successfully");
        } else {
            request.setAttribute("error", "Failed to approve account");
        }

        viewPendingAccounts(request, response);
    }

    private void denyAccount(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");

        if (username == null || username.isEmpty()) {
            request.setAttribute("error", "Username is required");
            viewPendingAccounts(request, response);
            return;
        }

        if (userDAO.denyAccount(username)) {
            request.setAttribute("success", "Account request denied");
        } else {
            request.setAttribute("error", "Failed to deny account request");
        }

        viewPendingAccounts(request, response);
    }

    private void confirmDeletion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");

        if (username == null || username.isEmpty()) {
            request.setAttribute("error", "Username is required");
            viewDeletionRequests(request, response);
            return;
        }

        if (userDAO.confirmAccountDeletion(username)) {
            request.setAttribute("success", "Account deleted successfully");
        } else {
            request.setAttribute("error", "Failed to delete account");
        }

        viewDeletionRequests(request, response);
    }

    private void cancelDeletion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");

        if (username == null || username.isEmpty()) {
            request.setAttribute("error", "Username is required");
            viewDeletionRequests(request, response);
            return;
        }

        if (userDAO.cancelDeletionRequest(username)) {
            request.setAttribute("success", "Deletion request cancelled");
        } else {
            request.setAttribute("error", "Failed to cancel deletion request");
        }

        viewDeletionRequests(request, response);
    }
}