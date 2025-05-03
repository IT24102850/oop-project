import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class studentRegistration extends HttpServlet {
    private static final String STUDENT_FILE = "students.txt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
            response.sendRedirect("register.jsp?error=empty_fields");
            return;
        }

        // Append the new student to the file
        String filePath = getServletContext().getRealPath("/") + STUDENT_FILE;
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
            writer.write(email + ":" + password + "\n");
        } catch (IOException e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=server_error");
            return;
        }

        response.sendRedirect("logIn.jsp?success=registration_complete");
    }
}