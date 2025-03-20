package com.studentregistration.dao;

import com.studentregistration.model.Admin;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class AdminDAO {
    private static final String FILE_PATH = "src/main/resources/admin.txt";

    // Create a new admin
    public void addAdmin(Admin admin) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            writer.write(admin.getId() + "," + admin.getUsername() + "," + admin.getPassword());
            writer.newLine();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Read all admins
    public List<Admin> getAllAdmins() {
        List<Admin> admins = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");
                Admin admin = new Admin(Integer.parseInt(data[0]), data[1], data[2]);
                admins.add(admin);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return admins;
    }
}