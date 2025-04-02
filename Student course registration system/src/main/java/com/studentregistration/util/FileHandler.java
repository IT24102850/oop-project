package com.studentregistration.util;

import javax.servlet.ServletContext;
import java.io.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class FileHandler {
    private static final String DATA_DIR = "WEB-INF/data/";
    private static final String PAYMENT_FILE = "payment_data.txt";
    private static final String LATE_FEE_FILE = "late_fee_data.txt";
    private static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    public static synchronized void savePayment(ServletContext context, String studentId,
                                                String courseId, double amount, String paymentMethod) {
        String record = String.format("%s|%s|%.2f|%s|%s%n",
                studentId, courseId, amount, paymentMethod,
                LocalDateTime.now().format(formatter));

        writeToFile(context, PAYMENT_FILE, record);
    }

    public static synchronized void saveLateFeeApplication(ServletContext context,
                                                           String studentId, String courseId, String reason) {
        String record = String.format("%s|%s|%s|%s%n",
                studentId, courseId, reason,
                LocalDateTime.now().format(formatter));

        writeToFile(context, LATE_FEE_FILE, record);
    }

    private static void writeToFile(ServletContext context, String filename, String content) {
        String filePath = context.getRealPath("") + File.separator + DATA_DIR + filename;
        ensureDirectoryExists(filePath);

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
            writer.write(content);
        } catch (IOException e) {
            System.err.println("Error writing to file: " + filePath);
            e.printStackTrace();
        }
    }

    private static void ensureDirectoryExists(String filePath) {
        File file = new File(filePath);
        File parent = file.getParentFile();
        if (!parent.exists()) {
            parent.mkdirs();
        }
    }
}