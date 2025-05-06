package com.studentregistration.dao;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ProfileDAO {
    private final String filePath;
    private static final Logger logger = Logger.getLogger(ProfileDAO.class.getName());

    public ProfileDAO(String filePath) {
        this.filePath = filePath;
        initializeFile();
    }

    private void initializeFile() {
        File file = new File(filePath);
        if (!file.exists()) {
            try {
                file.getParentFile().mkdirs();
                file.createNewFile();
                logger.info("Initialized profile data file: " + filePath);
            } catch (IOException e) {
                logger.log(Level.SEVERE, "Failed to initialize profile data file", e);
                throw new RuntimeException("File initialization failed", e);
            }
        }
    }

    public void saveProfile(String studentId, String name, String email, String dob, String gender, String phone, String address, String degree, String enrolled, String gpa, String passwordStatus, String twoFAStatus, String imagePath) {
        List<String> profiles = new ArrayList<>();
        boolean updated = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",", -1); // -1 to include empty trailing fields
                if (parts.length > 0 && parts[0].equals(studentId)) {
                    profiles.add(String.join(",", studentId, name, email, dob, gender, phone, address, degree, enrolled, gpa, passwordStatus, twoFAStatus, imagePath));
                    updated = true;
                } else {
                    profiles.add(line);
                }
            }
            if (!updated) {
                profiles.add(String.join(",", studentId, name, email, dob, gender, phone, address, degree, enrolled, gpa, passwordStatus, twoFAStatus, imagePath));
            }
        } catch (IOException e) {
            handleIOException("Failed to read profiles for update", e);
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            for (String profile : profiles) {
                writer.write(profile);
                writer.newLine();
            }
            logger.info("Profile saved for student ID: " + studentId);
        } catch (IOException e) {
            handleIOException("Failed to write profile data", e);
        }
    }

    public String[] getProfile(String studentId) {
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",", -1); // -1 to include empty trailing fields
                if (parts.length > 0 && parts[0].equals(studentId)) {
                    return parts;
                }
            }
        } catch (IOException e) {
            handleIOException("Failed to read profile for student ID: " + studentId, e);
        }
        return new String[]{"", "", "", "", "", "", "", "", "", "", "", "", ""}; // Default empty profile
    }

    private void handleIOException(String message, IOException e) {
        logger.log(Level.SEVERE, message, e);
        throw new RuntimeException(message, e);
    }
}