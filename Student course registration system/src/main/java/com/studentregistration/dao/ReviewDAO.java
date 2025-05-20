package com.studentregistration.dao;

import javax.servlet.ServletContext;
import java.io.*;
import java.util.*;

public class ReviewDAO {
    private static final String REVIEWS_FILE = "/WEB-INF/data/reviews.txt";

    // Save a new review to reviews.txt
    public void saveReview(String username, String review, ServletContext context) throws IOException {
        String filePath = context.getRealPath(REVIEWS_FILE);
        File file = new File(filePath);
        File parentDir = file.getParentFile();
        if (!parentDir.exists()) {
            parentDir.mkdirs();
        }

        String entry = username + "|" + review;
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
            writer.write(entry);
            writer.newLine();
        }
    }

    // Get all reviews from reviews.txt with incremental IDs
    public List<Map<String, String>> getAllReviews(ServletContext context) {
        List<Map<String, String>> reviews = new ArrayList<>();
        String filePath = context.getRealPath(REVIEWS_FILE);
        File file = new File(filePath);
        if (!file.exists()) {
            return reviews;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            int id = 1;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|", 2);
                if (parts.length == 2) {
                    Map<String, String> review = new HashMap<>();
                    review.put("id", String.valueOf(id++));
                    review.put("username", parts[0]);
                    review.put("review", parts[1]);
                    reviews.add(review);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return reviews;
    }

    // Update an existing review in reviews.txt
    public void updateReview(int id, String username, String review, ServletContext context) throws IOException {
        List<Map<String, String>> reviews = getAllReviews(context);
        String filePath = context.getRealPath(REVIEWS_FILE);
        File file = new File(filePath);

        if (id <= 0 || id > reviews.size()) {
            throw new IllegalArgumentException("Invalid review ID: " + id);
        }

        // Update the review at the specified index (id-1 since IDs are 1-based)
        Map<String, String> updatedReview = new HashMap<>();
        updatedReview.put("id", String.valueOf(id));
        updatedReview.put("username", username);
        updatedReview.put("review", review);
        reviews.set(id - 1, updatedReview);

        // Rewrite the file with updated reviews
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
            for (Map<String, String> rev : reviews) {
                writer.write(rev.get("username") + "|" + rev.get("review"));
                writer.newLine();
            }
        }
    }

    // Delete a review from reviews.txt
    public void deleteReview(int id, ServletContext context) throws IOException {
        List<Map<String, String>> reviews = getAllReviews(context);
        String filePath = context.getRealPath(REVIEWS_FILE);
        File file = new File(filePath);

        if (id <= 0 || id > reviews.size()) {
            throw new IllegalArgumentException("Invalid review ID: " + id);
        }

        // Remove the review at the specified index (id-1 since IDs are 1-based)
        reviews.remove(id - 1);

        // Rewrite the file with remaining reviews
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
            for (Map<String, String> rev : reviews) {
                writer.write(rev.get("username") + "|" + rev.get("review"));
                writer.newLine();
            }
        }
    }
}