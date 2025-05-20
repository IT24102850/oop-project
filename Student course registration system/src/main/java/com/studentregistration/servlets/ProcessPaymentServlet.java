package com.studentregistration.servlets;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import com.studentregistration.dao.PaymentDAO;
import com.studentregistration.model.Payment;

public class ProcessPaymentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (!"makePayment".equals(action)) {
            request.setAttribute("paymentStatus", "Invalid action specified.");
            response.sendRedirect("student-dashboard.jsp#payment");
            return;
        }

        // Retrieve and validate parameters
        String studentId = request.getParameter("studentId");
        if (studentId == null || studentId.trim().isEmpty()) {
            request.setAttribute("paymentStatus", "Student ID is required.");
            response.sendRedirect("student-dashboard.jsp#payment");
            return;
        }

        String subscriptionPlan = request.getParameter("subscriptionPlan");
        if (subscriptionPlan == null || !subscriptionPlan.matches("^(monthly|quarterly|yearly)$")) {
            request.setAttribute("paymentStatus", "Invalid subscription plan.");
            response.sendRedirect("student-dashboard.jsp#payment");
            return;
        }

        double totalAmount;
        try {
            totalAmount = Double.parseDouble(request.getParameter("totalAmount"));
            if (totalAmount <= 0) {
                throw new NumberFormatException("Total amount must be positive.");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("paymentStatus", "Invalid total amount: " + e.getMessage());
            response.sendRedirect("student-dashboard.jsp#payment");
            return;
        }

        double partialAmount;
        try {
            String partialAmountStr = request.getParameter("partialAmount");
            partialAmount = (partialAmountStr != null && !partialAmountStr.trim().isEmpty())
                    ? Double.parseDouble(partialAmountStr) : 0.0;
            if (partialAmount < 0 || partialAmount > totalAmount) {
                throw new NumberFormatException("Partial amount must be between 0 and total amount.");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("paymentStatus", "Invalid partial amount: " + e.getMessage());
            response.sendRedirect("student-dashboard.jsp#payment");
            return;
        }

        double remainingAmount;
        try {
            remainingAmount = Double.parseDouble(request.getParameter("remainingAmount"));
            if (remainingAmount < 0) {
                throw new NumberFormatException("Remaining amount cannot be negative.");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("paymentStatus", "Invalid remaining amount: " + e.getMessage());
            response.sendRedirect("student-dashboard.jsp#payment");
            return;
        }

        String startDate = request.getParameter("startDate");
        LocalDate startLocalDate;
        try {
            startLocalDate = LocalDate.parse(startDate, DateTimeFormatter.ISO_LOCAL_DATE);
            if (startLocalDate.isBefore(LocalDate.now())) {
                throw new DateTimeParseException("Start date cannot be in the past.", startDate, 0);
            }
        } catch (DateTimeParseException e) {
            request.setAttribute("paymentStatus", "Invalid start date: " + e.getMessage());
            response.sendRedirect("student-dashboard.jsp#payment");
            return;
        }

        String paymentMethod = request.getParameter("paymentMethod");
        if (paymentMethod == null || !paymentMethod.matches("^(creditCard|debitCard|bankTransfer|payPal|crypto)$")) {
            request.setAttribute("paymentStatus", "Invalid payment method.");
            response.sendRedirect("student-dashboard.jsp#payment");
            return;
        }

        // Calculate due date based on subscription plan
        String dueDate = startLocalDate.plusDays(subscriptionPlan.equals("monthly") ? 30 : subscriptionPlan.equals("quarterly") ? 90 : 365)
                .format(DateTimeFormatter.ISO_LOCAL_DATE);

        // Determine status and payment date
        String status = (partialAmount == totalAmount) ? "paid" : (partialAmount > 0 ? "pending" : "pending");
        String paymentDate = (partialAmount > 0) ? LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME) : "";

        // Initialize other fields
        double lateFee = 0.0;
        boolean waiverApplied = false;

        // Generate invoice ID with "INV" prefix and timestamp
        String invoiceId = "INV" + System.currentTimeMillis();

        // Use partialAmount as the recorded amount since that's what was actually paid
        Payment payment = new Payment(
                invoiceId,
                studentId,
                partialAmount, // Record the amount actually paid
                dueDate,
                status,
                paymentDate,
                waiverApplied,
                lateFee,
                paymentMethod,
                subscriptionPlan,
                startDate
        );

        // Save the payment
        String paymentsFilePath = getServletContext().getRealPath("/WEB-INF/data/payments.txt");
        PaymentDAO paymentDAO = new PaymentDAO(paymentsFilePath);
        try {
            paymentDAO.addPayment(payment);
        } catch (IOException e) {
            request.setAttribute("paymentStatus", "Error saving payment: " + e.getMessage());
            response.sendRedirect("student-dashboard.jsp#payment");
            return;
        }

        // Set payment status for JSP feedback
        if (remainingAmount == 0) {
            request.setAttribute("paymentStatus", "success");
        } else if (partialAmount > 0) {
            request.setAttribute("paymentStatus", "partial");
        } else {
            request.setAttribute("paymentStatus", "No payment made.");
        }
        response.sendRedirect("student-dashboard.jsp#payment");
    }
}