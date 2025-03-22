package com.example.dao;

import com.example.model.Student;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class StudentDAOTest {

    private StudentDAO studentDAO;
    private static final String TEST_FILE_PATH = "src/test/resources/students_test.txt";

    @BeforeEach
    void setUp() {
        // Use a test file for testing
        studentDAO = new StudentDAO();
        studentDAO.setFilePath(TEST_FILE_PATH);

        // Clear the test file before each test
        File file = new File(TEST_FILE_PATH);
        if (file.exists()) {
            file.delete();
        }
    }

    @Test
    void testAddStudent() {
        Student student = new Student("John Doe", "john.doe@example.com", "password123", "Computer Science");
        studentDAO.addStudent(student);

        List<Student> students = studentDAO.getAllStudents();
        assertEquals(1, students.size(), "One student should be added");
        assertEquals(student.toString(), students.get(0).toString(), "Added student should match");
    }

    @Test
    void testGetAllStudents() {
        Student student1 = new Student("John Doe", "john.doe@example.com", "password123", "Computer Science");
        Student student2 = new Student("Jane Smith", "jane.smith@example.com", "password456", "Mathematics");

        studentDAO.addStudent(student1);
        studentDAO.addStudent(student2);

        List<Student> students = studentDAO.getAllStudents();
        assertEquals(2, students.size(), "Two students should be retrieved");
        assertTrue(students.stream().anyMatch(s -> s.toString().equals(student1.toString())), "List should contain student1");
        assertTrue(students.stream().anyMatch(s -> s.toString().equals(student2.toString())), "List should contain student2");
    }

    @Test
    void testUpdateStudent() {
        Student student = new Student("John Doe", "john.doe@example.com", "password123", "Computer Science");
        studentDAO.addStudent(student);

        Student updatedStudent = new Student("John Doe", "john.doe@example.com", "newpassword123", "Physics");
        studentDAO.updateStudent("john.doe@example.com", updatedStudent);

        List<Student> students = studentDAO.getAllStudents();
        assertEquals(1, students.size(), "Only one student should exist after update");
        assertEquals(updatedStudent.toString(), students.get(0).toString(), "Student should be updated");
    }

    @Test
    void testDeleteStudent() {
        Student student = new Student("John Doe", "john.doe@example.com", "password123", "Computer Science");
        studentDAO.addStudent(student);

        studentDAO.deleteStudent("john.doe@example.com");

        List<Student> students = studentDAO.getAllStudents();
        assertTrue(students.isEmpty(), "Student list should be empty after deletion");
    }

    @Test
    void testFileHandling() {
        Student student = new Student("John Doe", "john.doe@example.com", "password123", "Computer Science");
        studentDAO.addStudent(student);

        // Simulate a new DAO instance to test file reading
        StudentDAO newStudentDAO = new StudentDAO();
        newStudentDAO.setFilePath(TEST_FILE_PATH);

        List<Student> students = newStudentDAO.getAllStudents();
        assertEquals(1, students.size(), "Student data should be persisted in the file");
        assertEquals(student.toString(), students.get(0).toString(), "Persisted student should match");
    }
}