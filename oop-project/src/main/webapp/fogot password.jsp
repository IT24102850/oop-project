<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password - NexoraSkill</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/forgotpassword.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.ico">
</head>
<body>
    <!-- Header Section -->
    <header class="header">
        <div class="container">
            <div class="logo">
                <img src="${pageContext.request.contextPath}/images/favicon-32x32.png" alt="NexoraSkill Logo">
                <span>NexoraSkill</span>
            </div>
            <nav class="navbar">
                <ul>
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="courses.jsp">Courses</a></li>
                    <li><a href="registration.jsp">Registration</a></li>
                    <li><a href="aboutus.jsp">About Us</a></li>
                    <li><a href="contactus.jsp">Contact</a></li>
                </ul>
            </nav>
            <div class="auth-buttons">
                <a href="logIn.jsp" class="btn-login">Login</a>
                <a href="signUp.jsp" class="btn-signup">Sign Up</a>
            </div>
        </div>
    </header>

    <!-- Forgot Password Section -->
    <section class="forgot-password-section">
        <div class="forgot-password-container">
            <h2>Forgot Password?</h2>
            <p class="forgot-password-subtext">Enter your email address to reset your password.</p>
            <form class="forgot-password-form" action="${pageContext.request.contextPath}/resetpassword" method="POST">
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" placeholder="Enter your email" required>
                </div>
                <button type="submit" class="cta-button">Reset Password</button>
                <p class="back-to-login">Remember your password? <a href="logIn.jsp">Login here</a></p>
            </form>
        </div>
    </section>

    <!-- Ensure FontAwesome is included -->
    <script src="https://kit.fontawesome.com/YOUR-KIT-ID.js" crossorigin="anonymous"></script>
</body>
</html>