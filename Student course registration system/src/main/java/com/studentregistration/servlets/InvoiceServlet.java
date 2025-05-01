package com.studentregistration.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "InvoiceServlet", urlPatterns = {"/ApplyLateFeeWaiver", "/VoidInvoice"})
public class InvoiceServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        HttpSession session = request.getSession();

        // Validate CSRF token
        String csrfToken = request.getParameter("csrfToken");
        String sessionCsrfToken = (String) session.getAttribute("csrfToken");
        if (csrfToken == null || !csrfToken.equals(sessionCsrfToken)) {
            request.setAttribute("message", "Invalid CSRF token");
            request.setAttribute("notification", "error");
            request.getRequestDispatcher("/FeeManagement.html").forward(request, response);
            return;
        }

        if ("/ApplyLateFeeWaiver".equals(path)) {
            String invoiceId = request.getParameter("invoiceId");
            String reason = request.getParameter("reason");
            String otherReason = request.getParameter("otherReason");

            if (invoiceId != null && invoiceId.matches("INV-[0-9]{4}-[0-9]{3}")) {
                // Simulate applying waiver (replace with actual database logic)
                request.setAttribute("message", "Late fee waiver applied successfully for invoice " + invoiceId);
                request.setAttribute("notification", "success");
            } else {
                request.setAttribute("message", "Invalid invoice ID");
                request.setAttribute("notification", "error");
            }
        } else if ("/VoidInvoice".equals(path)) {
            String invoiceId = request.getParameter("invoiceId");
            String reason = request.getParameter("reason");
            String otherReason = request.getParameter("otherReason");

            if (invoiceId != null && invoiceId.matches("INV-[0-9]{4}-[0-9]{3}")) {
                // Simulate voiding invoice (replace with actual database logic)
                request.setAttribute("message", "Invoice " + invoiceId + " voided successfully");
                request.setAttribute("notification", "success");
            } else {
                request.setAttribute("message", "Invalid invoice ID");
                request.setAttribute("notification", "error");
            }
        }
        request.getRequestDispatcher("/FeeManagement.html").forward(request, response);
    }
}