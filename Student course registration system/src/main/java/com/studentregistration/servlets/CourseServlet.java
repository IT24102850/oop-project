package com.studentregistration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;
import java.util.stream.Collectors;

@WebServlet("/course")
public class CourseServlet extends HttpServlet {
    private static final String COURSES_FILE = "/WEB-INF/data/courses.txt";
    private static final Logger LOGGER = Logger.getLogger(CourseServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("userType"))) {
            LOGGER.warning("Unauthorized access attempt to /course (GET). Redirecting to logIn.jsp.");
            response.sendRedirect("logIn.jsp");
            return;
        }

        String action = request.getParameter("action");
        if ("view".equals(action)) {
            handleViewCourses(request, response);
        } else {
            LOGGER.info("No valid action provided for GET request. Redirecting to admin-dashboard.jsp.");
            response.sendRedirect("admin-dashboard.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("userType"))) {
            LOGGER.warning("Unauthorized access attempt to /course (POST). Redirecting to logIn.jsp.");
            response.sendRedirect("logIn.jsp");
            return;
        }

        String action = request.getParameter("action");
        if ("create".equals(action)) {
            handleCreateCourse(request, response);
        } else if ("update".equals(action)) {
            handleUpdateCourse(request, response);
        } else if ("archive".equals(action)) {
            handleArchiveCourse(request, response);
        } else if ("delete".equals(action)) {
            handleDeleteCourse(request, response);
        } else {
            LOGGER.info("No valid action provided for POST request. Redirecting to admin-dashboard.jsp.");
            response.sendRedirect("admin-dashboard.jsp");
        }
    }

    private void handleCreateCourse(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String courseCode = sanitizeInput(request.getParameter("courseCode"));
        String title = sanitizeInput(request.getParameter("title"));
        String creditsStr = request.getParameter("credits");
        String department = sanitizeInput(request.getParameter("department"));
        String professor = sanitizeInput(request.getParameter("professor"));
        String syllabus = sanitizeInput(request.getParameter("syllabus"));

        // Validate required fields
        if (courseCode == null || title == null || creditsStr == null || department == null ||
                courseCode.trim().isEmpty() || title.trim().isEmpty() || creditsStr.trim().isEmpty() || department.trim().isEmpty()) {
            LOGGER.warning("Create course failed: All required fields must be filled.");
            request.setAttribute("error", "All required fields must be filled.");
            request.setAttribute("activeTab", "courses");
            request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
            return;
        }

        // Validate credits as a positive integer
        int credits;
        try {
            credits = Integer.parseInt(creditsStr);
            if (credits <= 0) {
                LOGGER.warning("Create course failed: Credits must be a positive number.");
                request.setAttribute("error", "Credits must be a positive number.");
                request.setAttribute("activeTab", "courses");
                request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
                return;
            }
        } catch (NumberFormatException e) {
            LOGGER.warning("Create course failed: Invalid credits value: " + creditsStr);
            request.setAttribute("error", "Credits must be a valid number.");
            request.setAttribute("activeTab", "courses");
            request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
            return;
        }

        // Default values for optional fields
        professor = (professor != null && !professor.trim().isEmpty()) ? professor : "TBD";
        syllabus = (syllabus != null && !syllabus.trim().isEmpty()) ? syllabus : "Not specified";

        // Read existing courses
        List<String> courses = readCourses(request);
        // Check for duplicate course code
        if (courses.stream().anyMatch(course -> course.startsWith(courseCode + ","))) {
            LOGGER.warning("Create course failed: Course code " + courseCode + " already exists.");
            request.setAttribute("error", "Course code already exists.");
            request.setAttribute("activeTab", "courses");
            request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
            return;
        }

        // Add new course
        String newCourse = String.format("%s,%s,%d,%s,%s,%s,true", courseCode, title, credits, department, professor, syllabus);
        courses.add(newCourse);
        writeCourses(request, courses);

        LOGGER.info("Course created successfully: " + courseCode);
        request.setAttribute("message", "Course created successfully.");
        request.setAttribute("courses", courses);
        request.setAttribute("activeTab", "courses");
        request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
    }

    private void handleUpdateCourse(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String originalCourseCode = sanitizeInput(request.getParameter("originalCourseCode"));
        String courseCode = sanitizeInput(request.getParameter("courseCode"));
        String title = sanitizeInput(request.getParameter("title"));
        String creditsStr = request.getParameter("credits");
        String department = sanitizeInput(request.getParameter("department"));
        String professor = sanitizeInput(request.getParameter("professor"));
        String syllabus = sanitizeInput(request.getParameter("syllabus"));

        // Validate required fields
        if (courseCode == null || title == null || creditsStr == null || department == null ||
                courseCode.trim().isEmpty() || title.trim().isEmpty() || creditsStr.trim().isEmpty() || department.trim().isEmpty()) {
            LOGGER.warning("Update course failed: All required fields must be filled.");
            request.setAttribute("error", "All required fields must be filled.");
            request.setAttribute("activeTab", "courses");
            request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
            return;
        }

        // Validate credits as a positive integer
        int credits;
        try {
            credits = Integer.parseInt(creditsStr);
            if (credits <= 0) {
                LOGGER.warning("Update course failed: Credits must be a positive number.");
                request.setAttribute("error", "Credits must be a positive number.");
                request.setAttribute("activeTab", "courses");
                request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
                return;
            }
        } catch (NumberFormatException e) {
            LOGGER.warning("Update course failed: Invalid credits value: " + creditsStr);
            request.setAttribute("error", "Credits must be a valid number.");
            request.setAttribute("activeTab", "courses");
            request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
            return;
        }

        // Default values for optional fields
        professor = (professor != null && !professor.trim().isEmpty()) ? professor : "TBD";
        syllabus = (syllabus != null && !syllabus.trim().isEmpty()) ? syllabus : "Not specified";

        // Read existing courses
        List<String> courses = readCourses(request);
        boolean courseFound = false;

        // Update the course
        for (int i = 0; i < courses.size(); i++) {
            String[] parts = courses.get(i).split(",");
            if (parts[0].equals(originalCourseCode)) {
                courses.set(i, String.format("%s,%s,%d,%s,%s,%s,%s", courseCode, title, credits, department, professor, syllabus, parts[6]));
                courseFound = true;
                break;
            }
        }

        if (!courseFound) {
            LOGGER.warning("Update course failed: Course with code " + originalCourseCode + " not found.");
            request.setAttribute("error", "Course not found.");
            request.setAttribute("activeTab", "courses");
            request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
            return;
        }

        writeCourses(request, courses);
        LOGGER.info("Course updated successfully: " + courseCode);
        request.setAttribute("message", "Course updated successfully.");
        request.setAttribute("courses", courses);
        request.setAttribute("activeTab", "courses");
        request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
    }

    private void handleViewCourses(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<String> courses = readCourses(request);
        List<String> filteredCourses = applyFilters(courses, request.getParameter("department"), request.getParameter("credits"));

        LOGGER.info("Viewing courses. Total courses: " + courses.size() + ", filtered: " + filteredCourses.size());
        request.setAttribute("courses", filteredCourses);
        request.setAttribute("activeTab", "courses");
        request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
    }

    private void handleArchiveCourse(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String courseCode = sanitizeInput(request.getParameter("courseCode"));

        if (courseCode == null || courseCode.trim().isEmpty()) {
            LOGGER.warning("Archive course failed: Invalid course code.");
            request.setAttribute("error", "Invalid course code.");
            request.setAttribute("activeTab", "courses");
            request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
            return;
        }

        List<String> courses = readCourses(request);
        boolean courseFound = false;

        // Archive the course (set isActive to false)
        for (int i = 0; i < courses.size(); i++) {
            String[] parts = courses.get(i).split(",");
            if (parts[0].equals(courseCode)) {
                courses.set(i, String.format("%s,%s,%s,%s,%s,%s,false", parts[0], parts[1], parts[2], parts[3], parts[4], parts[5]));
                courseFound = true;
                break;
            }
        }

        if (!courseFound) {
            LOGGER.warning("Archive course failed: Course with code " + courseCode + " not found.");
            request.setAttribute("error", "Course not found.");
            request.setAttribute("activeTab", "courses");
            request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
            return;
        }

        writeCourses(request, courses);
        LOGGER.info("Course archived successfully: " + courseCode);
        request.setAttribute("message", "Course archived successfully.");
        request.setAttribute("courses", courses);
        request.setAttribute("activeTab", "courses");
        request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
    }

    private void handleDeleteCourse(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String courseCode = sanitizeInput(request.getParameter("courseCode"));

        if (courseCode == null || courseCode.trim().isEmpty()) {
            LOGGER.warning("Delete course failed: Invalid course code.");
            request.setAttribute("error", "Invalid course code.");
            request.setAttribute("activeTab", "courses");
            request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
            return;
        }

        List<String> courses = readCourses(request);
        int initialSize = courses.size();

        // Log the course details before deletion for debugging
        String courseToDelete = courses.stream()
                .filter(course -> course.startsWith(courseCode + ","))
                .findFirst()
                .orElse(null);

        if (courseToDelete == null) {
            LOGGER.warning("Delete course failed: Course with code " + courseCode + " not found.");
            request.setAttribute("error", "Course with code " + courseCode + " not found.");
            request.setAttribute("activeTab", "courses");
            request.setAttribute("courses", courses);
            request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
            return;
        }

        LOGGER.info("Attempting to delete course: " + courseToDelete);

        // Filter out the course to delete
        List<String> updatedCourses = courses.stream()
                .filter(course -> !course.startsWith(courseCode + ","))
                .collect(Collectors.toList());

        // Double-check if the course was actually removed
        if (updatedCourses.size() >= initialSize) {
            LOGGER.severe("Delete course failed: Course with code " + courseCode + " was not removed from the list.");
            request.setAttribute("error", "Failed to delete course with code " + courseCode + ". Please try again.");
            request.setAttribute("activeTab", "courses");
            request.setAttribute("courses", courses);
            request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
            return;
        }

        // Write the updated list back to the file with error handling
        try {
            writeCourses(request, updatedCourses);
        } catch (IOException e) {
            LOGGER.severe("Failed to write updated courses file after deletion: " + e.getMessage());
            request.setAttribute("error", "Failed to delete course due to a server error. Please try again later.");
            request.setAttribute("activeTab", "courses");
            request.setAttribute("courses", courses); // Revert to original list
            request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
            return;
        }

        LOGGER.info("Course deleted successfully: " + courseCode + ". Courses before: " + initialSize + ", after: " + updatedCourses.size());

        // Apply filters if they were present (same as in handleViewCourses)
        List<String> filteredCourses = applyFilters(updatedCourses, request.getParameter("department"), request.getParameter("credits"));

        request.setAttribute("message", "Course with code " + courseCode + " deleted successfully.");
        request.setAttribute("courses", filteredCourses);
        request.setAttribute("activeTab", "courses");
        request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
    }

    private List<String> applyFilters(List<String> courses, String departmentFilter, String creditsFilter) {
        List<String> filteredCourses = new ArrayList<>(courses);

        // Apply department filter
        if (departmentFilter != null && !departmentFilter.isEmpty()) {
            filteredCourses = filteredCourses.stream()
                    .filter(course -> course.split(",")[3].equals(departmentFilter))
                    .collect(Collectors.toList());
        }

        // Apply credits filter
        if (creditsFilter != null && !creditsFilter.isEmpty()) {
            filteredCourses = filteredCourses.stream()
                    .filter(course -> course.split(",")[2].equals(creditsFilter))
                    .collect(Collectors.toList());
        }

        return filteredCourses;
    }

    private List<String> readCourses(HttpServletRequest request) throws IOException {
        List<String> courses = new ArrayList<>();
        String filePath = request.getServletContext().getRealPath(COURSES_FILE);
        File file = new File(filePath);

        if (!file.exists()) {
            file.getParentFile().mkdirs();
            file.createNewFile();
            LOGGER.info("Created new courses file at: " + filePath);
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (!line.trim().isEmpty()) {
                    courses.add(line.trim());
                }
            }
        } catch (IOException e) {
            LOGGER.severe("Failed to read courses file: " + e.getMessage());
            throw e;
        }
        return courses;
    }

    private void writeCourses(HttpServletRequest request, List<String> courses) throws IOException {
        String filePath = request.getServletContext().getRealPath(COURSES_FILE);
        File file = new File(filePath);

        // Create a temporary file to write the updated data
        File tempFile = new File(filePath + ".tmp");
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(tempFile))) {
            for (String course : courses) {
                writer.write(course);
                writer.newLine();
            }
        } catch (IOException e) {
            LOGGER.severe("Failed to write to temporary courses file: " + e.getMessage());
            throw e;
        }

        // Replace the original file with the temporary file
        if (!tempFile.renameTo(file)) {
            LOGGER.severe("Failed to replace original courses file with updated file.");
            throw new IOException("Failed to replace courses file with updated data.");
        }
    }

    private String sanitizeInput(String input) {
        if (input == null) {
            return null;
        }
        // Enhanced sanitization: remove potential script tags and replace commas
        return input.replaceAll("[<>{}\\[\\];]", "") // Remove potential script characters
                .replace(",", "\\,")
                .trim();
    }
}