<<<<<<< HEAD
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
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
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
            } else if ("deleteAccount".equals(action)) {
                handleDeleteAccount(request, response);
                return;
            } else if ("changePassword".equals(action)) {
                handleChangePassword(request, response);
                return;
            } else if ("resetPassword".equals(action)) {
                handleResetPassword(request, response);
                return;
            }

            String username = request.getParameter("username").trim();
            String password = request.getParameter("password");
            String userType = request.getParameter("userType");

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

    private void handleResetPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");

        // Verify email exists
        Student student = studentDao.getStudentByEmail(email);
        if (student == null) {
            handleError(request, response, "Email not found", "change-password.jsp");
            return;
        }

        // Update password in students.txt
        String studentsFilePath = getServletContext().getRealPath("/WEB-INF/data/students.txt");
        File studentFile = new File(studentsFilePath);
        File tempFile = new File(studentsFilePath + ".tmp");
        try (BufferedReader reader = new BufferedReader(new FileReader(studentFile));
             BufferedWriter writer = new BufferedWriter(new FileWriter(tempFile))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.contains(email)) {
                    String[] parts = line.split(",");
                    if (parts.length >= 4) {
                        parts[3] = newPassword; // Update password field (index 3)
                        line = String.join(",", parts);
                    }
                }
                writer.write(line + System.lineSeparator());
            }
        }
        studentFile.delete();
        tempFile.renameTo(studentFile);
        logger.info("Reset password in students.txt for email: " + email);

        // Update password in user_data.txt
        User user = userDao.findUserByUsername(email);
        if (user != null) {
            user.setPassword(PasswordUtil.hashPassword(newPassword));
            updateUser(user);
            logger.info("Reset password in user_data.txt for email: " + email);
        }

        // Redirect to logIn.jsp with success message
        response.sendRedirect("logIn.jsp?message=Password+reset+successfully");
    }

    private void handleChangePassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("email") == null) {
            response.sendRedirect("logIn.jsp");
            return;
        }

        String email = (String) session.getAttribute("email");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");

        // Verify current password
        boolean isValid = studentDao.validateStudent(email, currentPassword);
        if (!isValid) {
            handleError(request, response, "Incorrect current password", "change-password.jsp");
            return;
        }

        // Update password in students.txt
        String studentsFilePath = getServletContext().getRealPath("/WEB-INF/data/students.txt");
        File studentFile = new File(studentsFilePath);
        File tempFile = new File(studentsFilePath + ".tmp");
        try (BufferedReader reader = new BufferedReader(new FileReader(studentFile));
             BufferedWriter writer = new BufferedWriter(new FileWriter(tempFile))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.contains(email)) {
                    String[] parts = line.split(",");
                    if (parts.length >= 4) {
                        parts[3] = newPassword; // Update password field (index 3)
                        line = String.join(",", parts);
                    }
                }
                writer.write(line + System.lineSeparator());
            }
        }
        studentFile.delete();
        tempFile.renameTo(studentFile);
        logger.info("Updated password in students.txt for email: " + email);

        // Update password in user_data.txt
        User user = userDao.findUserByUsername(email);
        if (user != null) {
            user.setPassword(PasswordUtil.hashPassword(newPassword));
            updateUser(user);
            logger.info("Updated password in user_data.txt for email: " + email);
        }

        // Invalidate session and redirect to logIn.jsp with success message
        session.invalidate();
        response.sendRedirect("logIn.jsp?message=Password+updated+successfully");
    }

    private void handleDeleteAccount(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("email") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        String email = (String) session.getAttribute("email");
        String studentId = (String) session.getAttribute("studentId");
        String password = request.getParameter("password");

        // Verify password
        boolean isValid = studentDao.validateStudent(email, password);
        if (!isValid) {
            handleError(request, response, "Incorrect password", "delete-account.jsp");
            return;
        }

        // Delete student from students.txt
        String studentsFilePath = getServletContext().getRealPath("/WEB-INF/data/students.txt");
        File studentFile = new File(studentsFilePath);
        File tempFile = new File(studentsFilePath + ".tmp");
        try (BufferedReader reader = new BufferedReader(new FileReader(studentFile));
             BufferedWriter writer = new BufferedWriter(new FileWriter(tempFile))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (!line.contains(email)) {
                    writer.write(line + System.lineSeparator());
                }
            }
        }
        studentFile.delete();
        tempFile.renameTo(studentFile);
        logger.info("Deleted student record for email: " + email);

        // Delete associated enrollments from enrollments.txt
        String enrollmentsFilePath = getServletContext().getRealPath("/WEB-INF/data/enrollments.txt");
        File enrollmentFile = new File(enrollmentsFilePath);
        tempFile = new File(enrollmentsFilePath + ".tmp");
        try (BufferedReader reader = new BufferedReader(new FileReader(enrollmentFile));
             BufferedWriter writer = new BufferedWriter(new FileWriter(tempFile))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (!line.contains(studentId)) {
                    writer.write(line + System.lineSeparator());
                }
            }
        }
        enrollmentFile.delete();
        tempFile.renameTo(enrollmentFile);
        logger.info("Deleted enrollment records for studentId: " + studentId);

        // Delete user from user_data.txt
        String usersFilePath = getServletContext().getRealPath("/WEB-INF/data/user_data.txt");
        File userFile = new File(usersFilePath);
        tempFile = new File(usersFilePath + ".tmp");
        try (BufferedReader reader = new BufferedReader(new FileReader(userFile));
             BufferedWriter writer = new BufferedWriter(new FileWriter(tempFile))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (!line.contains(email)) {
                    writer.write(line + System.lineSeparator());
                }
            }
        }
        userFile.delete();
        tempFile.renameTo(userFile);
        logger.info("Deleted user record for email: " + email);

        // Invalidate session and redirect
        session.invalidate();
        response.sendRedirect("index.jsp");
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

        // Update last login timestamp
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
            handleError(request, response, "Invalid admin credentials", "logIn.jsp");
        }
    }

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
        response.sendRedirect("logIn.jsp");
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
<<<<<<< HEAD
=======
=======
>>>>>>> 0078e1f3e4be7d9b51724a87c2eba7514a9e19c5
>>>>>>> 0ca7d413789dd2d271765992c60a7946b7cc180a
