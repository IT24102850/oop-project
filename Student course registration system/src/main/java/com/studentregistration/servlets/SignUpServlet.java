package com.studentregistration.servlets;

import com.studentregistration.util.FileUtil;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/signup")
public class SignUpServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form parameters
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm-password");

        // Validate passwords match
        if (!password.equals(confirmPassword)) {
            response.sendRedirect(request.getContextPath() + "/signUp.jsp?error=1");
            return;
        }

        // Prepare user data
        String userData = String.format("%s|%s|%s\n", fullname, email, password);

        // Save to file
        String filePath = getServletContext().getRealPath("/WEB-INF/user_data.txt");
        FileUtil.saveUser(filePath, userData);

        // Redirect to login page
        response.sendRedirect(request.getContextPath() + "/login.jsp?registered=1");
    }
}