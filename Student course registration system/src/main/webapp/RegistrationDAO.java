package com.studentregistration.dao;

import com.studentregistration.model.Registration;
import java.util.List;
import java.util.stream.Collectors;

public class RegistrationDAO {
    private static final String REGISTRATIONS_FILE = "registrations.txt";
    private FileHandler fileHandler;  // Renamed from FileUtils to FileHandler for clarity

    public RegistrationDAO() {
        this.fileHandler = new FileHandler();
    }

    // Register a student for a course
    public boolean registerStudentForCourse(Registration registration) {
        try {
            // Check if already registered
            List<Registration> allRegistrations = getAllRegistrations();
            boolean alreadyRegistered = allRegistrations.stream()
                .anyMatch(r -> r.getStudentId().equals(registration.getStudentId()) 
                && allRegistrations.stream()
                .anyMatch(r -> r.getCourseId().equals(registration.getCourseId()));

            if (alreadyRegistered) {
                return false; // Registration already exists
            }

            // Add new registration
            allRegistrations.add(registration);
            fileHandler.writeRegistrations(REGISTRATIONS_FILE, allRegistrations);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get all registrations
    public List<Registration> getAllRegistrations() {
        try {
            return fileHandler.readRegistrations(REGISTRATIONS_FILE);
        } catch (Exception e) {
            e.printStackTrace();
            return List.of(); // Return empty list on error
        }
    }
}