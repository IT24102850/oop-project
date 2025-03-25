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
    <style>
        /* Header Styles */
        .header {
            background-color: #2c3e50;
            padding: 15px 0;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .container {
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo img {
            height: 40px;
        }

        .navbar ul {
            display: flex;
            list-style: none;
            margin: 0;
            padding: 0;
        }

        .navbar li {
            margin-left: 25px;
        }

        .navbar a {
            color: white;
            text-decoration: none;
            font-weight: 500;
        }

        /* Message Styles */
        .success-message {
            background-color: #d4edda;
            color: #155724;
            padding: 10px;
            border-radius: 4px;
            margin: 10px 0;
            text-align: center;
        }

        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            padding: 10px;
            border-radius: 4px;
            margin: 10px 0;
            text-align: center;
        }

        /* Login Section Styles */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            color: #333;
        }

        .login-section {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: calc(100vh - 70px);
            padding: 20px;
        }

        .login-container {
            background: white;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            padding: 30px;
        }

        .login-container h2 {
            color: #2c3e50;
            margin-bottom: 10px;
            text-align: center;
        }

        .login-subtitle {
            color: #7f8c8d;
            text-align: center;
            margin-bottom: 25px;
        }

        /* Futuristic Toggle Styles */
        .toggle-wrapper {
            margin: 25px 0;
            perspective: 1000px;
        }

        .toggle-container {
            position: relative;
            display: flex;
            height: 60px;
            background: rgba(20, 20, 30, 0.8);
            border-radius: 50px;
            overflow: hidden;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.3),
            inset 0 1px 0 rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .toggle-container input[type="radio"] {
            display: none;
        }

        .toggle-option {
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            z-index: 2;
            transition: all 0.5s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            color: rgba(255, 255, 255, 0.7);
        }

        .toggle-option .icon {
            font-size: 20px;
            margin-bottom: 5px;
            transition: all 0.3s;
        }

        .toggle-option .text {
            font-size: 14px;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        input[type="radio"]:checked + label {
            color: #fff;
            transform: translateY(-5px);
        }

        input[type="radio"]:checked + label .icon {
            transform: scale(1.2);
            text-shadow: 0 0 10px rgba(100, 255, 255, 0.7);
        }

        .toggle-glider {
            position: absolute;
            height: 100%;
            width: 50%;
            background: linear-gradient(135deg, #00b4db, #0083b0);
            border-radius: 50px;
            transition: all 0.5s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            z-index: 1;
            box-shadow: 0 0 20px rgba(0, 180, 219, 0.5);
        }

        #student:checked ~ .toggle-glider {
            transform: translateX(100%);
            background: linear-gradient(135deg, #a8ff78, #78ffd6);
            box-shadow: 0 0 20px rgba(168, 255, 120, 0.5);
        }

        /* Form Styles */
        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
        }

        .form-group input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            box-sizing: border-box;
            transition: border 0.3s;
        }

        .form-group input:focus {
            border-color: #009acd;
            outline: none;
        }

        .remember-me {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .remember-me input {
            margin-right: 8px;
        }

        .btn-login {
            width: 100%;
            padding: 12px;
            background: #009acd;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s;
        }

        .btn-login:hover {
            background: #007fa3;
        }

        .auth-links {
            margin-top: 15px;
            text-align: center;
            font-size: 14px;
        }

        .auth-links a {
            color: #009acd;
            text-decoration: none;
        }

        .auth-links a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<!-- Header Section -->
<header class="header">
    <div class="container">
        <div class="logo">
            <img src="${pageContext.request.contextPath}/images/logo.png" alt="NexoraSkill Logo">
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

<!-- Success and Error Messages -->
<% if (request.getParameter("success") != null) { %>
<div class="success-message">
    Registration successful! Please login.
</div>
<% } %>

<% if (request.getParameter("error") != null) { %>
<div class="error-message">
    Invalid username or password. Please try again.
</div>
<% } %>

<!-- Login Section -->
<section class="login-section">
    <div class="login-container">
        <h2>Login to Your Account</h2>
        <p class="login-subtitle">Welcome back! Please enter your credentials to access your account.</p>

        <!-- Futuristic Toggle Switch -->
        <div class="toggle-wrapper">
            <div class="toggle-container">
                <input type="radio" id="admin" name="userType" value="admin" checked>
                <label for="admin" class="toggle-option">
                    <span class="icon"><i class="fas fa-user-shield"></i></span>
                    <span class="text">Admin</span>
                </label>

                <input type="radio" id="student" name="userType" value="student">
                <label for="student" class="toggle-option">
                    <span class="icon"><i class="fas fa-user-graduate"></i></span>
                    <span class="text">Student</span>
                </label>

                <div class="toggle-glider"></div>
            </div>
        </div>

        <!-- Login Form -->
        <form class="login-form" action="${pageContext.request.contextPath}/auth" method="POST">
            <input type="hidden" id="userType" name="userType" value="admin">

            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" placeholder="Enter your username" required>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required>
            </div>

            <div class="remember-me">
                <input type="checkbox" id="remember-me" name="remember-me">
                <label for="remember-me">Remember Me</label>
            </div>

            <button type="submit" class="btn-login">Login</button>

            <div class="auth-links">
                <p>Don't have an account? <a href="${pageContext.request.contextPath}/navigation/signUp.jsp">Sign Up</a></p>
                <p><a href="${pageContext.request.contextPath}/navigation/forgotPassword.jsp">Forgot Password?</a></p>
            </div>
        </form>
    </div>
</section>

<script>
    // Enhanced futuristic toggle with animations
    document.addEventListener('DOMContentLoaded', function() {
        const toggleOptions = document.querySelectorAll('.toggle-option');
        const toggleGlider = document.querySelector('.toggle-glider');
        const userTypeInput = document.getElementById('userType');

        toggleOptions.forEach(option => {
            option.addEventListener('click', function() {
                // Add animation class
                toggleGlider.classList.add('animate');

                // Remove animation class after effect completes
                setTimeout(() => {
                    toggleGlider.classList.remove('animate');
                }, 500);
            });
        });

        // Handle toggle changes
        document.getElementById('admin').addEventListener('change', function() {
            userTypeInput.value = 'admin';
        });

        document.getElementById('student').addEventListener('change', function() {
            userTypeInput.value = 'student';
        });
    });

    // Form validation
    document.querySelector('.login-form').addEventListener('submit', function(event) {
        const username = document.getElementById('username').value.trim();
        const password = document.getElementById('password').value.trim();
        const userType = document.getElementById('userType').value;

        if (!username || !password) {
            alert('Please fill in all fields.');
            event.preventDefault();
        }

        if (username.length < 4) {
            alert('Username must be at least 4 characters long.');
            event.preventDefault();
        }

        if (password.length < 6) {
            alert('Password must be at least 6 characters long.');
            event.preventDefault();
        }

        // You can add additional validation here if needed
    });
</script>
</body>
</html>