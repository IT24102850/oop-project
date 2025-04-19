// FileUtil.java
package com.studentregistration.util;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

public class FileUtil {
    // ... existing code ...

    public static boolean appendToFile(String filePath, String content) {
        try {
            // Create parent directories if they don't exist
            Path path = Paths.get(filePath);
            if (!Files.exists(path.getParent())) {
                Files.createDirectories(path.getParent());
            }

            // Append content to file
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
                writer.write(content);
                writer.newLine();
            }
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }
}