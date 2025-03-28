package com.studentregistration.servlets;

import com.studentregistration.dao.StudentDAO;
import com.studentregistration.model.Student;
<<<<<<< HEAD
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
=======
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/student")
public class StudentServlet extends HttpServlet {

    private StudentDAO studentDao;

    @Override
    public void init() throws ServletException {
        studentDao = new StudentDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
            return;
        }

        String action = request.getParameter("action");

        try {
            switch (action) {
                case "view":
                    viewProfile(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                default:
                    listCourses(request, response);
            }
        } catch (Exception ex) {
            throw new ServletException(ex);
>>>>>>> df9aba31b33a13391e48a40a8d0daacb00a6a90e
        }
    }

<<<<<<< HEAD
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
=======
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
            return;
        }

        String action = request.getParameter("action");

        try {
            switch (action) {
                case "update":
                    updateProfile(request, response);
                    break;
                case "register-course":
                    registerCourse(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/student?action=view");
            }
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
    }

    private void listCourses(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Implementation to list available courses
        request.getRequestDispatcher("/jsp/courses.jsp").forward(request, response);
    }

    private void viewProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = (String) request.getSession().getAttribute("username");
        Student student = studentDao.getStudentByUsername(username);
        request.setAttribute("student", student);
        request.getRequestDispatcher("/jsp/student-profile.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = (String) request.getSession().getAttribute("username");
        Student student = studentDao.getStudentByUsername(username);
        request.setAttribute("student", student);
        request.getRequestDispatcher("/jsp/edit-profile.jsp").forward(request, response);
    }

    private void updateProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = (String) request.getSession().getAttribute("username");
        Student student = studentDao.getStudentByUsername(username);

        student.setEmail(request.getParameter("email"));
        student.setFullName(request.getParameter("fullName"));

        // Password change logic
        String newPassword = request.getParameter("password");
        if (newPassword != null && !newPassword.isEmpty()) {
            student.setPassword(newPassword);
>>>>>>> df9aba31b33a13391e48a40a8d0daacb00a6a90e
        }


    }

    private void registerCourse(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = (String) request.getSession().getAttribute("username");
        String courseId = request.getParameter("courseId");

        // Implementation to register course would go here
        // studentDao.registerCourse(username, courseId);

        request.setAttribute("message", "Course registered successfully!");
        listCourses(request, response);
    }
}