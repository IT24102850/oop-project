package com.studentregistration.dao;

import com.studentregistration.model.Course;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class CourseDAO {
    private static final String FILE_PATH = "src/main/resources/courses.txt";

    // Read all courses
    public List<Course> getAllCourses() {
        List<Course> courses = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");
                Course course = new Course(data[0], data[1], data[2], Integer.parseInt(data[3]));
                courses.add(course);
            }
        } catch (IOException e) {
            System.err.println("Error reading courses: " + e.getMessage());
        }
        return courses;
    }

    // Add a new course
    public boolean addCourse(Course course) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            writer.write(course.toString() + "\n");
            return true;
        } catch (IOException e) {
            System.err.println("Error adding course: " + e.getMessage());
            return false;
        }
    }

    // Update a course by ID
    public boolean updateCourse(String courseId, Course updatedCourse) {
        List<Course> courses = getAllCourses();
        boolean found = false;
        for (int i = 0; i < courses.size(); i++) {
            if (courses.get(i).getCourseId().equals(courseId)) {
                courses.set(i, updatedCourse);
                found = true;
                break;
            }
        }
        if (!found) return false;

        return rewriteFile(courses);
    }

    // Delete a course by ID
    public boolean deleteCourse(String courseId) {
        List<Course> courses = getAllCourses();
        boolean removed = courses.removeIf(c -> c.getCourseId().equals(courseId));
        if (!removed) return false;

        return rewriteFile(courses);
    }

    // Helper: Rewrite the entire file
    private boolean rewriteFile(List<Course> courses) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Course c : courses) {
                writer.write(c.toString() + "\n");
            }
            return true;
        } catch (IOException e) {
            System.err.println("Error updating file: " + e.getMessage());
            return false;
        }
    }

    // (Optional) Find course by ID
    public Course getCourseById(String courseId) {
        return getAllCourses().stream()
                .filter(c -> c.getCourseId().equals(courseId))
                .findFirst()
                .orElse(null);
    }
}