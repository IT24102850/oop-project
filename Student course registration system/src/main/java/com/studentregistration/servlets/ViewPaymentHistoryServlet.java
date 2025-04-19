package com.studentregistration.servlets;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;
import com.studentregistration.model.PaymentRecord;

@WebServlet("/ViewPaymentHistory")
public class ViewPaymentHistoryServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Verify CSRF token
        if (!validateCsrfToken(request)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid CSRF token");
            return;
        }

        String studentId = request.getParameter("studentId");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");

        try {
            // Validate input
            if (studentId == null || !studentId.matches("S\\d{4}")) {
                request.setAttribute("notification", "error");
                request.setAttribute("message", "Invalid Student ID format (should be S followed by 4 digits)");
                request.getRequestDispatcher("fee-management.jsp").forward(request, response);
                return;
            }

            // Date validation
            if (startDate != null && endDate != null && startDate.compareTo(endDate) > 0) {
                request.setAttribute("notification", "error");
                request.setAttribute("message", "End date must be after start date");
                request.getRequestDispatcher("fee-management.jsp").forward(request, response);
                return;
            }

            // Get payment history
            List<PaymentRecord> records = PaymentDAO.getPaymentHistory(studentId, startDate, endDate);
            double totalPayments = records.stream().mapToDouble(PaymentRecord::getAmount).sum();

            // Set attributes for JSP
            request.setAttribute("paymentRecords", records);
            request.setAttribute("studentId", studentId);
            request.setAttribute("totalPayments", totalPayments);

            // Forward to JSP
            request.getRequestDispatcher("fee-management.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("notification", "error");
            request.setAttribute("message", "Error retrieving payment history");
            request.getRequestDispatcher("fee-management.jsp").forward(request, response);
        }
    }

    private boolean validateCsrfToken(HttpServletRequest request) {
        String sessionToken = (String) request.getSession().getAttribute("csrfToken");
        String requestToken = request.getParameter("csrfToken");
        return sessionToken != null && sessionToken.equals(requestToken);
    }
}