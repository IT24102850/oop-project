package com.studentregistration.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "PaymentServlet", urlPatterns = {"/CancelPayment"})
public class PaymentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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

        String paymentId = request.getParameter("paymentId");
        String reason = request.getParameter("reason");
        String otherReason = request.getParameter("otherReason");

        if (paymentId != null && paymentId.matches("PAY-[0-9]{4}-[0-9]{3}")) {
            // Simulate canceling payment (replace with actual database logic)
            request.setAttribute("message", "Payment " + paymentId + " canceled successfully");
            request.setAttribute("notification", "success");
        } else {
            request.setAttribute("message", "Invalid payment ID");
            request.setAttribute("notification", "error");
        }
        request.getRequestDispatcher("/FeeManagement.html").forward(request, response);
    }
}