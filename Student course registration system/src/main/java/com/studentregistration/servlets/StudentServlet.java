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
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect(request.getContextPath() + "/jsp/logIn.jsp");
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
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect(request.getContextPath() + "/jsp/logIn.jsp");
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