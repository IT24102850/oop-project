package com.studentregistration.servlets;

import com.studentregistration.dao.RegistrationDAO;
import com.studentregistration.model.Registration;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "RegistrationServlet", urlPatterns = {"/registrations/*"})
public class RegistrationServlet extends HttpServlet {
    private RegistrationDAO registrationDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        this.registrationDAO = new RegistrationDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle course registration
        String studentId = request.getParameter("studentId");
        String courseId = request.getParameter("courseId");

        if (studentId == null || studentId.isEmpty() || courseId == null || courseId.isEmpty()) {
            request.setAttribute("error", "Student ID and Course ID are required");
            request.getRequestDispatcher("/jsp/registerCourse.jsp").forward(request, response);
            return;
        }

        Registration registration = new Registration(studentId, courseId);
        boolean success = registrationDAO.registerStudentForCourse(registration);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/registrations?studentId=" + studentId);
        } else {
            request.setAttribute("error", "Registration failed. You may already be registered for this course.");
            request.getRequestDispatcher("/jsp/registerCourse.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // View registered courses for a student
        String studentId = request.getParameter("studentId");

        if (studentId == null || studentId.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Student ID is required");
            return;
        }

        request.setAttribute("registeredCourses", registrationDAO.getRegisteredCourses(studentId));
        request.getRequestDispatcher("/jsp/viewRegistrations.jsp").forward(request, response);
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Drop a course registration
        String studentId = request.getParameter("studentId");
        String courseId = request.getParameter("courseId");

        if (studentId == null || studentId.isEmpty() || courseId == null || courseId.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Student ID and Course ID are required");
            return;
        }

        boolean success = registrationDAO.dropCourse(studentId, courseId);
        response.setContentType("application/json");
        response.getWriter().print("{\"success\": " + success + "}");
    }
}