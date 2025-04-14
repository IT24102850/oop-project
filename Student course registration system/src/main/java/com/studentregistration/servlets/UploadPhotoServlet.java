import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet("/uploadPhoto")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB threshold
        maxFileSize = 1024 * 1024 * 10,      // 10MB max file size
        maxRequestSize = 1024 * 1024 * 50)    // 50MB max request size
public class UploadPhotoServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "uploads";

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

        // Get the upload directory path
        String applicationPath = request.getServletContext().getRealPath("");
        String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;

        // Create the upload directory if it doesn't exist
        File uploadDir = new File(uploadFilePath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // Process the uploaded file
        Part filePart = request.getPart("profilePhoto");
        String fileName = filePart.getSubmittedFileName();
        String fileExtension = fileName.substring(fileName.lastIndexOf('.'));
        String newFileName = sanitizedUsername + fileExtension;
        String filePath = uploadFilePath + File.separator + newFileName;

        // Save the file
        try (InputStream fileContent = filePart.getInputStream();
             FileOutputStream fos = new FileOutputStream(filePath)) {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = fileContent.read(buffer)) != -1) {
                fos.write(buffer, 0, bytesRead);
            }
        }

        // Store the relative path in the session for display
        session.setAttribute("profilePhotoPath", UPLOAD_DIR + "/" + newFileName);

        // Redirect back to the dashboard with a success message
        response.sendRedirect("student-dashboard.jsp?section=profile&message=photo_uploaded");
    }
}