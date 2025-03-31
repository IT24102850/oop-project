package com.studentregistration.dao;

import com.studentregistration.model.Enrollment;
import com.studentregistration.util.FileUtil;
import com.studentregistration.util.ValidationUtils;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class RegistrationDAO {
    private static final String ENROLLMENT_FILE = "enrollments.txt";
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ISO_LOCAL_DATE;
    private static final String DEADLINE = "2023-12-15"; // Example deadline

    // C: Enroll student in multiple courses
    public boolean enrollStudent(String studentEmail, List<String> courseIds, String section) throws IOException {
        if (!ValidationUtils.isValidEmail(studentEmail)) {
            return false;
        }

        String enrollmentDate = LocalDate.now().format(DATE_FORMATTER);
        List<Enrollment> existingEnrollments = getAllEnrollments();

        for (String courseId : courseIds) {
            // Check if already enrolled
            boolean alreadyEnrolled = existingEnrollments.stream()
                    .anyMatch(e -> e.getStudentEmail().equals(studentEmail)
                            && e.getCourseId().equals(courseId));

            if (alreadyEnrolled) {
                continue; // Skip already enrolled courses
            }

            Enrollment enrollment = new Enrollment(
                    studentEmail,
                    courseId,
                    section,
                    enrollmentDate
            );

            FileUtil.writeToFile(ENROLLMENT_FILE, enrollment.toFileString(), true);
        }
        return true;
    }

    // R: View enrollment lists with student-course mapping
    public List<Enrollment> getAllEnrollments() throws IOException {
        List<String> enrollmentLines = FileUtil.readAllLines(ENROLLMENT_FILE);
        List<Enrollment> enrollments = new ArrayList<>();

        for (String line : enrollmentLines) {
            String[] parts = line.split("\\|");
            if (parts.length >= 4) {
                enrollments.add(new Enrollment(
                        parts[0], // studentEmail
                        parts[1], // courseId
                        parts[2], // section
                        parts[3]  // enrollmentDate
                ));
            }
        }
        return enrollments;
    }

    public List<Enrollment> getEnrollmentsByStudent(String studentEmail) throws IOException {
        return getAllEnrollments().stream()
                .filter(e -> e.getStudentEmail().equals(studentEmail))
                .collect(Collectors.toList());
    }

    public List<Enrollment> getEnrollmentsByCourse(String courseId) throws IOException {
        return getAllEnrollments().stream()
                .filter(e -> e.getCourseId().equals(courseId))
                .collect(Collectors.toList());
    }

    // U: Change student's course section
    public boolean changeSection(String studentEmail, String courseId, String newSection) throws IOException {
        List<Enrollment> enrollments = getAllEnrollments();
        boolean updated = false;

        for (Enrollment enrollment : enrollments) {
            if (enrollment.getStudentEmail().equals(studentEmail)
                    && enrollment.getCourseId().equals(courseId)) {
                enrollment.setSection(newSection);
                updated = true;
                break;
            }
        }

        if (updated) {
            rewriteEnrollmentsFile(enrollments);
            return true;
        }
        return false;
    }

    // D: Drop course enrollment before deadline
    public boolean dropEnrollment(String studentEmail, String courseId) throws IOException {
        if (LocalDate.now().isAfter(LocalDate.parse(DEADLINE))) {
            return false; // Past deadline
        }

        List<Enrollment> enrollments = getAllEnrollments();
        boolean removed = enrollments.removeIf(e ->
                e.getStudentEmail().equals(studentEmail)
                        && e.getCourseId().equals(courseId));

        if (removed) {
            rewriteEnrollmentsFile(enrollments);
            return true;
        }
        return false;
    }

    // Helper method to rewrite entire enrollments file
    private void rewriteEnrollmentsFile(List<Enrollment> enrollments) throws IOException {
        List<String> lines = enrollments.stream()
                .map(Enrollment::toFileString)
                .collect(Collectors.toList());

        FileUtil.rewriteFile(ENROLLMENT_FILE, lines);
    }

    // Check if student is enrolled in a course
    public boolean isEnrolled(String studentEmail, String courseId) throws IOException {
        return getAllEnrollments().stream()
                .anyMatch(e -> e.getStudentEmail().equals(studentEmail)
                        && e.getCourseId().equals(courseId));
    }

    // Get count of enrollments for a course
    public int getEnrollmentCount(String courseId) throws IOException {
        return (int) getAllEnrollments().stream()
                .filter(e -> e.getCourseId().equals(courseId))
                .count();
    }
}
//update