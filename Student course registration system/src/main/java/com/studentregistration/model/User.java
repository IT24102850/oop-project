package com.studentregistration.model;

import java.util.Objects;

public class User {
    private int id;
    private String username;
    private String password;
    private String role;
    private String email;
    private String fullName;
    private boolean active;

    // Add the Constructors
    public User() {
        this.active = true;
    }

    public User(int id, String username, String password, String role) {
        this();
        this.id = id;
        this.username = username;
        this.password = password;
        this.role = role;
    }

    public User(int id, String username, String password, String role,
                String email, String fullName) {
        this(id, username, password, role);
        this.email = email;
        this.fullName = fullName;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) {
        this.username = username != null ? username.trim() : null;
    }

    public String getPassword() { return password; }
    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() { return role; }
    public void setRole(String role) {
        if ("student".equalsIgnoreCase(role) || "admin".equalsIgnoreCase(role)) {
            this.role = role.toLowerCase();
        } else {
            throw new IllegalArgumentException("Invalid role specified");
        }
    }

    public String getEmail() { return email; }
    public void setEmail(String email) {
        if (email != null && !email.matches("^[\\w-.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
            throw new IllegalArgumentException("Invalid email format");
        }
        this.email = email;
    }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) {
        this.fullName = fullName != null ? fullName.trim() : null;
    }

    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }

    // Business Logic Methods
    public boolean hasPermission(String requiredPermission) {
        if ("admin".equals(role)) {
            return true;
        }
        return "student".equals(role) && !requiredPermission.startsWith("admin:");
    }

    // File Storage Format
    public String toFileString() {
        return String.format("%d|%s|%s|%s|%s|%s|%b",
                id, username, password, role, email, fullName, active);
    }

    public static User fromFileString(String fileLine) {
        String[] parts = fileLine.split("\\|");
        if (parts.length >= 7) {
            User user = new User();
            user.setId(Integer.parseInt(parts[0]));
            user.setUsername(parts[1]);
            user.setPassword(parts[2]);
            user.setRole(parts[3]);
            user.setEmail(parts[4]);
            user.setFullName(parts[5]);
            user.setActive(Boolean.parseBoolean(parts[6]));
            return user;
        }
        throw new IllegalArgumentException("Invalid user data format");
    }

    // Overrides
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        User user = (User) o;
        return id == user.id &&
                Objects.equals(username, user.username) &&
                Objects.equals(email, user.email);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, username, email);
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", role='" + role + '\'' +
                ", email='" + email + '\'' +
                ", fullName='" + fullName + '\'' +
                ", active=" + active +
                '}';
    }
}