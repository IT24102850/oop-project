package com.studentregistration.model;

public class Student {
    private String studentId;
    private String fullName;
    private String email;
    private String password;

    public Student(String studentId, String fullName, String email, String password) {
        this.studentId = studentId;
        this.fullName = fullName;
        this.email = email;
        this.password = password;
    }





    // Getters
    public String getStudentId() { return studentId; }
    public String getFullName() { return fullName; }
    public String getEmail() { return email; }
    public String getPassword() { return password; }

    // Setters (optional, if needed)
    public void setStudentId(String studentId) { this.studentId = studentId; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public void setEmail(String email) { this.email = email; }
    public void setPassword(String password) { this.password = password; }
}