<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Courses - NexoraSkill | Future-Ready Education Platform</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="icon" type="image/png" href="./images/favicon.ico">
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

        /* Header Section - Same as index.jsp */
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

        .logo:after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: 0;
            width: 0;
            height: 2px;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            transition: var(--transition);
        }

        .logo:hover:after {
            width: 100%;
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

        .navbar ul li a.active {
            color: var(--primary-color);
            text-shadow: 0 0 10px var(--glow-color);
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

        /* Hero Section for Courses Page */
        .courses-hero {
            min-height: 60vh;
            padding: 180px 5% 100px;
            position: relative;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
        }

        .courses-hero:before {
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

        .courses-hero h1 {
            font-size: 4.5rem;
            margin-bottom: 30px;
            line-height: 1.2;
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-shadow: 0 0 30px rgba(0, 242, 254, 0.3);
            animation: textGlow 3s infinite alternate;
            position: relative;
        }

        .courses-hero h1:after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            border-radius: 2px;
        }

        .courses-hero p {
            font-size: 1.4rem;
            margin-bottom: 40px;
            color: var(--text-muted);
            max-width: 800px;
        }

        /* Courses Grid Section */
        .courses-section {
            padding: 100px 5%;
            position: relative;
            z-index: 2;
        }

        .courses-section:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('./images/grid-pattern.png') center/cover;
            opacity: 0.05;
            z-index: -1;
        }

        .section-title {
            text-align: center;
            font-size: 3rem;
            margin-bottom: 80px;
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            position: relative;
            animation: fadeInUp 1s ease-out;
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

        .courses-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 40px;
            max-width: 1300px;
            margin: 0 auto;
        }

        .course-card {
            background: var(--card-bg);
            backdrop-filter: blur(10px);
            border-radius: var(--border-radius);
            overflow: hidden;
            transition: var(--transition);
            border: 1px solid rgba(0, 242, 254, 0.2);
            box-shadow: var(--box-shadow);
            position: relative;
            z-index: 1;
            animation: fadeInUp 1s ease-out;
        }

        .course-card:before {
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

        .course-card:hover {
            transform: translateY(-15px);
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.5);
            border-color: rgba(0, 242, 254, 0.4);
        }

        .course-card:hover:before {
            opacity: 1;
        }

        .course-image {
            height: 200px;
            width: 100%;
            object-fit: cover;
            border-bottom: 1px solid rgba(0, 242, 254, 0.2);
            transition: var(--transition);
        }

        .course-card:hover .course-image {
            transform: scale(1.05);
        }

        .course-content {
            padding: 30px;
        }

        .course-category {
            display: inline-block;
            padding: 5px 15px;
            background: rgba(0, 242, 254, 0.1);
            color: var(--primary-color);
            border-radius: 50px;
            font-size: 0.9rem;
            margin-bottom: 15px;
            transition: var(--transition);
        }

        .course-card:hover .course-category {
            background: rgba(0, 242, 254, 0.2);
        }

        .course-title {
            font-size: 1.8rem;
            margin-bottom: 15px;
            color: var(--text-color);
            transition: var(--transition);
        }

        .course-card:hover .course-title {
            color: var(--primary-color);
        }

        .course-description {
            color: var(--text-muted);
            margin-bottom: 25px;
            transition: var(--transition);
        }

        .course-card:hover .course-description {
            color: var(--text-color);
        }

        .course-meta {
            display: flex;
            justify-content: space-between;
            margin-bottom: 25px;
            color: var(--text-muted);
            font-size: 0.9rem;
            transition: var(--transition);
        }

        .course-card:hover .course-meta {
            color: var(--text-color);
        }

        .course-meta-item {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .course-btn {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 12px 25px;
            border-radius: 50px;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: var(--dark-color);
            text-decoration: none;
            font-weight: 600;
            transition: var(--transition);
            position: relative;
            overflow: hidden;
            z-index: 1;
        }

        .course-btn:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 0;
            height: 100%;
            background: linear-gradient(135deg, var(--secondary-color), var(--primary-color));
            transition: var(--transition);
            z-index: -1;
        }

        .course-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(0, 242, 254, 0.4);
        }

        .course-btn:hover:before {
            width: 100%;
        }

        /* Categories Filter */
        .categories-filter {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 60px;
            max-width: 900px;
            margin-left: auto;
            margin-right: auto;
        }

        .category-btn {
            padding: 10px 25px;
            border-radius: 50px;
            background: transparent;
            border: 1px solid rgba(0, 242, 254, 0.3);
            color: var(--text-muted);
            cursor: pointer;
            transition: var(--transition);
            font-family: 'Poppins', sans-serif;
            font-size: 1rem;
        }

        .category-btn:hover, .category-btn.active {
            background: rgba(0, 242, 254, 0.1);
            color: var(--primary-color);
            border-color: var(--primary-color);
            transform: translateY(-3px);
        }

        /* Footer - Same as index.jsp */
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
            .courses-hero h1 {
                font-size: 3.8rem;
            }
        }

        @media (max-width: 992px) {
            .courses-hero {
                padding-top: 200px;
                padding-bottom: 100px;
            }

            .courses-hero h1 {
                font-size: 3.5rem;
            }

            .section-title {
                font-size: 2.5rem;
                margin-bottom: 60px;
            }
        }

        @media (max-width: 768px) {
            .navbar {
                display: none;
            }

            .courses-hero h1 {
                font-size: 3rem;
            }

            .courses-hero p {
                font-size: 1.2rem;
            }

            .courses-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 576px) {
            .auth-buttons {
                display: none;
            }

            .courses-hero h1 {
                font-size: 2.5rem;
            }

            .courses-hero p {
                font-size: 1.1rem;
            }

            .section-title {
                font-size: 2rem;
            }

            .footer-logo {
                font-size: 1.8rem;
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
        <a href="index.jsp" class="logo">
            <img src="./images/favicon-32x32.png" alt="NexoraSkill Logo">
            <span>NexoraSkill</span>
        </a>

        <nav class="navbar">
            <ul>
                <li><a href="index.jsp">Home</a></li>
                <li><a href="courses.jsp" class="active">Courses</a></li>
                <li><a href="Apply%20Course.jsp">Registration</a></li>
                <li><a href="aboutus.jsp">About Us</a></li>
                <li><a href="contact.jsp">Contact</a></li>
            </ul>
        </nav>
        <div class="auth-buttons">
            <a href="logIn.jsp" class="btn btn-login"><i class="fas fa-sign-in-alt"></i> Login</a>
            <a href="signUp.jsp" class="btn btn-signup"><i class="fas fa-user-plus"></i> Sign Up</a>
        </div>
    </div>
</header>

<!-- Hero Section -->
<section class="courses-hero">
    <h1 class="animate__animated animate__fadeInDown">Explore Our Courses</h1>
    <p class="animate__animated animate__fadeInUp">Master cutting-edge technologies with our immersive learning experiences designed for the future.</p>
</section>

<!-- Courses Section -->
<section class="courses-section">
    <h2 class="section-title">Available Courses</h2>

    <div class="categories-filter">
        <button class="category-btn active" data-category="all">All Courses</button>
        <button class="category-btn" data-category="programming">Programming</button>
        <button class="category-btn" data-category="web">Web Development</button>
        <button class="category-btn" data-category="data">Data Science</button>
        <button class="category-btn" data-category="ai">AI & ML</button>
        <button class="category-btn" data-category="cyber">Cybersecurity</button>
        <button class="category-btn" data-category="mobile">Mobile Dev</button>
    </div>

    <div class="courses-grid">
        <!-- Course 1 -->
        <div class="course-card" data-category="programming">
            <img src="./images/course1.jpg" alt="Introduction to Programming" class="course-image">
            <div class="course-content">
                <span class="course-category">Programming</span>
                <h3 class="course-title">Introduction to Programming</h3>
                <p class="course-description">Learn the fundamentals of programming with Python in this comprehensive beginner's course.</p>
                <div class="course-meta">
                    <span class="course-meta-item"><i class="fas fa-clock"></i> 40 Hours</span>
                    <span class="course-meta-item"><i class="fas fa-user-graduate"></i> Beginner</span>
                </div>
                <a href="./courses/course1.html" class="course-btn">Enroll Now <i class="fas fa-arrow-right"></i></a>
            </div>
        </div>

        <!-- Course 2 -->
        <div class="course-card" data-category="web">
            <img src="./images/course2.jpg" alt="Web Development" class="course-image">
            <div class="course-content">
                <span class="course-category">Web Development</span>
                <h3 class="course-title">Modern Web Development</h3>
                <p class="course-description">Master HTML5, CSS3, JavaScript and modern frameworks to build responsive websites.</p>
                <div class="course-meta">
                    <span class="course-meta-item"><i class="fas fa-clock"></i> 60 Hours</span>
                    <span class="course-meta-item"><i class="fas fa-user-graduate"></i> Intermediate</span>
                </div>
                <a href="./courses/course2.html" class="course-btn">Enroll Now <i class="fas fa-arrow-right"></i></a>
            </div>
        </div>

        <!-- Course 3 -->
        <div class="course-card" data-category="data">
            <img src="./images/course3.jpg" alt="Data Science" class="course-image">
            <div class="course-content">
                <span class="course-category">Data Science</span>
                <h3 class="course-title">Data Science Fundamentals</h3>
                <p class="course-description">Explore data analysis, visualization and machine learning with Python and R.</p>
                <div class="course-meta">
                    <span class="course-meta-item"><i class="fas fa-clock"></i> 80 Hours</span>
                    <span class="course-meta-item"><i class="fas fa-user-graduate"></i> Intermediate</span>
                </div>
                <a href="./courses/course3.html" class="course-btn">Enroll Now <i class="fas fa-arrow-right"></i></a>
            </div>
        </div>

        <!-- Course 4 -->
        <div class="course-card" data-category="mobile">
            <img src="./images/course4.jpg" alt="Mobile App Development" class="course-image">
            <div class="course-content">
                <span class="course-category">Mobile Development</span>
                <h3 class="course-title">Flutter App Development</h3>
                <p class="course-description">Build cross-platform mobile apps using Flutter and Dart with this project-based course.</p>
                <div class="course-meta">
                    <span class="course-meta-item"><i class="fas fa-clock"></i> 50 Hours</span>
                    <span class="course-meta-item"><i class="fas fa-user-graduate"></i> Intermediate</span>
                </div>
                <a href="./courses/course4.html" class="course-btn">Enroll Now <i class="fas fa-arrow-right"></i></a>
            </div>
        </div>

        <!-- Course 5 -->
        <div class="course-card" data-category="cyber">
            <img src="./images/course5.jpg" alt="Cybersecurity" class="course-image">
            <div class="course-content">
                <span class="course-category">Cybersecurity</span>
                <h3 class="course-title">Ethical Hacking</h3>
                <p class="course-description">Learn penetration testing and ethical hacking techniques to secure systems.</p>
                <div class="course-meta">
                    <span class="course-meta-item"><i class="fas fa-clock"></i> 70 Hours</span>
                    <span class="course-meta-item"><i class="fas fa-user-graduate"></i> Advanced</span>
                </div>
                <a href="./courses/course5.html" class="course-btn">Enroll Now <i class="fas fa-arrow-right"></i></a>
            </div>
        </div>

        <!-- Course 6 -->
        <div class="course-card" data-category="ai">
            <img src="./images/course6.jpg" alt="AI & Machine Learning" class="course-image">
            <div class="course-content">
                <span class="course-category">AI & ML</span>
                <h3 class="course-title">Machine Learning</h3>
                <p class="course-description">Master machine learning algorithms and build AI models with TensorFlow and PyTorch.</p>
                <div class="course-meta">
                    <span class="course-meta-item"><i class="fas fa-clock"></i> 90 Hours</span>
                    <span class="course-meta-item"><i class="fas fa-user-graduate"></i> Advanced</span>
                </div>
                <a href="./courses/course6.html" class="course-btn">Enroll Now <i class="fas fa-arrow-right"></i></a>
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