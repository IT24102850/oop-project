<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList, java.util.List, java.io.*, java.time.LocalDateTime, java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Contact Us | NexoraSkill</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
  <link rel="icon" type="image/png" href="./images/favicon.ico">
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Orbitron:wght@400;500;600;700&display=swap" rel="stylesheet">
  <style>
    :root {
      --primary-color: #00f2fe;
      --secondary-color: #4facfe;
      --accent-color: #ff4d7e;
      --dark-color: #0a0f24;
      --darker-color: #050916;
      --text-color: #ffffff;
      --text-muted: rgba(255, 255, 255, 0.7);
      --hover-color: #00c6fb;
      --glow-color: rgba(0, 242, 254, 0.6);
      --card-bg: rgba(15, 23, 42, 0.8);
      --glass-bg: rgba(255, 255, 255, 0.08);
      --border-radius: 16px;
      --box-shadow: 0 12px 40px rgba(0, 0, 0, 0.4);
      --transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
    }

    body {
      margin: 0;
      background: radial-gradient(ellipse at bottom, var(--darker-color) 0%, var(--dark-color) 100%);
      font-family: 'Poppins', sans-serif;
      color: var(--text-color);
      overflow-x: hidden;
      line-height: 1.7;
      scroll-behavior: smooth;
    }

    .preloader {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: var(--dark-color);
      display: flex;
      justify-content: center;
      align-items: center;
      z-index: 1000;
      opacity: 1;
      transition: opacity 0.5s;
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

    /* Navigation Bar - Holographic Effect from index.jsp */
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

    .navbar ul li a:hover:before,
    .navbar ul li a.active:before {
      left: 100%;
    }

    .navbar ul li a:hover,
    .navbar ul li a.active {
      color: var(--primary-color);
      text-shadow: 0 0 10px var(--glow-color);
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

    .mobile-menu-toggle {
      display: none;
      color: var(--text-color);
      font-size: 1.5rem;
      cursor: pointer;
    }

    .mobile-menu-toggle.active i::before {
      content: '\f00d';
    }

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
      animation: rotate 60s linear infinite;
      z-index: -1;
    }

    @keyframes rotate {
      0% { transform: rotate(0deg); }
      100% { transform: rotate(360deg); }
    }

    .contact-title {
      font-family: 'Orbitron', sans-serif;
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
      transition: transform 0.3s;
    }

    .contact-info:hover {
      transform: translateY(-5px);
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
<<<<<<< HEAD
      width: 60px;
=======
      width: 60px77
>>>>>>> a4aa5e08dd87c6be13716062d6db6180df5c0c98
      height: 60px;
      background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      color: var(--dark-color);
      font-size: 1.5rem;
      flex-shrink: 0;
      transition: transform 0.3s;
    }

    .info-item:hover .info-icon {
      transform: rotate(360deg);
    }

    .info-content h3 {
      font-size: 1.5rem;
      margin-bottom: 10px;
      color: var(--primary-color);
    }

    .info-content p, .info-content a {
      color: var(--text-muted);
      transition: var(--transition);
      text-decoration: none;
    }

    .info-content a:hover {
      color: var(--primary-color);
      text-shadow: 0 0 10px rgba(0, 242, 254, 0.5);
    }

    .contact-form {
      background: var(--card-bg);
      backdrop-filter: blur(10px);
      border-radius: var(--border-radius);
      padding: 50px 40px;
      border: 1px solid rgba(0, 242, 254, 0.2);
      box-shadow: var(--box-shadow);
      position: relative;
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
      animation: fadeIn 0.5s ease-in;
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(10px); }
      to { opacity: 1; transform: translateY(0); }
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
<<<<<<< HEAD
      box-shadow: var(--box-shadow);
=======
      box-shadow: var--box-shadow);
