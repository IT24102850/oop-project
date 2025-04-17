package com.studentregistration.servlets;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ProcessPayment")
public class ProcessPaymentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form parameters
        String action = request.getParameter("action");
        String startDate = request.getParameter("startDate");
        String studyMode = request.getParameter("studyMode");
        String emergencyContact = request.getParameter("emergencyContact");
        String courseSelect = request.getParameter("courseSelect");
        String paymentPlan = request.getParameter("paymentPlan");
        String paymentMethod = request.getParameter("paymentMethod");
        String amount = request.getParameter("amount");
        String lateReason = request.getParameter("lateReason");

        // Validate input
        if (courseSelect == null || courseSelect.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Course selection is required");
            return;
        }

        // Map course value to course name for file naming
        String courseName;
        switch (courseSelect) {
            case "299": courseName = "WebDevelopment"; break;
            case "399": courseName = "DataScience"; break;
            case "499": courseName = "CyberSecurity"; break;
            case "599": courseName = "AIMachineLearning"; break;
            case "699": courseName = "QuantumComputing"; break;
            default: courseName = "UnknownCourse";
        }

        // Define the applications folder path
        String applicationsDir = getServletContext().getRealPath("/WEB-INF/data/payment");
        File dir = new File(applicationsDir);

        // Create applications folder if it doesn't exist
        if (!dir.exists()) {
            dir.mkdirs();
        }

        // Create file named after course + timestamp
        String fileName = courseName + "_" + System.currentTimeMillis() + ".txt";
        File file = new File(dir, fileName);
        int counter = 1;
        while (file.exists()) {
            fileName = courseName + "_" + System.currentTimeMillis() + "_" + counter + ".txt";
            file = new File(dir, fileName);
            counter++;
        }

        // Write form data to the text file
        try (PrintWriter writer = new PrintWriter(new FileWriter(file))) {
            writer.println("Action: " + (action != null ? action : "N/A"));
            writer.println("Course: " + courseName + " ($" + courseSelect + ")");
            writer.println("Start Date: " + (startDate != null ? startDate : "N/A"));
            writer.println("Study Mode: " + (studyMode != null ? studyMode : "N/A"));
            writer.println("Emergency Contact: " + (emergencyContact != null ? emergencyContact : "N/A"));
            writer.println("Payment Plan: " + (paymentPlan != null ? paymentPlan : "N/A"));
            writer.println("Payment Method: " + (paymentMethod != null ? paymentMethod : "N/A"));
            writer.println("Amount: $" + (amount != null ? amount : "N/A"));
            if ("latefee".equals(action)) {
                writer.println("Late Reason: " + (lateReason != null ? lateReason : "N/A"));
            }
            writer.println("Submission Time: " + new java.util.Date());
        } catch (IOException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error saving payment details");
            return;
        }

        // Redirect to registration.jsp
        response.sendRedirect("index.jsp");
    }
}