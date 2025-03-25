package com.studentregistration.dao;

import com.studentregistration.model.Student;
import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class StudentDAO {
    private static final String FILE_PATH = "students.txt"; // Changed to relative path
    private static final String DELIMITER = "::"; // More robust delimiter

    // Initialize file if it doesn't exist
    public StudentDAO() {
        try {
            File file = new File(FILE_PATH);
            if (!file.exists()) {
                file.createNewFile();
            }
        } catch (IOException e) {
            System.err.println("Error initializing student data file: " + e.getMessage());
        }
    }

    // Add a new student with validation
    public boolean addStudent(Student student) {
        if (student == null || student.getEmail() == null || student.getEmail().isEmpty()) {
            return false;
        }

        // Check if student already exists
        if (getStudentByEmail(student.getEmail()) != null) {
            return false;
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            String studentData = String.join(DELIMITER,
                    escape(student.getFullName()),
                    escape(student.getEmail()),
                    escape(student.getPassword()),
                    escape(student.getCourse()));
            writer.write(studentData);
            writer.newLine();
            return true;
        } catch (IOException e) {
            System.err.println("Error adding student: " + e.getMessage());
            return false;
        }
    }

    // Get all students with improved error handling
    public List<Student> getAllStudents() {
        List<Student> students = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (!line.trim().isEmpty()) {
                    String[] data = line.split(DELIMITER, -1); // -1 keeps empty values
                    if (data.length == 4) {
                        students.add(new Student(
                                unescape(data[0]),
                                unescape(data[1]),
                                unescape(data[2]),
                                unescape(data[3])));
                    }
                }
            }
        } catch (IOException e) {
            System.err.println("Error reading students: " + e.getMessage());
        }
        return students;
    }

    // Find student by email with stream API
    public Student getStudentByEmail(String email) {
        return getAllStudents().stream()
                .filter(student -> student.getEmail().equalsIgnoreCase(email))
                .findFirst()
                .orElse(null);
    }

    // Update student with comprehensive validation
    public boolean updateStudent(String email, Student updatedStudent) {
        if (email == null || updatedStudent == null) {
            return false;
        }

        List<Student> students = getAllStudents();
        boolean found = false;

        for (int i = 0; i < students.size(); i++) {
            if (students.get(i).getEmail().equalsIgnoreCase(email)) {
                // Preserve original email (as it's our key)
                updatedStudent.setEmail(email);
                students.set(i, updatedStudent);
                found = true;
                break;
            }
        }

        if (found) {
            return saveAllStudents(students);
        }
        return false;
    }

    // Delete student returns success status
    public boolean deleteStudent(String email) {
        List<Student> students = getAllStudents();
        int initialSize = students.size();

        students = students.stream()
                .filter(student -> !student.getEmail().equalsIgnoreCase(email))
                .collect(Collectors.toList());

        if (students.size() < initialSize) {
            return saveAllStudents(students);
        }
        return false;
    }

    // Save all students with proper error handling
    private boolean saveAllStudents(List<Student> students) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Student student : students) {
                String studentData = String.join(DELIMITER,
                        escape(student.getFullName()),
                        escape(student.getEmail()),
                        escape(student.getPassword()),
                        escape(student.getCourse()));
                writer.write(studentData);
                writer.newLine();
            }
            return true;
        } catch (IOException e) {
            System.err.println("Error saving students: " + e.getMessage());
            return false;
        }
    }

    // Helper methods to handle special characters in data
    private String escape(String data) {
        if (data == null) return "";
        return data.replace(DELIMITER, "\\" + DELIMITER)
                .replace("\n", "\\n")
                .replace("\r", "\\r");
    }

    private String unescape(String data) {
        if (data == null) return "";
        return data.replace("\\" + DELIMITER, DELIMITER)
                .replace("\\n", "\n")
                .replace("\\r", "\r");
    }

    // Additional useful methods
    public boolean studentExists(String email) {
        return getStudentByEmail(email) != null;
    }

    public List<Student> getStudentsByCourse(String course) {
        return getAllStudents().stream()
                .filter(student -> student.getCourse().equalsIgnoreCase(course))
                .collect(Collectors.toList());
    }
}