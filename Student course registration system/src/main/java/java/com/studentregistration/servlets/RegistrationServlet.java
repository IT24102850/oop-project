package com.studentregistration.servlets;

import com.studentregistration.util.FileHandler;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/register")
public class RegistrationServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get all parameters
        String studentId = request.getParameter("userId");
        String courseId = request.getParameter("courseSelect");
        String action = request.getParameter("action");
        ServletContext context = getServletContext();

        try {
            if ("payment".equals(action)) {
                String paymentMethod = request.getParameter("paymentMethod");
                String amountStr = request.getParameter("amount");
                double amount = Double.parseDouble(amountStr);

                FileHandler.savePayment(context, studentId, courseId, amount, paymentMethod);
                response.sendRedirect("dashboard.jsp?message=Payment+successful");

            } else if ("latefee".equals(action)) {
                String reason = request.getParameter("lateReason");

                FileHandler.saveLateFeeApplication(context, studentId, courseId, reason);
                response.sendRedirect("dashboard.jsp?message=Late+fee+application+submitted");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=Registration+failed");
        }
    }
}