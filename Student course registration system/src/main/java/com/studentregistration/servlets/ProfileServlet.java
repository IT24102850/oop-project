package com.studentregistration.servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/ProfileServlet")
@MultipartConfig(maxFileSize = 10485760) // 10MB max file size
public class ProfileServlet extends HttpServlet {
    private static final String DATA_PATH = "/WEB-INF/data/profiles.txt";
    private static final String IMAGE_PATH = "/WEB-INF/data/profile";
    private static final String FALLBACK_BASE_DIR = System.getProperty("java.io.tmpdir") + File.separator + "student-app-data";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve studentId from session (security check)
        String studentId = (String) request.getSession().getAttribute("studentId");
        if (studentId == null) {
            response.sendRedirect("login.jsp?message=Please log in to update your profile");
            return;
        }

        // Retrieve and sanitize form parameters
        String name = request.getParameter("name") != null ? request.getParameter("name").replaceAll(",", " ") : "";
        String dob = request.getParameter("dob") != null ? request.getParameter("dob") : "";
        String gender = request.getParameter("gender") != null ? request.getParameter("gender") : "";
        String email = request.getParameter("email") != null ? request.getParameter("email") : "";
        String phone = request.getParameter("phone") != null ? request.getParameter("phone").replaceAll("[\\s-]", "") : "";
        String address = request.getParameter("address") != null ? request.getParameter("address").replaceAll(",", " ") : "";

        // Get file paths with fallback
        String filePath = getServletContext().getRealPath(DATA_PATH);
        String imageDir = getServletContext().getRealPath(IMAGE_PATH);

        if (filePath == null) {
            filePath = FALLBACK_BASE_DIR + File.separator + "profiles.txt";
            System.out.println("Using fallback filePath: " + filePath);
        }
        if (imageDir == null) {
            imageDir = FALLBACK_BASE_DIR + File.separator + "profile";
            System.out.println("Using fallback imageDir: " + imageDir);
        }

        // Ensure image directory exists
        File dir = new File(imageDir);
        if (!dir.exists()) {
            if (!dir.mkdirs()) {
                System.out.println("Failed to create directory: " + imageDir);
                response.sendRedirect("student-dashboard.jsp?message=Failed to create directory for image storage");
                return;
            }
        }

        // Ensure profiles.txt exists
        File profileFile = new File(filePath);
        if (!profileFile.exists()) {
            if (!profileFile.getParentFile().exists()) {
                if (!profileFile.getParentFile().mkdirs()) {
                    System.out.println("Failed to create parent directory for profiles.txt: " + profileFile.getParent());
                    response.sendRedirect("student-dashboard.jsp?message=Failed to create profile data file");
                    return;
                }
            }
            try {
                profileFile.createNewFile();
            } catch (IOException e) {
                System.out.println("Failed to create profiles.txt: " + e.getMessage());
                response.sendRedirect("student-dashboard.jsp?message=Failed to create profile data file");
                return;
            }
        }

        // Handle file upload
        Part filePart = request.getPart("avatar");
        String fileName = "";
        if (filePart != null && filePart.getSize() > 0) {
            // Validate file type
            String contentType = filePart.getContentType();
            if (!contentType.matches("image/(jpeg|jpg|png|gif)")) {
                response.sendRedirect("student-dashboard.jsp?message=Only JPEG, PNG, or GIF images are allowed");
                return;
            }
            fileName = studentId + "_" + filePart.getSubmittedFileName().replaceAll("[^a-zA-Z0-9.-]", "_");
            String filePathName = imageDir + File.separator + fileName;

            // Clean up old profile picture
            String oldPic = readProfiles(filePath).stream()
                    .filter(p -> p[0].equals(studentId))
                    .map(p -> p[7])
                    .findFirst()
                    .orElse("");
            if (!oldPic.isEmpty()) {
                File oldImage = new File(imageDir, oldPic);
                if (oldImage.exists()) {
                    oldImage.delete();
                }
            }

            try (InputStream input = filePart.getInputStream()) {
                Files.copy(input, Paths.get(filePathName), java.nio.file.StandardCopyOption.REPLACE_EXISTING);
            } catch (IOException e) {
                System.out.println("Error uploading image: " + e.getMessage());
                response.sendRedirect("student-dashboard.jsp?message=Error uploading picture");
                return;
            }
        } else {
            response.sendRedirect("student-dashboard.jsp?message=Please select an image to upload");
            return;
        }

        // Read existing profiles
        List<String[]> profiles = readProfiles(filePath);

        // Update or add profile
        updateProfile(profiles, studentId, name, dob, gender, email, phone, address, fileName);

        // Write profiles back to file
        writeProfiles(filePath, profiles);

        // Redirect with success message
        response.sendRedirect("student-dashboard.jsp?message=Profile updated successfully");
    }

    private List<String[]> readProfiles(String filePath) {
        List<String[]> profiles = new ArrayList<>();
        File file = new File(filePath);
        if (file.exists()) {
            try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    if (!line.trim().isEmpty()) {
                        String[] parts = line.split(",", -1);
                        if (parts.length == 8) {
                            profiles.add(parts);
                        } else {
                            String[] corrected = new String[8];
                            for (int i = 0; i < 8; i++) {
                                corrected[i] = i < parts.length ? parts[i] : "";
                            }
                            profiles.add(corrected);
                        }
                    }
                }
            } catch (IOException e) {
                System.out.println("Error reading profiles: " + e.getMessage());
            }
        }
        return profiles;
    }

    private void updateProfile(List<String[]> profiles, String studentId, String name, String dob, String gender, String email, String phone, String address, String pic) {
        for (int i = 0; i < profiles.size(); i++) {
            if (profiles.get(i)[0].equals(studentId)) {
                String[] profile = profiles.get(i);
                profile[1] = name;
                profile[2] = dob;
                profile[3] = gender;
                profile[4] = email;
                profile[5] = phone;
                profile[6] = address;
                profile[7] = pic;
                return;
            }
        }
        // Add new profile if studentId not found
        String[] newProfile = {studentId, name, dob, gender, email, phone, address, pic};
        profiles.add(newProfile);
    }

    private void writeProfiles(String filePath, List<String[]> profiles) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            for (String[] profile : profiles) {
                writer.write(String.join(",", profile) + "\n");
            }
        } catch (IOException e) {
            System.out.println("Error writing profiles: " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("getPicture".equals(action)) {
            String pic = request.getParameter("pic");
            String imageDir = getServletContext().getRealPath(IMAGE_PATH);
            if (imageDir == null) {
                imageDir = FALLBACK_BASE_DIR + File.separator + "profile";
            }
            File imageFile = new File(imageDir, pic);

            if (imageFile.exists()) {
                // Set content type based on file extension (basic detection)
                String contentType = Files.probeContentType(imageFile.toPath());
                if (contentType == null) contentType = "image/jpeg"; // Default to JPEG
                response.setContentType(contentType);
                Files.copy(imageFile.toPath(), response.getOutputStream());
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Image not found");
            }
        }
    }
}