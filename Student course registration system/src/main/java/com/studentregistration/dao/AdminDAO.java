package com.studentregistration.dao;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.logging.Logger;

public class AdminDAO {
    private final String filePath;
    private static final Logger logger = Logger.getLogger(AdminDAO.class.getName());

    // Constructor to initialize the file path for admins.txt
    public AdminDAO(String filePath) {
        this.filePath = filePath;
    }

    // Validate admin credentials
    public boolean validateAdmin(String username, String password) {
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.trim().isEmpty()) continue;
                String[] parts = line.split(",");
                if (parts.length >= 1 && parts[0].equals(username)) {
                    // Check if password is provided in the file (at least 4 parts: username, name, email, password)
                    String expectedPassword = parts.length >= 4 ? parts[3] : new StringBuilder(username).reverse().toString();
                    return password.equals(expectedPassword);
                }
            }
        } catch (IOException e) {
            logger.severe("Error reading admins.txt: " + e.getMessage());
        }
        return false; // Return false if username not found or file read fails
    }

    // Retrieve admin details by username (optional, for future use)
    public String[] getAdminByUsername(String username) {
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.trim().isEmpty()) continue;
                String[] parts = line.split(",");
                if (parts.length >= 1 && parts[0].equals(username)) {
                    return parts; // Return the admin's data as an array (username, name, email, [password])
                }
            }
        } catch (IOException e) {
            logger.severe("Error reading admins.txt: " + e.getMessage());
        }
        return null; // Return null if admin not found
    }
}