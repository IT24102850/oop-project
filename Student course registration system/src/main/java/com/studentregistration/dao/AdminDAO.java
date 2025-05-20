package com.studentregistration.dao;

import com.studentregistration.model.Admin;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class AdminDAO {
    private static final String ADMIN_FILE = "admins.txt";

    // Create: Add a new admin to the file
    public void createAdmin(Admin admin) throws IOException {
        if (admin == null || admin.getEmail() == null) {
            throw new IllegalArgumentException("Admin or email cannot be null");
        }
        if (findAdminByEmail(admin.getEmail()) != null) {
            throw new IllegalStateException("Admin with email " + admin.getEmail() + " already exists");
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(ADMIN_FILE, true))) {
            writer.write(admin.toFileString());
            writer.newLine();
        }
    }

    // Read: Get all admins
    public List<Admin> getAllAdmins() throws IOException {
        List<Admin> admins = new ArrayList<>();
        File file = new File(ADMIN_FILE);
        if (!file.exists()) {
            return admins; // Return empty list if file doesn't exist
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(ADMIN_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (!line.trim().isEmpty()) {
                    try {
                        Admin admin = Admin.fromFileString(line);
                        admins.add(admin);
                    } catch (IllegalArgumentException e) {
                        System.err.println("Skipping invalid admin entry: " + e.getMessage());
                    }
                }
            }
        }
        return admins;
    }

    // Read: Find admin by email
    public Admin findAdminByEmail(String email) throws IOException {
        if (email == null) {
            throw new IllegalArgumentException("Email cannot be null");
        }

        File file = new File(ADMIN_FILE);
        if (!file.exists()) {
            return null;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(ADMIN_FILE))) {
            return reader.lines()
                    .filter(line -> !line.trim().isEmpty())
                    .map(Admin::fromFileString)
                    .filter(admin -> email.equals(admin.getEmail()))
                    .findFirst()
                    .orElse(null);
        }
    }

    // Update: Update an existing admin
    public void updateAdmin(Admin updatedAdmin) throws IOException {
        if (updatedAdmin == null || updatedAdmin.getEmail() == null) {
            throw new IllegalArgumentException("Admin or email cannot be null");
        }

        List<String> lines = Files.readAllLines(Paths.get(ADMIN_FILE));
        boolean updated = false;

        for (int i = 0; i < lines.size(); i++) {
            if (lines.get(i).trim().isEmpty()) continue;
            Admin admin = Admin.fromFileString(lines.get(i));
            if (updatedAdmin.getEmail().equals(admin.getEmail())) {
                lines.set(i, updatedAdmin.toFileString());
                updated = true;
                break;
            }
        }

        if (!updated) {
            throw new IllegalStateException("Admin with email " + updatedAdmin.getEmail() + " not found");
        }

        Files.write(Paths.get(ADMIN_FILE), lines);
    }

    // Delete: Remove an admin by email
    public void deleteAdmin(String email) throws IOException {
        if (email == null) {
            throw new IllegalArgumentException("Email cannot be null");
        }

        List<String> lines = Files.readAllLines(Paths.get(ADMIN_FILE));
        List<String> updatedLines = lines.stream()
                .filter(line -> {
                    if (line.trim().isEmpty()) return true;
                    Admin admin = Admin.fromFileString(line);
                    return !email.equals(admin.getEmail());
                })
                .collect(Collectors.toList());

        if (lines.size() == updatedLines.size()) {
            throw new IllegalStateException("Admin with email " + email + " not found");
        }

        Files.write(Paths.get(ADMIN_FILE), updatedLines);
    }

    // Additional Utility: Force password reset for an admin
    public void forcePasswordReset(String email) throws IOException {
        Admin admin = findAdminByEmail(email);
        if (admin == null) {
            throw new IllegalStateException("Admin with email " + email + " not found");
        }
        admin.setForcePasswordReset(true);
        admin.setLastPasswordChange(LocalDateTime.now());
        updateAdmin(admin);
    }

    // Additional Utility: Deactivate an admin
    public void deactivateAdmin(String email) throws IOException {
        Admin admin = findAdminByEmail(email);
        if (admin == null) {
            throw new IllegalStateException("Admin with email " + email + " not found");
        }
        admin.setActive(false);
        updateAdmin(admin);
    }
}