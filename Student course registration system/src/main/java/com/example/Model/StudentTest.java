package com.example.model;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class StudentTest {

    @Test
    void testDefaultConstructor() {
        Student student = new Student();
        assertNotNull(student, "Default constructor should create a non-null Student object");
    }

    @Test
    void testParameterizedConstructor() {
        Student student = new Student("John Doe", "john.doe@example.com", "password123", "Computer Science");
        assertAll(
                () -> assertEquals("John Doe", student.getFullName(), "Full name should match"),
                () -> assertEquals("john.doe@example.com", student.getEmail(), "Email should match"),
                () -> assertEquals("password123", student.getPassword(), "Password should match"),
                () -> assertEquals("Computer Science", student.getCourse(), "Course should match")
        );
    }

    @Test
    void testSettersAndGetters() {
        Student student = new Student();
        student.setFullName("Jane Smith");
        student.setEmail("jane.smith@example.com");
        student.setPassword("password456");
        student.setCourse("Mathematics");

        assertAll(
                () -> assertEquals("Jane Smith", student.getFullName(), "Full name should match"),
                () -> assertEquals("jane.smith@example.com", student.getEmail(), "Email should match"),
                () -> assertEquals("password456", student.getPassword(), "Password should match"),
                () -> assertEquals("Mathematics", student.getCourse(), "Course should match")
        );
    }

    @Test
    void testValidationInSetters() {
        Student student = new Student();

        // Test fullName validation
        assertThrows(IllegalArgumentException.class, () -> student.setFullName(null),
                "Setting fullName to null should throw IllegalArgumentException");
        assertThrows(IllegalArgumentException.class, () -> student.setFullName(""),
                "Setting fullName to empty string should throw IllegalArgumentException");

        // Test email validation
        assertThrows(IllegalArgumentException.class, () -> student.setEmail(null),
                "Setting email to null should throw IllegalArgumentException");
        assertThrows(IllegalArgumentException.class, () -> student.setEmail("invalid-email"),
                "Setting email to invalid format should throw IllegalArgumentException");

        // Test password validation
        assertThrows(IllegalArgumentException.class, () -> student.setPassword(null),
                "Setting password to null should throw IllegalArgumentException");
        assertThrows(IllegalArgumentException.class, () -> student.setPassword("short"),
                "Setting password to less than 8 characters should throw IllegalArgumentException");

        // Test course validation
        assertThrows(IllegalArgumentException.class, () -> student.setCourse(null),
                "Setting course to null should throw IllegalArgumentException");
        assertThrows(IllegalArgumentException.class, () -> student.setCourse(""),
                "Setting course to empty string should throw IllegalArgumentException");
    }

    @Test
    void testToString() {
        Student student = new Student("John Doe", "john.doe@example.com", "password123", "Computer Science");
        String expected = "John Doe,john.doe@example.com,password123,Computer Science";
        assertEquals(expected, student.toString(), "toString() should return the correct string representation");
    }
}
