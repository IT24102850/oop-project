<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 4/18/2025
  Time: 1:36 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Apply Course | NexoraSkill</title>
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

    /* Header Section */
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

    .navbar {
      display: flex;
      align-items: center;
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

    .menu-toggle {
      display: none;
      font-size: 1.8rem;
      color: var(--text-color);
      cursor: pointer;
      transition: var(--transition);
    }

    .menu-toggle:hover {
      color: var(--primary-color);
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

    /* Application Form Specific Styles */
    .application-section {
      padding: 150px 5% 100px;
      position: relative;
      min-height: 100vh;
    }

    .application-section:before {
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

    .application-container {
      max-width: 1000px;
      margin: 0 auto;
      display: flex;
      gap: 50px;
      position: relative;
      z-index: 2;
    }

    .course-details {
      flex: 1;
      background: var(--card-bg);
      backdrop-filter: blur(10px);
      border-radius: var(--border-radius);
      padding: 50px;
      border: 1px solid rgba(0, 242, 254, 0.2);
      box-shadow: var(--box-shadow);
      position: relative;
      overflow: hidden;
      animation: fadeInLeft 1s ease-out;
    }

    .course-details:before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: linear-gradient(135deg, rgba(0, 242, 254, 0.1), transparent);
      z-index: -1;
    }

    .course-title {
      font-size: 2.5rem;
      margin-bottom: 20px;
      background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      position: relative;
    }

    .course-title:after {
      content: '';
      position: absolute;
      bottom: -10px;
      left: 0;
      width: 100px;
      height: 4px;
      background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
      border-radius: 2px;
    }

    .course-image {
      width: 100%;
      height: 250px;
      object-fit: cover;
      border-radius: var(--border-radius);
      margin-bottom: 30px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
      transition: var(--transition);
    }

    .course-image:hover {
      transform: scale(1.02);
      box-shadow: 0 15px 40px rgba(0, 242, 254, 0.3);
    }

    .course-info {
      margin-bottom: 30px;
    }

    .info-item {
      display: flex;
      align-items: center;
      margin-bottom: 15px;
      color: var(--text-muted);
    }

    .info-item i {
      margin-right: 15px;
      color: var(--primary-color);
      width: 25px;
      text-align: center;
    }

    .course-description {
      color: var(--text-muted);
      margin-bottom: 30px;
      line-height: 1.8;
    }

    .application-form {
      flex: 1;
      background: var(--card-bg);
      backdrop-filter: blur(10px);
      border-radius: var(--border-radius);
      padding: 50px;
      border: 1px solid rgba(0, 242, 254, 0.2);
      box-shadow: var(--box-shadow);
      position: relative;
      overflow: hidden;
      animation: fadeInRight 1s ease-out;
    }

    .application-form:before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: linear-gradient(135deg, rgba(0, 242, 254, 0.1), transparent);
      z-index: -1;
    }

    .form-title {
      font-size: 2rem;
      margin-bottom: 30px;
      background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      position: relative;
    }

    .form-title:after {
      content: '';
      position: absolute;
      bottom: -10px;
      left: 0;
      width: 100px;
      height: 4px;
      background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
      border-radius: 2px;
    }

    .form-group {
      margin-bottom: 25px;
      position: relative;
    }

    .form-label {
      display: block;
      margin-bottom: 10px;
      font-weight: 500;
      color: var(--text-color);
    }

    .form-control {
      width: 100%;
      padding: 15px 20px;
      background: var(--glass-bg);
      border: 1px solid rgba(0, 242, 254, 0.3);
      border-radius: var(--border-radius);
      color: var(--text-color);
      font-family: 'Poppins', sans-serif;
      font-size: 1rem;
      transition: var(--transition);
      backdrop-filter: blur(5px);
    }

    .form-control:focus {
      outline: none;
      border-color: var(--primary-color);
      box-shadow: 0 0 15px rgba(0, 242, 254, 0.3);
    }

    .form-control::placeholder {
      color: var(--text-muted);
    }

    .select-wrapper {
      position: relative;
    }

    .select-wrapper:after {
      content: '\f078';
      font-family: 'Font Awesome 6 Free';
      font-weight: 900;
      position: absolute;
      top: 50%;
      right: 20px;
      transform: translateY(-50%);
      color: var(--primary-color);
      pointer-events: none;
    }

    select.form-control {
      appearance: none;
      -webkit-appearance: none;
      -moz-appearance: none;
    }

    .submit-btn {
      width: 100%;
      padding: 18px;
      border-radius: 50px;
      background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
      color: var(--dark-color);
      border: none;
      font-weight: 600;
      font-size: 1.1rem;
      cursor: pointer;
      transition: var(--transition);
      margin-top: 20px;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 10px;
      position: relative;
      overflow: hidden;
      z-index: 1;
    }

    .submit-btn:before {
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

    .submit-btn:hover {
      transform: translateY(-3px);
      box-shadow: 0 15px 30px rgba(0, 242, 254, 0.4);
    }

    .submit-btn:hover:before {
      width: 100%;
    }

    .form-note {
      color: var(--text-muted);
      font-size: 0.9rem;
      margin-top: 30px;
      text-align: center;
    }

    .form-note a {
      color: var(--primary-color);
      text-decoration: none;
      transition: var(--transition);
    }

    .form-note a:hover {
      text-shadow: 0 0 10px var(--glow-color);
    }

    /* Footer */
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
      padding: 20px 0 0;
      border-top: 1px solid rgba(0, 242, 254, 0.1);
      color: var(--text-muted);
      font-size: 1rem;
      position: relative;
      z-index: 1;
      margin-bottom: 0;
    }

    .footer-bottom a {
      color: var(--primary-color);
      text-decoration: none;
      transition: var(--transition);
    }

    .footer-bottom a:hover {
      text-shadow: 0 0 10px var(--glow-color);
    }

    /* Responsive Design */
    @media (max-width: 1200px) {
      .navbar ul {
        gap: 20px;
      }
    }

    @media (max-width: 992px) {
      .application-container {
        flex-direction: column;
      }

      .course-details, .application-form {
        flex: none;
        width: 100%;
      }

      .navbar ul {
        display: none;
        flex-direction: column;
        position: absolute;
        top: 100%;
        left: 0;
        width: 100%;
        background: rgba(10, 15, 36, 0.95);
        padding: 20px;
        gap: 20px;
        text-align: center;
      }

      .navbar.active ul {
        display: flex;
      }

      .menu-toggle {
        display: block;
      }

      .auth-buttons {
        display: none;
      }
    }

    @media (max-width: 576px) {
      .course-details, .application-form {
        padding: 30px;
      }

      .course-title {
        font-size: 2rem;
      }

      .form-title {
        font-size: 1.8rem;
      }

      .container {
        padding: 15px 3%;
      }

      .logo {
        font-size: 1.5rem;
      }

      .logo img {
        height: 35px;
      }
    }

    /* Animations */
    @keyframes rotate {
      0% { transform: rotate(0deg); }
      100% { transform: rotate(360deg); }
    }

    @keyframes fadeInLeft {
      from {
        opacity: 0;
        transform: translateX(-50px);
      }
      to {
        opacity: 1;
        transform: translateX(0);
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
        <li><a href="courses.jsp">Courses</a></li>
        <li><a href="registration.jsp">Apply Course</a></li>
        <li><a href="aboutus.jsp">About Us</a></li>
        <li><a href="contact.jsp">Contact</a></li>
      </ul>
    </nav>
    <div class="auth-buttons">
      <a href="logIn.jsp" class="btn btn-login"><i class="fas fa-sign-in-alt"></i> Login</a>
      <a href="signUp.jsp" class="btn btn-signup"><i class="fas fa-user-plus"></i> Sign Up</a>
    </div>
    <i class="fas fa-bars menu-toggle"></i>
  </div>
</header>

<!-- Application Section -->
<section class="application-section">
  <div class="application-container">
    <!-- Course Details Card -->
    <div class="course-details">
      <h2 class="course-title" id="course-title">Advanced AI Programming</h2>
      <img src="https://images.unsplash.com/photo-1516321318423-f06f85e504b3" alt="Course Image" class="course-image" id="course-image">

      <div class="course-info" id="course-info">
        <div class="info-item">
          <i class="fas fa-clock"></i>
          <span id="course-duration">Duration: 12 Weeks</span>
        </div>
        <div class="info-item">
          <i class="fas fa-chart-line"></i>
          <span id="course-level">Level: Advanced</span>
        </div>
        <div class="info-item">
          <i class="fas fa-user-tie"></i>
          <span id="course-instructor">Instructor: Dr. Sarah Chen</span>
        </div>
        <div class="info-item">
          <i class="fas fa-certificate"></i>
          <span id="course-certification">Certification: NexoraSkill AI Master</span>
        </div>
      </div>

      <p class="course-description" id="course-description">
        Master the latest AI technologies with our intensive 12-week program. Learn from industry experts and work on real-world projects using TensorFlow, PyTorch, and cutting-edge neural network architectures. This course includes hands-on labs, mentorship sessions, and a capstone project.
      </p>
    </div>

    <!-- Application Form -->
    <div class="application-form">
      <h2 class="form-title">Application Form</h2>

      <form action="ProcessApplication" method="POST">
        <div class="form-group">
          <label for="course" class="form-label">Select Course</label>
          <div class="select-wrapper">
            <select id="course" name="courseId" class="form-control" required onchange="updateCourseDetails(this.value)">
              <option value="" disabled selected>Select a course</option>
              <option value="AI101">Advanced AI Programming</option>
              <option value="BC201">Blockchain Development</option>
              <option value="QC301">Quantum Computing</option>
              <option value="CS401">Cybersecurity Essentials</option>
              <option value="CA501">Cloud Architecture</option>
            </select>
          </div>
        </div>

        <div class="form-group">
          <label for="fullName" class="form-label">Full Name</label>
          <input type="text" id="fullName" name="fullName" class="form-control" placeholder="Enter your full name" required>
        </div>

        <div class="form-group">
          <label for="email" class="form-label">Email Address</label>
          <input type="email" id="email" name="email" class="form-control" placeholder="Enter your email" required>
        </div>

        <div class="form-group">
          <label for="phone" class="form-label">Phone Number</label>
          <input type="tel" id="phone" name="phone" class="form-control" placeholder="Enter your phone number" required>
        </div>

        <div class="form-group">
          <label for="education" class="form-label">Highest Education Level</label>
          <div class="select-wrapper">
            <select id="education" name="education" class="form-control" required>
              <option value="" disabled selected>Select your education level</option>
              <option value="highschool">High School</option>
              <option value="bachelor">Bachelor's Degree</option>
              <option value="master">Master's Degree</option>
              <option value="phd">PhD</option>
              <option value="other">Other</option>
            </select>
          </div>
        </div>

        <div class="form-group">
          <label for="experience" class="form-label">Years of Programming Experience</label>
          <div class="select-wrapper">
            <select id="experience" name="experience" class="form-control" required>
              <option value="" disabled selected>Select your experience level</option>
              <option value="0-1">0-1 years</option>
              <option value="1-3">1-3 years</option>
              <option value="3-5">3-5 years</option>
              <option value="5+">5+ years</option>
            </select>
          </div>
        </div>

        <div class="form-group">
          <label for="goals" class="form-label">Your Learning Goals</label>
          <textarea id="goals" name="goals" class="form-control" rows="4" placeholder="Briefly describe what you hope to achieve with this course" required></textarea>
        </div>

        <div class="form-group" style="margin-top: 30px;">
          <label style="display: flex; align-items: flex-start; gap: 10px; cursor: pointer;">
            <input type="checkbox" name="terms" required style="margin-top: 3px;">
            <span>I agree to the <a href="#" style="color: var(--primary-color);">Terms & Conditions</a> and <a href="#" style="color: var(--primary-color);">Privacy Policy</a></span>
          </label>
        </div>

        <button type="submit" class="submit-btn">
          <i class="fas fa-paper-plane"></i> Submit Application
        </button>

        <p class="form-note">
          Need help? <a href="contact.jsp">Contact our admissions team</a>
        </p>
      </form>
    </div>
  </div>
</section>

<!-- Footer -->
<footer class="footer">
  <div class="footer-grid">
    <div class="footer-col">
      <a href="index.jsp" class="footer-logo">NexoraSkill</a>
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
    <p>© 2023 NexoraSkill. All rights reserved. | Designed with <i class="fas fa-heart" style="color: var(--accent-color);"></i> for the future of education</p>
  </div>
</footer>

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

  // Mobile Menu Toggle
  const menuToggle = document.querySelector('.menu-toggle');
  const navbar = document.querySelector('.navbar');
  menuToggle.addEventListener('click', function() {
    navbar.classList.toggle('active');
    menuToggle.classList.toggle('fa-bars');
    menuToggle.classList.toggle('fa-times');
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

  // Course Details Update Function
  function updateCourseDetails(courseId) {
    const courseData = {
      'AI101': {
        title: 'Advanced AI Programming',
        image: 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3',
        duration: '12 Weeks',
        level: 'Advanced',
        instructor: 'Dr. Sarah Chen',
        certification: 'NexoraSkill AI Master',
        description: 'Master the latest AI technologies with our intensive 12-week program. Learn from industry experts and work on real-world projects using TensorFlow, PyTorch, and cutting-edge neural network architectures. This course includes hands-on labs, mentorship sessions, and a capstone project.'
      },
      'BC201': {
        title: 'Blockchain Development',
        image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGQiGZ30sOOM3-c02iz8-d1q0tVSwJxpxXZg&s',
        duration: '10 Weeks',
        level: 'Intermediate',
        instructor: 'Prof. Michael Lee',
        certification: 'NexoraSkill Blockchain Expert',
        description: 'Dive into blockchain technology with this comprehensive 10-week course. Learn to develop decentralized applications using Ethereum, Solidity, and Hyperledger. Includes practical projects and smart contract development.'
      },
      'QC301': {
        title: 'Quantum Computing',
        image: 'https://dwg31ai31okv0.cloudfront.net/images/Article_Images/ImageForArticle_519_17140003651563270.jpg',
        duration: '14 Weeks',
        level: 'Advanced',
        instructor: 'Dr. Emily Watson',
        certification: 'NexoraSkill Quantum Specialist',
        description: 'Explore the frontiers of quantum computing in this 14-week program. Master quantum algorithms, Qiskit, and quantum circuit design. Features hands-on labs and collaboration with industry pioneers.'
      },
      'CS401': {
        title: 'Cybersecurity Essentials',
        image: 'https://images.unsplash.com/photo-1550751827-4bd374c3f58b',
        duration: '8 Weeks',
        level: 'Beginner',
        instructor: 'James Carter',
        certification: 'NexoraSkill Cybersecurity Professional',
        description: 'Build a strong foundation in cybersecurity with this 8-week course. Learn ethical hacking, network security, and threat analysis. Includes real-world simulations and penetration testing labs.'
      },
      'CA501': {
        title: 'Cloud Architecture',
        image: 'https://images.unsplash.com/photo-1451187580459-43490279c0fa',
        duration: '10 Weeks',
        level: 'Intermediate',
        instructor: 'Dr. Anita Patel',
        certification: 'NexoraSkill Cloud Architect',
        description: 'Design scalable cloud solutions in this 10-week course. Master AWS, Azure, and Google Cloud platforms. Includes architecture design projects and DevOps integration.'
      }
    };

    const selectedCourse = courseData[courseId] || courseData['AI101'];
    document.getElementById('course-title').textContent = selectedCourse.title;
    document.getElementById('course-image').src = selectedCourse.image;
    document.getElementById('course-image').alt = selectedCourse.title;
    document.getElementById('course-duration').textContent = 'Duration: ' + selectedCourse.duration;
    document.getElementById('course-level').textContent = 'Level: ' + selectedCourse.level;
    document.getElementById('course-instructor').textContent = 'Instructor: ' + selectedCourse.instructor;
    document.getElementById('course-certification').textContent = 'Certification: ' + selectedCourse.certification;
    document.getElementById('course-description').textContent = selectedCourse.description;
  }

  // Set default course on page load
  document.addEventListener('DOMContentLoaded', function() {
    const courseSelect = document.getElementById('course');
    if (courseSelect.value) {
      updateCourseDetails(courseSelect.value);
    }
  });
</script>
</body>
</html>
