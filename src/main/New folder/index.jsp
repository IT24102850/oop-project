<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>File CRUD</title>
</head>
<body>
    <h2>Enter Data</h2>
    <form action="file" method="post">
        <input type="text" name="data" required>
        <button type="submit" name="action" value="create">Save</button>
    </form>

    <h2>Delete Data</h2>
    <form action="file" method="post">
        <input type="text" name="data" required>
        <button type="submit" name="action" value="delete">Delete</button>
    </form>

    <h2>View Data</h2>
    <a href="file">View Stored Records</a>
</body>
</html>
