package com.studentregistration.model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Objects;

public class User {
    private int id;
    private String username;
    private String password;
    private String role;
    private String email;
    private String name; // Renamed from fullName to name
    private boolean active;
    private LocalDateTime lastLogin;

    private static final DateTimeFormatter DATE_TIME_FORMATTER =
            DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    // Default Constructor
    public User() {
        this.active = true;
        this.lastLogin = null;
    }

    // Constructor for registration (matches Admin's needs)
    public User(String email, String password, String name, String role, boolean isVerified) {
        this();
        this.email = email;
        this.password = password;
        this.name = name; // Updated to name
        this.role = role;
        this.active = isVerified;
        this.username = email; // Assume email as username
    }

    // Existing Constructors
    public User(int id, String username, String password, String role) {
        this();
        this.id = id;
        this.username = username;
        this.password = password;
        this.role = role;
    }

    public User(int id, String username, String password, String role, String email, String name) { // Updated to name
        this(id, username, password, role);
        this.email = email;
        this.name = name; // Updated to name
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) {
        this.username = username != null ? username.trim() : null;
    }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

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

    public String getName() { return name; } // Renamed from getFullName
    public void setName(String name) { // Renamed from setFullName
        this.name = name != null ? name.trim() : null;
    }

    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }

    public LocalDateTime getLastLogin() { return lastLogin; }
    public void setLastLogin(LocalDateTime lastLogin) { this.lastLogin = lastLogin; }

    // Business Logic Methods
    public boolean hasPermission(String requiredPermission) {
        if ("admin".equals(role)) {
            return true;
        }
        return "student".equals(role) && !requiredPermission.startsWith("admin:");
    }

    // File Storage Format (updated to match admins.txt format)
    public String toFileString() {
        return String.format("%s,%s,%s,%s,%s",
                username,
                name,
                email,
                password,
                role);
    }

    public static User fromFileString(String fileLine) {
        String[] parts = fileLine.split(",");
        if (parts.length >= 5) {
            User user = new User();
            user.setId(0); // Placeholder ID
            user.setUsername(parts[0]);
            user.setName(parts[1]); // Updated to name
            user.setEmail(parts[2]);
            user.setPassword(parts[3]);
            user.setRole(parts[4]);
            user.setActive(true); // Default to active
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
                ", name='" + name + '\'' + // Updated to name
                ", active=" + active +
                ", lastLogin=" + lastLogin +
                '}';
    }
}