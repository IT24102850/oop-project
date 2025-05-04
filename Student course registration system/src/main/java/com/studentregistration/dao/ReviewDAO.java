package com.studentregistration.dao;

import com.studentregistration.model.Review;
import javax.servlet.ServletContext;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO {
    private String filePath;

    public ReviewDAO(ServletContext context) {
        this.filePath = context.getRealPath("/WEB-INF/data/reviews.txt");
        File file = new File(filePath);
        if (!file.getParentFile().exists()) {
            file.getParentFile().mkdirs();
        }
        if (!file.exists()) {
            try {
                file.createNewFile();
            } catch (IOException e) {
                System.err.println("Failed to create reviews.txt: " + e.getMessage());
            }
        }
    }

    public List<Review> getAllReviews() throws IOException {
        List<Review> reviews = new ArrayList<>();
        File file = new File(filePath);
        if (!file.exists()) {
            file.createNewFile();
            return reviews;
        }
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            int id = 0;
            while ((line = reader.readLine()) != null) {
                Review review = Review.fromString(line);
                if (review != null) {
                    review.setId(id++);
                    reviews.add(review);
                }
            }
        }
        return reviews;
    }

    public void saveReview(Review review) throws IOException {
        File file = new File(filePath);
        if (!file.exists()) {
            file.getParentFile().mkdirs();
            file.createNewFile();
        }
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file, true))) {
            writer.write(review.getAuthor() + "|" + review.getText());
            writer.newLine();
        }
    }

    public void updateReview(int id, Review updatedReview) throws IOException {
        List<Review> reviews = getAllReviews();
        if (id >= 0 && id < reviews.size()) {
            updatedReview.setId(id);
            reviews.set(id, updatedReview);
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
                for (Review r : reviews) {
                    writer.write(r.getAuthor() + "|" + r.getText());
                    writer.newLine();
                }
            }
        } else {
            throw new IOException("Review with ID " + id + " not found.");
        }
    }

    public void deleteReview(int id) throws IOException {
        List<Review> reviews = getAllReviews();
        if (id >= 0 && id < reviews.size()) {
            reviews.remove(id);
            for (int i = 0; i < reviews.size(); i++) {
                reviews.get(i).setId(i);
            }
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
                for (Review r : reviews) {
                    writer.write(r.getAuthor() + "|" + r.getText());
                    writer.newLine();
                }
            }
        } else {
            throw new IOException("Review with ID " + id + " not found.");
        }
    }
}