package com.example.model;

public class Student extends User {
    private String fullName;
    private String course;

    // Default constructor
    public Student() {}

    // Parameterized constructor
    public Student(String fullName, String email, String password, String course) {
        super(email, password); // Call to User constructor
        this.fullName = fullName;
        this.course = course;
    }

    // Getters and Setters
    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        if (fullName == null || fullName.trim().isEmpty()) {
            throw new IllegalArgumentException("Full name cannot be null or empty");
        }
        this.fullName = fullName;
    }

    public String getCourse() {
        return course;
    }

    public void setCourse(String course) {
        if (course == null || course.trim().isEmpty()) {
            throw new IllegalArgumentException("Course cannot be null or empty");
        }
        this.course = course;
    }

    // Override toString() method
    @Override
    public String toString() {
        return String.join(",", fullName, getEmail(), getPassword(), course);
    }
}