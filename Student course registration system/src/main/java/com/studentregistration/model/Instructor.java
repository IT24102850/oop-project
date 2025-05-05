package com.studentregistration.model;

public class Instructor {
    private String instructorId;
    private String fullName;
    private String email;
    private String password;
    private boolean active;

    public Instructor() {}

    public Instructor(String instructorId, String fullName, String email, String password, boolean active) {
        this.instructorId = instructorId;
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.active = active;
    }

    public String getInstructorId() {
        return instructorId;
    }

    public void setInstructorId(String instructorId) {
        this.instructorId = instructorId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    @Override
    public String toString() {
        return instructorId + "," + fullName + "," + email + "," + password + "," + active;
    }
}