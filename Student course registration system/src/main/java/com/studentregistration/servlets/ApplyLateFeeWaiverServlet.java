package com.studentregistration.servlets;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/ApplyLateFeeWaiver")
public class ApplyLateFeeWaiverServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // CSRF protection
        if (!validateCsrfToken(request)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid CSRF token");
            return;
        }

        String invoiceId = request.getParameter("invoiceId");
        String reason = request.getParameter("reason");
        String otherReason = request.getParameter("otherReason");

        try {
            // Validate invoice ID format
            if (invoiceId == null || !invoiceId.matches("INV-\\d{4}-\\d{3}")) {
                request.setAttribute("notification", "error");
                request.setAttribute("message", "Invalid Invoice ID format (should be INV-YYYY-NNN)");
                request.getRequestDispatcher("fee-management.jsp").forward(request, response);
                return;
            }

            // Check if invoice exists
            if (!InvoiceDAO.invoiceExists(invoiceId)) {
                request.setAttribute("notification", "error");
                request.setAttribute("message", "Invoice not found");
                request.getRequestDispatcher("fee-management.jsp").forward(request, response);
                return;
            }

            // Check if waiver already applied
            if (InvoiceDAO.isWaiverApplied(invoiceId)) {
                request.setAttribute("notification", "error");
                request.setAttribute("message", "Waiver already applied to this invoice");
                request.getRequestDispatcher("fee-management.jsp").forward(request, response);
                return;
            }

            // Combine reason if "Other" was selected
            String finalReason = "Other".equals(reason) ? otherReason : reason;

            // Apply waiver
            boolean success = InvoiceDAO.applyWaiver(invoiceId, finalReason);

            if (success) {
                request.setAttribute("notification", "success");
                request.setAttribute("message", "Late fee waiver successfully applied to invoice " + invoiceId);
            } else {
                request.setAttribute("notification", "error");
                request.setAttribute("message", "Failed to apply waiver");
            }

        } catch (Exception e) {
            request.setAttribute("notification", "error");
            request.setAttribute("message", "Error processing waiver request");
            log("Error applying late fee waiver", e);
        }

        request.getRequestDispatcher("fee-management.jsp").forward(request, response);
    }

    private boolean validateCsrfToken(HttpServletRequest request) {
        String sessionToken = (String) request.getSession().getAttribute("csrfToken");
        String requestToken = request.getParameter("csrfToken");
        return sessionToken != null && sessionToken.equals(requestToken);
    }
}