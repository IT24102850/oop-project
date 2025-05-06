package com.studentregistration.model;

import java.text.SimpleDateFormat;
import java.util.Date;

public class CourseRequest {
    private String fullName;
    private String email;
    private String courseId;
    private String reason;
    private String additionalNotes;
    private boolean termsAccepted;
    private String submissionTime;

    public CourseRequest(String fullName, String email, String courseId,
                         String reason, String additionalNotes, boolean termsAccepted) {
        this.fullName = fullName;
        this.email = email;
        this.courseId = courseId;
        this.reason = reason;
        this.additionalNotes = additionalNotes;
        this.termsAccepted = termsAccepted;
        this.submissionTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
    }

    // Getters
    public String getFullName() {
        return fullName;
    }

    public String getEmail() {
        return email;
    }

    public String getCourseId() {
        return courseId;
    }

    public String getReason() {
        return reason;
    }

    public String getAdditionalNotes() {
        return additionalNotes;
    }

    public boolean isTermsAccepted() {
        return termsAccepted;
    }

    public String getSubmissionTime() {
        return submissionTime;
    }
}