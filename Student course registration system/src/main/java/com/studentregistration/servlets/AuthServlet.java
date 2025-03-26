package com.studentregistration.servlets;

import com.studentregistration.dao.AdminDAO;
import com.studentregistration.dao.StudentDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/auth")
public class AuthServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String userType = request.getParameter("userType");

        boolean authenticated = false;

        if("admin".equals(userType)) {
            authenticated = new AdminDAO().validateAdmin(username, password);
        } else {
            authenticated = new StudentDAO().validateStudent(username, password);
        }

        if(authenticated) {
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setAttribute("userType", userType);

            if("admin".equals(userType)) {
                response.sendRedirect("jsp/admin-dashboard.jsp");
            } else {
                response.sendRedirect("jsp/dashboard.jsp");
            }
        } else {
            response.sendRedirect("jsp/login.jsp?error=1");
        }
    }
}