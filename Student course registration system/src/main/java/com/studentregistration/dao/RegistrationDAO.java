package com.studentregistration.dao;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

    public class RegistrationDAO {
        private static final String FILE_PATH = "registrations.txt";

        // Save user to file
        public boolean saveUser(User user) {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
                writer.write(user.toString());
                writer.newLine();
                return true;
            } catch (IOException e) {
                e.printStackTrace();
                return false;
            }
        }

        // Check if email already exists (optional)
        public boolean emailExists(String email) {
            List<User> users = getAllUsers();
            return users.stream().anyMatch(u -> u.getEmail().equals(email));
        }

        // Get all users (for validation or admin purposes)
        public List<User> getAllUsers() {
            List<User> users = new ArrayList<>();
            try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split(",");
                    users.add(new User(parts[0], parts[1], parts[2], parts[3]));
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
            return users;
        }
    }

