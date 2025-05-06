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
    private static final String DATA_PATH = "/WEB-INF/data/Profile/profiles.txt";
    private static final String IMAGE_PATH = "/WEB-INF/data/Profile/";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("getPicture".equals(action)) {
            String studentId = request.getParameter("studentId");
            String pic = request.getParameter("pic");
            String imageDir = getServletContext().getRealPath(IMAGE_PATH);
            File imageFile = new File(imageDir, pic);

            if (imageFile.exists()) {
                response.setContentType("image/jpeg");
                Files.copy(imageFile.toPath(), response.getOutputStream());
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Image not found");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String studentId = request.getParameter("studentId");
        String filePath = getServletContext().getRealPath(DATA_PATH);
        String imageDir = getServletContext().getRealPath(IMAGE_PATH);

        File dir = new File(imageDir);
        if (!dir.exists()) {
            if (!dir.mkdirs()) {
                throw new ServletException("Failed to create directory: " + imageDir);
            }
        }

        File profileFile = new File(filePath);
        if (!profileFile.exists()) {
            if (!profileFile.getParentFile().exists()) {
                profileFile.getParentFile().mkdirs();
            }
            profileFile.createNewFile();
        }

        List<String[]> profiles = readProfiles(filePath);

        if ("updatePersonal".equals(action)) {
            String name = request.getParameter("name");
            String dob = request.getParameter("dob");
            String gender = request.getParameter("gender");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");

            updateProfile(profiles, studentId, name, dob, gender, email, phone, address, null, null, null, null, null, null);
            writeProfiles(filePath, profiles);
            response.sendRedirect("student-dashboard.jsp?tab=profile&message=Personal info updated successfully");
        } else if ("updateAcademic".equals(action)) {
            String degree = request.getParameter("degree");
            String enrolled = request.getParameter("enrolled");
            String gpa = request.getParameter("gpa");

            updateProfile(profiles, studentId, null, null, null, null, null, null, degree, enrolled, gpa, null, null, null);
            writeProfiles(filePath, profiles);
            response.sendRedirect("student-dashboard.jsp?tab=profile&message=Academic info updated successfully");
        } else if ("updateSecurity".equals(action)) {
            String password = request.getParameter("password");
            String twoFA = request.getParameter("twoFA") != null ? "Enabled" : "Not Enabled";

            updateProfile(profiles, studentId, null, null, null, null, null, null, null, null, null, password, twoFA, null);
            writeProfiles(filePath, profiles);
            response.sendRedirect("student-dashboard.jsp?tab=profile&message=Security info updated successfully");
        } else if ("uploadPicture".equals(action)) {
            Part filePart = request.getPart("avatar");
            if (filePart == null || filePart.getSize() == 0) {
                response.sendRedirect("student-dashboard.jsp?tab=profile&message=Please select an image to upload");
                return;
            }

            String fileName = studentId + "_" + filePart.getSubmittedFileName();
            String filePathName = imageDir + File.separator + fileName;

            try (InputStream input = filePart.getInputStream()) {
                Files.copy(input, Paths.get(filePathName), java.nio.file.StandardCopyOption.REPLACE_EXISTING);
                updateProfile(profiles, studentId, null, null, null, null, null, null, null, null, null, null, null, fileName);
                writeProfiles(filePath, profiles);
                response.sendRedirect("student-dashboard.jsp?tab=profile&message=Profile picture updated successfully");
            } catch (IOException e) {
                e.printStackTrace();
                response.sendRedirect("student-dashboard.jsp?tab=profile&message=Error uploading picture");
            }
        }
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
                        if (parts.length == 13) {
                            profiles.add(parts);
                        } else {
                            String[] corrected = new String[13];
                            for (int i = 0; i < 13; i++) {
                                corrected[i] = i < parts.length ? parts[i] : "";
                            }
                            profiles.add(corrected);
                        }
                    }
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return profiles;
    }

    private void updateProfile(List<String[]> profiles, String studentId, String name, String dob, String gender, String email, String phone, String address, String degree, String enrolled, String gpa, String password, String twoFA, String pic) {
        for (int i = 0; i < profiles.size(); i++) {
            if (profiles.get(i)[0].equals(studentId)) {
                String[] profile = profiles.get(i);
                if (name != null) profile[1] = name;
                if (dob != null) profile[2] = dob;
                if (gender != null) profile[3] = gender;
                if (email != null) profile[4] = email;
                if (phone != null) profile[5] = phone;
                if (address != null) profile[6] = address;
                if (degree != null) profile[7] = degree;
                if (enrolled != null) profile[8] = enrolled;
                if (gpa != null) profile[9] = gpa;
                if (password != null) profile[10] = password;
                if (twoFA != null) profile[11] = twoFA;
                if (pic != null) profile[12] = pic;
                return;
            }
        }
        String[] newProfile = new String[13];
        newProfile[0] = studentId;
        newProfile[1] = name != null ? name : "";
        newProfile[2] = dob != null ? dob : "";
        newProfile[3] = gender != null ? gender : "";
        newProfile[4] = email != null ? email : "";
        newProfile[5] = phone != null ? phone : "";
        newProfile[6] = address != null ? address : "";
        newProfile[7] = degree != null ? degree : "";
        newProfile[8] = enrolled != null ? enrolled : "";
        newProfile[9] = gpa != null ? gpa : "";
        newProfile[10] = password != null ? password : "";
        newProfile[11] = twoFA != null ? twoFA : "";
        newProfile[12] = pic != null ? pic : "";
        profiles.add(newProfile);
    }

    private void writeProfiles(String filePath, List<String[]> profiles) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            for (String[] profile : profiles) {
                writer.write(String.join(",", profile) + "\n");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}