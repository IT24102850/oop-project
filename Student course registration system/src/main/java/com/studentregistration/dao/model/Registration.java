package com.studentregistration.model;

public class Registration {
    private String studentId;
    private String fullName;
    private String email;
    private String password;
    private String courseId;
    private String courseName;

    // Constructor
    public Registration(String studentId, String fullName, String email,
                        String password, String courseId, String courseName) {
        this.studentId = studentId;
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.courseId = courseId;
        this.courseName = courseName;
    }

    // Getters and Setters
    public String getStudentId() { return studentId; }
    public void setStudentId(String studentId) { this.studentId = studentId; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getCourseId() { return courseId; }
    public void setCourseId(String courseId) { this.courseId = courseId; }

    public String getCourseName() { return courseName; }
    public void setCourseName(String courseName) { this.courseName = courseName; }

    @Override
    public String toString() {
        return studentId + "," + fullName + "," + email + "," +
                password + "," + courseId + "," + courseName;
    }
}