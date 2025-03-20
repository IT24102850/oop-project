package com.studentregistration.dao;

import com.studentregistration.model.User;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    private static final String FILE_PATH = "src/main/resources/users.txt";

    // Create a new user
    public void addUser(User user) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            writer.write(user.getId() + "," + user.getUsername() + "," + user.getPassword() + "," + user.getRole());
            writer.newLine();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Read all users
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");
                User user = new User(Integer.parseInt(data[0]), data[1], data[2], data[3]);
                users.add(user);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return users;
    }

    // Update a user
    public void updateUser(User updatedUser) {
        List<User> users = getAllUsers();
        for (User user : users) {
            if (user.getId() == updatedUser.getId()) {
                user.setUsername(updatedUser.getUsername());
                user.setPassword(updatedUser.getPassword());
                user.setRole(updatedUser.getRole());
                break;
            }
        }
        saveAllUsers(users);
    }

    // Delete a user
    public void deleteUser(int userId) {
        List<User> users = getAllUsers();
        users.removeIf(user -> user.getId() == userId);
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
            e.printStackTrace();
        }
    }
}