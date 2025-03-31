package com.studentregistration.util;

import java.io.*;
import java.nio.file.*;
import java.util.List;
import java.util.stream.Collectors;

public class FileUtil {

    // Save user data to a file (append mode)
    public static synchronized void saveUser(String filePath, String userData) throws IOException {
        File file = new File(filePath);

        // Ensure parent directory exists
        if (file.getParentFile() != null) {
            file.getParentFile().mkdirs();
        }

        try (BufferedWriter bw = new BufferedWriter(new FileWriter(file, true))) {
            bw.write(userData);
            bw.newLine(); // Ensures each entry is on a new line
            bw.flush(); // Ensures data is properly written
        }
    }

    // Read all lines from a file
    public static List<String> readAllLines(String filePath) throws IOException {
        Path path = Paths.get(filePath);
        if (!Files.exists(path)) {
            return List.of(); // Return empty list if file doesn't exist
        }
        return Files.readAllLines(path);
    }

    // Write a single line to a file (append mode)
    public static synchronized void writeToFile(String filePath, String data, boolean append) throws IOException {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(filePath, append))) {
            bw.write(data);
            bw.newLine();
            bw.flush();
        }
    }

    // Overwrite a file with a list of lines
    public static synchronized void rewriteFile(String filePath, List<String> lines) throws IOException {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(filePath, false))) {
            for (String line : lines) {
                bw.write(line);
                bw.newLine();
            }
            bw.flush();
        }
    }
}
