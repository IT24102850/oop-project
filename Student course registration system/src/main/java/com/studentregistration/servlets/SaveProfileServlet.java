import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet("/saveProfile")
public class SaveProfileServlet extends HttpServlet {
    private static final String PROFILE_DIR = "user_profiles";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the username from the session
        HttpSession session = request.getSession(false);
        String username = (String) session.getAttribute("username");
        if (username == null) {
            response.sendRedirect("logIn.jsp?error=session_expired");
            return;
        }

        // Sanitize username to create a valid filename (remove @ and domain)
        String sanitizedUsername = username.substring(0, username.indexOf('@'));
        String profileFileName = sanitizedUsername + ".txt";

        // Get the profile directory path
        String applicationPath = request.getServletContext().getRealPath("");
        String profileDirPath = applicationPath + File.separator + PROFILE_DIR;

        // Create the profile directory if it doesn't exist
        File profileDir = new File(profileDirPath);
        if (!profileDir.exists()) {
            profileDir.mkdirs();
        }

        // Get form data
        String name = request.getParameter("name");
        String dob = request.getParameter("dob");
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String degree = request.getParameter("degree");
        String enrolled = request.getParameter("enrolled");
        String gpa = request.getParameter("gpa");
        String twoFactor = request.getParameter("twoFactor");

        // Save data to the user-specific file
        String filePath = profileDirPath + File.separator + profileFileName;
        try (PrintWriter writer = new PrintWriter(new FileWriter(filePath))) {
            writer.println("name:" + name);
            writer.println("dob:" + dob);
            writer.println("gender:" + gender);
            writer.println("email:" + email);
            writer.println("phone:" + phone);
            writer.println("address:" + address);
            writer.println("degree:" + degree);
            writer.println("enrolled:" + enrolled);
            writer.println("gpa:" + gpa);
            writer.println("twoFactor:" + twoFactor);
        }

        // Redirect back to the profile section
        response.sendRedirect("student-dashboard.jsp?section=profile&message=profile_updated");
    }
}