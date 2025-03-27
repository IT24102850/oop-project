package com.studentregistration.utils;

import com.studentregistration.model.Student;
import java.util.regex.Pattern;
import java.util.List;

public class ValidationUtils {

    // Regex patterns for validation
    private static final Pattern EMAIL_PATTERN =
            Pattern.compile("^[A-Za-z0-9+_.-]+@(.+)$");
    private static final Pattern PHONE_PATTERN =
            Pattern.compile("^[0-9]{10,15}$");
    private static final Pattern ID_PATTERN =
            Pattern.compile("^[A-Za-z0-9-]+$");
    private static final Pattern NAME_PATTERN =
            Pattern.compile("^[A-Za-z ]{2,50}$");

    // Student validation
    public static void validateStudent(Student student) throws IllegalArgumentException {
        if (student == null) {
            throw new IllegalArgumentException("Student cannot be null");
        }

        validateField(student.getStudentId(), "Student ID", ID_PATTERN);
        validateField(student.getFirstName(), "First Name", NAME_PATTERN);
        validateField(student.getLastName(), "Last Name", NAME_PATTERN);
        validateField(student.getEmail(), "Email", EMAIL_PATTERN);
        validateField(student.getPhoneNumber(), "Phone Number", PHONE_PATTERN);

        if (student.getAddress() == null || student.getAddress().trim().isEmpty()) {
            throw new IllegalArgumentException("Address cannot be empty");
        }
    }

    // Generic field validation
    private static void validateField(String value, String fieldName, Pattern pattern) {
        if (value == null || value.trim().isEmpty()) {
            throw new IllegalArgumentException(fieldName + " cannot be empty");
        }

        if (!pattern.matcher(value).matches()) {
            throw new IllegalArgumentException("Invalid " + fieldName + " format");
        }
    }

    // Check for duplicate student ID
    public static void checkDuplicateId(String studentId, List<Student> existingStudents) {
        if (existingStudents.stream()
                .anyMatch(s -> s.getStudentId().equalsIgnoreCase(studentId))) {
            throw new IllegalArgumentException("Student ID already exists");
        }
    }

    // Password validation
    public static void validatePassword(String password) {
        if (password == null || password.length() < 8) {
            throw new IllegalArgumentException("Password must be at least 8 characters");
        }

        if (!password.matches(".*[A-Z].*")) {
            throw new IllegalArgumentException("Password must contain at least one uppercase letter");
        }

        if (!password.matches(".*[a-z].*")) {
            throw new IllegalArgumentException("Password must contain at least one lowercase letter");
        }

        if (!password.matches(".*[0-9].*")) {
            throw new IllegalArgumentException("Password must contain at least one digit");
        }
    }

    // Username validation
    public static void validateUsername(String username) {
        if (username == null || username.length() < 4) {
            throw new IllegalArgumentException("Username must be at least 4 characters");
        }

        if (!username.matches("^[A-Za-z0-9_]+$")) {
            throw new IllegalArgumentException("Username can only contain letters, numbers and underscores");
        }
    }

    // Email validation (standalone method)
    public static boolean isValidEmail(String email) {
        return email != null && EMAIL_PATTERN.matcher(email).matches();
    }

    // Phone number validation (standalone method)
    public static boolean isValidPhone(String phone) {
        return phone != null && PHONE_PATTERN.matcher(phone).matches();
    }
}
