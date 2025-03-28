package com.studentregistration.util;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class UserDataHandler {
    private static final String FILE_PATH = "user_data.txt";

    // Create a new user (already implemented in the servlet)

    // Read all users
    public static List<String[]> getAllUsers(String realPath) throws IOException {
        List<String[]> users = new ArrayList<>();
        File file = new File(realPath + FILE_PATH);

        if (!file.exists()) {
            return users;
        }

        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] userData = line.split("\\|");
                if (userData.length == 3) {
                    users.add(userData);
                }
            }
        }
        return users;
    }

    // Update user by email
    public static boolean updateUser(String realPath, String email, String newFullname, String newPassword)
            throws IOException {
        List<String[]> users = getAllUsers(realPath);
        boolean found = false;

        for (String[] user : users) {
            if (user[1].equals(email)) {
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
        boolean removed = users.removeIf(user -> user[1].equals(email));

        if (removed) {
            writeAllUsers(realPath, users);
            return true;
        }
        return false;
    }

    // Helper method to write all users back to file
    private static void writeAllUsers(String realPath, List<String[]> users) throws IOException {
        File file = new File(realPath + FILE_PATH);

        try (FileWriter fw = new FileWriter(file);
             BufferedWriter bw = new BufferedWriter(fw);
             PrintWriter out = new PrintWriter(bw)) {

            for (String[] user : users) {
                out.println(String.join("|", user));
            }
        }
    }

    // Check if email exists
    public static boolean emailExists(String realPath, String email) throws IOException {
        List<String[]> users = getAllUsers(realPath);
        return users.stream().anyMatch(user -> user[1].equals(email));
    }
}