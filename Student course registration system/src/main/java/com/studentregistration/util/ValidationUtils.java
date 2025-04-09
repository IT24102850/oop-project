package com.studentregistration.util;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.regex.Pattern;

public class ValidationUtils {
    // Email validation pattern
    private static final Pattern EMAIL_PATTERN = Pattern.compile(
            "^[A-Za-z0-9+_.-]+@(.+)$"
    );

    // Password requirements:
    // - At least 8 characters
    // - At least one uppercase letter
    // - At least one lowercase letter
    // - At least one digit
    private static final Pattern PASSWORD_PATTERN = Pattern.compile(
            "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{8,}$"
    );

    // Name validation: letters, spaces, hyphens, and apostrophes
    private static final Pattern NAME_PATTERN = Pattern.compile(
            "^[a-zA-Z\\s'-]+$"
    );

    // Course ID pattern: department code (2-4 letters) + course number (3-4 digits)
    private static final Pattern COURSE_ID_PATTERN = Pattern.compile(
            "^[A-Za-z]{2,4}\\d{3,4}$"
    );

    // Section pattern: typically 1-3 letters or numbers
    private static final Pattern SECTION_PATTERN = Pattern.compile(
            "^[A-Za-z0-9]{1,3}$"
    );

    // Date formatter for enrollment deadlines
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ISO_LOCAL_DATE;

    /**
     * Validates email format
     * @param email The email to validate
     * @return true if valid, false otherwise
     */
    public static boolean isValidEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        return EMAIL_PATTERN.matcher(email).matches();
    }

    /**
     * Validates password meets complexity requirements
     * @param password The password to validate
     * @return true if valid, false otherwise
     */
    public static boolean isValidPassword(String password) {
        if (password == null || password.trim().isEmpty()) {
            return false;
        }
        return PASSWORD_PATTERN.matcher(password).matches();
    }

    /**
     * Validates person's name (allows letters, spaces, hyphens, and apostrophes)
     * @param name The name to validate
     * @return true if valid, false otherwise
     */
    public static boolean isValidName(String name) {
        if (name == null || name.trim().isEmpty()) {
            return false;
        }
        return NAME_PATTERN.matcher(name).matches();
    }

    /**
     * Validates course ID format
     * @param courseId The course ID to validate
     * @return true if valid, false otherwise
     */
    public static boolean isValidCourseId(String courseId) {
        if (courseId == null || courseId.trim().isEmpty()) {
            return false;
        }
        return COURSE_ID_PATTERN.matcher(courseId).matches();
    }

    /**
     * Validates section format
     * @param section The section to validate
     * @return true if valid, false otherwise
     */
    public static boolean isValidSection(String section) {
        if (section == null || section.trim().isEmpty()) {
            return false;
        }
        return SECTION_PATTERN.matcher(section).matches();
    }

    /**
     * Validates date string format (yyyy-MM-dd)
     * @param dateStr The date string to validate
     * @return true if valid, false otherwise
     */
    public static boolean isValidDate(String dateStr) {
        try {
            LocalDate.parse(dateStr, DATE_FORMATTER);
            return true;
        } catch (DateTimeParseException e) {
            return false;
        }
    }

    /**
     * Checks if a date is before the deadline
     * @param dateStr The date to check (yyyy-MM-dd)
     * @param deadlineStr The deadline date (yyyy-MM-dd)
     * @return true if date is before deadline, false otherwise
     */
    public static boolean isBeforeDeadline(String dateStr, String deadlineStr) {
        try {
            LocalDate date = LocalDate.parse(dateStr, DATE_FORMATTER);
            LocalDate deadline = LocalDate.parse(deadlineStr, DATE_FORMATTER);
            return date.isBefore(deadline) || date.isEqual(deadline);
        } catch (DateTimeParseException e) {
            return false;
        }
    }

    /**
     * Validates enrollment parameters
     * @param studentEmail Student email
     * @param courseId Course ID
     * @param section Section
     * @return true if all parameters are valid, false otherwise
     */
    public static boolean isValidEnrollment(String studentEmail, String courseId, String section) {
        return isValidEmail(studentEmail) &&
                isValidCourseId(courseId) &&
                isValidSection(section);
    }

    /**
     * Validates admin role
     * @param role The role to validate
     * @return true if valid admin role, false otherwise
     */
    public static boolean isValidAdminRole(String role) {
        return role != null && (role.equals("admin") || role.equals("superadmin"));
    }

    /**
     * Validates that a string is not null or empty
     * @param input The string to validate
     * @return true if not null and not empty, false otherwise
     */
    public static boolean isNotEmpty(String input) {
        return input != null && !input.trim().isEmpty();
    }

    /**
     * Validates that a number is positive
     * @param number The number to validate
     * @return true if positive, false otherwise
     */
    public static boolean isPositive(int number) {
        return number > 0;
    }

    /**
     * Validates that a number is within a range
     * @param number The number to validate
     * @param min Minimum value (inclusive)
     * @param max Maximum value (inclusive)
     * @return true if within range, false otherwise
     */
    public static boolean isInRange(int number, int min, int max) {
        return number >= min && number <= max;
    }
}