>>>>>>> a4aa5e08dd87c6be13716062d6db6180df5c0c98
      transition: transform 0.3s;
    }

    .map-container:hover {
      transform: scale(1.02);
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

    .particles {
      position: absolute;
      width: 100%;
      height: 100%;
      top: 0;
      left: 0;
      pointer-events: none;
      z-index: -1;
    }

    .particle {
      position: absolute;
      width: 3px;
      height: 3px;
      background: var(--primary-color);
      border-radius: 50%;
      opacity: 0.6;
      animation: particleMove 15s linear infinite;
    }

    @keyframes particleMove {
      0% { transform: translateY(0) translateX(0); opacity: 0; }
      10% { opacity: 0.6; }
      90% { opacity: 0.6; }
      100% { transform: translateY(-1000px) translateX(200px); opacity: 0; }
    }

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

    @media (max-width: 992px) {
      .navbar {
        display: none;
        position: absolute;
        top: 100%;
        left: 0;
        width: 100%;
        background: rgba(10, 15, 36, 0.95);
        padding: 20px 0;
      }

      .navbar.active {
        display: block;
      }

      .navbar ul {
        flex-direction: column;
        gap: 20px;
        text-align: center;
      }

      .mobile-menu-toggle {
        display: block;
      }
    }

    @media (max-width: 768px) {
      .contact-title { font-size: 2.8rem; }
      .contact-subtext { font-size: 1.2rem; }
    }

    @media (max-width: 576px) {
      .auth-buttons {
        display: none;
      }
      .contact-title { font-size: 2.2rem; }
      .contact-subtext { font-size: 1.1rem; }
      .info-item { flex-direction: column; gap: 15px; }
      .info-icon { width: 50px; height: 50px; font-size: 1.2rem; }
    }
  </style>
</head>
<body>
<%
  String success = null;
  String error = null;
  if ("POST".equalsIgnoreCase(request.getMethod())) {
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String subject = request.getParameter("subject");
    String message = request.getParameter("message");

    List<String> errors = new ArrayList<>();
    if (name == null || name.trim().isEmpty()) errors.add("Name is required");
    if (email == null || email.trim().isEmpty() || !email.contains("@")) errors.add("Valid email is required");
    if (subject == null || subject.trim().isEmpty()) errors.add("Subject is required");
    if (message == null || message.trim().isEmpty()) errors.add("Message is required");

    if (errors.isEmpty()) {
      String filePath = application.getRealPath("/") + "WEB-INF/data/sendmessage.txt";
      File file = new File(filePath);
      if (!file.exists()) {
        try {
          file.getParentFile().mkdirs();
          file.createNewFile();
        } catch (IOException e) {
          errors.add("Failed to create file: " + e.getMessage());
        }
      }
      if (errors.isEmpty()) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file, true))) {
          String timestamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
          writer.write(String.format("%s | %s | %s | %s | %s", timestamp, name, email, subject, message));
          writer.newLine();
          success = "true";
        } catch (IOException e) {
          errors.add("Failed to save message: " + e.getMessage());
        }
      }
    }
    if (!errors.isEmpty()) {
      error = String.join(", ", errors);
    }
  }
%>

<!-- Preloader -->
<div class="preloader">
  <div class="loader"></div>
</div>

<!-- Particles Background -->
<div class="particles"></div>

<!-- Header Section -->
<header class="header">
  <div class="container">
    <a href="index.jsp" class="logo">
      <img src="./images/favicon-32x32.png" alt="NexoraSkill Logo">
      <span>NexoraSkill</span>
    </a>
    <nav class="navbar">
      <ul>
        <li><a href="index.jsp" class="nav-link"><i class="fas fa-home nav-icon"></i><span>Home</span><div class="nav-underline"></div></a></li>
        <li><a href="courses.jsp" class="nav-link"><i class="fas fa-book nav-icon"></i><span>Courses</span><div class="nav-underline"></div></a></li>
        <li><a href="Apply%20Course.jsp" class="nav-link"><i class="fas fa-rocket nav-icon"></i><span>Apply</span><div class="nav-underline"></div></a></li>
        <li><a href="aboutus.jsp" class="nav-link"><i class="fas fa-info-circle nav-icon"></i><span>About</span><div class="nav-underline"></div></a></li>
        <li><a href="contact.jsp" class="nav-link active"><i class="fas fa-envelope nav-icon"></i><span>Contact</span><div class="nav-underline"></div></a></li>
      </ul>
    </nav>
    <div class="auth-buttons">
      <a href="logIn.jsp" class="btn btn-login"><i class="fas fa-sign-in-alt"></i><span>Login</span></a>
      <a href="signUp.jsp" class="btn btn-signup"><i class="fas fa-user-plus"></i><span>Sign Up</span></a>
    </div>
    <div class="mobile-menu-toggle"><i class="fas fa-bars"></i></div>
  </div>
</header>

<!-- Hero Section -->
<section class="contact-hero">
  <h1 class="contact-title">Contact Us</h1>
  <p class="contact-subtext">Reach out to us for support, inquiries, or collaboration. We're here to help you navigate the cosmos of learning!</p>
</section>

