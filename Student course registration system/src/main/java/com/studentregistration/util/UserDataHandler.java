package com.studentregistration.util;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class UserDataHandler {
    public static final String FILE_PATH = "WEB-INF/user_data.txt"; // More secure location

    // Get all users with additional validation
    public static List<String[]> getAllUsers(String realPath) throws IOException {
        List<String[]> users = new ArrayList<>();
        File file = new File(realPath + FILE_PATH);

        if (!file.exists()) {
            file.getParentFile().mkdirs(); // Create directories if needed
            file.createNewFile();
            return users;
        }

        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] userData = line.split("\\|");
                if (userData.length >= 3) { // At least fullname, email, password
                    users.add(userData);
                }
            }
        }
        return users;
    }

    // Check if email exists (case-insensitive)
    public static boolean emailExists(String realPath, String email) throws IOException {
        List<String[]> users = getAllUsers(realPath);
        return users.stream()
                .anyMatch(user -> user.length > 1 &&
                        user[1].equalsIgnoreCase(email));
    }

    // Update user information
    public static boolean updateUser(String realPath, String email,
                                     String newFullname, String newPassword) throws IOException {
        List<String[]> users = getAllUsers(realPath);
        boolean found = false;

        for (String[] user : users) {
            if (user.length > 1 && user[1].equalsIgnoreCase(email)) {
                user[0] = newFullname;
                user[2] = newPassword;
                found = true;
                break;
            }
        }

        if (found) {
            writeAllUsers(realPath, users);
            return true;
        }
        return false;
    }

    // Delete user by email
    public static boolean deleteUser(String realPath, String email) throws IOException {
        List<String[]> users = getAllUsers(realPath);
        boolean removed = users.removeIf(user ->
                user.length > 1 && user[1].equalsIgnoreCase(email));

        if (removed) {
            writeAllUsers(realPath, users);
            return true;
        }
        return false;
    }

    // Write all users back to file
    private static void writeAllUsers(String realPath, List<String[]> users) throws IOException {
        File file = new File(realPath + FILE_PATH);

        try (PrintWriter out = new PrintWriter(new FileWriter(file))) {
            for (String[] user : users) {
                out.println(String.join("|", user));
            }
        }
    }

    // Get user by email
    public static String[] getUserByEmail(String realPath, String email) throws IOException {
        List<String[]> users = getAllUsers(realPath);
        return users.stream()
                .filter(user -> user.length > 1 && user[1].equalsIgnoreCase(email))
                .findFirst()
                .orElse(null);
    }
}