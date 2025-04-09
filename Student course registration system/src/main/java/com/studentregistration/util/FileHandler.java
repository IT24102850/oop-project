package com.studentregistration.util;

import javax.servlet.ServletContext;
import java.io.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;





public class FileHandler {
    private static final String DATA_DIR = "/WEB-INF/data/";
    private static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    public static synchronized void savePayment(ServletContext context, String studentId,
                                                String courseId, double amount, String paymentMethod) {
        String filePath = context.getRealPath(DATA_DIR + "payment_data.txt");
        String record = String.format("%s\t %s\t %.2f \t %s \t %s\n",
                studentId, courseId, amount, paymentMethod,
                LocalDateTime.now().format(formatter));

        writeToFile(filePath, record);
    }

    public static synchronized void saveLateFeeApplication(ServletContext context,
                                                           String studentId, String courseId, String reason) {
        String filePath = context.getRealPath(DATA_DIR + "late_fee_data.txt");
        String record = String.format("%s|%s|%s|%s%n",
                studentId, courseId, reason,
                LocalDateTime.now().format(formatter));

        writeToFile(filePath, record);
    }

    private static void writeToFile(String filePath, String content) {
        try {
            // Ensure directory exists
            File file = new File(filePath);
            file.getParentFile().mkdirs();

            // Write to file
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(file, true))) {
                writer.write(content);
                writer.flush();
                System.out.println("Successfully wrote to: " + filePath);
            }
        } catch (IOException e) {
            System.err.println("Error writing to file: " + filePath);
            e.printStackTrace();
        }
    }
}