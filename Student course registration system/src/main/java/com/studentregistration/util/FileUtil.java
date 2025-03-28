package com.studentregistration.util;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

public class FileUtil {
    public static synchronized void saveUser(String filePath, String userData) throws IOException {
        File file = new File(filePath);

        // Create parent directories if they don't exist
        file.getParentFile().mkdirs();

        // Write user data to file (append mode)
        try (FileWriter fw = new FileWriter(file, true);
             BufferedWriter bw = new BufferedWriter(fw)) {
            bw.write(userData);
        }
    }
}