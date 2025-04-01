package com.studentregistration.model;

package model;

import java.time.LocalDateTime;

public class LoginHistory {
    private String username;
    private LocalDateTime timestamp;
    private String ipAddress;
    private LoginStatus status;

    public enum LoginStatus {
        SUCCESS,
        FAILED
    }

    // Constructor
    public LoginHistory(String username, LocalDateTime timestamp, String ipAddress, LoginStatus status) {
        this.username = username;
        this.timestamp = timestamp;
        this.ipAddress = ipAddress;
        this.status = status;
    }

    // Getters
    public String getUsername() {
        return username;
    }

    public LocalDateTime getTimestamp() {
        return timestamp;
    }

    public String getIpAddress() {
        return ipAddress;
    }

    public LoginStatus getStatus() {
        return status;
    }

    // Formatted output methods
    public String toFileString() {
        return String.join("|",
                username,
                timestamp.toString(),
                ipAddress,
                status.name()
        );
    }

    public String toDisplayString() {
        return String.format("%s - %s (%s) - %s",
                timestamp.toString(),
                username,
                ipAddress,
                status.name()
        );
    }

    // Static method to parse from file string
    public static LoginHistory fromFileString(String fileString) {
        String[] parts = fileString.split("\\|");
        if (parts.length != 4) {
            throw new IllegalArgumentException("Invalid login history format");
        }

        return new LoginHistory(
                parts[0],
                LocalDateTime.parse(parts[1]),
                parts[2],
                LoginStatus.valueOf(parts[3])
        );
    }
}
