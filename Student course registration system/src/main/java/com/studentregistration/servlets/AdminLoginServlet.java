package com.studentregistration.servlets;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        boolean isValidAdmin = false;
        String adminsFilePath = getServletContext().getRealPath("/WEB-INF/data/admins.txt");
        File adminsFile = new File(adminsFilePath);
        String expectedPassword = null;

        if (adminsFile.exists()) {
            try (BufferedReader reader = new BufferedReader(new FileReader(adminsFile))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    if (line.trim().isEmpty()) continue;
                    String[] parts = line.split(",");
                    if (parts.length >= 1 && parts[0].equals(username)) {
                        isValidAdmin = true;
                        // Check if password is provided in the file (at least 4 parts: username, name, email, password)
                        if (parts.length >= 4) {
                            expectedPassword = parts[3]; // Use the password from the file
                        } else {
                            // If no password in file, use reverse of username
                            expectedPassword = new StringBuilder(username).reverse().toString();
                        }
                        if (password.equals(expectedPassword)) {
                            HttpSession session = request.getSession();
                            session.setAttribute("userType", "admin");
                            session.setAttribute("username", username);
                            // Remove the super admin check for Hasiru since we're standardizing password logic
                            response.sendRedirect("admin-dashboard.jsp");
                            return;
                        }
                        break;
                    }
                }
            } catch (IOException e) {
                getServletContext().log("Error reading admins.txt: " + e.getMessage());
            }
        }

        request.setAttribute("adminError", "Invalid username or password.");
        request.getRequestDispatcher("logIn.jsp").forward(request, response);
    }
}