package com.studentregistration.model;

public class Course {
    private String courseCode;
    private String title;
    private int credits;
    private String department;
    private String professor;
    private String syllabus;
    private boolean status; // true for active, false for archived

    // Constructor
    public Course(String courseCode, String title, int credits, String department, String professor, String syllabus, boolean status) {
        this.courseCode = courseCode;
        this.title = title;
        this.credits = credits;
        this.department = department;
        this.professor = professor;
        this.syllabus = syllabus;
        this.status = status;
    }

    // Getters and Setters
    public String getCourseCode() {
        return courseCode;
    }

    public void setCourseCode(String courseCode) {
        this.courseCode = courseCode;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getCredits() {
        return credits;
    }

    public void setCredits(int credits) {
        this.credits = credits;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getProfessor() {
        return professor;
    }

    public void setProfessor(String professor) {
        this.professor = professor;
    }

    public String getSyllabus() {
        return syllabus;
    }

    public void setSyllabus(String syllabus) {
        this.syllabus = syllabus;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    // toString method to write to courses.txt in the correct format
    @Override
    public String toString() {
        return String.format("%s,%s,%d,%s,%s,%s,%b",
                courseCode, title, credits, department, professor, syllabus, status);
    }
}