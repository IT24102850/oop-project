package com.studentregistration.model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Objects;

public class Admin extends User {
    private String role; // "admin" or "superadmin"
    private boolean forcePasswordReset;
    private LocalDateTime lastPasswordChange;

    private static final DateTimeFormatter DATE_TIME_FORMATTER =
            DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    public Admin(String email, String password, String name, boolean isVerified) {
        super(email, password, name, isVerified);
        this.role = "admin";
        this.forcePasswordReset = false;
        this.lastPasswordChange = LocalDateTime.now();
    }

    public Admin(String email, String password, String name, boolean isVerified, String role) {
        super(email, password, name, isVerified);
        this.role = role;
        this.forcePasswordReset = false;
        this.lastPasswordChange = LocalDateTime.now();
    }

    // Getters and Setters
    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public boolean isForcePasswordReset() {
        return forcePasswordReset;
    }

    public void setForcePasswordReset(boolean forcePasswordReset) {
        this.forcePasswordReset = forcePasswordReset;
    }

    public LocalDateTime getLastPasswordChange() {
        return lastPasswordChange;
    }

    public void setLastPasswordChange(LocalDateTime lastPasswordChange) {
        this.lastPasswordChange = lastPasswordChange;
    }

    public boolean isSuperAdmin() {
        return "superadmin".equalsIgnoreCase(role);
    }



    // Create Admin object from file string
    public static Admin fromFileString(String fileString) {
        String[] parts = fileString.split("\\|");
        if (parts.length < 8) {
            throw new IllegalArgumentException("Invalid admin data string");
        }

        Admin admin = new Admin(
                parts[0], // email
                parts[1], // password
                parts[2], // name
                Boolean.parseBoolean(parts[3]), // isVerified
                parts[4]  // role
        );

        admin.setForcePasswordReset(Boolean.parseBoolean(parts[5]));

        if (!"null".equals(parts[6])) {
            admin.setLastPasswordChange(LocalDateTime.parse(parts[6], DATE_TIME_FORMATTER));
        }



        return admin;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        if (!super.equals(o)) return false;
        Admin admin = (Admin) o;
        return forcePasswordReset == admin.forcePasswordReset &&
                Objects.equals(role, admin.role) &&
                Objects.equals(lastPasswordChange, admin.lastPasswordChange);
    }

    @Override
    public int hashCode() {
        return Objects.hash(super.hashCode(), role, forcePasswordReset, lastPasswordChange);
    }

    @Override
    public String toString() {
        return "Admin{" +
                "email='" + getEmail() + '\'' +

                ", role='" + role + '\'' +

                ", forcePasswordReset=" + forcePasswordReset +
                ", lastPasswordChange=" + lastPasswordChange +

                '}';
    }

    /**
     * Checks if the admin needs to change their password
     * @return true if password is expired or reset is forced
     */
    public boolean needsPasswordChange() {
        // Password expires after 90 days
        boolean passwordExpired = lastPasswordChange.plusDays(90).isBefore(LocalDateTime.now());
        return forcePasswordReset || passwordExpired;
    }

    /**
     * Changes the admin's password and resets the force flag
     * @param newPassword The new password
     */
    public void changePassword(String newPassword) {
        setPassword(newPassword);
        this.forcePasswordReset = false;
        this.lastPasswordChange = LocalDateTime.now();
    }
}