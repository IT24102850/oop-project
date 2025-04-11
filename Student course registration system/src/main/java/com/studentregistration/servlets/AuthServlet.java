package com.studentregistration.servlets;

import com.studentregistration.dao.StudentDAO;
import com.studentregistration.dao.UserDAO;
import com.studentregistration.model.Student;
import com.studentregistration.model.User;
import com.studentregistration.util.PasswordUtil;
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
    private UserDAO userDao;

    // Default admin credentials (will be used if not found in user_data.txt)
    private static final String DEFAULT_ADMIN_USERNAME = "Hasiru";
    private static final String DEFAULT_ADMIN_PASSWORD = "hasiru2004";

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            // Initialize DAOs with proper file paths
            String studentsPath = getServletContext().getRealPath("/WEB-INF/data/students.txt");
            String usersPath = getServletContext().getRealPath("/WEB-INF/data/user_data.txt");

            studentDao = new StudentDAO(studentsPath);
            userDao = new UserDAO(usersPath);

            // Ensure default admin account exists
            createDefaultAdminAccountIfNeeded();
        } catch (Exception e) {
            throw new ServletException("Failed to initialize authentication system", e);
        }
    }

    private void createDefaultAdminAccountIfNeeded() {
        try {
            User existingAdmin = userDao.findUserByUsername(DEFAULT_ADMIN_USERNAME);
            if (existingAdmin == null || !"admin".equals(existingAdmin.getRole())) {
                User admin = new User();
                admin.setUsername(DEFAULT_ADMIN_USERNAME);
                admin.setPassword(PasswordUtil.hashPassword(DEFAULT_ADMIN_PASSWORD));
                admin.setRole("admin");
                userDao.addUser(admin);
                getServletContext().log("Default admin account created");
            }
        } catch (Exception e) {
            getServletContext().log("Error creating default admin account", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String username = request.getParameter("username").trim();
            String password = request.getParameter("password");
            String userType = request.getParameter("userType");

            // Input validation
            if (username.isEmpty() || password.isEmpty() || userType == null) {
                handleError(request, response, "All fields are required", "logIn.jsp");
                return;
            }

            switch (userType) {
                case "student":
                    handleStudentLogin(request, response, username, password);
                    break;
                case "admin":
                    handleAdminLogin(request, response, username, password);
                    break;
                default:
                    handleError(request, response, "Invalid user type", "logIn.jsp");
            }
        } catch (Exception e) {
            handleError(request, response, "An unexpected error occurred", "logIn.jsp");
            getServletContext().log("Authentication error", e);
        }
    }

    private void handleStudentLogin(HttpServletRequest request, HttpServletResponse response,
                                    String email, String password)
            throws ServletException, IOException {
        boolean isValid = studentDao.validateStudent(email, password);

        if (!isValid) {
            handleError(request, response, "Invalid email or password", "logIn.jsp");
            return;
        }

        Student student = studentDao.getStudentByEmail(email);
        if (student == null) {
            handleError(request, response, "Student data not found", "logIn.jsp");
            return;
        }

        HttpSession session = request.getSession();
        session.setAttribute("studentId", student.getStudentId());
        session.setAttribute("fullName", student.getFullName());
        session.setAttribute("email", email);
        session.setAttribute("userType", "student");

        // Clear any admin session attributes
        session.removeAttribute("username");
        session.removeAttribute("userId");

        response.sendRedirect("student-dashboard.jsp");
    }

    private void handleAdminLogin(HttpServletRequest request, HttpServletResponse response,
                                  String username, String password)
            throws ServletException, IOException {
        User adminUser = userDao.findUserByUsername(username);

        // Check credentials against database or default admin
        boolean isAuthenticated = false;

        if (adminUser != null && "admin".equals(adminUser.getRole())) {
            // Check against database-stored admin
            isAuthenticated = PasswordUtil.verifyPassword(password, adminUser.getPassword());
        } else if (DEFAULT_ADMIN_USERNAME.equalsIgnoreCase(username)) {
            // Fallback to default admin check
            isAuthenticated = DEFAULT_ADMIN_PASSWORD.equals(password);
        }

        if (isAuthenticated) {
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setAttribute("userType", "admin");
            session.setAttribute("userId", adminUser != null ? adminUser.getId() : 0);

            // Clear any student session attributes
            session.removeAttribute("studentId");
            session.removeAttribute("fullName");
            session.removeAttribute("email");

            response.sendRedirect("admin-dashboard.jsp");
        } else {
            handleError(request, response, "Invalid admin credentials", "logIn.jsp");
        }
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response,
                             String errorMessage, String page)
            throws ServletException, IOException {
        request.setAttribute("error", errorMessage);
        request.getRequestDispatcher(page).forward(request, response);
    }
}