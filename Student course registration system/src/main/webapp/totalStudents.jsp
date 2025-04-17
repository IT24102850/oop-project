<%@ page import="java.io.*" %>
<%@ page contentType="text/plain;charset=UTF-8" language="java" %>
<%
    String filePath = application.getRealPath("/WEB-INF/student.txt");
    int totalStudents = 0;
    try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
        while (reader.readLine() != null) {
            totalStudents++;
        }
    } catch (IOException e) {
        totalStudents = -1; // Indicate an error
    }
    System.out.print(totalStudents);
%>