<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Contact Us | NexoraSkill</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
  <link rel="icon" type="image/png" href="./images/favicon.ico">
  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Orbitron:wght@400;500;600;700&display=swap" rel="stylesheet">
  <style>
    /* CSS Variables */
    :root {
      --primary-color: #00f2fe;
      --secondary-color: #ff00ff;
      --card-bg: rgba(10, 15, 36, 0.8);
      --border-radius: 10px;
      --box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
      --transition: all 0.3s ease;
      --text-muted: #a0a8c3;
      --text-color: #ffffff;
      --dark-color: #0a0f24;
      --bg-color: #1a1f3a;
    }

    /* Global Reset */
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Poppins', sans-serif;
      background: var(--bg-color);
      color: var(--text-color);
    }

    /* Container */
    .container {
      max-width: 1200px;
      margin: 0 auto;
      padding: 0 15px;
    }

    /* Preloader */
    .preloader {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: var(--dark-color);
      display: flex;
      align-items: center;
      justify-content: center;
      z-index: 9999;
      transition: opacity 0.5s ease;
    }

    .preloader.fade-out {
      opacity: 0;
    }

    .loader {
      width: 50px;
      height: 50px;
      border: 5px solid var(--primary-color);
      border-top: 5px solid transparent;
      border-radius: 50%;
      animation: spin 1s linear infinite;
    }

    @keyframes spin {
      0% { transform: rotate(0deg); }
      100% { transform: rotate(360deg); }
    }

    /* Header */
    .header {
      background: rgba(10, 15, 36, 0.9);
      backdrop-filter: blur(10px);
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      padding: 15px 0;
      z-index: 1000;
      transition: var(--transition);
    }

    .header.scrolled {
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
    }

    .header .container {
      display: flex;
      align-items: center;
      justify-content: space-between;
    }

    .logo {
      display: flex;
      align-items: center;
      gap: 10px;
      text-decoration: none;
      color: var(--text-color);
      font-family: 'Orbitron', sans-serif;
      font-size: 1.5rem;
      font-weight: 600;
    }

    .logo img {
      width: 32px;
    }

    .navbar ul {
      display: flex;
      list-style: none;
      gap: 30px;
    }

    .nav-link {
      display: flex;
      align-items: center;
      gap: 8px;
      color: var(--text-muted);
      text-decoration: none;
      font-size: 1rem;
      position: relative;
      transition: var(--transition);
    }

    .nav-link:hover,
    .nav-link.active {
      color: var(--primary-color);
    }

    .nav-icon {
      font-size: 1.2rem;
    }

    .nav-underline {
      position: absolute;
      bottom: -5px;
      left: 0;
      width: 0;
      height: 2px;
      background: var(--primary-color);
      transition: var(--transition);
    }

    .nav-link:hover .nav-underline,
    .nav-link.active .nav-underline {
      width: 100%;
    }

    .auth-buttons {
      display: flex;
      gap: 15px;
    }

    .btn {
      display: flex;
      align-items: center;
      gap: 8px;
      padding: 10px 20px;
      border-radius: 5px;
      text-decoration: none;
      font-size: 1rem;
      transition: var(--transition);
    }

    .btn-login {
      background: transparent;
      border: 1px solid var(--primary-color);
      color: var(--primary-color);
    }

    .btn-login:hover {
      background: var(--primary-color);
      color: var(--dark-color);
    }

    .btn-signup {
      background: var(--primary-color);
      color: var(--dark-color);
    }

    .btn-signup:hover {
      background: var(--secondary-color);
      color: var(--text-color);
    }

    .mobile-menu-toggle {
      display: none;
      font-size: 1.5rem;
      color: var(--text-color);
      cursor: pointer;
    }

    /* Contact Page Specific Styles */
    .contact-hero {
      padding: 180px 5% 100px;
      text-align: center;
      position: relative;
      overflow: hidden;
    }

    .contact-hero:before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: radial-gradient(circle, rgba(0, 242, 254, 0.05) 0%, transparent 70%);
      z-index: -1;
    }

    .contact-title {
      font-size: 4rem;
      margin-bottom: 30px;
      background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      text-shadow: 0 0 30px rgba(0, 242, 254, 0.3);
      position: relative;
    }

    .contact-title:after {
      content: '';
      position: absolute;
      bottom: -15px;
      left: 50%;
      transform: translateX(-50%);
      width: 100px;
      height: 4px;
      background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
      border-radius: 2px;
    }

    .contact-subtext {
      font-size: 1.4rem;
      color: var(--text-muted);
      max-width: 700px;
      margin: 0 auto 50px;
    }

    .contact-container {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
      gap: 50px;
      max-width: 1200px;
      margin: 0 auto;
      padding: 0 5% 100px;
    }

    .contact-info {
      background: var(--card-bg);
      backdrop-filter: blur(10px);
      border-radius: var(--border-radius);
      padding: 50px 40px;
      border: 1px solid rgba(0, 242, 254, 0.2);
      box-shadow: var(--box-shadow);
      position: relative;
      overflow: hidden;
      z-index: 1;
    }

    .contact-info:before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: linear-gradient(135deg, rgba(0, 242, 254, 0.1), transparent);
      z-index: -1;
    }

    .info-item {
      display: flex;
      align-items: flex-start;
      gap: 20px;
      margin-bottom: 30px;
    }

    .info-icon {
      width: 60px;
      height: 60px;
      background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      color: var(--dark-color);
      font-size: 1.5rem;
      flex-shrink: 0;
    }

    .info-content h3 {
      font-size: 1.5rem;
      margin-bottom: 10px;
      color: var(--primary-color);
    }

    .info-content p,
    .info-content a {
      color: var(--text-muted);
      transition: var(--transition);
      text-decoration: none;
    }

    .info-content a:hover {
      color: var(--primary-color);
    }

    .contact-form {
      background: var(--card-bg);
      backdrop-filter: blur(10px);
      border-radius: var(--border-radius);
      padding: 50px 40px;
      border: 1px solid rgba(0, 242, 254, 0.2);
      box-shadow: var(--box-shadow);
    }

    .form-group {
      position: relative;
      margin-bottom: 30px;
    }

    .form-group input,
    .form-group textarea {
      width: 100%;
      padding: 15px;
      border: 1px solid rgba(0, 242, 254, 0.3);
      border-radius: 5px;
      background: rgba(10, 15, 36, 0.5);
      color: var(--text-color);
      font-size: 1rem;
      transition: var(--transition);
    }

    .form-group textarea {
      min-height: 150px;
      resize: vertical;
    }

    .form-group input:focus,
    .form-group textarea:focus {
      outline: none;
      border-color: var(--primary-color);
      box-shadow: 0 0 0 2px rgba(0, 242, 254, 0.2);
    }

    .form-group label {
      position: absolute;
      top: 15px;
      left: 15px;
      color: var(--text-muted);
      pointer-events: none;
      transition: var(--transition);
      background: rgba(10, 15, 36, 0.5);
      padding: 0 5px;
    }

    .form-group input:focus + label,
    .form-group input:not(:placeholder-shown) + label,
    .form-group textarea:focus + label,
    .form-group textarea:not(:placeholder-shown) + label {
      top: -10px;
      left: 10px;
      font-size: 12px;
      color: var(--primary-color);
      background: var(--card-bg);
    }

    .submit-btn {
      width: 100%;
      padding: 16px;
      background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
      color: var(--dark-color);
      border: none;
      border-radius: 5px;
      font-size: 1.1rem;
      font-weight: 600;
      cursor: pointer;
      transition: var(--transition);
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 10px;
    }

    .submit-btn:hover {
      transform: translateY(-3px);
      box-shadow: 0 10px 20px rgba(0, 242, 254, 0.4);
    }

    .alert {
      padding: 15px;
      border-radius: 5px;
      margin-bottom: 30px;
      display: flex;
      align-items: center;
      gap: 15px;
    }

    .alert-success {
      background: rgba(0, 255, 0, 0.1);
      color: #00ff00;
      border: 1px solid #00ff00;
    }

    .alert-error {
      background: rgba(255, 0, 0, 0.1);
      color: #ff0000;
      border: 1px solid #ff0000;
    }

    .map-container {
      height: 400px;
      border-radius: var(--border-radius);
      overflow: hidden;
      margin-top: 50px;
      border: 1px solid rgba(0, 242, 254, 0.3);
      box-shadow: var(--box-shadow);
    }

    .map-container iframe {
      width: 100%;
      height: 100%;
      border: none;
      filter: grayscale(50%) hue-rotate(180deg);
      transition: var(--transition);
    }

    .map-container:hover iframe {
      filter: grayscale(0%) hue-rotate(0deg);
    }

    /* Footer */
    .footer {
      background: var(--dark-color);
      padding: 30px 0;
      text-align: center;
    }

    .footer .container {
      display: flex;
      flex-direction: column;
      gap: 15px;
    }

    .footer p {
      color: var(--text-muted);
    }

    .footer ul {
      display: flex;
      justify-content: center;
      gap: 20px;
      list-style: none;
    }

    .footer a {
      color: var(--text-muted);
      text-decoration: none;
      transition: var(--transition);
    }

    .footer a:hover {
      color: var(--primary-color);
    }

    /* Scroll to Top */
    .scroll-top {
      position: fixed;
      bottom: 20px;
      right: 20px;
      width: 50px;
      height: 50px;
      background: var(--primary-color);
      color: var(--dark-color);
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      cursor: pointer;
      opacity: 0;
      transition: var(--transition);
    }

    .scroll-top.active {
      opacity: 1;
    }

    .scroll-top:hover {
      transform: translateY(-5px);
    }

    /* Responsive Styles */
    @media (max-width: 992px) {
      .navbar {
        display: none;
        position: absolute;
        top: 100%;
        left: 0;
        width: 100%;
        background: rgba(10, 15, 36, 0.9);
        padding: 20px;
      }

      .navbar.active {
        display: block;
      }

      .navbar ul {
        flex-direction: column;
        gap: 15px;
      }

      .mobile-menu-toggle {
        display: block;
      }

      .auth-buttons {
        display: none;
      }
    }

    @media (max-width: 768px) {
      .contact-title {
        font-size: 2.8rem;
      }

      .contact-subtext {
        font-size: 1.2rem;
      }
    }

    @media (max-width: 576px) {
      .contact-title {
        font-size: 2.2rem;
      }

      .contact-subtext {
        font-size: 1.1rem;
      }

      .info-item {
        flex-direction: column;
        gap: 15px;
      }

      .info-icon {
        width: 50px;
        height: 50px;
        font-size: 1.2rem;
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
        <li>
          <a href="index.jsp" class="nav-link">
            <i class="fas fa-home nav-icon"></i>
            <span class="nav-text">Home</span>
            <div class="nav-underline"></div>
          </a>
        </li>
        <li>
          <a href="courses.jsp" class="nav-link">
            <i class="fas fa-book nav-icon"></i>
            <span class="nav-text">Courses</span>
            <div class="nav-underline"></div>
          </a>
        </li>
        <li>

          <a href="aboutus.jsp" class="nav-link">
            <i class="fas fa-info-circle nav-icon"></i>
            <span class="nav-text">About</span>
            <div class="nav-underline"></div>
          </a>
        </li>
        <li>
          <a href="contact.jsp" class="nav-link active">
            <i class="fas fa-envelope nav-icon"></i>
            <span class="nav-text">Contact</span>
            <div class="nav-underline"></div>
          </a>
        </li>
      </ul>
    </nav>

    <div class="auth-buttons">
      <a href="logIn.jsp" class="btn btn-login">
        <i class="fas fa-sign-in-alt"></i>
        <span class="btn-text">Login</span>
      </a>
      <a href="signUp.jsp" class="btn btn-signup">
        <i class="fas fa-user-plus"></i>
        <span class="btn-text">Sign Up</span>
      </a>
    </div>

    <!-- Mobile Menu Toggle -->
    <div class="mobile-menu-toggle">
      <i class="fas fa-bars"></i>
    </div>
  </div>
</header>

<!-- Hero Section -->
<section class="contact-hero">
  <h1 class="contact-title">Contact Us</h1>
  <p class="contact-subtext">We'd love to hear from you! Reach out with any questions or feedback.</p>
</section>

<!-- Contact Information and Form Section -->
<div class="contact-container">
  <!-- Contact Information Section -->
  <section class="contact-info">
    <div class="info-item">
      <div class="info-icon">
        <i class="fas fa-map-marker-alt"></i>
      </div>
      <div class="info-content">
        <h3>Our Address</h3>
        <p>123 NexoraSkill Street, Tech City, TX 12345</p>
      </div>
    </div>
    <div class="info-item">
      <div class="info-icon">
        <i class="fas fa-phone-alt"></i>
      </div>
      <div class="info-content">
        <h3>Phone Number</h3>
        <a href="tel:+1234567890">+1 (234) 567-890</a>
      </div>
    </div>
    <div class="info-item">
      <div class="info-icon">
        <i class="fas fa-envelope"></i>
      </div>
      <div class="info-content">
        <h3>Email Address</h3>
        <a href="mailto:support@nexoraskill.com">support@nexoraskill.com</a>
      </div>
    </div>
    <!-- Map -->
    <div class="map-container">
      <iframe
              src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3153.019238673314!2d-122.41941568468122!3d37.77492977975966!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x8085808f1a2a3b7b%3A0x9d2e6f2a3b4c5d67!2sSan%20Francisco%2C%20CA%2C%20USA!5e0!3m2!1sen!2sin!4v1634567890123!5m2!1sen!2sin"
              loading="lazy"
              allowfullscreen
      ></iframe>
    </div>
  </section>

  <!-- Contact Form Section -->
  <section class="contact-form">
    <h2>Send Us a Message</h2>
    <%-- Success/Error Messages --%>
    <% if (request.getAttribute("success") != null) { %>
    <div class="alert alert-success">
      <i class="fas fa-check-circle"></i> Your message has been sent successfully!
    </div>
    <% } %>
    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-error">
      <i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("error") %>
    </div>
    <% } %>

    <form action="${pageContext.request.contextPath}/ContactServlet" method="POST">
      <div class="form-group">
        <input type="text" name="name" id="name" placeholder=" " required>
        <label for="name">Your Name</label>
      </div>
      <div class="form-group">
        <input type="email" name="email" id="email" placeholder=" " required>
        <label for="email">Your Email</label>
      </div>
      <div class="form-group">
        <input type="text" name="subject" id="subject" placeholder=" " required>
        <label for="subject">Subject</label>
      </div>
      <div class="form-group">
        <textarea name="message" id="message" placeholder=" " required></textarea>
        <label for="message">Your Message</label>
      </div>
      <button type="submit" class="submit-btn">
        <i class="fas fa-paper-plane"></i> Send Message
      </button>
    </form>
  </section>
</div>

<!-- Footer -->
<footer class="footer">
  <div class="container">
    <p>© 2025 NexoraSkill. All rights reserved.</p>
    <ul>
      <li><a href="index.jsp">Home</a></li>
      <li><a href="courses.jsp">Courses</a></li>
      <li><a href="aboutus.jsp">About</a></li>
      <li><a href="contact.jsp">Contact</a></li>
    </ul>
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

  // Header scroll effect
  window.addEventListener('scroll', function() {
    const header = document.querySelector('.header');
    if (window.scrollY > 100) {
      header.classList.add('scrolled');
    } else {
      header.classList.remove('scrolled');
    }

    // Scroll to top button
    const scrollTop = document.querySelector('.scroll-top');
    if (window.scrollY > 300) {
      scrollTop.classList.add('active');
    } else {
      scrollTop.classList.remove('active');
    }
  });

  // Mobile Menu Toggle
  const mobileMenuToggle = document.querySelector('.mobile-menu-toggle');
  const navbar = document.querySelector('.navbar');

  mobileMenuToggle.addEventListener('click', function() {
    navbar.classList.toggle('active');
    mobileMenuToggle.classList.toggle('active');
  });

  // Close mobile menu when clicking on a link
  document.querySelectorAll('.nav-link').forEach(link => {
    link.addEventListener('click', function() {
      if (window.innerWidth <= 992) {
        navbar.classList.remove('active');
        mobileMenuToggle.classList.remove('active');
      }
    });
  });

  // Scroll to top button
  document.querySelector('.scroll-top').addEventListener('click', function() {
    window.scrollTo({
      top: 0,
      behavior: 'smooth'
    });
  });
</script>
</body>
</html>