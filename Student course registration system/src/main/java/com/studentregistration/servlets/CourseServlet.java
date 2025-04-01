package com.studentregistration.servlets;

import com.studentregistration.dao.CourseDAO;
import com.studentregistration.dao.RegistrationDAO;
import com.studentregistration.model.Course;
import com.studentregistration.model.Enrollment;
import com.studentregistration.util.FileUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet(name = "CourseServlet", urlPatterns = {"/courses"})
public class CourseServlet extends HttpServlet {
    private CourseDAO courseDAO;
    private RegistrationDAO registrationDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        this.courseDAO = new CourseDAO();
        this.registrationDAO = new RegistrationDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "create":
                    createCourse(request, response);
                    break;
                case "update":
                    updateCourse(request, response);
                    break;
                case "delete":
                    deleteCourse(request, response);
                    break;
                case "enroll":
                    enrollStudent(request, response);
                    break;
                default:
                    response.sendRedirect("courses?action=list");
            }
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "new":
                    showNewForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "view":
                    viewCourse(request, response);
                    break;
                case "list":
                default:
                    listCourses(request, response);
            }
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
    }

    private void listCourses(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String department = request.getParameter("department");
        String professor = request.getParameter("professor");

        List<Course> courses = courseDAO.getAllCourses(department, professor);
        request.setAttribute("courses", courses);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/viewCourses.jsp");
        dispatcher.forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/courseForm.jsp");
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String code = request.getParameter("code");
        Course course = courseDAO.getCourseByCode(code);
        request.setAttribute("course", course);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/courseForm.jsp");
        dispatcher.forward(request, response);
    }

    private void viewCourse(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String code = request.getParameter("code");
        Course course = courseDAO.getCourseByCode(code);
        List<Enrollment> enrollments = registrationDAO.getEnrollmentsForCourse(code);

        request.setAttribute("course", course);
        request.setAttribute("enrollments", enrollments);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/courseDetails.jsp");
        dispatcher.forward(request, response);
    }

    private void createCourse(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String code = request.getParameter("code");
        String title = request.getParameter("title");
        int credits = Integer.parseInt(request.getParameter("credits"));
        String department = request.getParameter("department");
        String professor = request.getParameter("professor");

        Course newCourse = new Course(code, title, credits, department, professor);
        courseDAO.createCourse(newCourse);
        response.sendRedirect("courses?action=list");
    }

    private void updateCourse(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String code = request.getParameter("code");
        String title = request.getParameter("title");
        int credits = Integer.parseInt(request.getParameter("credits"));
        String department = request.getParameter("department");
        String professor = request.getParameter("professor");

        Course course = new Course(code, title, credits, department, professor);
        courseDAO.updateCourse(course);
        response.sendRedirect("courses?action=list");
    }

    private void deleteCourse(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String code = request.getParameter("code");
        courseDAO.deleteCourse(code);
        response.sendRedirect("courses?action=list");
    }

    private void enrollStudent(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String studentEmail = request.getParameter("studentEmail");
        String courseCode = request.getParameter("courseCode");
        String section = request.getParameter("section");

        boolean success = registrationDAO.enrollStudent(studentEmail,
                List.of(courseCode), section);

        if (success) {
            request.setAttribute("message", "Enrollment successful!");
        } else {
            request.setAttribute("error", "Enrollment failed!");
        }

        viewCourse(request, response);
    }
}