<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Profile</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 20px;
            color: #333;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #2c3e50;
            text-align: center;
        }
        .profile-card {
            border: 1px solid #ddd;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .profile-header {
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
            margin-bottom: 15px;
        }
        .profile-details p {
            margin: 8px 0;
        }
        .profile-actions {
            margin-top: 20px;
            display: flex;
            gap: 10px;
        }
        .btn {
            padding: 8px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
        }
        .btn-edit {
            background-color: #3498db;
            color: white;
        }
        .btn-delete {
            background-color: #e74c3c;
            color: white;
        }
        .alert {
            padding: 10px;
            border-radius: 4px;
            margin-top: 15px;
        }
        .alert-success {
            background-color: #d4edda;
            color: #155724;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>My Profile</h1>
        <div class="profile-card">
            <div class="profile-header">
                <h2>${user.name}</h2>
                <p>ID: ${user.id}</p>
            </div>
            <div class="profile-details">
                <p><strong>Email:</strong> ${user.email}</p>
                <p><strong>Phone:</strong> ${user.phone}</p>
                <p><strong>Status:</strong> 
                    <c:if test="${user.deletionRequested}">Pending Deletion</c:if>
                    <c:if test="${not user.deletionRequested}">Active</c:if>
                </p>
            </div>
            <div class="profile-actions">
                <a href="editProfile.jsp" class="btn btn-edit">Edit Profile</a>
                <form action="profile" method="post" onsubmit="return confirm('Are you sure?');">
                    <input type="hidden" name="action" value="delete">
                    <button type="submit" class="btn btn-delete">Request Deletion</button>
                </form>
            </div>
        </div>
        <c:if test="${not empty param.success}">
            <div class="alert alert-success">Profile updated successfully!</div>
        </c:if>
    </div>
</body>
</html>