package com.example.dao;

import com.studentregistration.model.Student;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {
    private static final String FILE_PATH = "src/main/resources/students.txt";

    // Add a new student to the file
    public void addStudent(Student student) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            writer.write(student.toString());
            writer.newLine();
        } catch (IOException e) {
            System.err.println("Error writing to file: " + e.getMessage());
        }
    }

    // Retrieve all students from the file
    public List<Student> getAllStudents() {
        List<Student> students = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");
                Student student = new Student(data[0], data[1], data[2], data[3]);
                students.add(student);
            }
        } catch (IOException e) {
            System.err.println("Error reading from file: " + e.getMessage());
        }
        return students;
    }

    // Update a student's details
    public void updateStudent(String email, Student updatedStudent) {
        List<Student> students = getAllStudents();
        boolean found = false;
        for (int i = 0; i < students.size(); i++) {
            if (students.get(i).getEmail().equals(email)) {
                students.set(i, updatedStudent);
                found = true;
                break;
            }
        }
        if (found) {
            saveAllStudents(students);
        } else {
            System.err.println("Student with email " + email + " not found.");
        }
    }

    // Delete a student by email
    public void deleteStudent(String email) {
        List<Student> students = getAllStudents();
        students.removeIf(student -> student.getEmail().equals(email));
        saveAllStudents(students);
    }

    // Helper method to save all students to the file
    private void saveAllStudents(List<Student> students) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Student student : students) {
                writer.write(student.toString());
                writer.newLine();
            }
        } catch (IOException e) {
            System.err.println("Error saving students to file: " + e.getMessage());
        }
    }
}
