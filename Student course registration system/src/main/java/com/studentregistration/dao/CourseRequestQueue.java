package com.studentregistration.dao;

import com.studentregistration.model.CourseRequest;
import java.io.*;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.PriorityQueue;
import java.util.logging.Logger;

public class CourseRequestQueue {
    private static final Logger LOGGER = Logger.getLogger(CourseRequestQueue.class.getName());
    private static final String APPLY_FILE_PATH = "WEB-INF/data/apply.txt";
    private static final DateTimeFormatter DATE_FORMAT = DateTimeFormatter.ofPattern("EEE MMM dd HH:mm:ss z yyyy");
    private PriorityQueue<CourseRequest> queue;
    private String basePath;

    public CourseRequestQueue(String basePath) {
        this.basePath = basePath;
        this.queue = new PriorityQueue<>((req1, req2) -> req1.getSubmissionTime().compareTo(req2.getSubmissionTime()));
        loadRequestsFromFile();
    }

    private void loadRequestsFromFile() {
        File applyFile = new File(basePath, APPLY_FILE_PATH);
        if (!applyFile.exists()) {
            LOGGER.warning("apply.txt does not exist at: " + applyFile.getAbsolutePath());
            return;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(applyFile))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.trim().isEmpty()) continue;
                CourseRequest request = parseLine(line);
                if (request != null) {
                    queue.offer(request);
                }
            }
            LOGGER.info("Loaded " + queue.size() + " course requests into the queue.");
        } catch (IOException e) {
            LOGGER.severe("Error reading apply.txt: " + e.getMessage());
        }
    }

    private CourseRequest parseLine(String line) {
        try {
            String[] parts = line.split(",", 7);
            if (parts.length < 5) {
                LOGGER.warning("Skipping malformed line in apply.txt: " + line);
                return null;
            }

            ZonedDateTime submissionTime = ZonedDateTime.parse(parts[2].trim(), DATE_FORMAT);

            return new CourseRequest(
                    parts[4].trim(), // courseCode
                    parts[0].trim(), // email
                    parts[1].trim(), // fullName
                    parts[5].trim(), // reason
                    parts.length > 6 ? parts[6].trim() : "", // additionalNotes
                    submissionTime,
                    parts[3].trim()  // status
            );
        } catch (DateTimeParseException e) {
            LOGGER.warning("Invalid timestamp in line: " + line + ". Error: " + e.getMessage());
            return null;
        } catch (Exception e) {
            LOGGER.warning("Error parsing line: " + line + ". Error: " + e.getMessage());
            return null;
        }
    }

    public void addRequest(CourseRequest request) {
        if (request == null) {
            LOGGER.warning("Cannot add null CourseRequest to queue.");
            return;
        }
        queue.offer(request);
        LOGGER.info("Added course request for: " + request.getEmail() + " to queue.");
    }

    public CourseRequest poll() {
        CourseRequest request = queue.poll();
        if (request != null) {
            LOGGER.info("Polled course request for: " + request.getEmail() + " from queue.");
        }
        return request;
    }

    public CourseRequest peek() {
        return queue.peek();
    }

    public boolean isEmpty() {
        return queue.isEmpty();
    }

    public int size() {
        return queue.size();
    }

    public void clear() {
        queue.clear();
        LOGGER.info("Cleared the course request queue.");
    }

    // Update the status of a request and save to apply.txt
    public void updateRequestStatus(String email, ZonedDateTime submissionTime, String newStatus) throws IOException {
        List<String> updatedLines = new ArrayList<>();
        File applyFile = new File(basePath, APPLY_FILE_PATH);
        boolean updated = false;

        // Read all lines and update the matching request
        try (BufferedReader reader = new BufferedReader(new FileReader(applyFile))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.trim().isEmpty()) continue;
                String[] parts = line.split(",", 7);
                if (parts.length < 5) {
                    updatedLines.add(line);
                    continue;
                }

                String lineEmail = parts[0].trim();
                ZonedDateTime lineTime = ZonedDateTime.parse(parts[2].trim(), DATE_FORMAT);

                if (lineEmail.equals(email) && lineTime.equals(submissionTime)) {
                    parts[3] = newStatus; // Update status
                    updated = true;
                    line = String.join(",", parts);
                }
                updatedLines.add(line);
            }
        } catch (IOException e) {
            LOGGER.severe("Error reading apply.txt for update: " + e.getMessage());
            throw e;
        }

        if (!updated) {
            LOGGER.warning("No matching request found for email: " + email + " at time: " + submissionTime);
            return;
        }

        // Write updated lines back to apply.txt
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(applyFile))) {
            for (String line : updatedLines) {
                writer.write(line);
                writer.newLine();
            }
            LOGGER.info("Updated status to " + newStatus + " for request from: " + email + " at " + submissionTime);
        } catch (IOException e) {
            LOGGER.severe("Error writing updated apply.txt: " + e.getMessage());
            throw e;
        }

        // Update the in-memory queue by reloading
        clear();
        loadRequestsFromFile();
    }
}