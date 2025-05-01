package main.java.com.studentregistration.servlets;

import main.java.com.studentregistration.dao.ProfileDao;
import main.java.com.studentregistration.model.Profile;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    private ProfileDao profileDao;
    private DateTimeFormatter dateFormatter;

    @Override
    public void init() throws ServletException {
        super.init();
        profileDao = new ProfileDao();
        dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("studentId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String studentId = (String) session.getAttribute("studentId");

        try {
            Profile profile = profileDao.getProfile(studentId);
            if (profile == null) {
                // Create empty profile if not exists
                profile = new Profile(studentId, "", "");
                profileDao.saveProfile(profile);
            }
            request.setAttribute("profile", profile);
            request.getRequestDispatcher("/profile.jsp").forward(request, response);
        } catch (IOException e) {
            request.setAttribute("error", "Error loading profile: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("studentId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String studentId = (String) session.getAttribute("studentId");
        Profile profile;

        try {
            // Try to load existing profile or create new one
            profile = profileDao.getProfile(studentId);
            if (profile == null) {
                profile = new Profile(studentId, "", "");
            }

            // Update profile from form data with validation
            String displayName = sanitizeInput(request.getParameter("displayName"));
            String email = sanitizeInput(request.getParameter("email"));

            if (displayName.isEmpty() || email.isEmpty()) {
                throw new IllegalArgumentException("Display name and email are required");
            }

            profile.setDisplayName(displayName);
            profile.setEmail(email);

            String dobParam = request.getParameter("dob");
            if (dobParam != null && !dobParam.trim().isEmpty()) {
                try {
                    profile.setDob(LocalDate.parse(dobParam, dateFormatter));
                } catch (DateTimeParseException e) {
                    throw new IllegalArgumentException("Invalid date format for Date of Birth (use YYYY-MM-DD)");
                }
            }

            profile.setGender(sanitizeInput(request.getParameter("gender")));
            profile.setPhone(sanitizeInput(request.getParameter("phone")));
            profile.setAddress(sanitizeInput(request.getParameter("address")));
            profile.setDegree(sanitizeInput(request.getParameter("degree")));

            String enrolledDateParam = request.getParameter("enrolledDate");
            if (enrolledDateParam != null && !enrolledDateParam.trim().isEmpty()) {
                try {
                    profile.setEnrolledDate(LocalDate.parse(enrolledDateParam, dateFormatter));
                } catch (DateTimeParseException e) {
                    throw new IllegalArgumentException("Invalid date format for Enrolled Date (use YYYY-MM-DD)");
                }
            }

            String gpaParam = request.getParameter("gpa");
            if (gpaParam != null && !gpaParam.trim().isEmpty()) {
                try {
                    double gpa = Double.parseDouble(gpaParam);
                    if (gpa < 0.0 || gpa > 4.0) {
                        throw new IllegalArgumentException("GPA must be between 0.0 and 4.0");
                    }
                    profile.setGpa(gpa);
                } catch (NumberFormatException e) {
                    throw new IllegalArgumentException("Invalid GPA format");
                }
            }

            profile.setTwoFactorEnabled("on".equals(request.getParameter("twoFactorEnabled")));

            // Save the profile
            profileDao.saveProfile(profile);

            // Set success message
            session.setAttribute("success", "Profile updated successfully!");
            response.sendRedirect(request.getContextPath() + "/profile");

        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.setAttribute("profile", profile); // Return current profile data
            request.getRequestDispatcher("/profile.jsp").forward(request, response);
        }
    }

    private String sanitizeInput(String input) {
        if (input == null) {
            return "";
        }
        return input.trim();
    }
}