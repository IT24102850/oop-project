package com.studentregistration.dao;

import com.studentregistration.model.CourseRequest;
import java.io.*;
import java.time.format.DateTimeFormatter;
import java.util.logging.Logger;

public class CourseRequestDAO {
    private String basePath;
    private static final String APPLY_FILE_PATH = "WEB-INF/data/apply.txt";
    private static final DateTimeFormatter DATE_FORMAT = DateTimeFormatter.ofPattern("EEE MMM dd HH:mm:ss z yyyy");
    private static final Logger LOGGER = Logger.getLogger(CourseRequestDAO.class.getName());

    public CourseRequestDAO(String basePath) {
        this.basePath = basePath;
        ensureApplyFileExists();
    }

    private synchronized void ensureApplyFileExists() {
        File applyFile = new File(basePath, APPLY_FILE_PATH);
        try {
            File parentDir = applyFile.getParentFile();
            if (parentDir != null && !parentDir.exists()) {
                if (!parentDir.mkdirs()) {
                    LOGGER.severe("Failed to create parent directories for apply.txt at: " + parentDir.getAbsolutePath());
                    throw new IOException("Failed to create parent directories for apply.txt");
                }
                LOGGER.info("Created parent directories for apply.txt at: " + parentDir.getAbsolutePath());
            }
            if (!applyFile.exists()) {
                if (!applyFile.createNewFile()) {
                    LOGGER.severe("Failed to create apply.txt at: " + applyFile.getAbsolutePath());
                    throw new IOException("Failed to create apply.txt");
                }
                LOGGER.info("Created apply.txt at: " + applyFile.getAbsolutePath());
            }
            if (!applyFile.canWrite()) {
                LOGGER.severe("File is not writable: " + applyFile.getAbsolutePath());
                throw new IOException("File is not writable: " + applyFile.getAbsolutePath());
            }
            LOGGER.info("apply.txt is ready and writable at: " + applyFile.getAbsolutePath());
        } catch (IOException e) {
            LOGGER.severe("Error ensuring apply.txt exists: " + e.getMessage());
            throw new RuntimeException("Failed to initialize apply.txt: " + e.getMessage(), e);
        }
    }

    public synchronized void saveRequest(CourseRequest request) throws IOException {
        if (request == null) {
            LOGGER.warning("Attempted to save null CourseRequest");
            throw new IllegalArgumentException("CourseRequest cannot be null");
        }

        // Validate required fields
        if (request.getEmail() == null || request.getEmail().trim().isEmpty() ||
                request.getCourseCode() == null || request.getCourseCode().trim().isEmpty() ||
                request.getFullName() == null || request.getFullName().trim().isEmpty() ||
                request.getReason() == null || request.getReason().trim().isEmpty() ||
                request.getSubmissionTime() == null || request.getStatus() == null) {
            LOGGER.warning("Invalid CourseRequest data: " + request);
            throw new IllegalArgumentException("CourseRequest contains invalid or missing data");
        }

        File applyFile = new File(basePath, APPLY_FILE_PATH);
        ensureApplyFileExists(); // Ensure file is ready

        // Format the submission time
        String formattedSubmissionTime;
        try {
            formattedSubmissionTime = request.getSubmissionTime().format(DATE_FORMAT).trim();
        } catch (Exception e) {
            LOGGER.severe("Error formatting submission time: " + request.getSubmissionTime() + ". Error: " + e.getMessage());
            throw new IllegalArgumentException("Invalid submission time format: " + e.getMessage(), e);
        }

        // Format the request data as per the required CSV format
        String line = String.format("%s,%s,%s,%s,%s,%s,%s",
                escapeCsvValue(request.getEmail().trim()),
                escapeCsvValue(request.getCourseCode().trim()),
                escapeCsvValue(formattedSubmissionTime),
                escapeCsvValue(request.getStatus().trim()),
                escapeCsvValue(request.getFullName().trim()),
                escapeCsvValue(request.getReason().trim()),
                escapeCsvValue(request.getAdditionalNotes() != null ? request.getAdditionalNotes().trim() : ""));

        // Append the formatted line to apply.txt
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(applyFile, true))) {
            writer.write(line);
            writer.newLine();
            LOGGER.info("Successfully saved course request: " + line);
        } catch (IOException e) {
            LOGGER.severe("Error writing to apply.txt: " + e.getMessage() + " for request: " + line);
            throw e;
        }
    }

    private String escapeCsvValue(String value) {
        if (value == null) return "";
        // Escape commas and quotes within the value
        if (value.contains(",") || value.contains("\"")) {
            return "\"" + value.replace("\"", "\"\"") + "\"";
        }
        return value;
    }
}