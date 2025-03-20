<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - NexoraSkill</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/logIn.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.ico">
</head>
<body>
<!-- Header Section -->
<header class="header">
    <div class="container">
        <div class="logo">
            <img src="${pageContext.request.contextPath}/images/logo.png" alt="Course Registration Logo">
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

<!-- Login Section -->
<section class="login-section">
    <div class="login-container">
        <h2>Login to Your Account</h2>
        <p class="login-subtitle">Welcome back! Please enter your credentials to access your account.</p>

        <!-- Login Form (Email-Based) -->
        <form class="login-form" action="${pageContext.request.contextPath}/login" method="POST">
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="Enter your email" required>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required>
            </div>

            <div class="form-options">
                <div class="remember-me">
                    <input type="checkbox" id="remember-me" name="remember-me">
                    <label for="remember-me">Remember Me</label>
                </div>
            </div>

            <button type="submit" class="btn-login">Login</button>
        </form>

        <hr>

        <!-- Login Form (Username-Based) -->
        <form action="${pageContext.request.contextPath}/auth" method="post">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" placeholder="Username" required>
            </div>

            <div class="form-group">
                <label for="password2">Password</label>
                <input type="password" id="password2" name="password" placeholder="Password" required>
            </div>

            <button type="submit" class="btn-login">Login</button>
        </form>

        <p class="signup-link">Don't have an account? <a href="${pageContext.request.contextPath}/navigation/signUp.jsp">Sign Up</a></p>
    </div>
</section>

</body>
</html>
