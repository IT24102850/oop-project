package com.studentregistration.util;

import java.io.*;
import java.nio.file.*;
import java.util.*;
import java.util.stream.Collectors;

public class FileCRUD {
    private static final String DATA_DIR = "data/";

    // Initialize data directory
    static {
        try {
            Files.createDirectories(Paths.get(DATA_DIR));
        } catch (IOException e) {
            System.err.println("Failed to create data directory: " + e.getMessage());
        }
    }

    /**
     * Creates a new record in the specified file
     * @param filename Name of the file (e.g., "students.txt")
     * @param data Data to be written
     * @throws IOException If file operation fails
     */
    public static synchronized void create(String filename, String data) throws IOException {
        Path filePath = Paths.get(DATA_DIR + filename);

        // Create parent directories if they don't exist
        if (filePath.getParent() != null) {
            Files.createDirectories(filePath.getParent());
        }

        // Append data to file with newline
        Files.write(filePath, (data + System.lineSeparator()).getBytes(),
                StandardOpenOption.CREATE,
                StandardOpenOption.APPEND);
    }

    /**
     * Reads all lines from a file
     * @param filename Name of the file to read
     * @return List of all lines in the file
     * @throws IOException If file operation fails
     */
    public static synchronized List<String> readAll(String filename) throws IOException {
        Path filePath = Paths.get(DATA_DIR + filename);

        if (!Files.exists(filePath)) {
            return new ArrayList<>();
        }

        return Files.readAllLines(filePath)
                .stream()
                .filter(line -> !line.trim().isEmpty())
                .collect(Collectors.toList());
    }

    /**
     * Updates a specific line in the file
     * @param filename Name of the file
     * @param oldLine The exact line to be replaced
     * @param newLine The new line content
     * @throws IOException If file operation fails
     */
    public static synchronized void update(String filename, String oldLine, String newLine) throws IOException {
        Path filePath = Paths.get(DATA_DIR + filename);

        if (!Files.exists(filePath)) {
            throw new FileNotFoundException("File not found: " + filename);
        }

        List<String> lines = Files.readAllLines(filePath);
        List<String> updatedLines = new ArrayList<>();

        for (String line : lines) {
            if (line.equals(oldLine)) {
                updatedLines.add(newLine);
            } else {
                updatedLines.add(line);
            }
        }

        Files.write(filePath, updatedLines, StandardOpenOption.TRUNCATE_EXISTING);
    }

    /**
     * Deletes a specific line from the file
     * @param filename Name of the file
     * @param lineToDelete The exact line to be deleted
     * @throws IOException If file operation fails
     */
    public static synchronized void delete(String filename, String lineToDelete) throws IOException {
        Path filePath = Paths.get(DATA_DIR + filename);

        if (!Files.exists(filePath)) {
            throw new FileNotFoundException("File not found: " + filename);
        }

        List<String> lines = Files.readAllLines(filePath);
        List<String> updatedLines = lines.stream()
                .filter(line -> !line.equals(lineToDelete))
                .collect(Collectors.toList());

        Files.write(filePath, updatedLines, StandardOpenOption.TRUNCATE_EXISTING);
    }

    /**
     * Checks if a line matching the predicate exists in the file
     * @param filename Name of the file
     * @param predicate Condition to check
     * @return true if a matching line exists
     * @throws IOException If file operation fails
     */
    public static synchronized boolean exists(String filename, java.util.function.Predicate<String> predicate)
            throws IOException {
        return readAll(filename).stream().anyMatch(predicate);
    }

    /**
     * Finds the first line matching the predicate
     * @param filename Name of the file
     * @param predicate Condition to check
     * @return The matching line or null if not found
     * @throws IOException If file operation fails
     */
    public static synchronized String find(String filename, java.util.function.Predicate<String> predicate)
            throws IOException {
        return readAll(filename).stream()
                .filter(predicate)
                .findFirst()
                .orElse(null);
    }
}