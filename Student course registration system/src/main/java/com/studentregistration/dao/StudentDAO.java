package com.studentregistration.dao;

import com.studentregistration.model.Student;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {
    private static final String STUDENT_FILE = "users.txt"; // Stored in src/main/resources

    // Validate student credentials
    public boolean validateStudent(String username, String password) {
        List<Student> students = getAllStudents();
        return students.stream()
                .anyMatch(s -> s.getUsername().equals(username)
                        && s.getPassword().equals(password));
    }

    // Get all students from file
    public List<Student> getAllStudents() {
        List<Student> students = new ArrayList<>();
        String filePath = getClass().getClassLoader().getResource(STUDENT_FILE).getPath();

        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(":");
                if (parts.length >= 2) {
                    Student student = new Student();
                    student.setUsername(parts[0]);
                    student.setPassword(parts[1]);
                    // Add additional fields if present in the file
                    if (parts.length > 2) student.setEmail(parts[2]);
                    if (parts.length > 3) student.setFullName(parts[3]);
                    students.add(student);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return students;
    }

    // Get student by username
    public Student getStudentByUsername(String username) {
        return getAllStudents().stream()
                .filter(s -> s.getUsername().equals(username))
                .findFirst()
                .orElse(null);
    }

    // Register new student
    public boolean registerStudent(Student student) {
        // Implementation to write to users.txt
        // You'll need to add proper file writing logic here
        // Remember to handle file locking if multiple users register simultaneously
        return true;
    }
}