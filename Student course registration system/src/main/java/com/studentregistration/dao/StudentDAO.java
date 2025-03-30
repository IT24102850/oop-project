package com.studentregistration.dao;

import com.studentregistration.model.Student;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {
    private static final String STUDENT_FILE = "users.txt";

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

        try {
            // Get file path from resources
            InputStream inputStream = getClass().getClassLoader().getResourceAsStream(STUDENT_FILE);
            if (inputStream == null) {
                // Create file if it doesn't exist
                new File(STUDENT_FILE).createNewFile();
                return students;
            }

            try (BufferedReader br = new BufferedReader(new InputStreamReader(inputStream))) {
                String line;
                while ((line = br.readLine()) != null) {
                    String[] parts = line.split(":");
                    if (parts.length >= 2) {
                        Student student = new Student();
                        student.setUsername(parts[0]);
                        student.setPassword(parts[1]);
                        if (parts.length > 2) student.setEmail(parts[2]);
                        if (parts.length > 3) student.setFullName(parts[3]);
                        students.add(student);
                    }
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
    
    public boolean registerStudent(Student student) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(STUDENT_FILE, true))) {
            writer.write(student.getUsername() + ":" + student.getPassword() + ":"
                    + student.getEmail() + ":" + student.getFullName());
            writer.newLine();
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }
}