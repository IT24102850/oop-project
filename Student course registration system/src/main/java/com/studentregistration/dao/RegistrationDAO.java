package com.studentregistration.dao;

import com.studentregistration.model.Registration;
import com.studentregistration.util.FileUtil;
import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class RegistrationDAO {
    private static final String REGISTRATIONS_FILE = "registrations.txt";

    public RegistrationDAO() {
        // Constructor logic if needed
    }

    // Register a student for a course
    public boolean registerStudentForCourse(Registration registration) {
        try {
            List<Registration> allRegistrations = getAllRegistrations();
            boolean alreadyRegistered = allRegistrations.stream()
                    .anyMatch(r -> r.getStudentId().equals(registration.getStudentId())
                            && r.getCourseId().equals(registration.getCourseId()));

            if (alreadyRegistered) {
                return false;
            }

            allRegistrations.add(registration);
            saveAllRegistrations(allRegistrations);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get all registrations
    public List<Registration> getAllRegistrations() {
        try {
            File file = new File(REGISTRATIONS_FILE);
            if (!file.exists()) {
                return new ArrayList<>();
            }

            try (BufferedReader reader = new BufferedReader(new FileReader(REGISTRATIONS_FILE))) {
                List<Registration> registrations = new ArrayList<>();
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split(",");
                    if (parts.length == 6) {
                        registrations.add(new Registration(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5]));
                    }
                }
                return registrations;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    // Save all registrations to file
    private void saveAllRegistrations(List<Registration> registrations) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(REGISTRATIONS_FILE))) {
            for (Registration r : registrations) {
                writer.write(r.toString());
                writer.newLine();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Get registrations by student ID
    public List<Registration> getRegistrationsByStudentId(String studentId) {
        return getAllRegistrations().stream()
                .filter(r -> r.getStudentId().equals(studentId))
                .collect(Collectors.toList());
    }
}
