package com.studentregistration.servlets;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/validatePayment")
public class ValidatePaymentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String paymentId = request.getParameter("id");

        try {
            // Validate payment ID format
            if (paymentId == null || !paymentId.matches("PAY-\\d{4}-\\d{3}")) {
                response.getWriter().write("{\"error\":\"Invalid payment ID format\"}");
                return;
            }

            boolean exists = PaymentDAO.paymentExists(paymentId);
            response.getWriter().write("{\"exists\":" + exists + "}");

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"Server error validating payment\"}");
        }
    }
}