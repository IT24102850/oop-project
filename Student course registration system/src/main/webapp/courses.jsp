
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Courses - NexoraSkill</title>
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

        body {
            font-family: 'Poppins', sans-serif;
            background: #0a192f;
            background-size: cover;
            color: #ffffff;
        }

        .container {
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
        }

        /* Header Section */
        .header {
            display: flex;
            justify-content: space-between; /* Space between logo and nav/auth-buttons */
            align-items: center;
            padding: 20px;
        }

        .logo {
            margin-right: auto; /* Pushes everything else to the right */
        }

        .navbar {
            display: flex;
            justify-content: flex-end; /* Moves navbar to the right */
        }

        .navbar ul {
            list-style: none;
            display: flex;
            gap: 20px;
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

        .auth-buttons {
            display: flex;
            gap: 10px;
            margin-left: 20px; /* Space between navbar and buttons */
        }

        .btn-login,
        .btn-signup,
        .btn-cta,
        .btn-learn-more {
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: 500;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .auth-buttons {
            display: flex;
            gap: 10px;
            margin-left: auto; /* Pushes buttons to the right */
            align-items: center; /* Adjusts vertical positioning */
            justify-content: flex-end; /* Ensures buttons align to the right */
            padding-top: 7px; /* Adjust Y-axis (move buttons down) */
            padding-bottom: 10px; /* Adjust Y-axis (move buttons up) */
        }

        .btn-login {
            color: #ffffff;
            border: 1px solid #009acd;
            padding: 10px 20px; /* Adjust button size */
        }

        .btn-login:hover,
        .btn-cta:hover,
        .btn-learn-more:hover {
            background-color: #009acd;
            color: #121212;
        }

        .btn-signup,
        .btn-cta,
        .btn-learn-more {
            background-color: #009acd;
            color: #121212;
            padding: 10px 20px; /* Adjust button size */
        }

        /* If you want to manually position with margin */
        .btn-login {
            margin-right: 7px; /* Move login button to the right */
        }

        .btn-signup {
            margin-right: 7px; /* Move sign-up button to the right */
        }

        /* Hero Section */
        .hero {
            background-image: url('hero-bg.jpg');
            background-size: cover;
            background-position: center;
            padding: 100px 0;
            text-align: center;
        }

        .hero-content h1 {
            font-size: 48px;
            margin-bottom: 20px;
        }

        .hero p {
            font-size: 1.2rem;
            margin-bottom: 30px;
            color: #cccccc;
        }

        /* CTA Button Container */
        .cta {
            position: fixed; /* Fixed position relative to the viewport */
            z-index: 700; /* Ensure the button stays on top */
            top: 66%; /* Controls vertical position (50% from the top of the viewport) */
            left: 20%; /* Controls horizontal position (50% from the left of the viewport) */
            transform: translate(-50%, -50%) /* Adjust spacing from elements above */
        }

        /* CTA Button Styles */
        .cta .cta-button {
            font-family: 'Poppins', sans-serif;
            background-color: transparent; /* Primary button color */
            color: #ffffff; /* Text color */
            padding: 12px 40px;
            border-radius: 21px;
            font-size: 18px;
            font-weight: 700;
            text-decoration: none;
            display: inline-block;
            outline: 2px solid #009acd; /* White outline */
            outline-offset: 4px; /* Space between the button and the outline */
            transition: background-color 0.3s ease, transform 0.3s ease, outline-color 0.3s ease; /* Smooth transition */
            cursor: pointer;
        }

        /* Hover Effect */
        .cta .cta-button:hover {
            background-color: #009acd; /* Slightly darker blue */
            transform: scale(1.05);
            outline-color: #009acd;; /* Change outline to yellow on hover */
        }

        /* Section Styles */
        .features,
        .how-it-works,
        .course-highlights,
        .testimonials {
            padding: 80px 0;
            text-align: center;
        }

        .features h2,
        .how-it-works h2,
        .course-highlights h2,
        .testimonials h2 {
            font-size: 2.5rem;
            margin-bottom: 40px;
        }

        .feature-cards,
        .steps,
        .course-cards,
        .testimonial-cards {
            display: flex;
            justify-content: space-between;
            gap: 20px;
        }

        .card,
        .step,
        .course-card,
        .testimonial-card {
            background-color: #1f1f1f;
            padding: 20px;
            border-radius: 10px;
            width: 100%;
            text-align: center;
        }

        .card i,
        .step span {
            font-size: 2rem;
            color: #009acd;
            margin-bottom: 15px;
        }

        .card h3,
        .step h3,
        .course-card h3,
        .testimonial-card h3 {
            font-size: 1.5rem;
            margin-bottom: 10px;
        }

        .card p,
        .step p,
        .course-card p,
        .testimonial-card p {
            color: #cccccc;
        }

        .course-card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .course-highlights {
            text-align: center;
            padding: 40px 0;
        }

        .course-cards {
            display: flex;
            justify-content: space-between; /* Distributes the cards evenly */
            align-items: stretch; /* Makes all cards the same height */
            gap: 15px;
            flex-wrap: nowrap; /* Ensures all items stay in one row */
            max-width: 100%;
        }

        .course-card {
            background: #013971;
            color: white;
            border-radius: 10px;
            width: 16%; /* Adjusts width to fit six items in a row */
            padding: 20px;
            text-align: center;
            transition: transform 0.3s ease;
            flex-shrink: 0; /* Prevents shrinking */
            display: flex;
            flex-direction: column;
            justify-content: space-between; /* Ensures content is well distributed */
            height: 100%; /* Makes sure all items take the same height */
        }

        .course-card img {
            width: 100%;
            border-radius: 10px;
        }

        .course-card:hover {
            transform: scale(1.05);
        }

        .btn-learn-more {
            display: inline-block;
            padding: 10px 15px;
            background: #009acd;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            margin-top: auto; /* Pushes the button to the bottom */
        }

        .btn-learn-more:hover {
            background: #009acd;
        }

        /* Footer Section */
        .footer {
            background-color: #0a192f;
            padding: 40px 0;
            border-top: 1px solid #333;
        }

        .footer .container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
        }

        .footer-links {
            display: flex;
            gap: 20px;
        }

        .footer-links a {
            text-decoration: none;
            color: #ffffff;
            transition: color 0.3s ease;
        }

        .footer-links a:hover {
            color: #009acd;
        }

        .footer-social {
            display: flex;
            gap: 15px;
        }

        .footer-social a {
            color: #ffffff;
            font-size: 24px;
            transition: color 0.3s ease;
        }

        .footer-social a:hover {
            color: #009acd;
        }

        .footer-newsletter {
            text-align: center;
        }

        .footer-newsletter p {
            margin-bottom: 10px;
            color: #ffffff;
        }

        .footer-newsletter form {
            display: flex;
            gap: 10px;
        }

        .footer-newsletter input {
            padding: 10px;
            border: 1px solid #333;
            border-radius: 5px;
            background-color: #1f1f1f;
            color: #ffffff;
            font-size: 16px;
        }

        .footer-newsletter button {
            padding: 10px 20px;
            background: #009acd;
            color: #121212;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .footer-newsletter button:hover {
            background: #007ba7;
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
                <li><a href="courses.jsp" class="active">Courses</a></li>
                <li><a href="registration.jsp">Registration</a></li>
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

<!-- Courses Section -->
<section class="course-highlights">
    <div class="container">
        <h2>Our Courses</h2>
        <div class="course-cards">

            <!-- Course 1 -->
            <div class="course-card">
                <img src="./images/course.png" alt="Introduction to Programming">
                <h3>Introduction to Programming</h3>
                <p>Learn the basics of programming with Python.</p>
                <a href="./courses/course1.jsp" class="btn-learn-more">Learn More</a>
            </div>

            <!-- Course 2 -->
            <div class="course-card">
                <img src="./images/course2.jpg" alt="Web Development">
                <h3>Web Development</h3>
                <p>Master HTML, CSS, and JavaScript to build modern websites.</p>
                <a href="./courses/course2.jsp" class="btn-learn-more">Learn More</a>
            </div>

            <!-- Course 3 -->
            <div class="course-card">
                <img src="./images/course3.jpg" alt="Data Science">
                <h3>Data Science</h3>
                <p>Explore data analysis and machine learning techniques.</p>
                <a href="./courses/course3.jsp" class="btn-learn-more">Learn More</a>
            </div>

            <!-- Course 4 -->
            <div class="course-card">
                <img src="./images/course4.jpg" alt="Mobile App Development">
                <h3>Mobile App Development</h3>
                <p>Build cross-platform mobile apps using Flutter.</p>
                <a href="./courses/course4.jsp" class="btn-learn-more">Learn More</a>
            </div>

            <!-- Course 5 -->
            <div class="course-card">
                <img src="./images/course5.jpg" alt="Cybersecurity">
                <h3>Cybersecurity</h3>
                <p>Understand security fundamentals and ethical hacking.</p>
                <a href="./courses/course5.jsp" class="btn-learn-more">Learn More</a>
            </div>

            <!-- Course 6 -->
            <div class="course-card">
                <img src="./images/course6.jpg" alt="AI & Machine Learning">
                <h3>AI & Machine Learning</h3>
                <p>Learn artificial intelligence and machine learning concepts.</p>
                <a href="./courses/course6.jsp" class="btn-learn-more">Learn More</a>
            </div>
        </div>
    </div>
</section>



</body>
</html>