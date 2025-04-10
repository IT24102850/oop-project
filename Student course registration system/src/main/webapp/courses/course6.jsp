<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NexoraSkill - Web Development Course</title>
    <link rel="stylesheet" href="course6.css">
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
            <img src="../images/web-dev.jpg" alt="Web Development Course Illustration">
        </div>

        <!-- Middle Top: Course Description -->
        <div class="course-description">
            <h1>Web Development</h1>
            <p>This course is designed to help you master the fundamentals of web development. Whether you're a beginner or looking to refresh your skills, this course will guide you through HTML, CSS, JavaScript, and modern frameworks to build responsive and dynamic websites.</p>
        </div>

        <!-- Right Side: Review Section -->
        <div class="review-section">
            <h2>Student Reviews</h2>
            <div class="review-slideshow">
                <div class="review-card">
                    <p>"An amazing course for learning web development from scratch. The instructors are very clear and supportive!"</p>
                    <h4>- Emily Johnson</h4>
                </div>
                <div class="review-card">
                    <p>"The projects were challenging but rewarding. I now feel confident building my own websites!"</p>
                    <h4>- Daniel Lee</h4>
                </div>
                <div class="review-card">
                    <p>"The course content is well-structured, and the instructors are always available to help. Great experience!"</p>
                    <h4>- Sophia Martinez</h4>
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
                    <img src="teacher2.jpg" alt="Web Development Instructor">
                    <h3>Alex Carter</h3>
                    <p>Expert in Web Development</p>
                </div>
            </div>
        </div>

        <!-- Middle Bottom: Why Choose This Course -->
        <div class="why-choose">
            <h2>Why Choose This Course?</h2>
            <ul>
                <li>Comprehensive curriculum covering HTML, CSS, JavaScript, and more</li>
                <li>Hands-on projects to build real-world websites</li>
                <li>Expert instructors with industry experience</li>
                <li>Flexible learning schedule to fit your lifestyle</li>
            </ul>
        </div>

        <!-- Right Side: Enroll Me Button -->
        <div class="enroll-section">
            <button class="enroll-button" onclick="window.location.href='enrollment.jsp?course=web-development'">Enroll Me</button>
        </div>
    </section>
</main>

</body>
</html>