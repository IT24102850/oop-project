package com.studentregistration.servlets;

import com.studentregistration.dao.InstructorDAO;
import com.studentregistration.model.Instructor;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.UUID;
import java.util.logging.Logger;

@WebServlet("/auth")
public class AuthServlet extends HttpServlet {
    private InstructorDAO instructorDao;
    private static final Logger logger = Logger.getLogger(AuthServlet.class.getName());

    private static final String DEFAULT_INSTRUCTOR_USERNAME = "instructor@instructor.com";
    private static final String DEFAULT_INSTRUCTOR_PASSWORD = "instructor123";

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            String instructorsPath = getServletContext().getRealPath("/WEB-INF/data/instructors.txt");
            instructorDao = new InstructorDAO(instructorsPath);
        } catch (Exception e) {
            throw new ServletException("Failed to initialize authentication system", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String csrfToken = UUID.randomUUID().toString();
        session.setAttribute("csrfToken", csrfToken);
        request.getRequestDispatcher("logIn.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            String submittedCsrfToken = request.getParameter("csrfToken");
            String sessionCsrfToken = (String) session.getAttribute("csrfToken");
            if (submittedCsrfToken == null || !submittedCsrfToken.equals(sessionCsrfToken)) {
                handleError(request, response, "Invalid CSRF token", "logIn.jsp");
                return;
            }

            String username = request.getParameter("username").trim();
            String password = request.getParameter("password");
            String userType = request.getParameter("userType");

            if (username.isEmpty() || password.isEmpty() || userType == null) {
                handleError(request, response, "All fields are required", "logIn.jsp");
                return;
            }

            if ("instructor".equals(userType)) {
                handleInstructorLogin(request, response, username, password);
            } else {
                handleError(request, response, "Invalid user type", "logIn.jsp");
            }
        } catch (Exception e) {
            handleError(request, response, "An unexpected error occurred", "logIn.jsp");
            getServletContext().log("Authentication error", e);
        }
    }

    private void handleInstructorLogin(HttpServletRequest request, HttpServletResponse response,
                                       String email, String password)
            throws ServletException, IOException {
        boolean isAuthenticated = instructorDao.validateInstructor(email, password) ||
                (DEFAULT_INSTRUCTOR_USERNAME.equalsIgnoreCase(email) &&
                        DEFAULT_INSTRUCTOR_PASSWORD.equals(password));

        if (isAuthenticated) {
            Instructor instructor = instructorDao.getInstructorByEmail(email);
            if (instructor == null) {
                handleError(request, response, "Instructor data not found", "logIn.jsp");
                return;
            }

            if (!instructor.isActive()) {
                handleError(request, response, "Your account is not active. Please contact the administrator.", "logIn.jsp");
                return;
            }

            HttpSession session = request.getSession();
            session.setAttribute("instructorId", instructor.getInstructorId());
            session.setAttribute("fullName", instructor.getFullName());
            session.setAttribute("email", email);
            session.setAttribute("userType", "instructor");

            response.sendRedirect("instructor-dashboard.jsp");
        } else {
            handleError(request, response, "Invalid instructor email or password", "logIn.jsp");
        }
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response,
                             String errorMessage, String page)
            throws ServletException, IOException {
        request.setAttribute("error", errorMessage);
        request.getRequestDispatcher(page).forward(request, response);
    }
}