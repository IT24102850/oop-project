package com.studentregistration.dao;

import com.studentregistration.model.Course;
import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

public class CourseDAO {
    private final String filePath;
    private static final Logger LOGGER = Logger.getLogger(CourseDAO.class.getName());

    // Constructor to allow dynamic file path
    public CourseDAO(String filePath) {
        this.filePath = filePath;
    }

    // Read all courses
    public synchronized List<Course> getAllCourses() {
        List<Course> courses = new ArrayList<>();
        File file = new File(filePath);

        // Ensure the file exists
        try {
            if (!file.exists()) {
                file.getParentFile().mkdirs();
                file.createNewFile();
                LOGGER.info("Created new courses file at: " + filePath);
            }
        } catch (IOException e) {
            LOGGER.severe("Failed to create courses file: " + e.getMessage());
            return courses;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.trim().isEmpty()) continue;

                String[] data = line.split(",");
                // Validate the number of fields
                if (data.length != 4) {
                    LOGGER.warning("Invalid course data: " + line);
                    continue;
                }

                try {
                    String courseId = data[0].replace("\\,", ",");
                    String title = data[1].replace("\\,", ",");
                    String department = data[2].replace("\\,", ",");
                    int credits = Integer.parseInt(data[3]);
                    if (credits <= 0) {
                        LOGGER.warning("Invalid credits for course " + courseId + ": " + credits);
                        continue;
                    }

                    Course course = new Course(courseId, title, department, credits);
                    courses.add(course);
                } catch (NumberFormatException e) {
                    LOGGER.warning("Invalid credits format in course data: " + line);
                }
            }
        } catch (IOException e) {
            LOGGER.severe("Error reading courses: " + e.getMessage());
        }
        return courses;
    }

    // Add a new course
    public synchronized boolean addCourse(Course course) {
        if (course == null || course.getCourseId() == null || course.getTitle() == null || course.getDepartment() == null) {
            LOGGER.warning("Cannot add course: Invalid course data.");
            return false;
        }

        // Check for duplicate course ID
        List<Course> courses = getAllCourses();
        if (courses.stream().anyMatch(c -> c.getCourseId().equals(course.getCourseId()))) {
            LOGGER.warning("Course with ID " + course.getCourseId() + " already exists.");
            return false;
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
            String courseData = sanitize(course.getCourseId()) + "," +
                    sanitize(course.getTitle()) + "," +
                    sanitize(course.getDepartment()) + "," +
                    course.getCredits() + "\n";
            writer.write(courseData);
            LOGGER.info("Course added successfully: " + course.getCourseId());
            return true;
        } catch (IOException e) {
            LOGGER.severe("Error adding course: " + e.getMessage());
            return false;
        }
    }

    // Update a course by ID
    public synchronized boolean updateCourse(String courseId, Course updatedCourse) {
        if (courseId == null || updatedCourse == null) {
            LOGGER.warning("Cannot update course: Invalid input.");
            return false;
        }

        List<Course> courses = getAllCourses();
        boolean found = false;
        for (int i = 0; i < courses.size(); i++) {
            if (courses.get(i).getCourseId().equals(courseId)) {
                courses.set(i, updatedCourse);
                found = true;
                break;
            }
        }
        if (!found) {
            LOGGER.warning("Course with ID " + courseId + " not found for update.");
            return false;
        }

        boolean success = rewriteFile(courses);
        if (success) {
            LOGGER.info("Course updated successfully: " + courseId);
        }
        return success;
    }

    // Delete a course by ID
    public synchronized boolean deleteCourse(String courseId) {
        if (courseId == null) {
            LOGGER.warning("Cannot delete course: Invalid course ID.");
            return false;
        }

        List<Course> courses = getAllCourses();
        int initialSize = courses.size();
        boolean removed = courses.removeIf(c -> c.getCourseId().equals(courseId));

        if (!removed) {
            LOGGER.warning("Course with ID " + courseId + " not found for deletion.");
            return false;
        }

        boolean success = rewriteFile(courses);
        if (success) {
            LOGGER.info("Course deleted successfully: " + courseId + ". Courses before: " + initialSize + ", after: " + courses.size());
        }
        return success;
    }

    // Helper: Rewrite the entire file
    private boolean rewriteFile(List<Course> courses) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            for (Course c : courses) {
                String courseData = sanitize(c.getCourseId()) + "," +
                        sanitize(c.getTitle()) + "," +
                        sanitize(c.getDepartment()) + "," +
                        c.getCredits() + "\n";
                writer.write(courseData);
            }
            return true;
        } catch (IOException e) {
            LOGGER.severe("Error rewriting courses file: " + e.getMessage());
            return false;
        }
    }

    // Find course by ID
    public Course getCourseById(String courseId) {
        return getAllCourses().stream()
                .filter(c -> c.getCourseId().equals(courseId))
                .findFirst()
                .orElse(null);
    }

    // Sanitize input to prevent CSV injection
    private String sanitize(String input) {
        if (input == null) {
            return "";
        }
        return input.replace(",", "\\,").trim();
    }
}