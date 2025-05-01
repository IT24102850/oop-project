package com.studentregistration.servlets;

import com.studentregistration.dao.StudentDAO;
import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/saveReview")
public class ReviewServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private StudentDAO studentDAO;

    @Override
    public void init() throws ServletException {
        studentDAO = new StudentDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        String reviewerName = request.getParameter("reviewerName");
        String reviewText = request.getParameter("reviewText");

        if (reviewerName == null || reviewText == null || reviewerName.trim().isEmpty() || reviewText.trim().isEmpty()) {
            out.print("{\"success\": false, \"message\": \"Name and review are required.\"}");
            out.flush();
            return;
        }


    }
}
