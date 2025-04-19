package com.studentregistration.util;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class FileUtil {
    private static final DateTimeFormatter TIMESTAMP_FORMATTER =
            DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    /**
     * Appends content to a file, creating parent directories if needed
     * @param filePath Path to the file
     * @param content Content to append
     * @return true if successful, false otherwise
     */
    public static boolean appendToFile(String filePath, String content) {
        if (filePath == null || content == null) {
            return false;
        }

        try {
            Path path = Paths.get(filePath);
            createParentDirectories(path);

            // Using Files.write with StandardOpenOption for better atomicity
            Files.write(
                    path,
                    (content + System.lineSeparator()).getBytes(),
                    StandardOpenOption.CREATE,
                    StandardOpenOption.APPEND
            );
            return true;
        } catch (IOException e) {
            System.err.println("Error writing to file: " + filePath);
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Creates parent directories if they don't exist
     * @param path Path to check/create
     * @throws IOException If directory creation fails
     */
    private static void createParentDirectories(Path path) throws IOException {
        Path parent = path.getParent();
        if (parent != null && !Files.exists(parent)) {
            Files.createDirectories(parent);
        }
    }

    /**
     * Formats a message with timestamp for consistent logging
     * @param name Sender's name
     * @param email Sender's email
     * @param subject Message subject
     * @param message Message content
     * @return Formatted string with timestamp
     */
    public static String formatMessage(String name, String email, String subject, String message) {
        String timestamp = LocalDateTime.now().format(TIMESTAMP_FORMATTER);
        return String.format(
                "[%s]%nName: %s%nEmail: %s%nSubject: %s%nMessage: %s%n%n",
                timestamp, name, email, subject, message
        );
    }

    /**
     * Gets the absolute path within the application's context
     * @param contextPath Servlet context path
     * @param relativePath Relative path within the application
     * @return Absolute file system path
     */
    public static String getApplicationPath(String contextPath, String relativePath) {
        return Paths.get(contextPath, relativePath).toString();
    }
}