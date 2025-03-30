<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires", "0");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="NexoraSkill - Your gateway to mastering new skills and achieving your goals">
    <title>NexoraSkill - Student Course Registration System</title>

    <!-- Preload critical resources -->
    <link rel="preload" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" as="style">
    <link rel="preload" href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" as="style">

    <!-- Favicon -->
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon-32x32.png">

    <!-- CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        /* CSS Variables */
        :root {
            --primary-color: #009acd;
            --secondary-color: #00ffcc;
            --accent-color: #ff6b6b;
            --dark-color: #0a192f;
            --text-color: #ffffff;
            --hover-color: #007ba7;
            --glow-color: rgba(0, 255, 204, 0.6);
            --transition-speed: 0.3s;
        }

        /* Base Styles */
        *, *::before, *::after {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: var(--dark-color);
            color: var(--text-color);
            line-height: 1.6;
            overflow-x: hidden;
            min-height: 100vh;
        }

        /* Header Styles */
        .header {
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1000;
            background: var(--dark-color);
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
        }

        .container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1.25rem 2rem;
            max-width: 1200px;
            margin: 0 auto;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 0.625rem;
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--text-color);
            text-decoration: none;
        }

        .logo img {
            height: 2.5rem;
            transition: transform var(--transition-speed) ease;
        }

        .logo:hover img {
            transform: rotate(15deg);
        }

        .navbar ul {
            list-style: none;
            display: flex;
            gap: 1.25rem;
        }

        .navbar ul li a {
            font-weight: 500;
            text-decoration: none;
            color: var(--text-color);
            transition: color var(--transition-speed) ease;
            position: relative;
            padding: 0.5rem 0;
        }

        .navbar ul li a::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 0;
            height: 2px;
            background: var(--primary-color);
            transition: width var(--transition-speed) ease;
        }

        .navbar ul li a:hover {
            color: var(--primary-color);
        }

        .navbar ul li a:hover::after {
            width: 100%;
        }

        .auth-buttons {
            display: flex;
            gap: 0.625rem;
        }

        .btn {
            padding: 0.625rem 1.25rem;
            border-radius: 1.5625rem;
            text-decoration: none;
            font-weight: 500;
            transition: all var(--transition-speed) ease;
            display: inline-block;
            text-align: center;
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
            transform: translateY(-2px);
        }

        /* Hero Section */
        .hero {
            display: flex;
            justify-content: space-between;
            align-items: center;
            min-height: 100vh;
            padding: 6rem 5% 2rem;
            position: relative;
        }

        .hero-content {
            max-width: 37.5rem;
            animation: slideInLeft 1s ease;
        }

        .hero-title {
            font-size: clamp(2.5rem, 5vw, 3.5rem);
            margin-bottom: 1.25rem;
            color: var(--text-color);
            line-height: 1.2;
        }

        .hero-title span {
            color: var(--secondary-color);
            text-shadow: 0 0 0.625rem var(--glow-color);
        }

        .hero-subtext {
            font-size: 1.2rem;
            margin-bottom: 1.875rem;
            color: var(--text-color);
            opacity: 0.9;
        }

        .hero-cta {
            display: flex;
            gap: 1.25rem;
        }

        .cta-button {
            padding: 0.75rem 1.5rem;
            border-radius: 1.5625rem;
            text-decoration: none;
            font-weight: 600;
            transition: all var(--transition-speed) ease;
        }

        .primary-cta {
            background: var(--primary-color);
            color: var(--dark-color);
        }

        .primary-cta:hover {
            background: var(--hover-color);
            transform: translateY(-0.3125rem);
            box-shadow: 0 0.3125rem 1.25rem var(--glow-color);
        }

        .secondary-cta {
            background: transparent;
            border: 2px solid var(--primary-color);
            color: var(--text-color);
        }

        .secondary-cta:hover {
            background: var(--primary-color);
            color: var(--dark-color);
            transform: translateY(-0.3125rem);
        }

        .hero-visual {
            position: relative;
            width: 31.25rem;
            height: 31.25rem;
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
            background-size: 1.25rem 1.25rem;
            animation: moveGrid 5s linear infinite;
            opacity: 0.3;
        }

        /* Animations */
        @keyframes slideInLeft {
            from {
                transform: translateX(-6.25rem);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

        @keyframes slideInRight {
            from {
                transform: translateX(6.25rem);
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
                transform: scale(0.98);
            }
            100% {
                opacity: 1;
                transform: scale(1);
            }
        }

        @keyframes moveGrid {
            0% {
                background-position: 0 0;
            }
            100% {
                background-position: 2.5rem 2.5rem;
            }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                padding: 1rem;
                flex-wrap: wrap;
            }

            .navbar {
                order: 3;
                width: 100%;
                margin-top: 1rem;
            }

            .navbar ul {
                justify-content: center;
            }

            .hero {
                flex-direction: column;
                text-align: center;
                padding-top: 8rem;
            }

            .hero-content {
                margin-bottom: 3rem;
            }

            .hero-cta {
                justify-content: center;
            }

            .hero-visual {
                width: 18.75rem;
                height: 18.75rem;
            }
        }

        @media (max-width: 480px) {
            .hero-title {
                font-size: 2rem;
            }

            .hero-subtext {
                font-size: 1rem;
            }

            .hero-cta {
                flex-direction: column;
                gap: 0.625rem;
            }

            .cta-button {
                width: 100%;
            }
        }
    </style>
</head>
<body>

<!-- Header Section -->
<header class="header">
    <div class="container">
        <a href="${pageContext.request.contextPath}/" class="logo">
            <img src="${pageContext.request.contextPath}/images/favicon-32x32.png" alt="NexoraSkill Logo">
            <span>NexoraSkill</span>
        </a>

        <nav class="navbar">
            <ul>
                <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/courses.jsp">Courses</a></li>
                <li><a href="${pageContext.request.contextPath}/registration.jsp">Registration</a></li>
                <li><a href="${pageContext.request.contextPath}/aboutus.jsp">About Us</a></li>
                <li><a href="${pageContext.request.contextPath}/contact.jsp">Contact</a></li>
            </ul>
        </nav>
        <div class="auth-buttons">
            <a href="${pageContext.request.contextPath}/logIn.jsp" class="btn btn-login">Login</a>
            <a href="${pageContext.request.contextPath}/signUp.jsp" class="btn btn-signup">Sign Up</a>
        </div>
    </div>
</header>

<!-- Hero Section -->
<section class="hero">
    <div class="hero-content">
        <h1 class="hero-title">Welcome to <span>NexoraSkill</span></h1>
        <p class="hero-subtext">Your gateway to mastering new skills and achieving your goals.</p>
        <div class="hero-cta">
            <a href="${pageContext.request.contextPath}/courses.jsp" class="cta-button primary-cta">Explore Courses</a>
            <a href="${pageContext.request.contextPath}/registration.jsp" class="cta-button secondary-cta">Register Now</a>
        </div>
    </div>
    <div class="hero-visual">
        <div class="glowing-circle"></div>
        <div class="animated-grid"></div>
    </div>
</section>

<!-- FontAwesome -->
<script src="https://kit.fontawesome.com/YOUR-KIT-ID.js" crossorigin="anonymous"></script>

<!-- Optional: Lazy load non-critical resources -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Lazy load any non-critical resources here
    });
</script>
</body>
</html>