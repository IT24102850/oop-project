<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NexoraSkill - AI & Machine Learning</title>
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
            <img src="../images/ai-ml.jpg" alt="AI & ML Course Illustration">
        </div>

        <!-- Middle Top: Course Description -->
        <div class="course-description">
            <h1>AI & Machine Learning</h1>
            <p>Dive into the world of artificial intelligence and machine learning. This comprehensive course covers fundamental algorithms, neural networks, and practical applications to solve real-world problems using cutting-edge AI technologies.</p>
        </div>

        <!-- Right Side: Review Section -->
        <div class="review-section">
            <h2>Student Reviews</h2>
            <div class="review-slideshow">
                <div class="review-card">
                    <p>"Transformed my understanding of what AI can achieve."</p>
                    <h4>- David Kim</h4>
                </div>
                <div class="review-card">
                    <p>"The projects helped me build a strong portfolio."</p>
                    <h4>- Maria Garcia</h4>
                </div>
                <div class="review-card">
                    <p>"Perfect balance of theory and practical implementation."</p>
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
                    <img src="teacher3.jpg" alt="AI Expert">
                    <h3>Dr. Alan Turing</h3>
                    <p>AI Research Scientist</p>
                </div>
            </div>
        </div>

        <!-- Middle Bottom: Why Choose This Course -->
        <div class="why-choose">
            <h2>Why Choose This Course?</h2>
            <ul>
                <li>Hands-on projects with real datasets</li>
                <li>Coverage of both classical and modern AI techniques</li>
                <li>Guidance from leading AI researchers</li>
                <li>Career-focused curriculum</li>
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