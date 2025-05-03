<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.studentregistration.model.Course" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Course</title>
    <link rel="stylesheet" href="../css/styles.css">
</head>
<body>
    <h1>Update Course</h1>
    <form action="courses" method="post">
        <input type="hidden" name="action" value="update">
        
        <label>Course ID:</label>
        <input type="text" name="courseId" value="${course.courseId}" readonly><br>
        
        <label>Course Name:</label>
        <input type="text" name="courseName" value="${course.courseName}" required><br>
        
        <label>Description:</label>
        <textarea name="description" required>${course.description}</textarea><br>
        
        <label>Credits:</label>
        <input type="number" name="credits" min="1" value="${course.credits}" required><br>
        
        <button type="submit">Update</button>
        <a href="courses">Cancel</a>
    </form>
</body>
</html>
