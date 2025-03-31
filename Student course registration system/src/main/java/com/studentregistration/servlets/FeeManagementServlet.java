package com.studentregistration.servlets;

import com.studentregistration.dao.FeeDAO;
import com.studentregistration.model.FeeInvoice;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/fee-management")  // Fixed: using double quotes and correct path
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
        // Your GET implementation here
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Your POST implementation here
    }
}