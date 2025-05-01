<<<<<<< HEAD
package com.studentregistration.servlets;

import com.studentregistration.dao.RegistrationDAO;
import com.studentregistration.dao.StudentDAO;
import com.studentregistration.model.Student;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/enrollment")
public class EnrollmentServlet extends HttpServlet {
    private RegistrationDAO registrationDao;
    private StudentDAO studentDao;

    @Override
    public void init() throws ServletException {
        super.init();
        String userPath = getServletContext().getRealPath("/WEB-INF/data/user_data.txt");
        String studentPath = getServletContext().getRealPath("/WEB-INF/data/students.txt");
        String enrollmentPath = getServletContext().getRealPath("/WEB-INF/data/enrollments.txt");
        registrationDao = new RegistrationDAO(userPath, studentPath, enrollmentPath);
        studentDao = new StudentDAO(studentPath);
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
            // Save to individual file
            saveEnrollmentToIndividualFile(request, studentId, newCourseId);
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
            // No individual file write needed for drop, as it's a deletion
            request.setAttribute("message", "Course dropped successfully");
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
        }
        request.getRequestDispatcher("student-dashboard.jsp").forward(request, response);
    }

    private void saveEnrollmentToIndividualFile(HttpServletRequest request, String studentId, String courseId)
            throws IOException {
        // Get student's first name
        Student student = studentDao.getStudentByEmail((String) request.getSession().getAttribute("email"));
        if (student == null) {
            getServletContext().log("Student not found for ID: " + studentId);
            return;
        }
        String[] nameParts = student.getFullName().split(" ", 2);
        String firstName = nameParts[0].replaceAll("[^a-zA-Z0-9_]", "_");

        // Create filename with timestamp for uniqueness
        String uniqueId = String.valueOf(System.currentTimeMillis());
        String filename = firstName + "_" + uniqueId + ".txt";
        String filePath = getServletContext().getRealPath("/WEB-INF/data/") + filename;

        // Write enrollment data
        try (PrintWriter out = new PrintWriter(new FileWriter(filePath))) {
            out.println(studentId + "," + courseId);
        } catch (IOException e) {
            getServletContext().log("Failed to write to enrollment file: " + filename, e);
            // Continue even if individual file write fails
        }
    }
}
=======
>>>>>>> 0078e1f3e4be7d9b51724a87c2eba7514a9e19c5
