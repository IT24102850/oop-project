import java.io.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/studentRegistration")
public class StudentRegistrationServlet extends HttpServlet {
    private static final String STUDENTS_FILE_PATH = "/WEB-INF/data/students.txt";
    private final Object fileLock = new Object();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            handleDeleteStudent(request, response);
        } else {
            response.sendRedirect("admin-dashboard.jsp?activeTab=students&error=invalid_action");
        }
    }

<<<<<<< HEAD
=======



>>>>>>> fe20fe5a8563e26ff54b3649bcc50f18a47a489a
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            handleAddStudent(request, response);
        } else if ("update".equals(action)) {
            handleUpdateStudent(request, response);
        } else {
            response.sendRedirect("admin-dashboard.jsp?activeTab=students&error=invalid_action");
        }
    }

    private List<String[]> readStudents(HttpServletRequest request) throws IOException {
        List<String[]> students = new ArrayList<>();
        String filePath = request.getServletContext().getRealPath(STUDENTS_FILE_PATH);
        File file = new File(filePath);

        // Create file if it doesn't exist
        if (!file.exists()) {
            file.getParentFile().mkdirs();
            file.createNewFile();
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.trim().isEmpty()) continue;
                String[] parts = line.split(",");
                if (parts.length >= 3) { // Ensure we have at least id, name, email
                    students.add(parts);
                }
            }
        }
        return students;
    }

    private void writeStudents(HttpServletRequest request, List<String[]> students) throws IOException {
        String filePath = request.getServletContext().getRealPath(STUDENTS_FILE_PATH);
        File file = new File(filePath);

        // Ensure the directory exists
        File parentDir = file.getParentFile();
        if (!parentDir.exists()) {
            parentDir.mkdirs();
        }

        synchronized (fileLock) {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
                for (String[] student : students) {
                    writer.write(String.join(",", student));
                    writer.newLine();
                }
            }
        }
    }

    private boolean hasDuplicate(List<String[]> students, String id, String email, String excludeId) {
        for (String[] student : students) {
            String existingId = student[0];
            String existingEmail = student[2];

            // Skip the student being updated (if excludeId is provided)
            if (excludeId != null && existingId.equals(excludeId)) {
                continue;
            }

            if (existingId.equalsIgnoreCase(id) || existingEmail.equalsIgnoreCase(email)) {
                return true;
            }
        }
        return false;
    }

    private boolean containsInvalidCharacters(String input) {
        return input.contains(",");
    }

    private void handleAddStudent(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String email = request.getParameter("email");

        // Validate input
        if (id == null || name == null || email == null ||
                id.trim().isEmpty() || name.trim().isEmpty() || email.trim().isEmpty()) {
            response.sendRedirect("admin-dashboard.jsp?activeTab=students&error=empty_fields");
            return;
        }

        id = id.trim();
        name = name.trim();
        email = email.trim();

        // Check for invalid characters
        if (containsInvalidCharacters(id) || containsInvalidCharacters(name) || containsInvalidCharacters(email)) {
            response.sendRedirect("admin-dashboard.jsp?activeTab=students&error=invalid_input");
            return;
        }

        // Validate email format
        if (!email.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
            response.sendRedirect("admin-dashboard.jsp?activeTab=students&error=invalid_email");
            return;
        }

        try {
            List<String[]> students = readStudents(request);

            // Check for duplicates
            if (hasDuplicate(students, id, email, null)) {
                response.sendRedirect("admin-dashboard.jsp?activeTab=students&error=duplicate_id_or_email");
                return;
            }

            // Add new student
            students.add(new String[]{id, name, email});
            writeStudents(request, students);

            response.sendRedirect("admin-dashboard.jsp?activeTab=students&message=student_added");
        } catch (IOException e) {
            e.printStackTrace();
            response.sendRedirect("admin-dashboard.jsp?activeTab=students&error=server_error");
        }
    }

    private void handleUpdateStudent(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String originalId = request.getParameter("originalId");
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String email = request.getParameter("email");

        // Validate input
        if (id == null || name == null || email == null || originalId == null ||
                id.trim().isEmpty() || name.trim().isEmpty() || email.trim().isEmpty() || originalId.trim().isEmpty()) {
            response.sendRedirect("admin-dashboard.jsp?activeTab=students&error=empty_fields");
            return;
        }

        id = id.trim();
        name = name.trim();
        email = email.trim();
        originalId = originalId.trim();

        // Check for invalid characters
        if (containsInvalidCharacters(id) || containsInvalidCharacters(name) || containsInvalidCharacters(email)) {
            response.sendRedirect("admin-dashboard.jsp?activeTab=students&error=invalid_input");
            return;
        }

        // Validate email format
        if (!email.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
            response.sendRedirect("admin-dashboard.jsp?activeTab=students&error=invalid_email");
            return;
        }

        try {
            List<String[]> students = readStudents(request);
            boolean found = false;

            // Check for duplicates (excluding the student being updated)
            if (hasDuplicate(students, id, email, originalId)) {
                response.sendRedirect("admin-dashboard.jsp?activeTab=students&error=duplicate_id_or_email");
                return;
            }

            // Update the student
            for (int i = 0; i < students.size(); i++) {
                if (students.get(i)[0].equals(originalId)) {
                    students.set(i, new String[]{id, name, email});
                    found = true;
                    break;
                }
            }

            if (!found) {
                response.sendRedirect("admin-dashboard.jsp?activeTab=students&error=student_not_found");
                return;
            }

            writeStudents(request, students);
            response.sendRedirect("admin-dashboard.jsp?activeTab=students&message=student_updated");
        } catch (IOException e) {
            e.printStackTrace();
            response.sendRedirect("admin-dashboard.jsp?activeTab=students&error=server_error");
        }
    }

    private void handleDeleteStudent(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String id = request.getParameter("id");

        if (id == null || id.trim().isEmpty()) {
            response.sendRedirect("admin-dashboard.jsp?activeTab=students&error=empty_fields");
            return;
        }

        id = id.trim();

        try {
            List<String[]> students = readStudents(request);
            boolean found = false;

            // Remove the student
            for (int i = 0; i < students.size(); i++) {
                if (students.get(i)[0].equals(id)) {
                    students.remove(i);
                    found = true;
                    break;
                }
            }

            if (!found) {
                response.sendRedirect("admin-dashboard.jsp?activeTab=students&error=student_not_found");
                return;
            }

            writeStudents(request, students);
            response.sendRedirect("admin-dashboard.jsp?activeTab=students&message=student_deleted");
        } catch (IOException e) {
            e.printStackTrace();
            response.sendRedirect("admin-dashboard.jsp?activeTab=students&error=server_error");
        }
    }
}