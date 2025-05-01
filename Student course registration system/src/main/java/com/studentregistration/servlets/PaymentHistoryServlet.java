package com.studentregistration.servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "PaymentHistoryServlet", urlPatterns = {"/ViewPaymentHistory", "/PaymentDetails"})
public class PaymentHistoryServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        HttpSession session = request.getSession();

        if ("/ViewPaymentHistory".equals(path)) {
            // Validate CSRF token
            String csrfToken = request.getParameter("csrfToken");
            String sessionCsrfToken = (String) session.getAttribute("csrfToken");
            if (csrfToken == null || !csrfToken.equals(sessionCsrfToken)) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid CSRF token");
                return;
            }

            String studentId = request.getParameter("studentId");
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");
            int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
            int pageSize = 10; // Example page size

            // Simulate fetching payment records (replace with actual database logic)
            List<PaymentRecord> paymentRecords = new ArrayList<>();
            if (studentId != null && studentId.matches("S[0-9]{4}")) {
                // Mock data for demonstration
                paymentRecords.add(new PaymentRecord("PAY-2023-001", "2023-01-15", 500.0, "Credit Card", "PAID", System.currentTimeMillis(), true));
                paymentRecords.add(new PaymentRecord("PAY-2023-002", "2023-02-10", 300.0, "PayPal", "PENDING", System.currentTimeMillis(), false));
            }

            double totalPayments = paymentRecords.stream().mapToDouble(PaymentRecord::getAmount).sum();

            // Set attributes for JSP rendering
            request.setAttribute("paymentRecords", paymentRecords);
            request.setAttribute("studentId", studentId);
            request.setAttribute("page", page);
            request.setAttribute("pageSize", pageSize);
            request.setAttribute("totalPayments", totalPayments);
            request.setAttribute("message", paymentRecords.isEmpty() ? "No payment records found." : null);
            request.setAttribute("notification", paymentRecords.isEmpty() ? "error" : "success");
            request.getRequestDispatcher("/FeeManagement.html").forward(request, response);
        } else if ("/PaymentDetails".equals(path)) {
            String paymentId = request.getParameter("paymentId");

            if (paymentId != null && paymentId.matches("PAY-[0-9]{4}-[0-9]{3}")) {
                // Simulate fetching payment details (replace with actual database logic)
                request.setAttribute("paymentId", paymentId);
                request.setAttribute("studentId", "S1001");
                request.setAttribute("amount", 500.0);
                request.setAttribute("paymentDate", "2023-01-15");
                request.setAttribute("paymentMethod", "Credit Card");
                request.setAttribute("status", "PAID");
            } else {
                request.setAttribute("error", "Invalid payment ID");
            }
            // Forward to a JSP fragment to render the payment details
            request.getRequestDispatcher("/paymentDetails.jsp").forward(request, response);
        }
    }

    // Mock PaymentRecord class (replace with actual model)
    private static class PaymentRecord {
        private String paymentId;
        private String paymentDate;
        private double amount;
        private String paymentMethod;
        private String status;
        private long timestamp;
        private boolean canCancel;

        public PaymentRecord(String paymentId, String paymentDate, double amount, String paymentMethod,
                             String status, long timestamp, boolean canCancel) {
            this.paymentId = paymentId;
            this.paymentDate = paymentDate;
            this.amount = amount;
            this.paymentMethod = paymentMethod;
            this.status = status;
            this.timestamp = timestamp;
            this.canCancel = canCancel;
        }

        public String getPaymentId() { return paymentId; }
        public String getPaymentDate() { return paymentDate; }
        public double getAmount() { return amount; }
        public String getPaymentMethod() { return paymentMethod; }
        public String getStatus() { return status; }
        public long getTimestamp() { return timestamp; }
        public boolean isCanCancel() { return canCancel; }
    }
}