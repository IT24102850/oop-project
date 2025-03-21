<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - NexoraSkill</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/aboutus.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.ico">
    <style>
        /* General Reset */
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Poppins', sans-serif; background-color: #0a192f; color: #ffffff; line-height: 1.6;
        }

        .container { width: 90%; max-width: 1200px; margin: 0 auto; }

        /* Header Section */
        .header {
            display: flex; justify-content: space-between; align-items: center; padding: 20px;
            background-color: #0a192f;
        }

        /* Logo */
        .logo img { height: 40px; }

        /* Navigation Menu */
        .navbar {
            position: fixed; /* Fixes the navbar at the top */
            top: 0; /* Positions it at the top */
            left: 0; /* Aligns it to the left edge */
            width: 100%; /* Ensures it spans the full width */
            z-index: 1000; /* Ensures it stays above other content */
            display: flex;
            justify-content: center; /* Centers the navbar horizontally */
            padding: 10px 0; /* Adds some padding for better spacing */
        }

        .navbar ul {
            list-style: none;
            display: flex;
            gap: 20px;
            margin: 0;
            padding: 0;
        }

        .navbar ul li {
            display: inline-block;
        }

        .navbar ul li a {
            text-decoration: none;
            color: #ffffff;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .navbar ul li a:hover {
            color: #009acd;
        }

        /* Authentication Buttons */
        .auth-buttons {
            display: flex;
            gap: 10px;
            position: absolute;  /* Positions the buttons relative to the page */
            top: 20px;           /* Adjust as needed */
            right: 20px;         /* Aligns buttons to the right */
        }

        .btn-login, .btn-signup {
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: 500;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .btn-login {
            color: #ffffff;
            border: 1px solid #009acd;
        }

        .btn-login:hover {
            background-color: #009acd;
            color: #121212;
        }

        .btn-signup {
            background-color: #009acd;
            color: #121212;
        }

        .btn-signup:hover {
            background-color: #0077a3;
        }

        /* About Us Section */
        .about-us {
            padding: 80px 0;
            text-align: center;
        }

        .section-title {
            font-size: 2.5rem;
            margin-bottom: 20px;
            color: #00bfff; /* Neon blue color */
            text-shadow: 0 0 10px #00bfff, 0 0 20px #00bfff; /* Neon glow effect */
        }

        .section-description {
            font-size: 1.2rem;
            max-width: 800px;
            margin: 0 auto 40px;
            color: #a0aec0; /* Light gray for contrast */
        }

        /* Features Grid */
        .features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 30px;
            margin-top: 40px;
        }

        .feature-item {
            background: rgba(0, 191, 255, 0.1); /* Semi-transparent neon blue background */
            padding: 20px;
            border-radius: 10px;
            border: 1px solid #00bfff; /* Neon blue border */
            box-shadow: 0 0 10px rgba(0, 191, 255, 0.5); /* Neon glow */
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .feature-item:hover {
            transform: translateY(-10px);
            box-shadow: 0 0 20px rgba(0, 191, 255, 0.8); /* Stronger glow on hover */
        }

        .feature-title {
            font-size: 1.5rem;
            margin-bottom: 10px;
            color: #00bfff; /* Neon blue color */
        }

        .feature-description {
            font-size: 1rem;
            color: #a0aec0; /* Light gray for contrast */
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .navbar ul {
                flex-direction: column;
                gap: 10px;
                text-align: center;
            }

            .auth-buttons {
                flex-direction: column;
                gap: 10px;
            }

            .features {
                grid-template-columns: 1fr; /* Stack features in one column on small screens */
            }
        }
    </style>
</head>
<body>
<!-- Header Section -->
<header class="header">
    <div class="container">
        <div class="logo">
            <img src="./images/favicon-32x32.png" alt="NexoraSkill Logo">
        </div>
        <!-- Navigation Menu -->
        <nav class="navbar">
            <ul>
                <li><a href="index.jsp">Home</a></li>
                <li><a href="courses.jsp">Courses</a></li>
                <li><a href="registration.jsp">Registration</a></li>
                <li><a href="aboutus.jsp" class="active">About Us</a></li>
                <li><a href="contact.jsp">Contact</a></li>
            </ul>
        </nav>

        <!-- Authentication Buttons -->
        <div class="auth-buttons">
            <a href="logIn.jsp" class="btn-login">Login</a>
            <a href="signUp.jsp" class="btn-signup">Sign Up</a>
        </div>
    </div>
</header>

<!-- About Us Section -->
<section class="about-us">
    <div class="container">
        <h2 class="section-title">About Us</h2>
        <p class="section-description">
            We are a leading platform for student course registration, dedicated to helping students achieve their academic goals. Our mission is to provide a seamless and intuitive experience for course selection, registration, and progress tracking.
        </p>
        <div class="features">
            <div class="feature-item">
                <h3 class="feature-title">Easy Registration</h3>
                <p class="feature-description">
                    Our system ensures a hassle-free course registration process for all students.
                </p>
            </div>
            <div class="feature-item">
                <h3 class="feature-title">Wide Range of Courses</h3>
                <p class="feature-description">
                    Choose from hundreds of courses across various disciplines to suit your interests.
                </p>
            </div>
            <div class="feature-item">
                <h3 class="feature-title">24/7 Support</h3>
                <p class="feature-description">
                    Our dedicated support team is always available to assist you with any queries.
                </p>
            </div>
        </div>
    </div>
</section>

</body>
</html>