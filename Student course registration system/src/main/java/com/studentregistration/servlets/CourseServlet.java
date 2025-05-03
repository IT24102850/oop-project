import java.io.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/course")
public class CourseServlet extends HttpServlet {
    private static final String COURSES_FILE_PATH = "/WEB-INF/data/courses.txt";
    private static final String TEMP_FILE_PATH = "/WEB-INF/data/courses.txt.tmp";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<String> courses = readCourses();
        request.setAttribute("courses", courses);
        request.getRequestDispatcher("/admin-dashboard.jsp?activeTab=courses").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String activeTab = request.getParameter("activeTab");

        List<String> courses = readCourses();
        boolean updated = false;

        if ("create".equals(action)) {
            String courseCode = request.getParameter("courseCode");
            String title = request.getParameter("title");
            String credits = request.getParameter("credits");
            String department = request.getParameter("department");
            String professor = request.getParameter("professor");
            String syllabus = request.getParameter("syllabus");
            String isActive = "true";

            String newCourse = String.format("%s,%s,%s,%s,%s,%s,%s", courseCode, title, credits, department, professor, syllabus, isActive);
            if (!courses.contains(newCourse)) {
                courses.add(newCourse);
                updated = true;
                request.setAttribute("message", "course_added");
            } else {
                request.setAttribute("error", "duplicate_course");
            }
        } else if ("update".equals(action)) {
            String originalCourseCode = request.getParameter("originalCourseCode");
            String courseCode = request.getParameter("courseCode");
            String title = request.getParameter("title");
            String credits = request.getParameter("credits");
            String department = request.getParameter("department");
            String professor = request.getParameter("professor");
            String syllabus = request.getParameter("syllabus");

            for (int i = 0; i < courses.size(); i++) {
                String[] parts = courses.get(i).split(",");
                if (parts.length >= 7 && parts[0].equals(originalCourseCode)) {
                    String updatedCourse = String.format("%s,%s,%s,%s,%s,%s,%s", courseCode, title, credits, department, professor, syllabus, parts[6]);
                    courses.set(i, updatedCourse);
                    updated = true;
                    request.setAttribute("message", "course_updated");
                    break;
                }
            }
            if (!updated) {
                request.setAttribute("error", "course_not_found");
            }
        } else if ("archive".equals(action)) {
            String courseCode = request.getParameter("courseCode");
            for (int i = 0; i < courses.size(); i++) {
                String[] parts = courses.get(i).split(",");
                if (parts.length >= 7 && parts[0].equals(courseCode)) {
                    String[] updatedParts = parts.clone();
                    updatedParts[6] = "false";
                    courses.set(i, String.join(",", updatedParts));
                    updated = true;
                    request.setAttribute("message", "course_archived");
                    break;
                }
            }
            if (!updated) {
                request.setAttribute("error", "course_not_found");
            }
        } else if ("delete".equals(action)) {
            String courseCode = request.getParameter("courseCode");
            courses.removeIf(course -> course.split(",")[0].equals(courseCode));
            updated = true;
            request.setAttribute("message", "course_deleted");
        }

        if (updated) {
            writeCourses(courses);
        }

        response.sendRedirect(request.getContextPath() + "/admin-dashboard.jsp?activeTab=" + (activeTab != null ? activeTab : "courses"));
    }

    private List<String> readCourses() {
        List<String> courses = new ArrayList<>();
        String filePath = getServletContext().getRealPath(COURSES_FILE_PATH);
        File file = new File(filePath);
        if (file.exists()) {
            try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    if (!line.trim().isEmpty()) {
                        courses.add(line);
                    }
                }
            } catch (IOException e) {
                System.err.println("Error reading courses.txt: " + e.getMessage());
            }
        }
        return courses;
    }

    private void writeCourses(List<String> courses) {
        String filePath = getServletContext().getRealPath(COURSES_FILE_PATH);
        File file = new File(filePath);
        File tempFile = new File(getServletContext().getRealPath(TEMP_FILE_PATH));

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(tempFile))) {
            for (String course : courses) {
                writer.write(course);
                writer.newLine();
            }
            writer.flush();

            // Replace the original file with the temp file
            if (file.exists() && !file.delete()) {
                throw new IOException("Failed to delete original courses file");
            }
            if (!tempFile.renameTo(file)) {
                throw new IOException("Failed to replace courses file with updated data");
            }
        } catch (IOException e) {
            System.err.println("Error writing courses.txt: " + e.getMessage());
            throw new RuntimeException("Failed to replace courses file with updated data.", e);
        }
    }
}