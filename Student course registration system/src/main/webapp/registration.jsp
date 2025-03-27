<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration - NexoraSkill</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.ico">
    <!-- Add Google Fonts for Poppins -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        /* General Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: #0a192f;
            color: #ffffff;
            line-height: 1.6;
        }

        .container {
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
        }

        /* Header Section */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px;
            background-color: #0a192f;
        }

        /* Logo */
        .logo img {
            height: 40px;
        }

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
            position: absolute; /* Positions the buttons relative to the page */
            top: 20px; /* Adjust as needed */
            right: 20px; /* Aligns buttons to the right */
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

        /* Main Content Section */
        .main-content {
            display: flex;
            flex-direction: column;
            gap: 40px;
            padding: 50px 0 40px; /* Reduced padding-top from 100px to 50px */
        }

        /* Registration Section */
        .registration {
            text-align: center;
        }
        .registration h2 {
            font-size: 2.5rem;
            margin-bottom: 20px; /* Reduced gap */
            color: #00bfff;
        }
        .registration form {
            max-width: 500px; /* Reduced from 600px to 500px */
            margin: 0 auto;
            background-color: #112240;
            padding: 15px; /* Reduced from 20px to 15px */
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 191, 255, 0.5);
            margin-top: 10px; /* Optional: Further reduce gap */
        }
        .form-group {
            margin-bottom: 15px;
            text-align: left;
        } /* Reduced from 20px to 15px */
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: 500;
            color: #00bfff;
        }
        .form-group input, .form-group select {
            width: 100%;
            padding: 8px; /* Reduced from 10px to 8px */
            border: 2px solid #00bfff;
            border-radius: 5px;
            font-size: 14px; /* Reduced from 16px to 14px */
            background-color: #112240;
            color: #ffffff;
            outline: none;
        }
        .form-group input:focus, .form-group select:focus {
            border-color: #00ffff;
            box-shadow: 0 0 10px rgba(0, 191, 255, 0.5);
        }
        .btn-submit {
            width: 100%;
            padding: 8px; /* Reduced from 10px to 8px */
            background-color: #00bfff;
            color: #121212;
            border: none;
            border-radius: 5px;
            font-size: 16px; /* Reduced from 18px to 16px */
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s ease, box-shadow 0.3s ease;
        }
        .btn-submit:hover {
            background-color: #00ffff;
            box-shadow: 0 0 15px rgba(0, 191, 255, 0.7);
        }

        /* Features Section */
        .features {
            text-align: center;
        }
        .features h2 {
            font-size: 2.5rem;
            margin-bottom: 40px;
            color: #00bfff;
        }
        .feature-cards {
            display: flex;
            justify-content: space-between;
            gap: 20px;
        }
        .feature-item {
            background-color: #112240;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 191, 255, 0.5);
            flex: 1;
        }
        .feature-item h3 {
            font-size: 1.5rem;
            margin-bottom: 10px;
            color: #00bfff;
        }
        .feature-item p {
            color: #a8b2d1;
        }

        /* Footer Section */
        .footer {
            background-color: rgba(31, 31, 31, 0.8);
            padding: 20px 0;
            text-align: center;
        }
        .footer p {
            font-size: 14px;
            color: #cccccc;
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
                margin-left: 0;
            } /* Reset margin for mobile */
            .feature-cards {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>

<!-- Header Section -->
<header class="header">
    <div class="container">
        <!-- Logo -->
        <div class="logo">
            <img src="./images/favicon-32x32.png" alt="NexoraSkill Logo">
        </div>


        <!-- Navigation Menu -->
        <nav class="navbar">
            <ul>
                <li><a href="index.jsp">Home</a></li>
                <li><a href="courses.jsp">Courses</a></li>
                <li><a href="">Registration</a></li>
                <li><a href="aboutus.jsp">About Us</a></li>
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

<!-- Registration Section -->
<section class="registration">
    <div class="container">
        <h2>Register for a Course</h2>
        <form id="registration-form" action="${pageContext.request.contextPath}/register" method="POST">
            <!-- Personal Information -->
            <div class="form-group">
                <label for="full-name">Full Name</label>
                <input type="text" id="full-name" name="full-name" placeholder="Enter your full name" required>
            </div>

            <div class="form-group">
                <label for="email">Email Address</label>
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

            <!-- Course Selection -->
            <div class="form-group">
                <label for="course">Select Course</label>
                <select id="course" name="course" required>
                    <option value="" disabled selected>Choose a course</option>
                    <option value="intro-to-programming">Introduction to Programming</option>
                    <option value="web-development">Web Development</option>
                    <option value="data-science">Data Science</option>
                </select>
            </div>

            <!-- Submit Button -->
            <div class="form-group">
                <button type="submit" class="btn-submit">Register Now</button>
            </div>
        </form>
    </div>
</section>



<!-- JavaScript to handle form submission -->
<script src="${pageContext.request.contextPath}/js/registration.js"></script>
</body>
</html>