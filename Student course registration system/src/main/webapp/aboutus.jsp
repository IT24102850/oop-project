<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - NexoraSkill</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.ico">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Orbitron:wght@400;500;600;700&display=swap" rel="stylesheet">
    <!-- Animate.css -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <style>
        :root {
            --primary-color: #00f2fe;
            --secondary-color: #4facfe;
            --accent-color: #ff4d7e;
            --dark-color: #0a0f24;
            --darker-color: #050916;
            --text-color: #ffffff;
            --text-muted: rgba(255,255,255,0.7);
            --hover-color: #00c6fb;
            --glow-color: rgba(0, 242, 254, 0.6);
            --card-bg: rgba(15, 23, 42, 0.8);
            --glass-bg: rgba(255, 255, 255, 0.08);
            --border-radius: 16px;
            --box-shadow: 0 12px 40px rgba(0, 0, 0, 0.4);
            --transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: radial-gradient(ellipse at bottom, var(--darker-color) 0%, var(--dark-color) 100%);
            color: var(--text-color);
            overflow-x: hidden;
            line-height: 1.7;
            scroll-behavior: smooth;
        }

        h1, h2, h3 {
            font-family: 'Orbitron', sans-serif;
            font-weight: 700;
            letter-spacing: 1.5px;
            text-transform: uppercase;
        }

        ::selection {
            background: var(--primary-color);
            color: var(--dark-color);
        }

        /* Preloader */
        .preloader {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: var(--darker-color);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 9999;
            transition: opacity 0.5s ease;
        }

        .preloader.fade-out {
            opacity: 0;
        }

        .loader {
            width: 80px;
            height: 80px;
            border: 5px solid transparent;
            border-top-color: var(--primary-color);
            border-bottom-color: var(--primary-color);
            border-radius: 50%;
            animation: spin 1.5s linear infinite;
            position: relative;
        }

        .loader:before {
            content: '';
            position: absolute;
            top: 10px;
            left: 10px;
            right: 10px;
            bottom: 10px;
            border: 5px solid transparent;
            border-top-color: var(--secondary-color);
            border-bottom-color: var(--secondary-color);
            border-radius: 50%;
            animation: spin 1s linear infinite reverse;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Header Section - Holographic Effect */
        .header {
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1000;
            background: var(--glass-bg);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            border-bottom: 1px solid rgba(0, 242, 254, 0.1);
            box-shadow: 0 5px 30px rgba(0, 0, 0, 0.2);
            transition: var(--transition);
        }

        .header.scrolled {
            padding: 10px 0;
            background: rgba(10, 15, 36, 0.95);
        }

        .container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 5%;
            max-width: 1600px;
            margin: 0 auto;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 15px;
            font-size: 2rem;
            font-weight: 700;
            color: var(--text-color);
            text-decoration: none;
            transition: var(--transition);
            position: relative;
        }

        .logo:hover {
            color: var(--primary-color);
            transform: scale(1.05);
        }

        .logo img {
            height: 45px;
            transition: var(--transition);
            filter: drop-shadow(0 0 5px var(--glow-color));
        }

        .logo:hover img {
            transform: rotate(15deg) scale(1.1);
            filter: drop-shadow(0 0 10px var(--glow-color));
        }

        .navbar ul {
            list-style: none;
            display: flex;
            gap: 35px;
        }

        .navbar ul li a {
            position: relative;
            font-family: 'Poppins', sans-serif;
            text-decoration: none;
            color: var(--text-color);
            font-weight: 500;
            font-size: 1.1rem;
            transition: var(--transition);
            padding: 8px 0;
            overflow: hidden;
        }

        .navbar ul li a:before {
            content: '';
            position: absolute;
            width: 100%;
            height: 2px;
            bottom: 0;
            left: -100%;
            background: linear-gradient(90deg, transparent, var(--primary-color));
            transition: var(--transition);
        }

        .navbar ul li a:hover {
            color: var(--primary-color);
            text-shadow: 0 0 10px var(--glow-color);
        }

        .navbar ul li a:hover:before {
            left: 100%;
        }

        .navbar ul li a.active {
            color: var(--primary-color);
            text-shadow: 0 0 10px var(--glow-color);
        }

        .auth-buttons {
            display: flex;
            gap: 20px;
        }

        .btn {
            padding: 14px 32px;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 600;
            transition: var(--transition);
            font-size: 1rem;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            position: relative;
            overflow: hidden;
            z-index: 1;
        }

        .btn:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 0;
            height: 100%;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            transition: var(--transition);
            z-index: -1;
        }

        .btn:hover:before {
            width: 100%;
        }

        .btn-login {
            background: transparent;
            border: 2px solid var(--primary-color);
            color: var(--text-color);
        }

        .btn-login:hover {
            color: var(--dark-color);
            border-color: transparent;
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0, 242, 254, 0.3);
        }

        .btn-signup {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: var(--dark-color);
            border: 2px solid transparent;
        }

        .btn-signup:hover {
            background: transparent;
            color: var(--primary-color);
            border-color: var(--primary-color);
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0, 242, 254, 0.3);
        }

        /* About Us Section - Futuristic Design */
        .about-us {
            padding: 180px 5% 100px;
            position: relative;
            overflow: hidden;
            min-height: 100vh;
        }

        .about-us:before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(0, 242, 254, 0.05) 0%, transparent 70%);
            animation: rotate 60s linear infinite;
            z-index: -1;
        }

        .section-title {
            text-align: center;
            font-size: 3.5rem;
            margin-bottom: 50px;
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-shadow: 0 0 30px rgba(0, 242, 254, 0.3);
            animation: textGlow 3s infinite alternate;
            position: relative;
        }

        .section-title:after {
            content: '';
            position: absolute;
            bottom: -20px;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            border-radius: 2px;
        }

        .section-description {
            font-size: 1.4rem;
            max-width: 800px;
            margin: 0 auto 60px;
            color: var(--text-muted);
            text-align: center;
            animation: fadeInUp 1s ease-out 0.2s both;
        }

        /* Mission Vision Section */
        .mission-vision {
            display: flex;
            justify-content: space-between;
            gap: 40px;
            max-width: 1200px;
            margin: 0 auto 80px;
        }

        .mission-card, .vision-card {
            flex: 1;
            background: var(--card-bg);
            backdrop-filter: blur(10px);
            border-radius: var(--border-radius);
            padding: 50px 40px;
            text-align: center;
            transition: var(--transition);
            border: 1px solid rgba(0, 242, 254, 0.2);
            box-shadow: var(--box-shadow);
            position: relative;
            overflow: hidden;
            z-index: 1;
            animation: fadeInUp 1s ease-out;
        }

        .mission-card:before, .vision-card:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(0, 242, 254, 0.1), transparent);
            z-index: -1;
            opacity: 0;
            transition: var(--transition);
        }

        .mission-card:hover, .vision-card:hover {
            transform: translateY(-15px);
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.5);
            border-color: rgba(0, 242, 254, 0.4);
        }

        .mission-card:hover:before, .vision-card:hover:before {
            opacity: 1;
        }

        .mission-icon, .vision-icon {
            font-size: 4rem;
            margin-bottom: 30px;
            color: var(--primary-color);
            transition: var(--transition);
        }

        .mission-card:hover .mission-icon, .vision-card:hover .vision-icon {
            transform: scale(1.2);
            filter: drop-shadow(0 0 10px var(--glow-color));
        }

        .mission-title, .vision-title {
            font-size: 1.8rem;
            margin-bottom: 20px;
            color: var(--text-color);
            transition: var(--transition);
        }

        .mission-card:hover .mission-title, .vision-card:hover .vision-title {
            color: var(--primary-color);
        }

        .mission-text, .vision-text {
            color: var(--text-muted);
            font-size: 1.1rem;
            transition: var(--transition);
        }

        .mission-card:hover .mission-text, .vision-card:hover .vision-text {
            color: var(--text-color);
        }

        /* Features Grid */
        .features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 40px;
            max-width: 1300px;
            margin: 0 auto;
        }

        .feature-item {
            background: var(--card-bg);
            backdrop-filter: blur(10px);
            border-radius: var(--border-radius);
            padding: 50px 40px;
            text-align: center;
            transition: var(--transition);
            border: 1px solid rgba(0, 242, 254, 0.2);
            box-shadow: var(--box-shadow);
            position: relative;
            overflow: hidden;
            z-index: 1;
            animation: fadeInUp 1s ease-out;
        }

        .feature-item:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(0, 242, 254, 0.1), transparent);
            z-index: -1;
            opacity: 0;
            transition: var(--transition);
        }

        .feature-item:hover {
            transform: translateY(-15px);
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.5);
            border-color: rgba(0, 242, 254, 0.4);
        }

        .feature-item:hover:before {
            opacity: 1;
        }

        .feature-icon {
            font-size: 3rem;
            margin-bottom: 30px;
            color: var(--primary-color);
            transition: var(--transition);
        }

        .feature-item:hover .feature-icon {
            transform: scale(1.2);
            filter: drop-shadow(0 0 10px var(--glow-color));
        }

        .feature-title {
            font-size: 1.5rem;
            margin-bottom: 20px;
            color: var(--text-color);
            transition: var(--transition);
        }

        .feature-item:hover .feature-title {
            color: var(--primary-color);
        }

        .feature-description {
            color: var(--text-muted);
            font-size: 1.1rem;
            transition: var(--transition);
        }

        .feature-item:hover .feature-description {
            color: var(--text-color);
        }

        /* Team Section */
        .team-section {
            padding: 100px 5%;
            text-align: center;
            position: relative;
        }

        .team-members {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 30px;
            max-width: 1200px;
            margin: 50px auto 0;
        }

        .team-member {
            background: var(--card-bg);
            backdrop-filter: blur(10px);
            border-radius: var(--border-radius);
            padding: 30px;
            transition: var(--transition);
            border: 1px solid rgba(0, 242, 254, 0.2);
            box-shadow: var(--box-shadow);
            position: relative;
            overflow: hidden;
        }

        .team-member:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
            border-color: rgba(0, 242, 254, 0.4);
        }

        .member-image {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            margin: 0 auto 20px;
            overflow: hidden;
            border: 3px solid var(--primary-color);
            position: relative;
        }

        .member-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: var(--transition);
        }

        .team-member:hover .member-image img {
            transform: scale(1.1);
        }

        .member-name {
            font-size: 1.5rem;
            margin-bottom: 10px;
            color: var(--primary-color);
        }

        .member-position {
            color: var(--text-muted);
            margin-bottom: 15px;
            font-size: 1rem;
        }

        .member-social {
            display: flex;
            justify-content: center;
            gap: 15px;
        }

        .social-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: var(--glass-bg);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--text-color);
            transition: var(--transition);
            border: 1px solid rgba(0, 242, 254, 0.1);
        }

        .social-icon:hover {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: var(--dark-color);
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 242, 254, 0.3);
            border-color: transparent;
        }

        /* Footer - Holographic Grid */
        .footer {
            background: var(--darker-color);
            padding: 100px 5% 50px;
            border-top: 1px solid rgba(0, 242, 254, 0.1);
            position: relative;
            overflow: hidden;
        }

        .footer:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('./images/grid-pattern.png') center/cover;
            opacity: 0.03;
            z-index: 0;
        }

        .footer-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 50px;
            max-width: 1300px;
            margin: 0 auto 60px;
            position: relative;
            z-index: 1;
        }

        .footer-col {
            position: relative;
        }

        .footer-logo {
            font-size: 2.2rem;
            font-weight: 700;
            margin-bottom: 25px;
            display: inline-block;
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            position: relative;
        }

        .footer-logo:after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 60px;
            height: 3px;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            border-radius: 2px;
        }

        .footer-about {
            color: var(--text-muted);
            margin-bottom: 30px;
            font-size: 1.1rem;
            line-height: 1.8;
        }

        .social-links {
            display: flex;
            gap: 20px;
        }

        .social-link {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: var(--glass-bg);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--text-color);
            transition: var(--transition);
            font-size: 1.3rem;
            border: 1px solid rgba(0, 242, 254, 0.1);
        }

        .social-link:hover {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: var(--dark-color);
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 242, 254, 0.3);
            border-color: transparent;
        }

        .footer-title {
            font-size: 1.5rem;
            margin-bottom: 30px;
            color: var(--text-color);
            position: relative;
            padding-bottom: 15px;
        }

        .footer-title:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 50px;
            height: 2px;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            border-radius: 2px;
        }

        .footer-links {
            list-style: none;
        }

        .footer-links li {
            margin-bottom: 20px;
            position: relative;
            padding-left: 20px;
        }

        .footer-links li:before {
            content: '»';
            position: absolute;
            left: 0;
            color: var(--primary-color);
            transition: var(--transition);
        }

        .footer-links a {
            color: var(--text-muted);
            text-decoration: none;
            transition: var(--transition);
            font-size: 1.1rem;
            display: inline-block;
        }

        .footer-links li:hover:before {
            transform: translateX(5px);
        }

        .footer-links a:hover {
            color: var(--primary-color);
            transform: translateX(5px);
        }

        .footer-bottom {
            text-align: center;
            padding-top: 50px;
            border-top: 1px solid rgba(0, 242, 254, 0.1);
            color: var(--text-muted);
            font-size: 1rem;
            position: relative;
            z-index: 1;
        }

        .footer-bottom a {
            color: var(--primary-color);
            text-decoration: none;
            transition: var(--transition);
        }

        .footer-bottom a:hover {
            text-shadow: 0 0 10px var(--glow-color);
        }

        /* Scroll To Top Button */
        .scroll-top {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: var(--dark-color);
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 1.5rem;
            cursor: pointer;
            transition: var(--transition);
            box-shadow: 0 5px 20px rgba(0, 242, 254, 0.4);
            z-index: 999;
            opacity: 0;
            visibility: hidden;
            transform: translateY(20px);
        }

        .scroll-top.active {
            opacity: 1;
            visibility: visible;
            transform: translateY(0);
        }

        .scroll-top:hover {
            transform: translateY(-5px) scale(1.1);
            box-shadow: 0 10px 25px rgba(0, 242, 254, 0.6);
        }

        /* Animations */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeInRight {
            from {
                opacity: 0;
                transform: translateX(50px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes float {
            0% {
                transform: translateY(0) rotate(0deg);
            }
            50% {
                transform: translateY(-20px) rotate(5deg);
            }
            100% {
                transform: translateY(0) rotate(0deg);
            }
        }

        @keyframes textGlow {
            0% {
                text-shadow: 0 0 10px rgba(0, 242, 254, 0.3);
            }
            100% {
                text-shadow: 0 0 30px rgba(0, 242, 254, 0.6);
            }
        }

        @keyframes rotate {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Responsive Design */
        @media (max-width: 1200px) {
            .section-title {
                font-size: 3rem;
            }
        }

        @media (max-width: 992px) {
            .mission-vision {
                flex-direction: column;
            }

            .section-title {
                font-size: 2.5rem;
                margin-bottom: 40px;
            }
        }

        @media (max-width: 768px) {
            .navbar {
                display: none;
            }

            .section-title {
                font-size: 2.2rem;
            }

            .section-description {
                font-size: 1.2rem;
            }

            .features {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 576px) {
            .auth-buttons {
                display: none;
            }

            .section-title {
                font-size: 1.8rem;
            }

            .section-description {
                font-size: 1.1rem;
            }
        }
    </style>
</head>
<body>
<!-- Preloader -->
<div class="preloader">
    <div class="loader"></div>
</div>

<!-- Header Section -->
<header class="header">
    <div class="container">
        <a href="#" class="logo">
            <img src="./images/favicon-32x32.png" alt="NexoraSkill Logo">
            <span>NexoraSkill</span>
        </a>

        <nav class="navbar">
            <ul>
                <li><a href="index.jsp">Home</a></li>
                <li><a href="courses.jsp">Courses</a></li>
                <li><a href="Apply%20Course.jsp">Registration</a></li>
                <li><a href="aboutus.jsp" class="active">About Us</a></li>
                <li><a href="contact.jsp">Contact</a></li>
            </ul>
        </nav>
        <div class="auth-buttons">
            <a href="logIn.jsp" class="btn btn-login"><i class="fas fa-sign-in-alt"></i> Login</a>
            <a href="signUp.jsp" class="btn btn-signup"><i class="fas fa-user-plus"></i> Sign Up</a>
        </div>
    </div>
</header>

<!-- About Us Section -->
<section class="about-us">
    <div class="container">
        <h2 class="section-title animate_animated animate_fadeInUp">About NexoraSkill</h2>
        <p class="section-description">
            We are revolutionizing education through cutting-edge technology and immersive learning experiences.
            Our platform bridges the gap between traditional education and the skills needed for tomorrow's workforce.
        </p>

        <div class="mission-vision">
            <div class="mission-card animate_animated animate_fadeInUp" style="animation-delay: 0.2s">
                <div class="mission-icon">
                    <i class="fas fa-bullseye"></i>
                </div>
                <h3 class="mission-title">Our Mission</h3>
                <p class="mission-text">
                    To democratize access to high-quality tech education and empower individuals worldwide
                    with future-ready skills through innovative learning experiences.
                </p>
            </div>

            <div class="vision-card animate_animated animate_fadeInUp" style="animation-delay: 0.4s">
                <div class="vision-icon">
                    <i class="fas fa-eye"></i>
                </div>
                <h3 class="vision-title">Our Vision</h3>
                <p class="vision-text">
                    To create a world where anyone, anywhere can transform their life by gaining
                    the digital skills needed for the careers of the future.
                </p>
            </div>
        </div>

        <h3 class="section-title animate_animated animate_fadeInUp" style="animation-delay: 0.6s">Why Choose Us?</h3>

        <div class="features">
            <div class="feature-item animate_animated animate_fadeInUp" style="animation-delay: 0.2s">
                <div class="feature-icon">
                    <i class="fas fa-bolt"></i>
                </div>
                <h3 class="feature-title">Cutting-Edge Curriculum</h3>
                <p class="feature-description">
                    Our courses are continuously updated to reflect the latest industry trends and technologies,
                    ensuring you learn the most relevant skills.
                </p>
            </div>

            <div class="feature-item animate_animated animate_fadeInUp" style="animation-delay: 0.4s">
                <div class="feature-icon">
                    <i class="fas fa-chalkboard-teacher"></i>
                </div>
                <h3 class="feature-title">Expert Instructors</h3>
                <p class="feature-description">
                    Learn from industry professionals and tech leaders who bring real-world experience
                    into every lesson.
                </p>
            </div>

            <div class="feature-item animate_animated animate_fadeInUp" style="animation-delay: 0.6s">
                <div class="feature-icon">
                    <i class="fas fa-laptop-code"></i>
                </div>
                <h3 class="feature-title">Hands-On Learning</h3>
                <p class="feature-description">
                    Our interactive platform provides practical experience through projects,
                    labs, and real-world simulations.
                </p>
            </div>

            <div class="feature-item animate_animated animate_fadeInUp" style="animation-delay: 0.8s">
                <div class="feature-icon">
                    <i class="fas fa-user-graduate"></i>
                </div>
                <h3 class="feature-title">Career Support</h3>
                <p class="feature-description">
                    Get career guidance, resume reviews, and interview preparation to help
                    you land your dream job.
                </p>
            </div>

            <div class="feature-item animate_animated animate_fadeInUp" style="animation-delay: 1.0s">
                <div class="feature-icon">
                    <i class="fas fa-globe"></i>
                </div>
                <h3 class="feature-title">Global Community</h3>
                <p class="feature-description">
                    Join a network of thousands of learners and professionals from around
                    the world.
                </p>
            </div>

            <div class="feature-item animate_animated animate_fadeInUp" style="animation-delay: 1.2s">
                <div class="feature-icon">
                    <i class="fas fa-headset"></i>
                </div>
                <h3 class="feature-title">24/7 Support</h3>
                <p class="feature-description">
                    Our dedicated support team is available around the clock to assist you
                    with any questions.
                </p>
            </div>
        </div>
    </div>
</section>

<!-- Team Section -->
<section class="team-section">
    <div class="container">
        <h2 class="section-title animate_animated animate_fadeInUp">Meet Our Team</h2>
        <p class="section-description">
            The brilliant minds behind NexoraSkill who are passionate about transforming education.
        </p>

        <div class="team-members">
            <div class="team-member animate_animated animate_fadeInUp" style="animation-delay: 0.2s">
                <div class="member-image">
                    <img src="https://randomuser.me/api/portraits/women/32.jpg" alt="Sarah Johnson">
                </div>
                <h3 class="member-name">Sarah Johnson</h3>
                <p class="member-position">Founder & CEO</p>
                <div class="member-social">
                    <a href="#" class="social-icon"><i class="fab fa-linkedin-in"></i></a>
                    <a href="#" class="social-icon"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="social-icon"><i class="fas fa-envelope"></i></a>
                </div>
            </div>

            <div class="team-member animate_animated animate_fadeInUp" style="animation-delay: 0.4s">
                <div class="member-image">
                    <img src="https://randomuser.me/api/portraits/men/45.jpg" alt="Michael Chen">
                </div>
                <h3 class="member-name">Michael Chen</h3>
                <p class="member-position">CTO</p>
                <div class="member-social">
                    <a href="#" class="social-icon"><i class="fab fa-linkedin-in"></i></a>
                    <a href="#" class="social-icon"><i class="fab fa-github"></i></a>
                    <a href="#" class="social-icon"><i class="fas fa-envelope"></i></a>
                </div>
            </div>

            <div class="team-member animate_animated animate_fadeInUp" style="animation-delay: 0.6s">
                <div class="member-image">
                    <img src="https://randomuser.me/api/portraits/women/68.jpg" alt="Priya Patel">
                </div>
                <h3 class="member-name">Priya Patel</h3>
                <p class="member-position">Head of Education</p>
                <div class="member-social">
                    <a href="#" class="social-icon"><i class="fab fa-linkedin-in"></i></a>
                    <a href="#" class="social-icon"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="social-icon"><i class="fas fa-envelope"></i></a>
                </div>
            </div>

            <div class="team-member animate_animated animate_fadeInUp" style="animation-delay: 0.8s">
                <div class="member-image">
                    <img src="https://randomuser.me/api/portraits/men/22.jpg" alt="David Kim">
                </div>
                <h3 class="member-name">David Kim</h3>
                <p class="member-position">Lead Instructor</p>
                <div class="member-social">
                    <a href="#" class="social-icon"><i class="fab fa-linkedin-in"></i></a>
                    <a href="#" class="social-icon"><i class="fab fa-github"></i></a>
                    <a href="#" class="social-icon"><i class="fas fa-envelope"></i></a>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="footer">
    <div class="footer-grid">
        <div class="footer-col">
            <a href="#" class="footer-logo">NexoraSkill</a>
            <p class="footer-about">The premier platform for future-ready education. We're revolutionizing how the world learns technology through immersive, interactive experiences.</p>
            <div class="social-links">
                <a href="#" class="social-link"><i class="fab fa-facebook-f"></i></a>
                <a href="#" class="social-link"><i class="fab fa-twitter"></i></a>
                <a href="#" class="social-link"><i class="fab fa-linkedin-in"></i></a>
                <a href="#" class="social-link"><i class="fab fa-instagram"></i></a>
                <a href="#" class="social-link"><i class="fab fa-youtube"></i></a>
            </div>
        </div>
        <div class="footer-col">
            <h3 class="footer-title">Quick Links</h3>
            <ul class="footer-links">
                <li><a href="index.jsp">Home</a></li>
                <li><a href="courses.jsp">Courses</a></li>
                <li><a href="registration.jsp">Registration</a></li>
                <li><a href="aboutus.jsp">About Us</a></li>
                <li><a href="contact.jsp">Contact</a></li>
            </ul>
        </div>
        <div class="footer-col">
            <h3 class="footer-title">Tech Tracks</h3>
            <ul class="footer-links">
                <li><a href="#">AI & Machine Learning</a></li>
                <li><a href="#">Blockchain Development</a></li>
                <li><a href="#">Quantum Computing</a></li>
                <li><a href="#">Cybersecurity</a></li>
                <li><a href="#">Cloud Architecture</a></li>
            </ul>
        </div>
        <div class="footer-col">
            <h3 class="footer-title">Company</h3>
            <ul class="footer-links">
                <li><a href="#">Careers</a></li>
                <li><a href="#">Press</a></li>
                <li><a href="#">Investors</a></li>
                <li><a href="#">Privacy Policy</a></li>
                <li><a href="#">Terms of Service</a></li>
            </ul>
        </div>
    </div>
    <div class="footer-bottom">
        <p>&copy; 2023 NexoraSkill. All rights reserved. | Designed with <i class="fas fa-heart" style="color: var(--accent-color);"></i> for the future of education</p>
    </div>
</footer>

<!-- Scroll To Top Button -->
<div class="scroll-top">
    <i class="fas fa-arrow-up"></i>
</div>

<!-- Scripts -->
<script>
    // Preloader
    window.addEventListener('load', function() {
        const preloader = document.querySelector('.preloader');
        preloader.classList.add('fade-out');
        setTimeout(() => {
            preloader.style.display = 'none';
        }, 500);
    });

    // Header Scroll Effect
    window.addEventListener('scroll', function() {
        const header = document.querySelector('.header');
        if (window.scrollY > 100) {
            header.classList.add('scrolled');
        } else {
            header.classList.remove('scrolled');
        }
    });

    // Scroll To Top Button
    const scrollTop = document.querySelector('.scroll-top');
    window.addEventListener('scroll', function() {
        if (window.scrollY > 300) {
            scrollTop.classList.add('active');
        } else {
            scrollTop.classList.remove('active');
        }
    });

    scrollTop.addEventListener('click', function() {
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    });

    // Smooth scrolling for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function(e) {
            e.preventDefault();
            document.querySelector(this.getAttribute('href')).scrollIntoView({
                behavior: 'smooth'
            });
        });
    });

    // Animation on scroll
    const animateElements = document.querySelectorAll('.animate__animated');

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add(entry.target.dataset.animation);
                observer.unobserve(entry.target);
            }
        });
    }, {
        threshold: 0.1
    });

    animateElements.forEach(element => {
        observer.observe(element);
    });
</script>
</body>
</html>