<!-- Contact Information Section -->
<section class="contact-container">
  <div class="contact-info">
    <div class="info-item">
      <div class="info-icon"><i class="fas fa-map-marker-alt"></i></div>
      <div class="info-content">
        <h3>Location</h3>
        <p>123 Cosmic Avenue, Nebula City, NC 45678</p>
      </div>
    </div>
    <div class="info-item">
      <div class="info-icon"><i class="fas fa-phone"></i></div>
      <div class="info-content">
        <h3>Phone</h3>
        <a href="tel:+1234567890">+1 (234) 567-890</a>
      </div>
    </div>
    <div class="info-item">
      <div class="info-icon"><i class="fas fa-envelope"></i></div>
      <div class="info-content">
        <h3>Email</h3>
        <a href="mailto:support@nexoraskill.com">support@nexoraskill.com</a>
      </div>
    </div>
  </div>

  <!-- Contact Form Section -->
  <div class="contact-form">
    <h2>Send Us a Message</h2>
    <% if ("true".equals(success)) { %>
    <div class="alert alert-success" role="alert">
      <i class="fas fa-check-circle"></i> Your message has been sent successfully!
    </div>
    <% } else if (error != null) { %>
    <div class="alert alert-error" role="alert">
      <i class="fas fa-exclamation-circle"></i> <%= error %>
    </div>
    <% } %>

    <form action="contact.jsp" method="POST" id="contactForm" novalidate>
      <div class="form-group">
        <input type="text" name="name" id="name" placeholder=" " required aria-required="true">
        <label for="name">Your Name</label>
      </div>
      <div class="form-group">
        <input type="email" name="email" id="email" placeholder=" " required aria-required="true">
        <label for="email">Your Email</label>
      </div>
      <div class="form-group">
        <input type="text" name="subject" id="subject" placeholder=" " required aria-required="true">
        <label for="subject">Subject</label>
      </div>
      <div class="form-group">
        <textarea name="message" id="message" placeholder=" " required aria-required="true"></textarea>
        <label for="message">Your Message</label>
      </div>
      <button type="submit" class="submit-btn">
        <i class="fas fa-paper-plane"></i> Send Message
      </button>
    </form>
  </div>
</section>

<!-- Map Section -->
<section class="contact-container">
  <div class="map-container">
    <iframe src="https://www.google.com/maps/embed?pb=..." frameborder="0" allowfullscreen></iframe>
  </div>
</section>

<!-- Footer -->
<footer class="footer">
  <div class="container">
    <p>© 2025 NexoraSkill. All rights reserved.</p>
  </div>
</footer>

<!-- Scroll To Top Button -->
<div class="scroll-top">
  <i class="fas fa-arrow-up"></i>
</div>

<script>
  // Preloader
  window.addEventListener('load', () => {
    const preloader = document.querySelector('.preloader');
    preloader.classList.add('fade-out');
    setTimeout(() => preloader.style.display = 'none', 500);
  });

  // Header scroll effect
  window.addEventListener('scroll', () => {
    const header = document.querySelector('.header');
    const scrollTop = document.querySelector('.scroll-top');
    if (window.scrollY > 100) header.classList.add('scrolled');
    else header.classList.remove('scrolled');
    if (window.scrollY > 300) scrollTop.classList.add('active');
    else scrollTop.classList.remove('active');
  });

  // Mobile Menu Toggle
  const mobileMenuToggle = document.querySelector('.mobile-menu-toggle');
  const navbar = document.querySelector('.navbar');
  mobileMenuToggle.addEventListener('click', () => {
    navbar.classList.toggle('active');
    mobileMenuToggle.classList.toggle('active');
  });

  document.querySelectorAll('.nav-link').forEach(link => {
    link.addEventListener('click', () => {
      if (window.innerWidth <= 992) {
        navbar.classList.remove('active');
        mobileMenuToggle.classList.remove('active');
      }
    });
  });

<<<<<<< HEAD
=======


>>>>>>> a4aa5e08dd87c6be13716062d6db6180df5c0c98
  document.querySelector('.scroll-top').addEventListener('click', () => {
    window.scrollTo({ top: 0, behavior: 'smooth' });
  });

  // Particle Animation
  function createParticles(count) {
    const particlesDiv = document.querySelector('.particles');
    for (let i = 0; i < count; i++) {
      const particle = document.createElement('div');
      particle.className = 'particle';
      particle.style.left = Math.random() * 100 + 'vw';
      particle.style.top = Math.random() * 100 + 'vh';
      particle.style.animationDuration = Math.random() * 20 + 10 + 's';
      particle.style.animationDelay = Math.random() * 5 + 's';
      particlesDiv.appendChild(particle);
    }
  }
  createParticles(100);

  // Form Validation
  document.getElementById('contactForm').addEventListener('submit', (e) => {
    const inputs = document.querySelectorAll('input[required], textarea[required]');
    let isValid = true;
    inputs.forEach(input => {
      if (!input.value.trim()) {
        isValid = false;
        input.style.borderColor = '#ff0000';
      } else {
        input.style.borderColor = '';
      }
    });
    if (!isValid) e.preventDefault();
  });
</script>
</body>
</html>