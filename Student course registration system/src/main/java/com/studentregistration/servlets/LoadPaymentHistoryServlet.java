package com.studentregistration.servlets;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;
import java.text.SimpleDateFormat;

@WebServlet("/LoadPaymentHistory")
public class LoadPaymentHistoryServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<String[]> paymentHistory = new ArrayList<>();
        String paymentsFilePath = getServletContext().getRealPath("/WEB-INF/data/payments.txt");
        File paymentsFile = new File(paymentsFilePath);

        // Check if the file exists and read its content
        if (paymentsFile.exists()) {
            try (BufferedReader reader = new BufferedReader(new FileReader(paymentsFile))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split(",");
                    if (parts.length >= 11) { // Ensure the line has all required fields
                        paymentHistory.add(parts);
                    }
                }
            } catch (IOException e) {
                request.setAttribute("error", "Error loading payment history: " + e.getMessage());
            }
        } else {
            request.setAttribute("error", "Payment history file not found.");
        }

        // Set request attributes
        request.setAttribute("paymentHistory", paymentHistory);
        request.setAttribute("currentDate", new Date());
        request.setAttribute("dateFormat", new SimpleDateFormat("yyyy-MM-dd"));
        request.setAttribute("studentId", request.getSession().getAttribute("studentId"));

        // Forward to JSP
        request.getRequestDispatcher("/student-dashboard.jsp").forward(request, response);
    }
}