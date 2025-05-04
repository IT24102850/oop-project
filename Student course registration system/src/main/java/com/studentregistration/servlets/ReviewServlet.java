package com.studentregistration.servlet;

import com.studentregistration.dao.ReviewDAO;
import com.studentregistration.model.Review;
import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.util.List;

@WebServlet("/ReviewServlet")
public class ReviewServlet extends HttpServlet {
    private ReviewDAO reviewDAO;

    @Override
    public void init() throws ServletException {
        reviewDAO = new ReviewDAO(getServletContext());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if (action == null || action.equals("create")) {
                String author = request.getParameter("author");
                String text = request.getParameter("text");
                if (author != null && text != null && !author.trim().isEmpty() && !text.trim().isEmpty()) {
                    Review review = new Review(author.trim(), text.trim());
                    reviewDAO.saveReview(review);
                } else {
                    request.setAttribute("error", "Author and text cannot be empty.");
                }
            } else if (action.equals("update")) {
                int id = Integer.parseInt(request.getParameter("id"));
                String author = request.getParameter("author");
                String text = request.getParameter("text");
                if (author != null && text != null && !author.trim().isEmpty() && !text.trim().isEmpty()) {
                    Review updatedReview = new Review(id, author.trim(), text.trim());
                    reviewDAO.updateReview(id, updatedReview);
                } else {
                    request.setAttribute("error", "Author and text cannot be empty for update.");
                }
            } else if (action.equals("delete")) {
                int id = Integer.parseInt(request.getParameter("id"));
                reviewDAO.deleteReview(id);
            } else {
                request.setAttribute("error", "Invalid action specified.");
            }
        } catch (Exception e) {
            request.setAttribute("error", "Operation failed: " + e.getMessage());
            System.err.println("Error in doPost: " + e.getMessage());
        }

        // Forward to doGet to refresh the page
        doGet(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Review> reviews = reviewDAO.getAllReviews();
            request.setAttribute("reviews", reviews);
            if (reviews.isEmpty()) {
                System.out.println("No reviews found in " + reviewDAO.getClass().getName());
            }
        } catch (IOException e) {
            request.setAttribute("error", "Unable to load reviews: " + e.getMessage());
            System.err.println("Error loading reviews: " + e.getMessage());
        }
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}