package com.studentregistration.servlets;

import com.studentregistration.dao.CourseDAO;
import com.studentregistration.model.Course;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/courses")
public class CourseServlet extends HttpServlet {
    private CourseDAO courseDAO = new CourseDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            // Default: List all courses
            request.setAttribute("courses", courseDAO.getAllCourses());
            request.getRequestDispatcher("/jsp/viewCourses.jsp").forward(request, response);
        }
        else if (action.equals("new")) {
            // Show add course form
            request.getRequestDispatcher("/jsp/addCourse.jsp").forward(request, response);
        }
        else if (action.equals("edit")) {
            // Show edit form for a specific course
            String courseId = request.getParameter("id");
            Course course = courseDAO.getCourseById(courseId);
            request.setAttribute("course", course);
            request.getRequestDispatcher("/jsp/updateCourse.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String courseId = request.getParameter("courseId");
        String courseName = request.getParameter("courseName");
        String description = request.getParameter("description");
        int credits = Integer.parseInt(request.getParameter("credits"));

        Course course = new Course(courseId, courseName, description, credits);

        if (action.equals("add")) {
            courseDAO.addCourse(course);
        }
        else if (action.equals("update")) {
            courseDAO.updateCourse(courseId, course);
        }

        response.sendRedirect("courses");
    }
}
