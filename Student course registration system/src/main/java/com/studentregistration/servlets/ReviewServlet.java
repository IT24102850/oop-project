package com.studentregistration.servlets;

import dao.ReviewDAO;
import model.Review;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

@WebServlet(name = "ReviewServlet", urlPatterns = {"/reviews"})
public class ReviewServlet extends HttpServlet {
    private ReviewDAO reviewDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        Connection connection = (Connection) getServletContext().getAttribute("DBConnection");
        reviewDAO = new ReviewDAO(connection);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "add":
                    addReview(request, response);
                    break;
                case "update":
                    updateReview(request, response);
                    break;
                case "delete":
                    deleteReview(request, response);
                    break;
                default:
                    response.sendRedirect("viewReviews.jsp");
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "new":
                    showNewForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "list":
                default:
                    listReviews(request, response);
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    private void listReviews(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<Review> reviews = reviewDAO.getAllReviews();
        request.setAttribute("reviews", reviews);
        RequestDispatcher dispatcher = request.getRequestDispatcher("viewReviews.jsp");
        dispatcher.forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("addReview.jsp");
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Review review = reviewDAO.getReviewById(id);
        RequestDispatcher dispatcher = request.getRequestDispatcher("editReview.jsp");
        request.setAttribute("review", review);
        dispatcher.forward(request, response);
    }

    private void addReview(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        // Get user ID from session (you'll need to implement user authentication)
        int userId = 1; // Temporary - replace with actual user ID from session

        String title = request.getParameter("title");
        String content = request.getParameter("content");
        int rating = Integer.parseInt(request.getParameter("rating"));
        String category = request.getParameter("category");

        Review newReview = new Review(title, content, rating, category, userId);
        reviewDAO.addReview(newReview);
        response.sendRedirect("reviews");
    }

    private void updateReview(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        int rating = Integer.parseInt(request.getParameter("rating"));
        String category = request.getParameter("category");

        Review review = new Review();
        review.setId(id);
        review.setTitle(title);
        review.setContent(content);
        review.setRating(rating);
        review.setCategory(category);

        reviewDAO.updateReview(review);
        response.sendRedirect("reviews");
    }

    private void deleteReview(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        reviewDAO.deleteReview(id);
        response.sendRedirect("reviews");
    }
}
