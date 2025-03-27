package com.studentregistration.dao;

import com.studentregistration.model.Student;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {
    private static final String FILE_PATH = "students.txt";

    // Add a new student
    public void addStudent(Student student) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            writer.write(student.getFullName() + "," + student.getEmail() + ","
                    + student.getPassword() + "," + student.getCourse());
            writer.newLine();
        } catch (IOException e) {
            System.err.println("Error adding student: " + e.getMessage());
        }
    }

    // Read all students
    public List<Student> getAllStudents() {
        List<Student> students = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");
                if (data.length >= 4) { // Safety check
                    Student student = new Student(data[0], data[1], data[2], data[3]);
                    students.add(student);
                }
            }
        } catch (IOException e) {
            System.err.println("Error reading students: " + e.getMessage());
        }
        return students;
    }

    // Find a student by email
    public Student getStudentByEmail(String email) {
        return getAllStudents().stream()
                .filter(student -> student.getEmail().equals(email))
                .findFirst()
                .orElse(null);
    }

    // Update a student
    public boolean updateStudent(String email, Student updatedStudent) {
        List<Student> students = getAllStudents();
        boolean updated = false;

        for (int i = 0; i < students.size(); i++) {
            if (students.get(i).getEmail().equals(email)) {
                students.set(i, updatedStudent);
                updated = true;
                break;
            }
        }

        if (updated) {
            saveAllStudents(students);
        }
        return updated;
    }

    // Delete a student
    public boolean deleteStudent(String email) {
        List<Student> students = getAllStudents();
        boolean removed = students.removeIf(student -> student.getEmail().equals(email));

        if (removed) {
            saveAllStudents(students);
        }
        return removed;
    }

    // Save all students to file
    private void saveAllStudents(List<Student> students) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Student student : students) {
                writer.write(student.getFullName() + "," + student.getEmail() + ","
                        + student.getPassword() + "," + student.getCourse());
                writer.newLine();
            }
        } catch (IOException e) {
            System.err.println("Error saving students: " + e.getMessage());
        }
    }
}