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
    }
}