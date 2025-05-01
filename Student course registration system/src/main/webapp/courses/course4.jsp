<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NexoraSkill - Cybersecurity Course</title>
    <link rel="stylesheet" href="course1.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="icon" type="image/png" href="../images/favicon.ico">
</head>
<body>

<!-- Header Section -->
<header class="header">
    <div class="container">
        <div class="logo">
            <img src="../images/favicon-32x32.png" alt="NexoraSkill Logo">
            <span>NexoraSkill</span>
        </div>
        <nav class="navbar">
            <ul>
                <li><a href="#home">Home</a></li>
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

<main>
    <!-- Top Section -->
    <section class="top-section">
        <!-- Left Side: Course Image -->
        <div class="course-image">
            <img src="../images/cybersecurity.jpg" alt="Cybersecurity Course Illustration">
        </div>

        <!-- Middle Top: Course Description -->
        <div class="course-description">
            <h1>Cybersecurity Fundamentals</h1>
            <p>Master the art of protecting systems, networks, and programs from digital attacks. This course covers essential cybersecurity concepts, threat detection, and defense strategies to secure digital assets in an increasingly connected world.</p>
        </div>

        <!-- Right Side: Review Section -->
        <div class="review-section">
            <h2>Student Reviews</h2>
            <div class="review-slideshow">
                <div class="review-card">
                    <p>"Eye-opening course that made me rethink digital security."</p>
                    <h4>- Michael Chen</h4>
                </div>
                <div class="review-card">
                    <p>"Practical labs helped me understand real-world threats."</p>
                    <h4>- Priya Patel</h4>
                </div>
                <div class="review-card">
                    <p>"Comprehensive coverage of security fundamentals."</p>
                    <h4>- Robert Johnson</h4>
                </div>
            </div>
        </div>
    </section>

    <!-- Bottom Section -->
    <section class="bottom-section">
        <!-- Left Side: Instructors Description -->
        <div class="instructors-description">
            <h2>Meet Our Instructors</h2>
            <div class="instructor-list">
                <div class="instructor-item">
                    <img src="teacher2.jpg" alt="Security Expert">
                    <h3>Sarah Williams</h3>
                    <p>Former Chief Security Officer</p>
                </div>
            </div>
        </div>

        <!-- Middle Bottom: Why Choose This Course -->
        <div class="why-choose">
            <h2>Why Choose This Course?</h2>
            <ul>
                <li>Hands-on penetration testing exercises</li>
                <li>Learn from industry security experts</li>
                <li>Coverage of latest cybersecurity threats</li>
                <li>Preparation for industry certifications</li>
            </ul>
        </div>

        <!-- Right Side: Enroll Me Button -->
        <div class="enroll-section">
            <button class="enroll-button">Enroll Me</button>
        </div>
    </section>
</main>

</body>
</html>