package com.studentregistration.util;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class FileUtil {

    // Read all lines from a file and return as a List of Strings
    public static List<String> readFile(String filePath) {
        List<String> lines = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = br.readLine()) != null) {
                lines.add(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return lines;
    }

    // Write a single line to a file (append mode)
    public static void writeToFile(String filePath, String data) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(filePath, true))) {
            bw.write(data);
            bw.newLine();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Overwrite a file with new data
    public static void overwriteFile(String filePath, List<String> data) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(filePath))) {
            for (String line : data) {
                bw.write(line);
                bw.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Update a specific record in the file
    public static void updateFile(String filePath, String oldData, String newData) {
        List<String> lines = readFile(filePath);
        for (int i = 0; i < lines.size(); i++) {
            if (lines.get(i).equals(oldData)) {
                lines.set(i, newData);
                break;
            }
        }
        overwriteFile(filePath, lines);
    }

    // Delete a specific record from the file
    public static void deleteFromFile(String filePath, String dataToDelete) {
        List<String> lines = readFile(filePath);
        lines.removeIf(line -> line.equals(dataToDelete));
        overwriteFile(filePath, lines);
    }
}
