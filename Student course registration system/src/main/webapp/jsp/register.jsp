<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Registration</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <script src="${pageContext.request.contextPath}/js/validation.js"></script>
</head>
<body>
    <div class="container">
        <h1>Student Registration</h1>
        
        <%-- Display error message if exists --%>
        <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="alert error">
                <%= request.getAttribute("errorMessage") %>
            </div>
        <% } %>
        
        <%-- Registration Form --%>
        <form id="registrationForm" action="${pageContext.request.contextPath}/register" method="post" onsubmit="return validateForm()">
            <div class="form-group">
                <label for="studentId">Student ID:</label>
                <input type="text" id="studentId" name="studentId" required>
            </div>
            
            <div class="form-group">
                <label for="firstName">First Name:</label>
                <input type="text" id="firstName" name="firstName" required>
            </div>
            
            <div class="form-group">
                <label for="lastName">Last Name:</label>
                <input type="text" id="lastName" name="lastName" required>
            </div>
            
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
            </div>
            
            <div class="form-group">
                <label for="phoneNumber">Phone Number:</label>
                <input type="tel" id="phoneNumber" name="phoneNumber" required>
            </div>
            
            <div class="form-group">
                <label for="address">Address:</label>
                <textarea id="address" name="address" rows="3" required></textarea>
            </div>
            
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required>
            </div>
            
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            
            <div class="form-group">
                <label for="confirmPassword">Confirm Password:</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required>
            </div>
            
            <div class="form-actions">
                <button type="submit" class="btn">Register</button>
                <button type="reset" class="btn secondary">Clear</button>
            </div>
        </form>
        
        <div class="login-link">
            Already have an account? <a href="${pageContext.request.contextPath}/login.jsp">Login here</a>
        </div>
    </div>
</body>
</html>