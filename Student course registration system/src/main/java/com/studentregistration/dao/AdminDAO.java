package com.studentregistration.dao;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class AdminDAO {
    public boolean validateAdmin(String username, String password) {
        String filePath = getClass().getClassLoader().getResource("admins.txt").getPath();

        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(":");
                if (parts.length == 2 && parts[0].equals(username) && parts[1].equals(password)) {
                    return true;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return false;
    }
}