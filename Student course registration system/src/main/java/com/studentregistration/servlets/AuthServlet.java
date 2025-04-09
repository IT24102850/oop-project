package com.studentregistration.servlets;

import com.studentregistration.dao.StudentDAO;
import com.studentregistration.model.Student;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/auth")
public class AuthServlet extends HttpServlet {
    private StudentDAO studentDao;

    @Override
    public void init() throws ServletException {
        super.init();
        // Initialize StudentDAO with the path to students.txt
        String filePath = getServletContext().getRealPath("/students.txt");
        studentDao = new StudentDAO(filePath);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("username");
        String password = request.getParameter("password");
        String userType = request.getParameter("userType");

        // Debugging: Log the received parameters
        System.out.println("Received login attempt: email=" + email + ", userType=" + userType);

        if ("student".equals(userType)) {
            boolean isValid = studentDao.validateStudent(email, password);
            System.out.println("Student validation result: " + isValid);

            if (isValid) {
                Student student = studentDao.getStudentByEmail(email);
                if (student != null) {
                    HttpSession session = request.getSession();
                    session.setAttribute("studentId", student.getStudentId());
                    session.setAttribute("fullName", student.getFullName());
                    session.setAttribute("email", email);
                    session.setAttribute("userType", "student");
                    System.out.println("Redirecting to student-dashboard.jsp");
                    response.sendRedirect("student-dashboard.jsp");
                } else {
                    System.out.println("Student not found after validation");
                    request.setAttribute("error", "Student data not found");
                    request.getRequestDispatcher("logIn.jsp").forward(request, response);
                }
            } else {
                System.out.println("Invalid email or password");
                request.setAttribute("error", "Invalid email or password");
                request.getRequestDispatcher("logIn.jsp").forward(request, response);
            }
        } else if ("admin".equals(userType)) {
            // Admin login logic (implement if needed)
            System.out.println("Admin login not implemented");
            request.setAttribute("error", "Admin login not implemented");
            request.getRequestDispatcher("logIn.jsp").forward(request, response);
        } else {
            System.out.println("Invalid user type: " + userType);
            request.setAttribute("error", "Invalid user type");
            request.getRequestDispatcher("logIn.jsp").forward(request, response);
        }
    }
}