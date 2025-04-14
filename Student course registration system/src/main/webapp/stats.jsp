<%@ page import="java.io.*, java.util.*" %>
<%@ page contentType="application/json;charset=UTF-8" language="java" %>
<%
    // Function to count lines in a file, excluding empty lines
    int countLines(String filePath) throws IOException {
        int count = 0;
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (!line.trim().isEmpty()) {
                    count++;
                }
            }
        }
        return count;
    }

    // Function to count active courses
    int countActiveCourses(String filePath) throws IOException {
        int count = 0;
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (!line.trim().isEmpty()) {
                    String[] parts = line.split(",");
                    if (parts.length > 4 && parts[4].trim().equalsIgnoreCase("Active")) {
                        count++;
                    }
                }
            }
        }
        return count;
    }

    // Function to count pending requests
    int countPendingRequests(String filePath) throws IOException {
        int count = 0;
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (!line.trim().isEmpty()) {
                    String[] parts = line.split(",");
                    if (parts.length > 3 && parts[3].trim().equalsIgnoreCase("Pending")) {
                        count++;
                    }
                }
            }
        }
        return count;
    }

    // Get the real paths of the files
    String studentFilePath = application.getRealPath("/WEB-INF/data/students.txt");
    String coursesFilePath = application.getRealPath("/WEB-INF/data/courses.txt");
    String requestsFilePath = application.getRealPath("/WEB-INF/data/requests.txt");

    // Initialize stats
    int totalStudents = 0;
    int activeCourses = 0;
    int pendingRequests = 0;

    try {
        totalStudents = countLines(studentFilePath);
    } catch (IOException e) {
        totalStudents = -1; // Indicate error
    }

    try {
        activeCourses = countActiveCourses(coursesFilePath);
    } catch (IOException e) {
        activeCourses = -1; // Indicate error
    }

    try {
        pendingRequests = countPendingRequests(requestsFilePath);
    } catch (IOException e) {
        pendingRequests = -1; // Indicate error
    }

    // Create JSON response
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    out.print("{");
    out.print("\"totalStudents\": " + totalStudents + ",");
    out.print("\"activeCourses\": " + activeCourses + ",");
    out.print("\"pendingRequests\": " + pendingRequests);
    out.print("}");
%>