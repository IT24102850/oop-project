// In src/main/java/com/studentregistration/servlets/RegistrationServlet.java
package com.studentregistration.servlets;

import com.studentregistration.dao.RegistrationDAO;
import com.studentregistration.model.Registration;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

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
        String studentId = request.getParameter("studentId");
        String courseId = request.getParameter("courseId");

        Registration registration = new Registration(studentId, courseId);
        boolean success = registrationDAO.registerStudentForCourse(registration);

        if (success) {
            response.sendRedirect("viewRegistrations.jsp?studentId=" + studentId);
        } else {
            request.setAttribute("error", "Registration failed. You may already be registered for this course.");
            request.getRequestDispatcher("registerCourse.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String studentId = request.getParameter("studentId");
        request.setAttribute("registeredCourses", registrationDAO.getRegisteredCourses(studentId));
        request.getRequestDispatcher("viewRegistrations.jsp").forward(request, response);
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String studentId = request.getParameter("studentId");
        String courseId = request.getParameter("courseId");

        boolean success = registrationDAO.dropCourse(studentId, courseId);
        response.setContentType("application/json");
        response.getWriter().write("{\"success\": " + success + "}");
    }
}
