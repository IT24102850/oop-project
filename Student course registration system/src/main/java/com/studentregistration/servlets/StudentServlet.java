package com.studentregistration.dao;

import com.studentregistration.model.Student;
import java.io.*;
import java.util.ArrayList;
import java.util.List;
//implement class
class StudentDAO {
    private static final String FILE_PATH = "src/main/resources/students.txt";

    // Add a new student
    public void addStudent(Student student) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            writer.write(student.getFullName() + "," + student.getEmail() + "," + student.getPassword() + "," + student.getCourse());
            writer.newLine();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Read all students
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
            e.printStackTrace();
        }
        return students;
    }

    // Find a student by email
    public Student getStudentByEmail(String email) {
        List<Student> students = getAllStudents();
        for (Student student : students) {
            if (student.getEmail().equals(email)) {
                return student;
            }
        }
        return null; // Student not found
    }

    // Update a student
    public void updateStudent(String email, Student updatedStudent) {
        List<Student> students = getAllStudents();
        for (Student student : students) {
            if (student.getEmail().equals(email)) {
                student.setFullName(updatedStudent.getFullName());
                student.setPassword(updatedStudent.getPassword());
                student.setCourse(updatedStudent.getCourse());
                break;
            }
        }
        saveAllStudents(students);
    }

    // Delete a student
    public void deleteStudent(String email) {
        List<Student> students = getAllStudents();
        students.removeIf(student -> student.getEmail().equals(email));
        saveAllStudents(students);
    }

    // Save all students to file
    private void saveAllStudents(List<Student> students) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Student student : students) {
                writer.write(student.getFullName() + "," + student.getEmail() + "," + student.getPassword() + "," + student.getCourse());
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}