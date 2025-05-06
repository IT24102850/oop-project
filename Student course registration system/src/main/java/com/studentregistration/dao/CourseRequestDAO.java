package com.studentregistration.dao;

import com.studentregistration.model.CourseRequest;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;

public class CourseRequestDAO {
    private String basePath;
    private static final String APPLICATIONS_DIR = "WEB-INF/data/applications/";
    private static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyyMMdd_HHmmss");

    public CourseRequestDAO(String basePath) {
        this.basePath = basePath;
        createApplicationsDirectory();
    }

    private void createApplicationsDirectory() {
        try {
            Files.createDirectories(Paths.get(basePath, APPLICATIONS_DIR));
        } catch (IOException e) {
            System.err.println("Failed to create applications directory: " + e.getMessage());
        }
    }

    public void saveRequest(CourseRequest request) throws IOException {
        String timestamp = DATE_FORMAT.format(new Date());
        String filename = "application_" + timestamp + "_" + request.getEmail().replace("@", "_") + ".txt";
        File file = new File(basePath + APPLICATIONS_DIR + filename);

        try (PrintWriter writer = new PrintWriter(new FileWriter(file))) {
            writer.println("=== Course Application Details ===");
            writer.println("Submission Time: " + request.getSubmissionTime());
            writer.println("Full Name: " + request.getFullName());
            writer.println("Email: " + request.getEmail());
            writer.println("Course ID: " + request.getCourseId());
            writer.println("Reason: " + request.getReason());
            writer.println("Additional Notes: " + request.getAdditionalNotes());
            writer.println("Terms Accepted: " + request.isTermsAccepted());
            writer.println("=== End of Application ===");
        }
    }
}