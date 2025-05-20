package com.studentregistration.dao;

import com.studentregistration.model.Student;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for managing student data stored in a text file (students.txt).
 * The file may contain lines in multiple formats:
 * - New format: ID,Name,Email,Password (e.g., 922B14B1,Supuni Kavindya,supuni2004@gmail.com,supuni2004)
 * - Old tab-separated format: ID<TAB>Name<TAB>Email<TAB>Username (e.g., 1<TAB>Damith Asanka<TAB>damith2004@gmail.com<TAB>hasiru2006)
 * - Old comma-separated format: Email,Password,FullName (e.g., damith2004@gmail.com,hasiru2006,Damith Asanka)
 */
public class StudentDAO {
    private static final Logger logger = Logger.getLogger(StudentDAO.class.getName());
    private String filePath;
    private Map<String, Student> studentCache; // Cache for student data
    private static final Object fileLock = new Object(); // For synchronized file access

    /**
     * Constructor to initialize the DAO with a file path.
     * @param filePath The path to the students.txt file
     */
    public StudentDAO(String filePath) {
        this.filePath = filePath;
        this.studentCache = new HashMap<>();
        logger.info("StudentDAO initialized with filePath: " + filePath);
        loadStudentsFromFile();
    }

    /**
     * Default constructor for flexibility (file path to be set later).
     */
    public StudentDAO() {
        this.studentCache = new HashMap<>();
    }

    /**
     * Sets the file path and reloads the student data.
     * @param filePath The path to the students.txt file
     */
    public void setFilePath(String filePath) {
        this.filePath = filePath;
        logger.info("StudentDAO filePath updated to: " + filePath);
        loadStudentsFromFile();
    }

    /**
     * Loads student data from the text file into the cache.
     */
    private void loadStudentsFromFile() {
        if (filePath == null) {
            logger.severe("File path for students.txt is not set");
            throw new IllegalStateException("File path for students.txt is not set");
        }

        studentCache.clear();
        synchronized (fileLock) {
            try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
                String line;
                int lineNumber = 0;
                while ((line = reader.readLine()) != null) {
                    lineNumber++;
                    if (line.trim().isEmpty()) {
                        logger.fine("Skipping empty line at line " + lineNumber);
                        continue; // Skip empty lines
                    }

                    // Skip header line
                    if (line.startsWith("ID\tName\tEmail\t")) {
                        logger.fine("Skipping header line at line " + lineNumber);
                        continue;
                    }

                    String[] parts;
                    String fullName = null;
                    String studentId = null;
                    String email = null;
                    String password = null;

                    try {
                        // Handle tab-separated format: ID<TAB>Name<TAB>Email<TAB>Username
                        if (line.contains("\t")) {
                            parts = line.split("\t");
                            if (parts.length >= 4) {
                                studentId = parts[0].trim(); // ID
                                fullName = parts[1].trim();  // Name
                                email = parts[2].trim();     // Email
                                password = parts[3].trim();  // Username (used as password)
                            } else {
                                logger.warning("Malformed tab-separated line at line " + lineNumber + ": " + line + " (expected 4 fields)");
                                continue;
                            }
                        } else {
                            parts = line.split(",");
                            if (parts.length >= 4) {
                                // New format: ID,Name,Email,Password
                                studentId = parts[0].trim(); // ID
                                fullName = parts[1].trim();  // Name
                                email = parts[2].trim();     // Email
                                password = parts[3].trim();  // Password
                            } else if (parts.length >= 3) {
                                // Old comma-separated format: Email,Password,FullName
                                email = parts[0].trim();     // Email
                                password = parts[1].trim();  // Password
                                fullName = parts[2].trim();  // FullName
                                studentId = "UNKNOWN_" + email.hashCode(); // Generate a dummy ID
                            } else {
                                logger.warning("Malformed comma-separated line at line " + lineNumber + ": " + line + " (expected at least 3 fields)");
                                continue;
                            }
                        }

                        // Create Student object and add to cache
                        Student student = new Student(fullName, studentId, email, password);
                        if (studentCache.containsKey(email)) {
                            logger.warning("Duplicate email found: " + email + ". Overwriting with newer entry.");
                        }
                        studentCache.put(email, student);
                        logger.info("Loaded student: " + email);
                    } catch (Exception e) {
                        logger.warning("Error parsing line " + lineNumber + ": " + line + ". Error: " + e.getMessage());
                        continue;
                    }
                }
            } catch (IOException e) {
                logger.log(Level.SEVERE, "Failed to read students.txt at " + filePath, e);
                throw new RuntimeException("Failed to read students.txt", e);
            }
        }
    }

    /**
     * Validates a student by checking if the provided email and password match.
     * @param email The student's email
     * @param password The student's password
     * @return true if credentials are valid, false otherwise
     * @throws IllegalArgumentException if email or password is null/empty
     */
    public boolean validateStudent(String email, String password) {
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            logger.warning("Validation failed: Email or password is null/empty");
            throw new IllegalArgumentException("Email and password must not be null or empty");
        }

        Student student = studentCache.get(email);
        if (student == null) {
            logger.warning("No student found for email: " + email);
            return false;
        }
        boolean isValid = student.getPassword().equals(password);
        if (isValid) {
            logger.info("Student validated successfully: " + email);
        } else {
            logger.warning("Invalid password for email: " + email);
        }
        return isValid;
    }

    /**
     * Retrieves a student by email from the cache.
     * @param email The student's email
     * @return Student object if found, null otherwise
     * @throws IllegalArgumentException if email is null/empty
     */
    public Student getStudentByEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            logger.warning("getStudentByEmail failed: Email is null/empty");
            throw new IllegalArgumentException("Email must not be null or empty");
        }

        Student student = studentCache.get(email);
        if (student == null) {
            logger.warning("Student not found for email: " + email);
        } else {
            logger.info("Student retrieved: " + student.getFullName());
        }
        return student;
    }

    /**
     * Reloads the student data from the file, useful if the file is updated externally.
     */
    public void reloadStudents() {
        loadStudentsFromFile();
        logger.info("Student data reloaded from " + filePath);
    }
}