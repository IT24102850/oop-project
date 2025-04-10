<<<<<<< HEAD
=======
package com.studentregistration.servlets;

import com.studentregistration.dao.StudentDAO;
import com.studentregistration.model.Student;
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
        if (session == null || session.getAttribute("email") == null) { // Changed from username to email
            response.sendRedirect(request.getContextPath() + "/logIn.jsp");
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
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("email") == null) { // Changed from username to email
            response.sendRedirect(request.getContextPath() + "/logIn.jsp");
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
        request.getRequestDispatcher("/courses.jsp").forward(request, response);
    }

    private void viewProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = (String) request.getSession().getAttribute("email"); // Changed from username to email
        Student student = studentDao.getStudentByEmail(email); // Changed method call
        request.setAttribute("student", student);
        request.getRequestDispatcher("/student-profile.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = (String) request.getSession().getAttribute("email"); // Changed from username to email
        Student student = studentDao.getStudentByEmail(email); // Changed method call
        request.setAttribute("student", student);
        request.getRequestDispatcher("/edit-profile.jsp").forward(request, response);
    }

    private void updateProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = (String) request.getSession().getAttribute("email"); // Changed from username to email
        Student student = studentDao.getStudentByEmail(email); // Changed method call

        // Update student details
        student.setEmail(request.getParameter("email"));
        student.setFullName(request.getParameter("fullName")); // Changed from setFullName to setName

        // Password change logic
        String newPassword = request.getParameter("password");
        if (newPassword != null && !newPassword.isEmpty()) {
            student.setPassword(newPassword);
        }

        // TODO: Add code to actually update the student in the database/file
        // studentDao.updateStudent(student);

        response.sendRedirect(request.getContextPath() + "/student?action=view");
    }

    private void registerCourse(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = (String) request.getSession().getAttribute("email"); // Changed from username to email
        String courseId = request.getParameter("courseId");

        // Implementation to register course would go here
        // studentDao.registerCourse(email, courseId);

        request.setAttribute("message", "Course registered successfully!");
        listCourses(request, response);
    }
}
>>>>>>> 371633be2d62f4b187038b8cd48de0e1c5b353ce
