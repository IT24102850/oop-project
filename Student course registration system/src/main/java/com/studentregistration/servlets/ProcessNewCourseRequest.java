package com.studentregistration.servlets;

import com.studentregistration.dao.CourseRequestDAO;
import com.studentregistration.model.CourseRequest;
import com.studentregistration.model.User;
import com.studentregistration.util.ValidationUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.logging.*;

@WebServlet("/ProcessNewCourseRequest")
public class ProcessNewCourseRequest extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CourseRequestDAO courseRequestDAO;
    private static final Logger LOGGER = Logger.getLogger(ProcessNewCourseRequest.class.getName());

    @Override
    public void init() throws ServletException {
        try {
            // Initialize CourseRequestDAO with the real path
            String basePath = getServletContext().getRealPath("/");
            courseRequestDAO = new CourseRequestDAO(basePath);

            // Set up logging to WEB-INF/logs directory
            String logPath = basePath + "WEB-INF/logs/";
            new File(logPath).mkdirs(); // Ensure logs directory exists
            FileHandler fileHandler = new FileHandler(logPath + "course_requests.log", true);
            fileHandler.setFormatter(new SimpleFormatter());
            LOGGER.addHandler(fileHandler);
            LOGGER.setLevel(Level.ALL);

            LOGGER.info("ProcessNewCourseRequest servlet initialized successfully");
        } catch (IOException e) {
            LOGGER.severe("Failed to initialize servlet: " + e.getMessage());
            throw new ServletException("Failed to initialize servlet", e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // Check session and authentication
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                out.write("Please log in to submit a course request");
                LOGGER.warning("Unauthorized access attempt to course request");
                return;
            }

            // Get user from session
            User user = (User) session.getAttribute("user");
            String email = user.getEmail();

            // Get and validate form parameters
            String fullName = request.getParameter("fullName");
            String courseId = request.getParameter("course");
            String reason = request.getParameter("reason");
            String additionalNotes = request.getParameter("additionalNotes");
            boolean termsAccepted = request.getParameter("terms") != null;

            // Validate required fields
            if (!ValidationUtils.isNotEmpty(fullName) ||
                    !ValidationUtils.isNotEmpty(courseId) ||
                    !ValidationUtils.isNotEmpty(reason)) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.write("Full name, course, and reason are required");
                LOGGER.warning("Missing required fields in course request");
                return;
            }

            // Validate email format (from session user)
            if (!ValidationUtils.isValidEmail(email)) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.write("Invalid email format");
                LOGGER.warning("Invalid email format: " + email);
                return;
            }

            // Validate terms acceptance
            if (!termsAccepted) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.write("You must accept the terms and conditions");
                LOGGER.warning("Terms not accepted by user: " + email);
                return;
            }

            // Create and save course request
            CourseRequest courseRequest = new CourseRequest(
                    fullName,
                    email,
                    courseId,
                    reason,
                    additionalNotes,
                    termsAccepted
            );

            // Save the request using CourseRequestDAO
            try {
                courseRequestDAO.saveRequest(courseRequest);
            } catch (IOException e) {
                LOGGER.severe("Failed to save course request for user " + email + ": " + e.getMessage());
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                out.write("Failed to save request: " + e.getMessage());
                return;
            }

            LOGGER.info(String.format(
                    "New course request saved: User=%s, Course=%s, Time=%s",
                    email,
                    courseId,
                    courseRequest.getSubmissionTime()
            ));

            // Success response
            response.setStatus(HttpServletResponse.SC_OK);
            out.write("Request submitted successfully!");
        } catch (Exception e) {
            LOGGER.severe("Error processing course request: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.write("Failed to process request: " + e.getMessage());
        } finally {
            if (out != null) {
                out.close();
            }
        }
    }
}