package main.java.com.studentregistration.servlets;

import main.java.com.studentregistration.dao.ProfileDAO;
import main.java.com.studentregistration.model.Profile;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.Date;

@WebServlet("/profile")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class ProfileServlet extends HttpServlet {
    private ProfileDAO profileDAO;
    private static final String UPLOAD_DIR = "uploads/profiles";

    @Override
    public void init() throws ServletException {
        profileDAO = new ProfileDAO();

        // Create upload directory if it doesn't exist
        File uploadDir = new File(getServletContext().getRealPath("") + File.separator + UPLOAD_DIR);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer studentId = (Integer) session.getAttribute("studentId");

        if (studentId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Profile profile = profileDAO.getProfileByStudentId(studentId);
        if (profile == null) {
            // Create new profile if none exists
            profile = new Profile();
            profile.setStudentId(studentId);
            profile.setProfileId(generateProfileId());
            profileDAO.saveProfile(profile);
        }

        request.setAttribute("profile", profile);
        request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer studentId = (Integer) session.getAttribute("studentId");

        if (studentId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get existing profile or create new one
        Profile profile = profileDAO.getProfileByStudentId(studentId);
        if (profile == null) {
            profile = new Profile();
            profile.setStudentId(studentId);
            profile.setProfileId(generateProfileId());
        }

        // Update profile data
        profile.setBio(request.getParameter("bio"));
        profile.setInterests(request.getParameter("interests"));
        profile.setSkills(request.getParameter("skills"));
        profile.setSocialLinks(request.getParameter("socialLinks"));
        profile.setEducationBackground(request.getParameter("educationBackground"));

        // Handle file upload
        Part filePart = request.getPart("profilePicture");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = studentId + "_" + System.currentTimeMillis() + "_" +
                    getSubmittedFileName(filePart);

            // Save file
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            filePart.write(uploadPath + File.separator + fileName);

            profile.setProfilePicturePath(UPLOAD_DIR + "/" + fileName);
        }

        // Save profile
        boolean updated = profileDAO.saveProfile(profile);

        if (updated) {
            session.setAttribute("successMessage", "Profile updated successfully!");
        } else {
            session.setAttribute("errorMessage", "Failed to update profile.");
        }

        response.sendRedirect("profile");
    }

    private int generateProfileId() {
        // Simple ID generation - in production use better method
        return (int) (System.currentTimeMillis() % Integer.MAX_VALUE);
    }

    private String getSubmittedFileName(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                String fileName = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
                return fileName.substring(fileName.lastIndexOf('/') + 1)
                        .substring(fileName.lastIndexOf('\\') + 1);
            }
        }
        return null;
    }
}