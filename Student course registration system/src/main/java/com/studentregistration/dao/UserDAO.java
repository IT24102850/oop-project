package com.studentregistration.dao;

import com.studentregistration.model.User;
import com.studentregistration.util.PasswordUtil;
import java.io.*;
import java.time.LocalDateTime;
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

    public User findUserByUsername(String username) {
        return getAllUsers().stream()
                .filter(user -> user.getUsername().equalsIgnoreCase(username))
                .findFirst()
                .orElse(null);
    }

    // **Admin-Specific Auth: Read (R) - Monitor active admin sessions**
    public List<User> getActiveAdminSessions() {
        List<User> activeAdmins = new ArrayList<>();
        LocalDateTime now = LocalDateTime.now();
        for (User user : getAllUsers()) {
            if (("admin".equals(user.getRole()) || "superadmin".equals(user.getRole())) &&
                    user.getLastLogin() != null &&
                    user.getLastLogin().plusHours(1).isAfter(now)) { // 1-hour session timeout
                activeAdmins.add(user);
            }
        }
        logger.info("Retrieved " + activeAdmins.size() + " active admin sessions");
        return activeAdmins;
    }

    // **Admin-Specific Auth: Update (U) - Force password resets for compromised accounts**
    public void forcePasswordReset(String username) {
        List<User> users = new ArrayList<>();
        boolean updated = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                User user = User.fromFileString(line);
                if (user.getUsername().equalsIgnoreCase(username) &&
                        ("admin".equals(user.getRole()) || "superadmin".equals(user.getRole()))) {
                    user.setPassword(PasswordUtil.hashPassword("tempPassword123")); // Temporary password
                    updated = true;
                    logger.info("Forced password reset for admin: " + username);
                }
                users.add(user);
            }
        } catch (IOException e) {
            logger.log(Level.SEVERE, "Failed to force password reset", e);
            throw new RuntimeException("Failed to force password reset", e);
        }

        if (updated) {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
                for (User user : users) {
                    writer.write(user.toFileString());
                    writer.newLine();
                }
            } catch (IOException e) {
                logger.log(Level.SEVERE, "Failed to write updated user data", e);
                throw new RuntimeException("Failed to update user data after password reset", e);
            }
        } else {
            logger.warning("No admin user found with username: " + username);
            throw new IllegalArgumentException("No admin user found with username: " + username);
        }
    }

    // **Admin-Specific Auth: Delete (D) - Deactivate suspicious accounts**
    public void deactivateAccount(String username) {
        List<User> users = new ArrayList<>();
        boolean deactivated = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                User user = User.fromFileString(line);
                if (user.getUsername().equalsIgnoreCase(username)) {
                    user.setActive(false);
                    deactivated = true;
                    logger.info("Deactivated account: " + username);
                }
                users.add(user);
            }
        } catch (IOException e) {
            logger.log(Level.SEVERE, "Failed to deactivate account", e);
            throw new RuntimeException("Failed to deactivate account", e);
        }

        if (deactivated) {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
                for (User user : users) {
                    writer.write(user.toFileString());
                    writer.newLine();
                }
            } catch (IOException e) {
                logger.log(Level.SEVERE, "Failed to write updated user data", e);
                throw new RuntimeException("Failed to update user data after deactivation", e);
            }
        } else {
            logger.warning("No user found with username: " + username);
            throw new IllegalArgumentException("No user found with username: " + username);
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
                String.valueOf(user.getId()),
                user.getUsername(),
                user.getPassword(),
                user.getRole());
    }

    private User parseUser(String csvLine) {
        try {
            return User.fromFileString(csvLine);
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