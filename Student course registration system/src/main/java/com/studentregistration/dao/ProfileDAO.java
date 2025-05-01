<<<<<<< HEAD
package com.studentregistration.dao;

import javax.servlet.ServletContext;
import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProfileDAO {

    private static final String PROFILE_DIR = "/WEB-INF/data/Profiles/";
    private static final String DEFAULT_IMAGE = "https://via.placeholder.com/150";

    /**
     * Saves the user's profile data to username.txt in the profiles directory.
     * @param username The user's username (used as the filename).
     * @param profileData Map containing profile fields (name, dob, gender, email, phone, address, imagePath).
     * @param context ServletContext to get the real path of the profiles directory.
     * @throws IOException If file writing fails.
     */
    public void saveProfile(String username, Map<String, String> profileData, ServletContext context) throws IOException {
        if (username == null || username.trim().isEmpty()) {
            throw new IllegalArgumentException("Username cannot be null or empty");
        }

        // Sanitize username to prevent file path vulnerabilities
        String sanitizedUsername = username.replaceAll("[^a-zA-Z0-9_-]", "");

        String profilesPath = context.getRealPath(PROFILE_DIR);
        File profilesDir = new File(profilesPath);
        if (!profilesDir.exists()) {
            profilesDir.mkdirs();
        }

        File profileFile = new File(profilesDir, sanitizedUsername + ".txt");
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(profileFile))) {
            // Write data in the format: name,dob,gender,email,phone,address,imagePath
            writer.write(String.join(",",
                    escapeCsv(profileData.getOrDefault("name", "")),
                    escapeCsv(profileData.getOrDefault("dob", "")),
                    escapeCsv(profileData.getOrDefault("gender", "")),
                    escapeCsv(profileData.getOrDefault("email", "")),
                    escapeCsv(profileData.getOrDefault("phone", "")),
                    escapeCsv(profileData.getOrDefault("address", "")),
                    escapeCsv(profileData.getOrDefault("imagePath", DEFAULT_IMAGE))
            ));
        }
    }

    /**
     * Retrieves the user's profile data from username.txt.
     * @param username The user's username.
     * @param context ServletContext to get the real path of the profiles directory.
     * @return Map containing profile fields, or null if the file doesn't exist or an error occurs.
     */
    public Map<String, String> getProfile(String username, ServletContext context) {
        if (username == null || username.trim().isEmpty()) {
            return null;
        }

        // Sanitize username
        String sanitizedUsername = username.replaceAll("[^a-zA-Z0-9_-]", "");

        String profilePath = context.getRealPath(PROFILE_DIR + sanitizedUsername + ".txt");
        File profileFile = new File(profilePath);

        if (!profileFile.exists()) {
            return null;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(profileFile))) {
            String line = reader.readLine();
            if (line != null && !line.trim().isEmpty()) {
                String[] parts = splitCsv(line);
                if (parts.length >= 7) {
                    Map<String, String> profileData = new HashMap<>();
                    profileData.put("name", parts[0]);
                    profileData.put("dob", parts[1]);
                    profileData.put("gender", parts[2]);
                    profileData.put("email", parts[3]);
                    profileData.put("phone", parts[4]);
                    profileData.put("address", parts[5]);
                    profileData.put("imagePath", parts[6]);
                    return profileData;
                }
            }
        } catch (IOException e) {
            // Log error (use a logging framework like SLF4J in production)
            System.err.println("Error reading profile for " + sanitizedUsername + ": " + e.getMessage());
        }
        return null;
    }

    /**
     * Escapes a string for CSV by wrapping it in quotes if it contains commas or quotes.
     * @param value The string to escape.
     * @return Escaped string.
     */
    private String escapeCsv(String value) {
        if (value == null) {
            return "";
        }
        if (value.contains(",") || value.contains("\"")) {
            return "\"" + value.replace("\"", "\"\"") + "\"";
        }
        return value;
    }

    /**
     * Splits a CSV line into fields, handling quoted values with commas.
     * @param line The CSV line to split.
     * @return Array of field values.
     */
    private String[] splitCsv(String line) {
        if (line == null || line.trim().isEmpty()) {
            return new String[7]; // Return empty fields to avoid index issues
        }

        List<String> fields = new ArrayList<>();
        boolean inQuotes = false;
        StringBuilder field = new StringBuilder();

        for (int i = 0; i < line.length(); i++) {
            char c = line.charAt(i);

            if (c == '"') {
                inQuotes = !inQuotes;
                continue;
            }

            if (c == ',' && !inQuotes) {
                fields.add(field.toString());
                field = new StringBuilder();
                continue;
            }

            field.append(c);
        }

        // Add the last field
        fields.add(field.toString());

        // Ensure we have at least 7 fields to avoid ArrayIndexOutOfBounds
        while (fields.size() < 7) {
            fields.add("");
        }

        return fields.toArray(new String[0]);
=======
package main.java.com.studentregistration.dao;

import main.java.com.studentregistration.model.Profile;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

public class ProfileDao {
    private static final String DATA_DIR = "data";
    private static final String DATA_FILE = "profiles.dat";

    public ProfileDao() {
        initDataDirectory();
    }

    private void initDataDirectory() {
        try {
            Path path = Paths.get(DATA_DIR);
            if (!Files.exists(path)) {
                Files.createDirectories(path);
            }
        } catch (IOException e) {
            throw new RuntimeException("Could not initialize data directory", e);
        }
    }

    private Path getDataFilePath() {
        return Paths.get(DATA_DIR, DATA_FILE);
    }

    // Create or update a profile
    public void saveProfile(Profile profile) throws IOException {
        Objects.requireNonNull(profile, "Profile cannot be null");
        Objects.requireNonNull(profile.getStudentId(), "Student ID cannot be null");

        List<Profile> profiles = getAllProfiles();

        // Remove existing profile if it exists
        profiles.removeIf(p -> p.getStudentId().equals(profile.getStudentId()));
        profiles.add(profile);

        writeAllProfiles(profiles);
    }

    // Retrieve a profile by student ID
    public Profile getProfile(String studentId) throws IOException {
        Objects.requireNonNull(studentId, "Student ID cannot be null");

        return getAllProfiles().stream()
                .filter(p -> studentId.equals(p.getStudentId()))
                .findFirst()
                .orElse(null);
    }

    // Retrieve all profiles
    public List<Profile> getAllProfiles() throws IOException {
        Path filePath = getDataFilePath();

        if (!Files.exists(filePath)) {
            return new ArrayList<>();
        }

        try (BufferedReader reader = Files.newBufferedReader(filePath)) {
            return reader.lines()
                    .filter(line -> !line.trim().isEmpty()) // Skip empty lines
                    .map(Profile::deserialize)
                    .collect(Collectors.toList());
        }
    }

    // Delete a profile
    public boolean deleteProfile(String studentId) throws IOException {
        Objects.requireNonNull(studentId, "Student ID cannot be null");

        List<Profile> profiles = getAllProfiles();
        boolean removed = profiles.removeIf(p -> studentId.equals(p.getStudentId()));

        if (removed) {
            writeAllProfiles(profiles);
        }

        return removed;
    }

    // Helper method to write all profiles to file
    private void writeAllProfiles(List<Profile> profiles) throws IOException {
        Path filePath = getDataFilePath();

        // Create parent directories if they don't exist
        Files.createDirectories(filePath.getParent());

        try (BufferedWriter writer = Files.newBufferedWriter(filePath)) {
            for (Profile profile : profiles) {
                writer.write(profile.serialize());
                writer.newLine();
            }
        }
    }

    // Additional utility methods
    public boolean profileExists(String studentId) throws IOException {
        return getProfile(studentId) != null;
    }

    public long getProfileCount() throws IOException {
        return getAllProfiles().size();
>>>>>>> 0078e1f3e4be7d9b51724a87c2eba7514a9e19c5
    }
}