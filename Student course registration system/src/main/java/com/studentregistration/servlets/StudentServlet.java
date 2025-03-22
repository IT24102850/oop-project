package com.studentregistration.servlets;

import com.studentregistration.dao.StudentDAO;
import com.studentregistration.model.Student;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/students")
public class StudentServlet extends HttpServlet {
    private StudentDAO studentDAO;

    @Override
    public void init() throws ServletException {
        studentDAO = new StudentDAO(); // Initialize the StudentDAO
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list"; // Default action
        }

        switch (action) {
            case "new":
                showNewForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteStudent(request, response);
                break;
            default:
                listStudents(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list"; // Default action
        }

        switch (action) {
            case "insert":
                insertStudent(request, response);
                break;
            case "update":
                updateStudent(request, response);
                break;
            default:
                listStudents(request, response);
        }
    }

    // Display the list of students
    private void listStudents(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Student> students = studentDAO.getAllStudents();
        request.setAttribute("students", students);
        request.getRequestDispatcher("viewStudents.jsp").forward(request, response);
    }

    // Display the form for adding a new student
    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("studentForm.jsp").forward(request, response);
    }

    // Display the form for editing an existing student
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        Student student = studentDAO.getStudentByEmail(email);
        request.setAttribute("student", student);
        request.getRequestDispatcher("studentForm.jsp").forward(request, response);
    }

    // Insert a new student
    private void insertStudent(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String course = request.getParameter("course");

        Student newStudent = new Student(fullName, email, password, course);
        studentDAO.addStudent(newStudent);
        response.sendRedirect("students");
    }

    // Update an existing student
    private void updateStudent(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String course = request.getParameter("course");

        Student updatedStudent = new Student(fullName, email, password, course);
        studentDAO.updateStudent(email, updatedStudent);
        response.sendRedirect("students");
    }

    // Delete a student
    private void deleteStudent(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String email = request.getParameter("email");
        studentDAO.deleteStudent(email);
        response.sendRedirect("students");
    }
}