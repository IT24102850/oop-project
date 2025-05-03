<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.studentregistration.model.Course" %>
<!DOCTYPE html>
<html>
<head>
    <title>Course List</title>
    <link rel="stylesheet" href="../css/styles.css">
</head>
<body>
    <h1>Course List</h1>
    <a href="courses?action=new">Add New Course</a>
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Description</th>
            <th>Credits</th>
            <th>Actions</th>
        </tr>
        <% List<Course> courses = (List<Course>) request.getAttribute("courses");
           for (Course course : courses) { %>
        <tr>
            <td><%= course.getCourseId() %></td>
            <td><%= course.getCourseName() %></td>
            <td><%= course.getDescription() %></td>
            <td><%= course.getCredits() %></td>
            <td>
                <a href="courses?action=edit&id=<%= course.getCourseId() %>">Edit</a>
                <form action="courses" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="courseId" value="<%= course.getCourseId() %>">
                    <button type="submit" onclick="return confirm('Are you sure?')">Delete</button>
                </form>
            </td>
        </tr>
        <% } %>
    </table>
</body>
</html>