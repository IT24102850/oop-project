package com.studentregistration.dao;

import com.studentregistration.model.User;
import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserDAO {
    private static final String FILE_PATH = "src/main/resources/users.txt";
    private static final Logger logger = Logger.getLogger(UserDAO.class.getName());

    // Create a new user
    public void addUser(User user) {
        if (user == null || user.getUsername() == null || user.getPassword() == null || user.getRole() == null) {
            throw new IllegalArgumentException("User details cannot be null.");
        }

        // Check if the user already exists
        List<User> users = getAllUsers();
        for (User existingUser : users) {
            if (existingUser.getUsername().equals(user.getUsername())) {
                throw new IllegalArgumentException("User with the same username already exists.");
            }
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            writer.write(user.getId() + "," + user.getUsername() + "," + user.getPassword() + "," + user.getRole());
            writer.newLine();
        } catch (IOException e) {
            logger.log(Level.SEVERE, "Failed to add user to file", e);
            throw new RuntimeException("Failed to add user to file", e);
        }
    }

    // Read all users
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");
                if (data.length == 4) { // Ensure the line has all required fields
                    User user = new User(Integer.parseInt(data[0]), data[1], data[2], data[3]);
                    users.add(user);
                }
            }
        } catch (IOException e) {
            logger.log(Level.SEVERE, "Failed to read users from file", e);
            throw new RuntimeException("Failed to read users from file", e);
        }
        return users;
    }

    // Update a user
    public void updateUser(User updatedUser) {
        if (updatedUser == null) {
            throw new IllegalArgumentException("Updated user cannot be null.");
        }

        List<User> users = getAllUsers();
        boolean userFound = false;

        for (User user : users) {
            if (user.getId() == updatedUser.getId()) {
                user.setUsername(updatedUser.getUsername());
                user.setPassword(updatedUser.getPassword());
                user.setRole(updatedUser.getRole());
                userFound = true;
                break;
            }
        }

        if (!userFound) {
            throw new IllegalArgumentException("User with ID " + updatedUser.getId() + " not found.");
        }

        saveAllUsers(users);
    }

    // Delete a user
    public void deleteUser(int userId) {
        List<User> users = getAllUsers();
        boolean userRemoved = users.removeIf(user -> user.getId() == userId);

        if (!userRemoved) {
            throw new IllegalArgumentException("User with ID " + userId + " not found.");
        }

        saveAllUsers(users);
    }

    // Save all users to file
    private void saveAllUsers(List<User> users) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (User user : users) {
                writer.write(user.getId() + "," + user.getUsername() + "," + user.getPassword() + "," + user.getRole());
                writer.newLine();
            }
        } catch (IOException e) {
            logger.log(Level.SEVERE, "Failed to save users to file", e);
            throw new RuntimeException("Failed to save users to file", e);
        }
    }

    // Find a user by username
    public User findUserByUsername(String username) {
        if (username == null) {
            throw new IllegalArgumentException("Username cannot be null.");
        }

        List<User> users = getAllUsers();
        for (User user : users) {
            if (user.getUsername().equals(username)) {
                return user;
            }
        }
        return null; // User not found
    }

    // Find a user by ID
    public User findUserById(int userId) {
        List<User> users = getAllUsers();
        for (User user : users) {
            if (user.getId() == userId) {
                return user;
            }
        }
        return null; // User not found
    }
}