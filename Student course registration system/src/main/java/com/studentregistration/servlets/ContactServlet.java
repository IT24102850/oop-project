// ContactServlet.java
package com.studentregistration.servlets;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet("/contact")
@MultipartConfig
public class ContactServlet extends HttpServlet {
    private static final String CONTACT_FILE = "contact_messages.txt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        // Get current timestamp
        String timestamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

        // Format the message data
        String messageData = String.format(
                "[%s]%nName: %s%nEmail: %s%nSubject: %s%nMessage: %s%n%n",
                timestamp, name, email, subject, message
        );

        // Save to file
        boolean success = FileUtil.appendToFile(
                getServletContext().getRealPath("/WEB-INF/data/" + CONTACT_FILE),
                messageData
        );

        if (success) {
            // Redirect with success message
            response.sendRedirect("contact.jsp?success=true");
        } else {
            // Redirect with error message
            response.sendRedirect("contact.jsp?error=true");
        }
    }
}
