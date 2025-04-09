package com.studentregistration.model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Objects;

public class Admin extends User {
    private boolean forcePasswordReset;
    private LocalDateTime lastPasswordChange;

    private static final DateTimeFormatter DATE_TIME_FORMATTER =
            DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    public Admin(String email, String password, String fullName, boolean isVerified) {
        super(email, password, fullName, "admin", isVerified);
        this.forcePasswordReset = false;
        this.lastPasswordChange = LocalDateTime.now();
    }

    public Admin(String email, String password, String fullName, boolean isVerified, String role) {
        super(email, password, fullName, role, isVerified);
        this.forcePasswordReset = false;
        this.lastPasswordChange = LocalDateTime.now();
    }

    // Getters and Setters
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
        return "superadmin".equalsIgnoreCase(getRole());
    }

    // File handling methods
    @Override
    public String toFileString() {
        return String.join("|",
                getEmail(),
                getPassword(),
                getFullName(),
                String.valueOf(isActive()),
                getRole(),
                String.valueOf(forcePasswordReset),
                lastPasswordChange.format(DATE_TIME_FORMATTER),
                getLastLogin() != null ? getLastLogin().format(DATE_TIME_FORMATTER) : "null"
        );
    }

    public static Admin fromFileString(String fileString) {
        String[] parts = fileString.split("\\|");
        if (parts.length < 8) {
            throw new IllegalArgumentException("Invalid admin data string");
        }

        Admin admin = new Admin(
                parts[0], // email
                parts[1], // password
                parts[2], // fullName
                Boolean.parseBoolean(parts[3]), // isActive
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
                Objects.equals(lastPasswordChange, admin.lastPasswordChange);
    }

    @Override
    public int hashCode() {
        return Objects.hash(super.hashCode(), forcePasswordReset, lastPasswordChange);
    }

    @Override
    public String toString() {
        return "Admin{" +
                "email='" + getEmail() + '\'' +
                ", name='" + getFullName() + '\'' +
                ", role='" + getRole() + '\'' +
                ", isVerified=" + isActive() +
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