package com.studentregistration.servlets;

import com.studentregistration.dao.FeeDAO;
import com.studentregistration.model.FeeInvoice;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/fee-management")
public class FeeManagementServlet extends HttpServlet {
    private FeeDAO feeDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        feeDAO = new FeeDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String studentId = request.getParameter("studentId");

        try {
            if ("view".equals(action) && studentId != null) {
                List<FeeInvoice> invoices = feeDAO.getInvoicesByStudent(studentId);
                request.setAttribute("invoices", invoices);
                request.getRequestDispatcher("/jsp/viewPaymentHistory.jsp").forward(request, response);
            }
        } catch (IOException e) {
            throw new ServletException("Error processing fee management request", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("generate".equals(action)) {
                String studentId = request.getParameter("studentId");
                double amount = Double.parseDouble(request.getParameter("amount"));
                String description = request.getParameter("description");
                LocalDate dueDate = LocalDate.parse(request.getParameter("dueDate"));

                FeeInvoice invoice = new FeeInvoice(null, studentId, amount,
                        LocalDate.now(), dueDate, description);
                String invoiceId = feeDAO.createInvoice(invoice);

                request.setAttribute("message", "Invoice generated successfully! ID: " + invoiceId);
                response.sendRedirect("jsp/generateInvoice.jsp?success=true");

            } else if ("waiver".equals(action)) {
                String invoiceId = request.getParameter("invoiceId");
                double waiverAmount = Double.parseDouble(request.getParameter("waiverAmount"));

                feeDAO.applyLateFeeWaiver(invoiceId, waiverAmount);
                response.sendRedirect("jsp/viewPaymentHistory.jsp?studentId=" +
                        request.getParameter("studentId") + "&success=true");

            } else if ("void".equals(action)) {
                String invoiceId = request.getParameter("invoiceId");
                feeDAO.voidInvoice(invoiceId);
                response.sendRedirect("jsp/viewPaymentHistory.jsp?studentId=" +
                        request.getParameter("studentId") + "&success=true");
            }
        } catch (Exception e) {
            throw new ServletException("Error processing fee management request", e);
        }
    }
}
