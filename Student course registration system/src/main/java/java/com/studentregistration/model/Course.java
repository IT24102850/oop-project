package com.studentregistration.model;

public class Course {
    private String courseId;
    private String courseName;
    private String description;
    private int credits;


    public Course() {}
//add the constructors
    public Course(String courseId, String courseName, String description, int credits) {
        this.courseId = courseId;
        this.courseName = courseName;
        this.description = description;
        this.credits = credits;
    }

    // Getters and Setters
    public String getCourseId() { return courseId; }
    public void setCourseId(String courseId) { this.courseId = courseId; }

    public String getCourseName() { return courseName; }
    public void setCourseName(String courseName) { this.courseName = courseName; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public int getCredits() { return credits; }
    public void setCredits(int credits) { this.credits = credits; }

    // Format for file storage
    @Override
    public String toString() {
        return String.join(",", courseId, courseName, description, String.valueOf(credits));
    }
}