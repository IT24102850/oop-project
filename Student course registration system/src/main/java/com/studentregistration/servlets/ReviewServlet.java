package com.studentregistration.servlets;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

@WebServlet("/ReviewServlet")
public class ReviewServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        String action = request.getParameter("action");
        if ("save".equals(action)) {
            // Handle saving a new review
            String reviewerName = request.getParameter("reviewerName");
            String reviewText = request.getParameter("reviewText");
            System.out.println("Received - reviewerName: " + reviewerName + ", reviewText: " + reviewText);

            if (reviewerName == null || reviewText == null || reviewerName.trim().isEmpty() || reviewText.trim().isEmpty()) {
                out.print("{\"success\": false, \"message\": \"Name and review are required.\"}");
                out.flush();
                return;
            }

            try {
                com.studentregistration.dao.ReviewDAO reviewDAO = new com.studentregistration.dao.ReviewDAO();
                reviewDAO.saveReview(reviewerName, reviewText, getServletContext());
                out.print("{\"success\": true, \"message\": \"Review saved successfully.\"}");
            } catch (IOException e) {
                e.printStackTrace();
                out.print("{\"success\": false, \"message\": \"Error saving review: " + e.getMessage() + "\"}");
            }
        } else if ("update".equals(action)) {
            // Handle updating an existing review
            String id = request.getParameter("id");
            String currentAuthor = request.getParameter("currentAuthor");
            String currentReviewText = request.getParameter("currentReviewText");

            if (id == null || currentAuthor == null || currentReviewText == null ||
                    id.trim().isEmpty() || currentAuthor.trim().isEmpty() || currentReviewText.trim().isEmpty()) {
                out.print("{\"success\": false, \"message\": \"ID, author, and review text are required.\"}");
                out.flush();
                return;
            }

            try {
                com.studentregistration.dao.ReviewDAO reviewDAO = new com.studentregistration.dao.ReviewDAO();
                reviewDAO.updateReview(Integer.parseInt(id), currentAuthor, currentReviewText, getServletContext());
                out.print("{\"success\": true, \"message\": \"Review updated successfully.\"}");
                response.sendRedirect(request.getContextPath() + "/admin-dashboard.jsp?activeTab=reviews&message=review_updated");
            } catch (IOException | NumberFormatException e) {
                e.printStackTrace();
                out.print("{\"success\": false, \"message\": \"Error updating review: " + e.getMessage() + "\"}");
            }
        }
        out.flush();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            String id = request.getParameter("id");

            if (id == null || id.trim().isEmpty()) {
                out.print("{\"success\": false, \"message\": \"Review ID is required.\"}");
                out.flush();
                return;
            }

            try {
                com.studentregistration.dao.ReviewDAO reviewDAO = new com.studentregistration.dao.ReviewDAO();
                reviewDAO.deleteReview(Integer.parseInt(id), getServletContext());
                out.print("{\"success\": true, \"message\": \"Review deleted successfully.\"}");
                response.sendRedirect(request.getContextPath() + "/admin-dashboard.jsp?activeTab=reviews&message=review_deleted");
            } catch (IOException | NumberFormatException e) {
                e.printStackTrace();
                out.print("{\"success\": false, \"message\": \"Error deleting review: " + e.getMessage() + "\"}");
            }
        }
        out.flush();
    }
}