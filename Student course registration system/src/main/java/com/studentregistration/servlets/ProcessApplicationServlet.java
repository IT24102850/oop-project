package com.studentregistration.servlets;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;





@WebServlet("/ProcessApplication")
public class ProcessApplicationServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form parameters
        String courseId = request.getParameter("courseId");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String education = request.getParameter("education");
        String experience = request.getParameter("experience");
        String goals = request.getParameter("goals");
        String terms = request.getParameter("terms");

        // Validate input
        if (fullName == null || fullName.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Full name is required");
            return;
        }

        // Extract first name for file naming (first word before space)
        String firstName = fullName.split("\\s+")[0].trim();
        if (firstName.isEmpty()) {
            firstName = "application";
        }

        // Define the applications folder path
        String applicationsDir = getServletContext().getRealPath("/WEB-INF/data/applications");
        File dir = new File(applicationsDir);

        // Create applications folder if it doesn't exist
        if (!dir.exists()) {
            dir.mkdirs();
        }

        // Create file named after first name (handle duplicates by appending timestamp)
        String fileName = firstName + ".txt";
        File file = new File(dir, fileName);
        int counter = 1;
        while (file.exists()) {
            fileName = firstName + "_" + System.currentTimeMillis() + "_" + counter + ".txt";
            file = new File(dir, fileName);
            counter++;
        }

        // Write form data to the text file
        try (PrintWriter writer = new PrintWriter(new FileWriter(file))) {
            writer.println("Course ID: " + (courseId != null ? courseId : "N/A"));
            writer.println("Full Name: " + fullName);
            writer.println("Email: " + (email != null ? email : "N/A"));
            writer.println("Phone: " + (phone != null ? phone : "N/A"));
            writer.println("Education Level: " + (education != null ? education : "N/A"));
            writer.println("Programming Experience: " + (experience != null ? experience : "N/A"));
            writer.println("Learning Goals: " + (goals != null ? goals : "N/A"));
            writer.println("Terms Accepted: " + (terms != null ? "Yes" : "No"));
            writer.println("Submission Time: " + new java.util.Date());
        } catch (IOException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error saving application");
            return;
        }

        // Redirect to registration.jsp
        response.sendRedirect("Payment.jsp");
    }
}