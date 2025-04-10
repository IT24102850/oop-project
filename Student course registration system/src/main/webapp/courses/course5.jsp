<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NexoraSkill - Database Management Course</title>
    <link rel="stylesheet" href="course5.css">
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
            <img src="../images/ip.jpg" alt="Database Management Course Illustration">
        </div>

        <!-- Middle Top: Course Description -->
        <div class="course-description">
            <h1>Database Management</h1>
            <p>This course is designed to help you master the fundamentals of database management. Whether you're a beginner or looking to refresh your skills, this course will guide you through the essential concepts and practical applications.</p>
        </div>

        <!-- Right Side: Review Section -->
        <div class="review-section">
            <h2>Student Reviews</h2>
            <div class="review-slideshow">
                <div class="review-card">
                    <p>"An excellent course for understanding database systems. The instructors are very knowledgeable!"</p>
                    <h4>- Michael Brown</h4>
                </div>
                <div class="review-card">
                    <p>"The hands-on projects helped me apply what I learned in real-world scenarios. Highly recommended!"</p>
                    <h4>- Laura Smith</h4>
                </div>
                <div class="review-card">
                    <p>"I loved the flexibility of this course. It fit perfectly into my busy schedule."</p>
                    <h4>- James Wilson</h4>
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
                    <img src="teacher1.jpg" alt="Database Expert">
                    <h3>Sam David</h3>
                    <p>Expert in Data Science</p>
                </div>
            </div>
        </div>

        <!-- Middle Bottom: Why Choose This Course -->
        <div class="why-choose">
            <h2>Why Choose This Course?</h2>
            <ul>
                <li>Comprehensive curriculum covering all essential topics</li>
                <li>Hands-on projects to apply your knowledge</li>
                <li>Expert instructors with real-world experience</li>
                <li>Flexible learning schedule to fit your lifestyle</li>
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