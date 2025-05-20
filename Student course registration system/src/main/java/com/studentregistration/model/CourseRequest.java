package com.studentregistration.model;

import java.time.ZonedDateTime;

public class CourseRequest {
    private String fullName;
    private String email;
    private String courseCode;
    private String reason;
    private String additionalNotes;
    private ZonedDateTime submissionTime;
    private String status;

    public CourseRequest(String fullName, String email, String courseCode, String reason, String additionalNotes, ZonedDateTime submissionTime, String status) {
        this.fullName = fullName;
        this.email = email;
        this.courseCode = courseCode;
        this.reason = reason;
        this.additionalNotes = additionalNotes;
        this.submissionTime = submissionTime;
        this.status = status;
    }

    public String getFullName() {
        return fullName;
    }

    public String getEmail() {
        return email;
    }

    public String getCourseCode() {
        return courseCode;
    }

    public String getReason() {
        return reason;
    }

    public String getAdditionalNotes() {
        return additionalNotes;
    }

    public ZonedDateTime getSubmissionTime() {
        return submissionTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}