package com.example;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class FileHandler {
    private static final String FILE_PATH = "C:\\data\\users.txt"; // Change path if needed

    // Create or Update a record
    public static void saveRecord(String data) throws IOException {
        FileWriter writer = new FileWriter(FILE_PATH, true);
        BufferedWriter buffer = new BufferedWriter(writer);
        buffer.write(data + "\n");
        buffer.close();
    }

    // Read all records
    public static List<String> readRecords() throws IOException {
        List<String> records = new ArrayList<>();
        File file = new File(FILE_PATH);
        if (!file.exists()) return records;

        BufferedReader reader = new BufferedReader(new FileReader(file));
        String line;
        while ((line = reader.readLine()) != null) {
            records.add(line);
        }
        reader.close();
        return records;
    }

    // Delete a record (by filtering and rewriting the file)
    public static void deleteRecord(String data) throws IOException {
        List<String> records = readRecords();
        BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH));

        for (String record : records) {
            if (!record.equals(data)) {
                writer.write(record + "\n");
            }
        }
        writer.close();
    }
}
