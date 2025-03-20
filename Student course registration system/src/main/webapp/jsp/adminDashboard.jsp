<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/styles.css">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
        }
        .sidebar {
            width: 250px;
            background: #2c3e50;
            height: 100vh;
            padding-top: 20px;
            position: fixed;
            color: white;
        }
        .sidebar ul {
            list-style: none;
            padding: 0;
        }
        .sidebar ul li {
            padding: 15px;
            text-align: center;
        }
        .sidebar ul li a {
            color: white;
            text-decoration: none;
            display: block;
        }
        .sidebar ul li:hover {
            background: #34495e;
        }
        .content {
            margin-left: 260px;
            padding: 20px;
            width: 100%;
        }
        h1 {
            color: #2c3e50;
        }
    </style>
</head>
<body>
<div class="sidebar">
    <h2>Admin Panel</h2>
    <ul>
        <li><a href="${pageContext.request.contextPath}/jsp/addUser.jsp"><i class="fas fa-user-plus"></i> Add User</a></li>
        <li><a href="${pageContext.request.contextPath}/jsp/viewUsers.jsp"><i class="fas fa-users"></i> View Users</a></li>
        <li><a href="${pageContext.request.contextPath}/jsp/addCourse.jsp"><i class="fas fa-book"></i> Add Course</a></li>
        <li><a href="${pageContext.request.contextPath}/jsp/viewCourses.jsp"><i class="fas fa-list"></i> View Courses</a></li>
        <li><a href="${pageContext.request.contextPath}/auth?logout=true"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
    </ul>
</div>
<div class="content">
    <h1>Welcome, Admin!</h1>
    <p>Manage users and courses efficiently with the admin dashboard.</p>
</div>
<script src="${pageContext.request.contextPath}/js/scripts.js"></script>
</body>
</html>
