import java.io.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ContactServlet")
public class ContactServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get form parameters
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        // Validate input
        if (name != null && !name.trim().isEmpty() &&
                email != null && !email.trim().isEmpty() &&
                subject != null && !subject.trim().isEmpty() &&
                message != null && !message.trim().isEmpty()) {

            // Format message with timestamp
            String timestamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            String messageData = String.format(
                    "[%s]%nName: %s%nEmail: %s%nSubject: %s%nMessage: %s%n%n",
                    timestamp, name, email, subject, message
            );

            // Get the real path to the data directory
            String dataDir = getServletContext().getRealPath("/WEB-INF/data");
            File directory = new File(dataDir);
            if (!directory.exists()) {
                directory.mkdirs();
            }

            // Write to file
            String filePath = dataDir + "/contact_messages.txt";
            try (PrintWriter writer = new PrintWriter(new FileWriter(filePath, true))) {
                writer.print(messageData);
                request.setAttribute("success", true);
            } catch (IOException e) {
                request.setAttribute("error", true);
                e.printStackTrace();
            }
        } else {
            request.setAttribute("error", true);
        }

        // Forward back to contact.jsp
        request.getRequestDispatcher("/contact.jsp").forward(request, response);
    }
}