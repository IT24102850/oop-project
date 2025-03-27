<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add New Course</title>
    <link rel="stylesheet" href="../css/styles.css">
</head>
<body>
    <h1>Add New Course</h1>
    <form action="courses" method="post">
        <input type="hidden" name="action" value="add">
        
        <label>Course ID:</label>
        <input type="text" name="courseId" required><br>
        
        <label>Course Name:</label>
        <input type="text" name="courseName" required><br>
        
        <label>Description:</label>
        <textarea name="description" required></textarea><br>
        
        <label>Credits:</label>
        <input type="number" name="credits" min="1" required><br>
        
        <button type="submit">Save</button>
        <a href="courses">Cancel</a>
    </form>
</body>
</html>
