package com.studentregistration.dao;

import com.studentregistration.model.User;
import com.studentregistration.util.PasswordUtil;
import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserDAO {
    private final String filePath;
    private static final Logger logger = Logger.getLogger(UserDAO.class.getName());

    // Constructor with file path dependency
    public UserDAO(String filePath) {
        this.filePath = filePath;
        initializeFile();
    }

    private void initializeFile() {
        File file = new File(filePath);
        if (!file.exists()) {
            try {
                file.getParentFile().mkdirs();
                file.createNewFile();
                createDefaultAdminAccount();
            } catch (IOException e) {
                logger.log(Level.SEVERE, "Failed to initialize user data file", e);
            }
        }
    }

    private void createDefaultAdminAccount() {
        User admin = new User();
        admin.setId(1);
        admin.setUsername("Hasiru");
        admin.setPassword(PasswordUtil.hashPassword("hasiru2004"));
        admin.setRole("admin");

        try {
            addUser(admin);
            logger.info("Default admin account created");
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Failed to create default admin", e);
        }
    }

    // Updated methods using instance filePath
    public void addUser(User user) {
        validateUser(user);
        checkDuplicateUsername(user.getUsername());

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
            writer.write(userToCsv(user));
            writer.newLine();
        } catch (IOException e) {
            handleIOException("Failed to add user to file", e);
        }
    }

    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                User user = parseUser(line);
                if (user != null) users.add(user);
            }
        } catch (IOException e) {
            handleIOException("Failed to read users from file", e);
        }
        return users;
    }

    // Other methods (updateUser, deleteUser, saveAllUsers) follow same pattern...

    public User findUserByUsername(String username) {
        return getAllUsers().stream()
                .filter(user -> user.getUsername().equalsIgnoreCase(username))
                .findFirst()
                .orElse(null);
    }

    // Helper methods
    private void validateUser(User user) {
        if (user == null || user.getUsername() == null ||
                user.getPassword() == null || user.getRole() == null) {
            throw new IllegalArgumentException("Invalid user data");
        }
    }

    private void checkDuplicateUsername(String username) {
        if (findUserByUsername(username) != null) {
            throw new IllegalArgumentException("Username already exists");
        }
    }

    private String userToCsv(User user) {
        return String.join(",",
                String.valueOf(user.getId()),
                user.getUsername(),
                user.getPassword(),
                user.getRole());
    }

    private User parseUser(String csvLine) {
        String[] data = csvLine.split(",");
        if (data.length == 4) {
            return new User(
                    Integer.parseInt(data[0]),
                    data[1],
                    data[2],
                    data[3]
            );
        }
        return null;
    }

    private void handleIOException(String message, IOException e) {
        logger.log(Level.SEVERE, message, e);
        throw new RuntimeException(message, e);
    }
}