package com.studentregistration.servlets;

import com.studentregistration.dao.FeeDAO;
import com.studentregistration.model.FeeInvoice;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/fee-management")
public class FeeManagementServlet extends HttpServlet {
    private FeeDAO feeDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        feeDAO = new FeeDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String studentId = request.getParameter("studentId");

        try {
            if ("view".equals(action) && studentId != null) {
                List<FeeInvoice> invoices = feeDAO.getInvoicesByStudent(studentId);
                request.setAttribute("invoices", invoices);
                request.getRequestDispatcher("/jsp/viewPaymentHistory.jsp").forward(request, response);
            }
        } catch (IOException e) {
            throw new ServletException("Error processing request", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("generate".equals(action)) {
                // Implementation for generating invoices
            } else if ("waiver".equals(action)) {
                // Implementation for fee waivers
            } else if ("void".equals(action)) {
                // Implementation for voiding invoices
            }
        } catch (Exception e) {
            throw new ServletException("Error processing request", e);
        }
    }
}