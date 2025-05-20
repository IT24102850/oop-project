package com.studentregistration.servlets;

import com.studentregistration.dao.CourseRequestDAO;
import com.studentregistration.dao.CourseRequestQueue;
import com.studentregistration.model.CourseRequest;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

public class ProcessNewCourseRequest extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(ProcessNewCourseRequest.class.getName());
    private CourseRequestDAO courseRequestDAO;
    private CourseRequestQueue courseRequestQueue;
    private static final DateTimeFormatter TIMESTAMP_FORMATTER = DateTimeFormatter.ofPattern("EEE MMM dd HH:mm:ss z yyyy");

    @Override
    public void init() throws ServletException {
        String basePath = getServletContext().getRealPath("/");
        courseRequestDAO = new CourseRequestDAO(basePath);
        courseRequestQueue = new CourseRequestQueue(basePath);
        LOGGER.info("ProcessNewCourseRequest servlet initialized with base path: " + basePath);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String requestId = request.getParameter("requestId");
        String activeTab = request.getParameter("activeTab");

        if (action == null) {
            LOGGER.warning("Action parameter is null. Redirecting to admin dashboard with error.");
            response.sendRedirect("admin-dashboard.jsp?activeTab=course-requests&error=invalid_input");
            return;
        }

        String applyFilePath = getServletContext().getRealPath("/WEB-INF/data/apply.txt");

        if ("submit".equals(action)) {
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String courseCode = request.getParameter("course");
            String reason = request.getParameter("reason");
            String additionalNotes = request.getParameter("additionalNotes");

            if (email == null || email.trim().isEmpty() || courseCode == null || courseCode.trim().isEmpty() ||
                    fullName == null || fullName.trim().isEmpty() || reason == null || reason.trim().isEmpty()) {
                LOGGER.warning("Invalid course request submission: Missing required fields. Email: " + email + ", Course: " + courseCode + ", FullName: " + fullName + ", Reason: " + reason);
                response.sendRedirect("ApplyNewCourse.jsp?error=invalid_input");
                return;
            }

            if (containsInappropriateContent(reason) || (additionalNotes != null && containsInappropriateContent(additionalNotes))) {
                LOGGER.warning("Inappropriate content detected in request from: " + email);
                response.sendRedirect("ApplyNewCourse.jsp?error=inappropriate_content");
                return;
            }

            ZonedDateTime submissionTime = ZonedDateTime.now();

            CourseRequest courseRequest = new CourseRequest(
                    fullName,
                    email,
                    courseCode,
                    reason,
                    additionalNotes,
                    submissionTime,
                    "pending"
            );

            try {
                courseRequestDAO.saveRequest(courseRequest);
                courseRequestQueue.addRequest(courseRequest);
                LOGGER.info("Course request submitted successfully for email: " + email + ", course: " + courseCode);
            } catch (IOException e) {
                LOGGER.severe("Error saving course request: " + e.getMessage());
                response.sendRedirect("ApplyNewCourse.jsp?error=server_error");
                return;
            }

            response.sendRedirect("ApplyNewCourse.jsp?message=request_submitted");
            return;
        }

        if (requestId == null) {
            LOGGER.warning("Request ID is null for action: " + action);
            response.sendRedirect("admin-dashboard.jsp?activeTab=course-requests&error=invalid_input");
            return;
        }

        List<String> updatedLines = new ArrayList<>();
        boolean requestFound = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(applyFilePath))) {
            String line;
            int currentId = 1;
            while ((line = reader.readLine()) != null) {
                if (line.trim().isEmpty()) continue;
                if (String.valueOf(currentId).equals(requestId)) {
                    String[] parts = line.split(",", 7);
                    if (parts.length >= 4 && "pending".equals(parts[3].trim())) {
                        String newStatus = "approve".equals(action) ? "approved" : "rejected";
                        parts[3] = newStatus;
                        line = String.join(",", parts);
                        requestFound = true;

                        CourseRequest queuedRequest = courseRequestQueue.peek();
                        if (queuedRequest != null && queuedRequest.getEmail().equals(parts[0].trim()) &&
                                queuedRequest.getSubmissionTime().format(TIMESTAMP_FORMATTER).equals(parts[2].trim())) {
                            ZonedDateTime queuedSubmissionTime = queuedRequest.getSubmissionTime();
                            courseRequestQueue.updateRequestStatus(parts[0].trim(), queuedSubmissionTime, newStatus);
                            LOGGER.info("Updated status in queue for email: " + parts[0] + " to " + newStatus);
                        }
                    }
                }
                updatedLines.add(line);
                currentId++;
            }
        } catch (IOException e) {
            LOGGER.severe("Error reading apply.txt: " + e.getMessage());
            response.sendRedirect("admin-dashboard.jsp?activeTab=course-requests&error=server_error");
            return;
        }

        if (!requestFound) {
            LOGGER.warning("Request ID " + requestId + " not found or not pending.");
            response.sendRedirect("admin-dashboard.jsp?activeTab=course-requests&error=request_not_found");
            return;
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(applyFilePath))) {
            for (String line : updatedLines) {
                writer.write(line);
                writer.newLine();
            }
        } catch (IOException e) {
            LOGGER.severe("Error writing to apply.txt: " + e.getMessage());
            response.sendRedirect("admin-dashboard.jsp?activeTab=course-requests&error=server_error");
            return;
        }

        String message = "approve".equals(action) ? "request_approved" : "request_rejected";
        LOGGER.info("Action " + action + " completed for request ID " + requestId);
        response.sendRedirect("admin-dashboard.jsp?activeTab=course-requests&message=" + message);
    }

    private boolean containsInappropriateContent(String text) {
        if (text == null) return false;
        String[] bannedWords = {"inappropriate", "offensive", "spam", "hate"};
        String lowerText = text.toLowerCase();
        for (String word : bannedWords) {
            if (lowerText.contains(word)) {
                return true;
            }
        }
        return false;
    }
}