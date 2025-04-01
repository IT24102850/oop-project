package com.studentregistration.model;

import java.time.LocalDateTime;

public class VerificationToken {
    private String token;
    private LocalDateTime expiryDate;

    public VerificationToken(String token, LocalDateTime expiryDate) {
        this.token = token;
        this.expiryDate = expiryDate;
    }

    public boolean isExpired() {
        return LocalDateTime.now().isAfter(expiryDate);
    }

    // Getters and setters
    public String getToken() { return token; }
    public LocalDateTime getExpiryDate() { return expiryDate; }
}