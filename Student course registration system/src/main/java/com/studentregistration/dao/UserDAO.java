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
                logger.info("Initialized admin data file: " + filePath);
            } catch (IOException e) {
                logger.log(Level.SEVERE, "Failed to initialize admin data file", e);
                throw new RuntimeException("File initialization failed", e);
            }
        }
    }

    public void addUser(User user) {
        validateUser(user);
        checkDuplicateUsername(user.getUsername());
        user.setPassword(PasswordUtil.hashPassword(user.getPassword())); // Hash password

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
            writer.write(userToCsv(user));
            writer.newLine();
            logger.info("Admin added: " + user.getEmail());
        } catch (IOException e) {
            handleIOException("Failed to add admin to file", e);
        }
    }

    public void updateUser(User user, String originalUsername) {
        List<User> users = new ArrayList<>();
        boolean updated = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                User existingUser = parseUser(line);
                if (existingUser != null && existingUser.getUsername().equalsIgnoreCase(originalUsername)) {
                    if (!user.getPassword().equals(existingUser.getPassword())) {
                        user.setPassword(PasswordUtil.hashPassword(user.getPassword())); // Hash new password
                    }
                    users.add(user);
                    updated = true;
                    logger.info("Admin updated: " + user.getEmail());
                } else {
                    users.add(existingUser);
                }
            }
        } catch (IOException e) {
            handleIOException("Failed to read admins for update", e);
        }

        if (updated) {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
                for (User u : users) {
                    if (u != null) {
                        writer.write(userToCsv(u));
                        writer.newLine();
                    }
                }
            } catch (IOException e) {
                handleIOException("Failed to write updated admin data", e);
            }
        } else {
            throw new IllegalArgumentException("No admin found with username: " + originalUsername);
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
            handleIOException("Failed to read admins from file", e);
        }
        return users;
    }

    public User findUserByUsername(String username) {
        return getAllUsers().stream()
                .filter(user -> user.getUsername().equalsIgnoreCase(username))
                .findFirst()
                .orElse(null);
    }

    public void deleteUser(String username) {
        List<User> users = new ArrayList<>();
        boolean deleted = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                User user = parseUser(line);
                if (user != null && !user.getUsername().equalsIgnoreCase(username)) {
                    users.add(user);
                } else {
                    deleted = true;
                    logger.info("Admin deleted: " + username);
                }
            }
        } catch (IOException e) {
            handleIOException("Failed to read admins for deletion", e);
        }

        if (deleted) {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
                for (User user : users) {
                    if (user != null) {
                        writer.write(userToCsv(user));
                        writer.newLine();
                    }
                }
            } catch (IOException e) {
                handleIOException("Failed to write updated admin data after deletion", e);
            }
        } else {
            throw new IllegalArgumentException("No admin found with username: " + username);
        }
    }

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
                user.getUsername(),
                user.getName(),
                user.getEmail(),
                user.getPassword(),
                user.getRole());
    }

    private User parseUser(String csvLine) {
        try {
            String[] parts = csvLine.split(",");
            if (parts.length >= 5) {
                User user = new User();
                user.setId(0); // Placeholder ID
                user.setUsername(parts[0]);
                user.setName(parts[1]);
                user.setEmail(parts[2]);
                user.setPassword(parts[3]);
                user.setRole(parts[4]);
                user.setActive(true); // Default to active
                return user;
            }
            return null;
        } catch (Exception e) {
            logger.log(Level.WARNING, "Failed to parse user line: " + csvLine, e);
            return null;
        }
    }

    private void handleIOException(String message, IOException e) {
        logger.log(Level.SEVERE, message, e);
        throw new RuntimeException(message, e);
    }
}