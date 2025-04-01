package com.studentregistration.dao;

import model.LoginHistory;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

public class LoginHistoryDAO {
    private static final String LOGIN_HISTORY_FILE = "login_history.txt";

    public void recordLoginAttempt(LoginHistory entry) {
        Objects.requireNonNull(entry, "Login history entry cannot be null");

        try (PrintWriter out = new PrintWriter(new FileWriter(LOGIN_HISTORY_FILE, StandardCharsets.UTF_8, true))) {
            out.println(entry.toFileString());
            out.flush();
        } catch (IOException e) {
            System.err.println("Error writing to login history file: " + e.getMessage());
        }
    }

    public List<LoginHistory> getUserLoginHistory(String username) {
        Objects.requireNonNull(username, "Username cannot be null");
        List<LoginHistory> userHistory = new ArrayList<>();

        File file = new File(LOGIN_HISTORY_FILE);
        if (!file.exists()) {
            return userHistory;
        }

        try (BufferedReader reader = new BufferedReader(
                new FileReader(LOGIN_HISTORY_FILE, StandardCharsets.UTF_8))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.trim().isEmpty()) {
                    continue;
                }
                try {
                    LoginHistory entry = LoginHistory.fromFileString(line);
                    if (entry.getUsername().equals(username)) {
                        userHistory.add(entry);
                    }
                } catch (IllegalArgumentException e) {
                    System.err.println("Skipping malformed login history entry: " + line);
                }
            }
        } catch (IOException e) {
            System.err.println("Error reading login history file: " + e.getMessage());
        }

        return userHistory;
    }

    public List<LoginHistory> getAllLoginHistory() {
        List<LoginHistory> allHistory = new ArrayList<>();

        File file = new File(LOGIN_HISTORY_FILE);
        if (!file.exists()) {
            return allHistory;
        }

        try (BufferedReader reader = new BufferedReader(
                new FileReader(LOGIN_HISTORY_FILE, StandardCharsets.UTF_8))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.trim().isEmpty()) {
                    continue;
                }
                try {
                    allHistory.add(LoginHistory.fromFileString(line));
                } catch (IllegalArgumentException e) {
                    System.err.println("Skipping malformed login history entry: " + line);
                }
            }
        } catch (IOException e) {
            System.err.println("Error reading login history file: " + e.getMessage());
        }

        return allHistory;
    }

    public void cleanupOldHistory(int daysToKeep) {
        if (daysToKeep < 0) {
            throw new IllegalArgumentException("Days to keep must be non-negative");
        }

        File file = new File(LOGIN_HISTORY_FILE);
        if (!file.exists()) {
            return;
        }

        LocalDateTime cutoff = LocalDateTime.now().minusDays(daysToKeep);
        List<LoginHistory> recentEntries = new ArrayList<>();

        // First pass: read and filter entries
        try (BufferedReader reader = new BufferedReader(
                new FileReader(LOGIN_HISTORY_FILE, StandardCharsets.UTF_8))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.trim().isEmpty()) {
                    continue;
                }
                try {
                    LoginHistory entry = LoginHistory.fromFileString(line);
                    if (entry.getTimestamp().isAfter(cutoff)) {
                        recentEntries.add(entry);
                    }
                } catch (IllegalArgumentException e) {
                    System.err.println("Skipping malformed login history entry: " + line);
                }
            }
        } catch (IOException e) {
            System.err.println("Error reading login history for cleanup: " + e.getMessage());
            return;
        }

        // Second pass: write back filtered entries
        try (PrintWriter out = new PrintWriter(new FileWriter(LOGIN_HISTORY_FILE, StandardCharsets.UTF_8))) {
            for (LoginHistory entry : recentEntries) {
                out.println(entry.toFileString());
            }
        } catch (IOException e) {
            System.err.println("Error writing cleaned login history: " + e.getMessage());
            // Consider restoring from backup here if possible
        }
    }
}