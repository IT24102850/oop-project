package com.studentregistration.servlets;

import com.studentregistration.dao.PaymentDAO; // Import PaymentDAO
import com.studentregistration.model.Payment;   // Import Payment
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {
    private PaymentDAO paymentDAO;

    @Override
    public void init() throws ServletException {
        String filePath = getServletContext().getRealPath("/WEB-INF/data/payments.txt");
        paymentDAO = new PaymentDAO(filePath);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null || action.equals("view")) {
            // Display payment history
            List<Payment> payments = paymentDAO.getAllPayments();
            request.setAttribute("payments", payments);
            request.setAttribute("activeTab", "payment");
            request.getRequestDispatcher("/admin-dashboard.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("updateStatus".equals(action)) {
            String invoiceId = request.getParameter("invoiceId");
            String newStatus = request.getParameter("status");
            String paymentDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date()); // Current date

            try {
                boolean updated = paymentDAO.updatePaymentStatus(invoiceId, newStatus, paymentDate);
                if (updated) {
                    request.setAttribute("message", "payment_updated");
                } else {
                    request.setAttribute("error", "payment_not_found");
                }
            } catch (Exception e) {
                request.setAttribute("error", "server_error");
                e.printStackTrace();
            }

            // Redirect back to payment section
            response.sendRedirect("payment?action=view");
        }
    }
}