package com.studentregistration.servlets;

import com.studentregistration.dao.StudentDAO;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

public class AuthServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(AuthServlet.class.getName());
    private static final String STUDENTS_FILE = "/WEB-INF/data/students.txt";
    private static final String ADMIN_USERNAME = "Hasiru";
    private static final String ADMIN_PASSWORD = "hasiru2004";
    private static final Object fileLock = new Object();
    private StudentDAO studentDAO; // Added for DAO integration

    @Override
    public void init() throws ServletException {
        String studentsPath = getServletContext().getRealPath(STUDENTS_FILE);
        studentDAO = new StudentDAO(studentsPath);
        logger.info("StudentDAO initialized in AuthServlet with file path: " + studentsPath);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username"); // Used for both admin username and student email
        String password = request.getParameter("password");
        String userType = request.getParameter("userType");

        // Validate input
        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty() || userType == null) {
            logger.warning("Invalid login attempt: username=" + username + ", userType=" + userType);
            response.sendRedirect(request.getContextPath() + "/logIn.jsp?error=1"); // Invalid input
            return;
        }

        username = username.trim();
        password = password.trim();

        if (userType.equals("admin")) {
            // Admin login
            if (username.equals(ADMIN_USERNAME) && password.equals(ADMIN_PASSWORD)) {
                HttpSession session = request.getSession();
                session.setAttribute("userType", "admin");
                session.setAttribute("username", username);
                logger.info("Admin login successful: " + username);
                response.sendRedirect(request.getContextPath() + "/admin-dashboard.jsp");
            } else {
                logger.warning("Admin login failed: username=" + username);
                response.sendRedirect(request.getContextPath() + "/logIn.jsp?error=2"); // Invalid admin credentials
            }
        } else if (userType.equals("student")) {
            // Student login (username field contains email)
            try {
                boolean isValid = studentDAO.validateStudent(username, password);
                if (isValid) {
                    HttpSession session = request.getSession();
                    session.setAttribute("userType", "student");
                    session.setAttribute("email", username);
                    logger.info("Student login successful: " + username);
                    response.sendRedirect(request.getContextPath() + "/student-dashboard.jsp");
                } else {
                    logger.warning("Student login failed: email=" + username);
                    response.sendRedirect(request.getContextPath() + "/logIn.jsp?error=3"); // Invalid student credentials
                }
            } catch (IllegalArgumentException e) {
                logger.warning("Invalid input for student login: " + e.getMessage());
                response.sendRedirect(request.getContextPath() + "/logIn.jsp?error=1"); // Invalid input
            }
        } else {
            String action = request.getParameter("action");
            if ("deleteAccount".equals(action)) {
                HttpSession session = request.getSession(false);
                if (session == null || !"student".equals(session.getAttribute("userType"))) {
                    logger.warning("Unauthorized account deletion attempt: no valid student session");
                    response.sendRedirect(request.getContextPath() + "/logIn.jsp?error=4");
                    return;
                }

                String email = (String) session.getAttribute("email");
                String providedPassword = request.getParameter("password");
                try {
                    if (studentDAO.validateStudent(email, providedPassword)) {
                        deleteStudentFromFile(email);
                        session.invalidate();
                        logger.info("Account deleted successfully for email: " + email);
                        response.sendRedirect(request.getContextPath() + "/logIn.jsp?message=account_deleted");
                    } else {
                        logger.warning("Incorrect password for account deletion: email=" + email);
                        request.setAttribute("error", "Incorrect password. Account deletion failed.");
                        RequestDispatcher dispatcher = request.getRequestDispatcher("/delete-account.jsp");
                        dispatcher.forward(request, response);
                    }
                } catch (IllegalArgumentException e) {
                    logger.warning("Invalid input for account deletion: " + e.getMessage());
                    request.setAttribute("error", "Invalid input: " + e.getMessage());
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/delete-account.jsp");
                    dispatcher.forward(request, response);
                }
            } else {
                logger.warning("Invalid user type or action: " + userType + ", action: " + action);
                response.sendRedirect(request.getContextPath() + "/logIn.jsp?error=4"); // Invalid user type or action
            }
        }
    }

    private void deleteStudentFromFile(String email) throws IOException {
        String studentsPath = getServletContext().getRealPath(STUDENTS_FILE);
        File file = new File(studentsPath);
        if (!file.exists()) {
            logger.warning("students.txt does not exist at: " + studentsPath);
            return;
        }

        List<String> lines = new ArrayList<>();
        boolean found = false;

        synchronized (fileLock) {
            try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    if (line.trim().isEmpty()) continue;
                    if (line.startsWith("ID\tName\tEmail\t")) {
                        lines.add(line);
                        continue;
                    }
                    String[] parts;
                    String currentEmail = null;
                    try {
                        if (line.contains("\t")) {
                            parts = line.split("\t");
                            if (parts.length >= 3) currentEmail = parts[2].trim();
                        } else {
                            parts = line.split(",");
                            if (parts.length >= 3) currentEmail = parts[2].trim();
                            else if (parts.length >= 1) currentEmail = parts[0].trim();
                        }
                        if (currentEmail != null && !currentEmail.equals(email)) {
                            lines.add(line);
                        } else if (currentEmail != null && currentEmail.equals(email)) {
                            found = true;
                        }
                    } catch (Exception e) {
                        logger.warning("Error parsing line in students.txt: " + line + ". Error: " + e.getMessage());
                        lines.add(line);
                    }
                }
            }

            if (found) {
                try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
                    for (String line : lines) {
                        writer.write(line);
                        writer.newLine();
                    }
                    logger.info("Deleted student with email: " + email + " from students.txt");
                    studentDAO.reloadStudents(); // Refresh the DAO cache
                }
            } else {
                logger.warning("Student with email " + email + " not found in students.txt");
            }
        }
    }

    private String getStudentPasswordFromFile(HttpServletRequest request, String email) throws IOException {
        String studentsPath = request.getServletContext().getRealPath(STUDENTS_FILE);
        File file = new File(studentsPath);
        if (!file.exists()) {
            logger.warning("students.txt does not exist at: " + studentsPath);
            return null;
        }

        String lastPassword = null;
        boolean duplicateFound = false;

        synchronized (fileLock) {
            try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                String line;
                int lineNumber = 0;
                while ((line = reader.readLine()) != null) {
                    lineNumber++;
                    if (line.trim().isEmpty()) {
                        logger.fine("Skipping empty line at line " + lineNumber);
                        continue;
                    }

                    // Skip the header line
                    if (line.startsWith("ID\tName\tEmail\t")) {
                        logger.fine("Skipping header line at line " + lineNumber);
                        continue;
                    }

                    String[] parts;
                    String currentEmail = null;
                    String password = null;

                    try {
                        // Try tab-separated format: ID<TAB>Name<TAB>Email<TAB>Password
                        if (line.contains("\t")) {
                            parts = line.split("\t");
                            if (parts.length >= 4) {
                                currentEmail = parts[2].trim(); // Email is in the third column
                                password = parts[3].trim();     // Password is in the fourth column
                            } else {
                                logger.warning("Malformed tab-separated line at line " + lineNumber + ": " + line);
                                continue;
                            }
                        } else {
                            parts = line.split(",");
                            if (parts.length >= 4) {
                                // New format: ID,Name,Email,Password
                                currentEmail = parts[2].trim(); // Email is in the third column
                                password = parts[3].trim();     // Password is in the fourth column
                            } else if (parts.length >= 2) {
                                // Old comma-separated format: Email,Password,FullName
                                currentEmail = parts[0].trim(); // Email is in the first column
                                password = parts[1].trim();     // Password is in the second column
                            } else {
                                logger.warning("Malformed comma-separated line at line " + lineNumber + ": " + line);
                                continue;
                            }
                        }

                        // Check if the email matches
                        if (currentEmail != null && currentEmail.equals(email)) {
                            if (lastPassword != null) {
                                duplicateFound = true; // Mark that a duplicate email was found
                            }
                            lastPassword = password; // Update with the latest password
                        }
                    } catch (Exception e) {
                        logger.warning("Error parsing line " + lineNumber + " in students.txt: " + line + ". Error: " + e.getMessage());
                        continue;
                    }
                }
            } catch (IOException e) {
                logger.severe("Error reading students.txt: " + e.getMessage());
                throw e;
            }
        }

        // Log a warning if duplicates were found
        if (duplicateFound) {
            logger.warning("Duplicate email entries found for: " + email + ". Using the latest entry.");
        }

        if (lastPassword == null) {
            logger.info("No matching email found for: " + email);
        } else {
            logger.info("Found password for email: " + email);
        }

        return lastPassword; // Return the latest matching password, or null if no match
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String logoutParam = request.getParameter("logout");
        if ("logout".equals(action) || "true".equals(logoutParam)) {
            HttpSession session = request.getSession(false); // Do not create a new session
            if (session != null) {
                session.invalidate(); // Invalidate the session
                logger.info("User logged out successfully");
            }
            response.sendRedirect(request.getContextPath() + "/logIn.jsp"); // Redirect to login page
        } else {
            logger.warning("Invalid action: " + action);
            response.sendRedirect(request.getContextPath() + "/logIn.jsp?error=4"); // Invalid action treated as invalid user type
        }
    }
}