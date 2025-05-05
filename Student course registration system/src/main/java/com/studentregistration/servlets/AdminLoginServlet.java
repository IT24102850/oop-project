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

        if (adminsFile.exists()) {
            try (BufferedReader reader = new BufferedReader(new FileReader(adminsFile))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    if (line.trim().isEmpty()) continue;
                    String[] parts = line.split(",");
                    if (parts.length >= 1 && parts[0].equals(username)) {
                        isValidAdmin = true;
                        String expectedPassword = "hasiru2004".equals(password) && "Hasiru".equals(username) ? "hasiru2004" :
                                new StringBuilder(username).reverse().toString();
                        if (password.equals(expectedPassword)) {
                            HttpSession session = request.getSession();
                            session.setAttribute("userType", "admin");
                            session.setAttribute("username", username);
                            if ("Hasiru".equals(username)) {
                                session.setAttribute("isSuperAdmin", true);
                            }
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