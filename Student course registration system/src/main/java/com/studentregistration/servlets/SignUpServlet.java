package com.nexoraskill.servlets;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/signup")
public class SignUpServlet extends HttpServlet {
    private static final String FILE_PATH = "users.txt";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form data
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm-password");

        // Validate passwords match
        if (!password.equals(confirmPassword)) {
            response.sendRedirect(request.getContextPath() + "/signUp.jsp?error=1");
            return;
        }

        // Create user data string
        String userData = String.format("%s|%s|%s%n", fullname, email, password);

        // Save to file
        saveUserData(userData);

        // Redirect to login page after successful registration
        response.sendRedirect(request.getContextPath() + "/logIn.jsp");
    }

    private synchronized void saveUserData(String userData) throws IOException {
        // Get real path to store the file in the web application directory
        String realPath = getServletContext().getRealPath("/");
        File file = new File(realPath + FILE_PATH);

        // Create parent directories if they don't exist
        file.getParentFile().mkdirs();

        // Write user data to file (append mode)
        try (FileWriter fw = new FileWriter(file, true);
             BufferedWriter bw = new BufferedWriter(fw);
             PrintWriter out = new PrintWriter(bw)) {
            out.print(userData);
        }
    }
}