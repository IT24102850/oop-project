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
import java.io.BufferedReader; // Added import
import java.io.BufferedWriter; // Added import
import java.io.FileReader; // Added import
import java.io.FileWriter; // Added import
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

@WebServlet("/auth")
public class AuthServlet extends HttpServlet {
    private StudentDAO studentDao;
    private UserDAO userDao;
    private static final Logger logger = Logger.getLogger(AuthServlet.class.getName());

    private static final String DEFAULT_ADMIN_USERNAME = "Hasiru";
    private static final String DEFAULT_ADMIN_PASSWORD = "hasiru2004";

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            String studentsPath = getServletContext().getRealPath("/WEB-INF/data/students.txt");
            String usersPath = getServletContext().getRealPath("/WEB-INF/data/user_data.txt");

            studentDao = new StudentDAO(studentsPath);
            userDao = new UserDAO(usersPath);

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
            String action = request.getParameter("action");
            if ("logout".equals(action)) {
                handleLogout(request, response);
                return;
            }

            String username = request.getParameter("username").trim();
            String password = request.getParameter("password");
            String userType = request.getParameter("userType");

            if (username.isEmpty() || password.isEmpty() || userType == null) {
                handleError(request, response, "All fields are required", "login.jsp");
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
                    handleError(request, response, "Invalid user type", "login.jsp");
            }
        } catch (Exception e) {
            handleError(request, response, "An unexpected error occurred", "login.jsp");
            getServletContext().log("Authentication error", e);
        }
    }

    // **User Login: Read (R) - Authenticate credentials & generate session tokens**
    private void handleStudentLogin(HttpServletRequest request, HttpServletResponse response,
                                    String email, String password)
            throws ServletException, IOException {
        boolean isValid = studentDao.validateStudent(email, password);

        if (!isValid) {
            handleError(request, response, "Invalid email or password", "login.jsp");
            return;
        }

        Student student = studentDao.getStudentByEmail(email);
        if (student == null) {
            handleError(request, response, "Student data not found", "login.jsp");
            return;
        }

        // **User Login: Update (U) - Track last login timestamps**
        User user = userDao.findUserByUsername(email);
        if (user != null) {
            user.setLastLogin(LocalDateTime.now());
            updateUser(user);
            logger.info("Updated last login for student: " + email);
        }

        HttpSession session = request.getSession();
        session.setAttribute("studentId", student.getStudentId());
        session.setAttribute("fullName", student.getFullName());
        session.setAttribute("email", email);
        session.setAttribute("userType", "student");

        session.removeAttribute("username");
        session.removeAttribute("userId");

        response.sendRedirect("student-dashboard.jsp");
    }

    private void handleAdminLogin(HttpServletRequest request, HttpServletResponse response,
                                  String username, String password)
            throws ServletException, IOException {
        User adminUser = userDao.findUserByUsername(username);

        boolean isAuthenticated = false;

        if (adminUser != null && "admin".equals(adminUser.getRole())) {
            isAuthenticated = PasswordUtil.verifyPassword(password, adminUser.getPassword());
        } else if (DEFAULT_ADMIN_USERNAME.equalsIgnoreCase(username)) {
            isAuthenticated = DEFAULT_ADMIN_PASSWORD.equals(password);
        }

        if (isAuthenticated) {
            // **User Login: Update (U) - Track last login timestamps**
            if (adminUser != null) {
                adminUser.setLastLogin(LocalDateTime.now());
                updateUser(adminUser);
                logger.info("Updated last login for admin: " + username);
            }

            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setAttribute("userType", "admin");
            session.setAttribute("userId", adminUser != null ? adminUser.getId() : 0);

            session.removeAttribute("studentId");
            session.removeAttribute("fullName");
            session.removeAttribute("email");

            response.sendRedirect("admin-dashboard.jsp");
        } else {
            handleError(request, response, "Invalid admin credentials", "login.jsp");
        }
    }

    // **User Login: Delete (D) - Invalidate active sessions on logout**
    private void handleLogout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            String userType = (String) session.getAttribute("userType");
            String username = (String) session.getAttribute("username");
            String email = (String) session.getAttribute("email");

            session.invalidate();
            logger.info("Session invalidated for " + userType + ": " + (username != null ? username : email));
        }
        response.sendRedirect("login.jsp");
    }

    private void updateUser(User user) throws IOException {
        List<User> users = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(
                getServletContext().getRealPath("/WEB-INF/data/user_data.txt")))) {
            String line;
            while ((line = reader.readLine()) != null) {
                users.add(User.fromFileString(line));
            }
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(
                getServletContext().getRealPath("/WEB-INF/data/user_data.txt")))) {
            for (User u : users) {
                if (u.getUsername().equals(user.getUsername())) {
                    writer.write(user.toFileString());
                } else {
                    writer.write(u.toFileString());
                }
                writer.newLine();
            }
        }
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response,
                             String errorMessage, String page)
            throws ServletException, IOException {
        request.setAttribute("error", errorMessage);
        request.getRequestDispatcher(page).forward(request, response);
    }
}