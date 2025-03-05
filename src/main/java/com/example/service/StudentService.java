package com.example.service;

import com.example.model.Student;
import org.springframework.stereotype.Service;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

@Service
public class StudentService {
    private static final String FILE_PATH = "data/students.txt";

    // Create a new student and save to file
    public void createStudent(Student student) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            writer.write(student.toString());
            writer.newLine();
        } catch (IOException e) {
            System.out.println("Error saving student data: " + e.getMessage());
        }
    }

    // Read all students from file
    public List<Student> getAllStudents() {
        List<Student> students = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");
                students.add(new Student(data[0], data[1], data[2], data[3]));
            }
        } catch (IOException e) {
            System.out.println("Error reading student data: " + e.getMessage());
        }
        return students;
    }

    // Update a student by email
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
        }
    }

    // Delete a student by email
    public void deleteStudent(String email) {
        List<Student> students = getAllStudents();
        boolean removed = students.removeIf(student -> student.getEmail().equals(email));
        if (removed) {
            saveAllStudents(students);
        }
    }

    // Helper method to save all students to the file
    private void saveAllStudents(List<Student> students) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Student student : students) {
                writer.write(student.toString());
                writer.newLine();
            }
        } catch (IOException e) {
            System.out.println("Error saving student data: " + e.getMessage());
        }
    }
}