package com.studentregistration.dao;

import com.studentregistration.model.Instructor;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class InstructorDAO {
    private final String filePath;
    private final List<Instructor> instructors;

    public InstructorDAO(String filePath) throws IOException {
        this.filePath = filePath;
        this.instructors = new ArrayList<>();
        loadInstructors();
    }

    private void loadInstructors() throws IOException {
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.trim().isEmpty()) continue;
                String[] parts = line.split(",");
                if (parts.length >= 5) {
                    Instructor instructor = new Instructor();
                    instructor.setInstructorId(parts[0].trim());
                    instructor.setFullName(parts[1].trim());
                    instructor.setEmail(parts[2].trim());
                    instructor.setPassword(parts[3].trim());
                    instructor.setActive(true); // Default to true since not stored in file
                    instructors.add(instructor);
                } else {
                    System.err.println("Invalid line in instructors.txt: " + line);
                }
            }
        }
    }

    public Instructor getInstructorByEmail(String email) {
        for (Instructor instructor : instructors) {
            if (instructor.getEmail().equalsIgnoreCase(email)) {
                return instructor;
            }
        }
        return null;
    }

    public boolean validateInstructor(String email, String password) {
        Instructor instructor = getInstructorByEmail(email);
        return instructor != null && instructor.getPassword().equals(password);
    }
}