package com.studentregistration.servlets;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.util.logging.Logger;

@WebServlet("/auth")
public class InstructorLoginServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(InstructorLoginServlet.class.getName());
    private static final int ID_INDEX = 0;
    private static final int NAME_INDEX = 1;
    private static final int EMAIL_INDEX = 2;
    private static final int PASSWORD_INDEX = 3;
    private static final int USER_TYPE_INDEX = 4;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userType = request.getParameter("userType");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String submittedCsrfToken = request.getParameter("csrfToken");
        String sessionCsrfToken = (String) request.getSession().getAttribute("csrfToken");

        // CSRF Token Validation
        if (submittedCsrfToken == null || !submittedCsrfToken.equals(sessionCsrfToken)) {
            LOGGER.warning("CSRF token validation failed. Submitted: " + submittedCsrfToken + ", Expected: " + sessionCsrfToken);
            request.setAttribute("error", "Invalid request. Please try again.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        if (email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty() ||
                userType == null || userType.trim().isEmpty()) {
            request.setAttribute("error", "All fields are required");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        if ("instructor".equalsIgnoreCase(userType)) {
            String instructorsFilePath = getServletContext().getRealPath("/") + "WEB-INF/data/instructors.txt";
            File file = new File(instructorsFilePath);

            if (!file.exists()) {
                LOGGER.severe("Instructor data file not found at: " + instructorsFilePath);
                request.setAttribute("error", "Instructor data file not found. Please contact the administrator.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            boolean isAuthenticated = false;
            String[] instructorDetails = null;

            try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    LOGGER.info("Processing line: " + line);
                    if (line.trim().isEmpty()) {
                        LOGGER.info("Skipping empty line");
                        continue;
                    }

                    String[] parts = line.split(",");
                    if (parts.length != 5) {
                        LOGGER.warning("Invalid line format in instructors.txt: " + line + " (expected 5 fields, got " + parts.length + ")");
                        continue;
                    }

                    if (parts[PASSWORD_INDEX] == null || parts[PASSWORD_INDEX].trim().isEmpty()) {
                        LOGGER.warning("Missing password for instructor email: " + parts[EMAIL_INDEX]);
                        continue;
                    }

                    if (parts[EMAIL_INDEX].equalsIgnoreCase(email) && parts[PASSWORD_INDEX].equals(password)) {
                        isAuthenticated = true;
                        instructorDetails = parts;
                        LOGGER.info("Authentication successful for email: " + email);
                        break;
                    }
                }
            } catch (IOException e) {
                LOGGER.severe("IO Exception while reading instructors.txt: " + e.getMessage());
                e.printStackTrace();
                request.setAttribute("error", "An error occurred while processing your login");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            if (isAuthenticated) {
                HttpSession session = request.getSession();
                session.setAttribute("userId", instructorDetails[ID_INDEX]);
                session.setAttribute("name", instructorDetails[NAME_INDEX]);
                session.setAttribute("email", instructorDetails[EMAIL_INDEX]);
                session.setAttribute("userType", instructorDetails[USER_TYPE_INDEX]);
                session.setAttribute("active", "true");
                session.setAttribute("csrfToken", submittedCsrfToken);

                LOGGER.info("Redirecting to instructorDashboard.jsp for user: " + instructorDetails[NAME_INDEX]);
                response.sendRedirect("instructorDashboard.jsp");
            } else {
                request.setAttribute("error", "Invalid email or password for instructor.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "Only 'Instructor' login is supported at this time.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}