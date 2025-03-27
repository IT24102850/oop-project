package com.nexoraskill.servlets;

import com.nexoraskill.utils.UserDataHandler;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/signup")
public class SignUpServlet extends HttpServlet {

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

        // Check if email already exists
        String realPath = getServletContext().getRealPath("/");
        if (UserDataHandler.emailExists(realPath, email)) {
            response.sendRedirect(request.getContextPath() + "/signUp.jsp?error=2");
            return;
        }

        // Create user data string
        String userData = String.format("%s|%s|%s%n", fullname, email, password);

        // Save to file
        saveUserData(realPath, userData);

        // Redirect to login page after successful registration
        response.sendRedirect(request.getContextPath() + "/logIn.jsp?registered=1");
    }

    private synchronized void saveUserData(String realPath, String userData) throws IOException {
        File file = new File(realPath + UserDataHandler.FILE_PATH);

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