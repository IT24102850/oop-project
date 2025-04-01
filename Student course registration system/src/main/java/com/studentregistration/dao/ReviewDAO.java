package com.studentregistration.dao;

import model.Review;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO {
    private Connection connection;

    public ReviewDAO(Connection connection) {
        this.connection = connection;
    }

    // Create
    public boolean addReview(Review review) throws SQLException {
        String sql = "INSERT INTO reviews (title, content, rating, category, date, user_id) VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            statement.setString(1, review.getTitle());
            statement.setString(2, review.getContent());
            statement.setInt(3, review.getRating());
            statement.setString(4, review.getCategory());
            statement.setDate(5, Date.valueOf(review.getDate()));
            statement.setInt(6, review.getUserId());

            int affectedRows = statement.executeUpdate();

            if (affectedRows == 0) {
                return false;
            }

            try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    review.setId(generatedKeys.getInt(1));
                }
            }
            return true;
        }
    }

    // Read
    public List<Review> getAllReviews() throws SQLException {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT * FROM reviews ORDER BY date DESC";

        try (Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(sql)) {

            while (resultSet.next()) {
                Review review = extractReviewFromResultSet(resultSet);
                reviews.add(review);
            }
        }
        return reviews;
    }

    public Review getReviewById(int id) throws SQLException {
        String sql = "SELECT * FROM reviews WHERE id = ?";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return extractReviewFromResultSet(resultSet);
                }
            }
        }
        return null;
    }

    public List<Review> getReviewsByUserId(int userId) throws SQLException {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT * FROM reviews WHERE user_id = ? ORDER BY date DESC";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userId);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Review review = extractReviewFromResultSet(resultSet);
                    reviews.add(review);
                }
            }
        }
        return reviews;
    }

    // Update
    public boolean updateReview(Review review) throws SQLException {
        String sql = "UPDATE reviews SET title = ?, content = ?, rating = ?, category = ? WHERE id = ?";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, review.getTitle());
            statement.setString(2, review.getContent());
            statement.setInt(3, review.getRating());
            statement.setString(4, review.getCategory());
            statement.setInt(5, review.getId());

            return statement.executeUpdate() > 0;
        }
    }

    // Delete
    public boolean deleteReview(int id) throws SQLException {
        String sql = "DELETE FROM reviews WHERE id = ?";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            return statement.executeUpdate() > 0;
        }
    }

    // Helper method
    private Review extractReviewFromResultSet(ResultSet resultSet) throws SQLException {
        Review review = new Review();
        review.setId(resultSet.getInt("id"));
        review.setTitle(resultSet.getString("title"));
        review.setContent(resultSet.getString("content"));
        review.setRating(resultSet.getInt("rating"));
        review.setCategory(resultSet.getString("category"));
        review.setDate(resultSet.getDate("date").toLocalDate());
        review.setUserId(resultSet.getInt("user_id"));
        return review;
    }
}
