package com.studentregistration.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ValidationServlte", urlPatterns = {"/ValidateStudent", "/ValidateInvoice", "/ValidatePayment"})
class ValidationServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();

        String id = request.getParameter("id");
        boolean exists = false;

        if ("/ValidateStudent".equals(path)) {
            if (id != null && id.matches("S[0-9]{4}")) {
                // Simulate student validation (replace with actual database logic)
                exists = true; // Example: Assume student exists
            }
        } else if ("/ValidateInvoice".equals(path)) {
            if (id != null && id.matches("INV-[0-9]{4}-[0-9]{3}")) {
                // Simulate invoice validation (replace with actual database logic)
                exists = true; // Example: Assume invoice exists
            }
        } else if ("/ValidatePayment".equals(path)) {
            if (id != null && id.matches("PAY-[0-9]{4}-[0-9]{3}")) {
                // Simulate payment validation (replace with actual database logic)
                exists = true; // Example: Assume payment exists
            }
        }

        out.print(exists ? "true" : "false");
        out.flush();
    }
}
