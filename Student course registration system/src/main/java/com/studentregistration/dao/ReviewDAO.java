 package com.studentregistration.dao;

import javax.servlet.ServletContext;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;

public class ReviewDAO {
    private static final String REVIEWS_DIR = "/WEB-INF/data/reviews/";

    // Save a review to username.txt
    public void saveReview(String username, String review, ServletContext context) throws IOException {
        String dirPath = context.getRealPath(REVIEWS_DIR);
        File dir = new File(dirPath);
        if (!dir.exists()) {
            dir.mkdirs();
        }
        String filePath = dirPath + File.separator + username + ".txt";
        String timestamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
        String entry = timestamp + "|" + review;

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
            writer.write(entry);
            writer.newLine();
        }
    }

    // Get all reviews from all users
    public List<Map<String, String>> getAllReviews(ServletContext context) {
        List<Map<String, String>> reviews = new ArrayList<>();
        String dirPath = context.getRealPath(REVIEWS_DIR);
        File dir = new File(dirPath);
        if (!dir.exists()) {
            return reviews;
        }

        File[] files = dir.listFiles((d, name) -> name.endsWith(".txt"));
        if (files != null) {
            for (File file : files) {
                String username = file.getName().replace(".txt", "");
                try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                    String line;
                    while ((line = reader.readLine()) != null) {
                        String[] parts = line.split("\\|", 2);
                        if (parts.length == 2) {
                            Map<String, String> review = new HashMap<>();
                            review.put("username", username);
                            review.put("review", parts[1]);
                            reviews.add(review);
                        }
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return reviews;
    }
}
