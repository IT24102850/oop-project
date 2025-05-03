package com.studentregistration.dao;

import com.studentregistration.model.Student;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class StudentDAO {
    private static final Logger logger = Logger.getLogger(StudentDAO.class.getName());
    private String filePath;

    // Constructor to set the file path dynamically
    public StudentDAO(String filePath) {
        this.filePath = filePath;
        logger.info("StudentDAO initialized with filePath: " + filePath);
    }

    // Default constructor for existing instantiation
    public StudentDAO() {
        // filePath will be set later
    }

    // Setter for filePath
    public void setFilePath(String filePath) {
        this.filePath = filePath;
        logger.info("StudentDAO filePath set to: " + filePath);
    }

    /**
     * Validates a student by checking if the provided email and password match
     * a record in students.txt.
     * @param email The student's email
     * @param password The student's password
     * @return true if credentials are valid, false otherwise
     */
    public boolean validateStudent(String email, String password) {
        if (filePath == null) {
            logger.severe("File path for students.txt is not set");
            throw new IllegalStateException("File path for students.txt is not set");
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 4) {
                    String storedEmail = parts[2].trim();    // Email is the 3rd field
                    String storedPassword = parts[3].trim(); // Password is the 4th field
                    if (storedEmail.equals(email) && storedPassword.equals(password)) {
                        logger.info("Student validated successfully: " + email);
                        return true;
                    }
                }
            }
            logger.warning("No matching student found for email: " + email);
        } catch (IOException e) {
            logger.log(Level.SEVERE, "Failed to read students.txt", e);
            throw new RuntimeException("Failed to read students.txt", e);
        }
        return false;
    }

    /**
     * Retrieves a student by email from students.txt.
     * @param email The student's email
     * @return Student object if found, null otherwise
     */
    public Student getStudentByEmail(String email) {
        if (filePath == null) {
            logger.severe("File path for students.txt is not set");
            throw new IllegalStateException("File path for students.txt is not set");
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 4) {
                    String storedEmail = parts[2].trim();
                    if (storedEmail.equals(email)) {
                        Student student = new Student(parts[0].trim(), parts[1].trim(), storedEmail, parts[3].trim());
                        logger.info("Student retrieved: " + student.getFullName());
                        return student;
                    }
                }
            }
            logger.warning("Student not found for email: " + email);
        } catch (IOException e) {
            logger.log(Level.SEVERE, "Failed to read students.txt", e);
            throw new RuntimeException("Failed to read students.txt", e);
        }
        return null;
    }
}