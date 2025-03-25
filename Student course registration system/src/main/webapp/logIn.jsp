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

        <!-- User Type Toggle Switch -->
        <div class="user-type-toggle">
            <div class="toggle-option active" id="admin-toggle">Admin</div>
            <div class="toggle-option" id="student-toggle">Student</div>
            <input type="hidden" id="userType" name="userType" value="admin">
        </div>

        <!-- Login Form -->
        <form class="login-form" action="${pageContext.request.contextPath}/auth" method="POST">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" placeholder="Enter your username" required>
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
            <div class="auth-links">
                <p class="signup-link">Don't have an account? <a href="${pageContext.request.contextPath}/navigation/signUp.jsp">Sign Up</a></p>
                <p class="forgot-password">
                    <a href="${pageContext.request.contextPath}/navigation/forgotPassword.jsp">Forgot Password?</a>
                </p>
            </div>
        </form>
    </div>
</section>

<style>
    /* Toggle Switch Styles */
    .user-type-toggle {
        display: flex;
        margin: 20px 0;
        border-radius: 6px;
        overflow: hidden;
        border: 1px solid #ddd;
        background: #f5f5f5;
    }

    .toggle-option {
        flex: 1;
        padding: 10px 15px;
        text-align: center;
        cursor: pointer;
        transition: all 0.3s ease;
        font-weight: 500;
        color: #555;
    }

    .toggle-option.active {
        background: #009acd;
        color: white;
    }

    /* Form Styles */
    .login-container {
        max-width: 400px;
        margin: 0 auto;
        padding: 30px;
        background: white;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }

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
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 14px;
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
        background: #009acd;
    }

    .auth-links {
        margin-top: 15px;
        text-align: center;
    }

    .auth-links a {
        color:  #009acd;
        text-decoration: none;
    }

    .auth-links a:hover {
        text-decoration: underline;
    }
</style>

<script>
    // Toggle Switch Functionality
    document.getElementById('admin-toggle').addEventListener('click', function() {
        this.classList.add('active');
        document.getElementById('student-toggle').classList.remove('active');
        document.getElementById('userType').value = 'admin';
    });

    document.getElementById('student-toggle').addEventListener('click', function() {
        this.classList.add('active');
        document.getElementById('admin-toggle').classList.remove('active');
        document.getElementById('userType').value = 'student';
    });
</script>

<!-- JavaScript for Form Validation -->
<script>
    document.querySelector('.login-form').addEventListener('submit', function(event) {
        const username = document.getElementById('username').value;
        const password = document.getElementById('password').value;

        if (!username || !password) {
            alert('Please fill in all fields.');
            event.preventDefault(); // Prevent form submission
        }
    });
</script>
</body>
</html>