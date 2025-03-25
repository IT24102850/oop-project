
<%
    // After successful user creation
    response.sendRedirect(request.getContextPath() + "/login.jsp");
%>



<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up - NexoraSkill</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/signUp.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.ico">
</head>
<body>
<!-- Header Section -->
<header class="header">
    <div class="container">
        <div class="logo">
            <img src="${pageContext.request.contextPath}/images/logo.png" alt="Course Registration Logo">
            <link rel="icon" href="${pageContext.request.contextPath}/images/favicon-16x16.png">
        </div>
        <nav class="navbar">
            <ul>
                <li><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/navigation/courses.jsp">Courses</a></li>
                <li><a href="${pageContext.request.contextPath}/navigation/registration.jsp">Registration</a></li>
                <li><a href="${pageContext.request.contextPath}/navigation/aboutus.jsp">About Us</a></li>
                <li><a href="#contact">Contact</a></li>
            </ul>
        </nav>
    </div>
</header>

<!-- Sign Up Section -->
<section class="login-section">
    <div class="login-container">
        <h2>Create Your Account</h2>
        <p class="login-subtitle">Join us today! Please fill in the details to create your account.</p>

        <!-- Sign Up Form -->
        <form class="login-form" action="${pageContext.request.contextPath}/signup" method="POST">
            <div class="form-group">
                <label for="fullname">Full Name</label>
                <input type="text" id="fullname" name="fullname" placeholder="Enter your full name" required>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="Enter your email" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required>
            </div>
            <div class="form-group">
                <label for="confirm-password">Confirm Password</label>
                <input type="password" id="confirm-password" name="confirm-password" placeholder="Confirm your password" required>
            </div>
            <button type="submit" class="btn-login">Sign Up</button>
            <p class="signup-link">Already have an account? <a href="${pageContext.request.contextPath}/navigation/logIn.jsp">Login here</a></p>
        </form>

        <% if (request.getParameter("error") != null) { %>
        <div class="error-message">
            Passwords do not match. Please try again.
        </div>
        <% } %>
    </div>
</section>

<!-- JavaScript for Form Validation -->
<script>
    document.querySelector('.login-form').addEventListener('submit', function(event) {
        const fullname = document.getElementById('fullname').value;
        const email = document.getElementById('email').value;
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirm-password').value;

        if (!fullname || !email || !password || !confirmPassword) {
            alert('Please fill in all fields.');
            event.preventDefault(); // Prevent form submission
        } else if (password !== confirmPassword) {
            alert('Passwords do not match. Please try again.');
            event.preventDefault(); // Prevent form submission
        }
    });
</script>
</body>
</html>