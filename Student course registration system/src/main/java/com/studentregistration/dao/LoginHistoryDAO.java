package com.studentregistration.dao;

import model.LoginHistory;
import java.io.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class LoginHistoryDAO {
    private static final String LOGIN_HISTORY_FILE = "login_history.txt";

    public void recordLoginAttempt(LoginHistory entry) {
        try (PrintWriter out = new PrintWriter(new FileWriter(LOGIN_HISTORY_FILE, true))) {
            out.println(entry.toFileString());
        } catch (IOException e) {
            System.err.println("Error writing to login history file: " + e.getMessage());
        }
    }

    public List<LoginHistory> getUserLoginHistory(String username) {
        List<LoginHistory> userHistory = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(LOGIN_HISTORY_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
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

        try (BufferedReader reader = new BufferedReader(new FileReader(LOGIN_HISTORY_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
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
        LocalDateTime cutoff = LocalDateTime.now().minusDays(daysToKeep);
        List<LoginHistory> recentEntries = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(LOGIN_HISTORY_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
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
        
        try (PrintWriter out = new PrintWriter(new FileWriter(LOGIN_HISTORY_FILE))) {
            for (LoginHistory entry : recentEntries) {
                out.println(entry.toFileString());
            }
        } catch (IOException e) {
            System.err.println("Error writing cleaned login history: " + e.getMessage());
        }
    }
}