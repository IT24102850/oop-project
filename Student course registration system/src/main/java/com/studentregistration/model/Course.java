package com.studentregistration.model;

public class Course {
    private String courseId;
    private String title; // Renamed from courseName
    private String department; // Renamed from description
    private int credits;
    private String professor; // Added for servlet/JSP compatibility
    private String syllabus; // Added for servlet/JSP compatibility
    private boolean isActive; // Added for servlet/JSP compatibility

    // Default constructor
    public Course() {
        this.professor = "TBD";
        this.syllabus = "Not specified";
        this.isActive = true;
    }

    // Constructor for DAO (matches the file format: courseId,title,department,credits)
    public Course(String courseId, String title, String department, int credits) {
        validateRequiredFields(courseId, title, department);
        if (credits <= 0) {
            throw new IllegalArgumentException("Credits must be a positive number.");
        }

        this.courseId = courseId;
        this.title = title;
        this.department = department;
        this.credits = credits;
        this.professor = "TBD";
        this.syllabus = "Not specified";
        this.isActive = true;
    }

    // Constructor with all fields (for servlet use)
    public Course(String courseId, String title, String department, int credits, String professor, String syllabus, boolean isActive) {
        validateRequiredFields(courseId, title, department);
        if (credits <= 0) {
            throw new IllegalArgumentException("Credits must be a positive number.");
        }

        this.courseId = courseId;
        this.title = title;
        this.department = department;
        this.credits = credits;
        this.professor = (professor != null && !professor.trim().isEmpty()) ? professor : "TBD";
        this.syllabus = (syllabus != null && !syllabus.trim().isEmpty()) ? syllabus : "Not specified";
        this.isActive = isActive;
    }

    // Getters and Setters
    public String getCourseId() {
        return courseId;
    }

    public void setCourseId(String courseId) {
        if (courseId == null || courseId.trim().isEmpty()) {
            throw new IllegalArgumentException("Course ID cannot be null or empty.");
        }
        this.courseId = courseId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        if (title == null || title.trim().isEmpty()) {
            throw new IllegalArgumentException("Title cannot be null or empty.");
        }
        this.title = title;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        if (department == null || department.trim().isEmpty()) {
            throw new IllegalArgumentException("Department cannot be null or empty.");
        }
        this.department = department;
    }

    public int getCredits() {
        return credits;
    }

    public void setCredits(int credits) {
        if (credits <= 0) {
            throw new IllegalArgumentException("Credits must be a positive number.");
        }
        this.credits = credits;
    }

    public String getProfessor() {
        return professor;
    }

    public void setProfessor(String professor) {
        this.professor = (professor != null && !professor.trim().isEmpty()) ? professor : "TBD";
    }

    public String getSyllabus() {
        return syllabus;
    }

    public void setSyllabus(String syllabus) {
        this.syllabus = (syllabus != null && !syllabus.trim().isEmpty()) ? syllabus : "Not specified";
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        this.isActive = active;
    }

    // Format for file storage (matches DAO expectation: courseId,title,department,credits)
    @Override
    public String toString() {
        return String.join(",", courseId, title, department, String.valueOf(credits));
    }

    // Helper method to validate required fields
    private void validateRequiredFields(String courseId, String title, String department) {
        if (courseId == null || courseId.trim().isEmpty()) {
            throw new IllegalArgumentException("Course ID cannot be null or empty.");
        }
        if (title == null || title.trim().isEmpty()) {
            throw new IllegalArgumentException("Title cannot be null or empty.");
        }
        if (department == null || department.trim().isEmpty()) {
            throw new IllegalArgumentException("Department cannot be null or empty.");
        }
    }
}