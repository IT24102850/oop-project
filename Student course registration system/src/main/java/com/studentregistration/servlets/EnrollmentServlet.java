package com.studentregistration.servlets;

import com.studentregistration.dao.RegistrationDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/enrollment")
public class EnrollmentServlet extends HttpServlet {
    private RegistrationDAO registrationDao;

    @Override
    public void init() throws ServletException {
        super.init();
        String userPath = getServletContext().getRealPath("/WEB-INF/data/user_data.txt");
        String studentPath = getServletContext().getRealPath("/WEB-INF/data/students.txt");
        String enrollmentPath = getServletContext().getRealPath("/WEB-INF/data/enrollments.txt");
        registrationDao = new RegistrationDAO(userPath, studentPath, enrollmentPath);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "changeSection":
                handleChangeSection(request, response);
                break;
            case "dropCourse":
                handleDropCourse(request, response);
                break;
            default:
                request.setAttribute("error", "Invalid action");
                request.getRequestDispatcher("student-dashboard.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("viewEnrollments".equals(action)) {
            handleViewEnrollments(request, response);
        } else {
            request.setAttribute("error", "Invalid action");
            request.getRequestDispatcher("student-dashboard.jsp").forward(request, response);
        }
    }

    private void handleViewEnrollments(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String studentId = (String) request.getSession().getAttribute("studentId");
        List<String> enrollments = registrationDao.getEnrollmentsByStudent(studentId);
        request.setAttribute("enrollments", enrollments);
        request.getRequestDispatcher("enrollments.jsp").forward(request, response);
    }

    private void handleChangeSection(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String studentId = (String) request.getSession().getAttribute("studentId");
        String oldCourseId = request.getParameter("oldCourseId");
        String newCourseId = request.getParameter("newCourseId");

        try {
            registrationDao.changeCourseSection(studentId, oldCourseId, newCourseId);
            request.setAttribute("message", "Course section changed successfully");
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
        }
        request.getRequestDispatcher("student-dashboard.jsp").forward(request, response);
    }

    private void handleDropCourse(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String studentId = (String) request.getSession().getAttribute("studentId");
        String courseId = request.getParameter("courseId");

        try {
            registrationDao.dropCourse(studentId, courseId);
            request.setAttribute("message", "Course dropped successfully");
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
        }
        request.getRequestDispatcher("student-dashboard.jsp").forward(request, response);
    }
}