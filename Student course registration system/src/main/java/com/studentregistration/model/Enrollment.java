package com.studentregistration.model;

public class Enrollment {
    private String studentEmail;
    private String courseId;
    private String section;
    private String enrollmentDate;

    public Enrollment(String studentEmail, String courseId, String section, String enrollmentDate) {
        this.studentEmail = studentEmail;
        this.courseId = courseId;
        this.section = section;
        this.enrollmentDate = enrollmentDate;
    }

    public String toFileString() {
        return studentEmail + "|" + courseId + "|" + section + "|" + enrollmentDate;
    }

    // Getters and Setters
    public String getStudentEmail() { return studentEmail; }
    public String getCourseId() { return courseId; }
    public String getSection() { return section; }
    public void setSection(String section) { this.section = section; }
    public String getEnrollmentDate() { return enrollmentDate; }
}