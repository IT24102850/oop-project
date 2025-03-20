<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NexoraSkill - Student Course Registration System</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="icon" type="image/png" href="./images/favicon.ico">
    <!-- Add Google Fonts for Poppins -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">


    <style>
        /* General Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --primary-color: #009acd;
            --secondary-color: #00ffcc;
            --accent-color: #ff6b6b;
            --dark-color: #0a192f;
            --text-color: #ffffff;
            --hover-color: #007ba7;
            --glow-color: rgba(0, 255, 204, 0.6);
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: var(--dark-color);
            color: var(--text-color);
            overflow-x: hidden;
        }

        /* Header Section */
        .header {
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1000;
            background: var(--dark-color);
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--text-color);
        }

        .logo img {
            height: 40px;
            transition: transform 0.3s ease;
        }

        .logo:hover img {
            transform: rotate(15deg);
        }

        .navbar ul {
            list-style: none;
            display: flex;
            gap: 20px;
        }

        .navbar ul li a {
            font-family: 'Poppins', sans-serif;
            font-weight: bold;
            text-decoration: none;
            color: var(--text-color);
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .navbar ul li a:hover {
            color: var(--primary-color);
        }

        .auth-buttons {
            display: flex;
            gap: 10px;
        }

        .btn-login, .btn-signup {
            padding: 10px 20px;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-login {
            background: transparent;
            border: 2px solid var(--primary-color);
            color: var(--text-color);
        }

        .btn-login:hover {
            background: var(--primary-color);
            color: var(--dark-color);
        }

        .btn-signup {
            background: var(--primary-color);
            color: var(--dark-color);
        }

        .btn-signup:hover {
            background: var(--hover-color);
        }

        /* Hero Section */
        .hero {
            display: flex;
            justify-content: space-between;
            align-items: center;
            min-height: 100vh;
            padding: 0 5%;
            position: relative;
            overflow: hidden;
        }

        .hero-content {
            max-width: 600px;
            animation: slideInLeft 1s ease;
        }

        .hero-title {
            font-size: 3.5rem;
            margin-bottom: 20px;
            color: var(--text-color);
            text-shadow: 0 0 10px var(--glow-color);
        }

        .hero-subtext {
            font-size: 1.2rem;
            margin-bottom: 30px;
            color: var(--text-color);
        }

        .hero-cta {
            display: flex;
            gap: 20px;
        }

        .cta-button {
            padding: 12px 24px;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .primary-cta {
            background: var(--primary-color);
            color: var(--dark-color);
        }

        .primary-cta:hover {
            background: var(--hover-color);
            transform: translateY(-5px);
            box-shadow: 0 5px 20px var(--glow-color);
        }

        .secondary-cta {
            background: transparent;
            border: 2px solid var(--primary-color);
            color: var(--text-color);
        }

        .secondary-cta:hover {
            background: var(--primary-color);
            color: var(--dark-color);
            transform: translateY(-5px);
        }

        .hero-visual {
            position: relative;
            width: 500px;
            height: 500px;
            animation: slideInRight 1s ease;
        }

        .glowing-circle {
            position: absolute;
            width: 100%;
            height: 100%;
            background: radial-gradient(circle, var(--glow-color), transparent 70%);
            border-radius: 50%;
            animation: glow 3s infinite alternate;
        }

        .animated-grid {
            position: absolute;
            width: 100%;
            height: 100%;
            background: repeating-linear-gradient(
                    45deg,
                    transparent,
                    transparent 25%,
                    var(--glow-color) 25%,
                    var(--glow-color) 50%
            );
            background-size: 20px 20px;
            animation: moveGrid 5s linear infinite;
        }

        /* Animations */
        @keyframes slideInLeft {
            from {
                transform: translateX(-100px);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

        @keyframes slideInRight {
            from {
                transform: translateX(100px);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

        @keyframes glow {
            0% {
                opacity: 0.6;
            }
            100% {
                opacity: 1;
            }
        }

        @keyframes moveGrid {
            0% {
                background-position: 0 0;
            }
            100% {
                background-position: 40px 40px;
            }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .hero {
                flex-direction: column;
                text-align: center;
            }

            .hero-visual {
                width: 300px;
                height: 300px;
                margin-top: 30px;
            }

            .hero-title {
                font-size: 2.5rem;
            }

            .hero-subtext {
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>

<!-- Header Section -->
<header class="header">
    <div class="container">
        <div class="logo">
            <link rel="icon" type="image/png" href="./images/favicon-32x32.png">
            <span>NexoraSkill</span>
        </div>

        <div class="logo">
            <img src="./images/favicon-32x32.png" alt="NexoraSkill Logo">
        </div>
        <nav class="navbar">
            <ul>
                <li><a href="#home">Home</a></li>
                <li><a href="courses.jsp">Courses</a></li>
                <li><a href="registration.jsp">Registration</a></li>
                <li><a href="aboutus.jsp">About Us</a></li>
                <li><a href="contact.jsp">Contact</a></li>
            </ul>
        </nav>
        <div class="auth-buttons">
            <a href="logIn.jsp" class="btn-login">Login</a>
            <a href="signUp.jsp" class="btn-signup">Sign Up</a>
        </div>
    </div>
</header>

<!-- Hero Section -->
<section class="hero">
    <div class="hero-content">
        <h1 class="hero-title">Welcome to NexoraSkill</h1>
        <p class="hero-subtext">Your gateway to mastering new skills and achieving your goals.</p>
        <div class="hero-cta">
            <a href="${pageContext.request.contextPath}/courses.jsp" class="cta-button primary-cta">Explore Courses</a>
            <a href="${pageContext.request.contextPath}/registration.jsp" class="cta-button secondary-cta">Register Now</a>
        </div>
    </div>
    <div class="hero-visual">
        <link rel="icon" type="image/png" href="./images/favicon-32x32.png">
        <div class="glowing-circle"></div>
        <div class="animated-grid"></div>
    </div>
</section>

<!-- Ensure FontAwesome is included -->
<script src="https://kit.fontawesome.com/YOUR-KIT-ID.js" crossorigin="anonymous"></script>
</body>
</html>