import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/ValidateStudent")
public class ValidateStudentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        response.setContentType("application/json");
        String studentId = request.getParameter("id");

        boolean exists = StudentDAO.studentExists(studentId);
        response.getWriter().write("{\"exists\":" + exists + "}");
    }
}
