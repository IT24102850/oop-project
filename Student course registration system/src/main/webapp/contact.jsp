<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.time.*, java.time.format.DateTimeFormatter" %>
<%
  // Handle form submission
  if ("POST".equalsIgnoreCase(request.getMethod())) {
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String subject = request.getParameter("subject");
    String message = request.getParameter("message");

    if (name != null && email != null && subject != null && message != null) {
      // Format the message with timestamp
      String timestamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
      String messageData = String.format(
              "[%s]\nName: %s\nEmail: %s\nSubject: %s\nMessage: %s\n\n",
              timestamp, name, email, subject, message
      );

      // Get the real path to WEB-INF/data directory
      String dataDir = application.getRealPath("/WEB-INF/data");
      File directory = new File(dataDir);
      if (!directory.exists()) {
        directory.mkdirs();
      }

      // Write to file
      try (PrintWriter writer = new PrintWriter(new FileWriter(dataDir + "/contact_messages.txt", true))) {
        writer.println(messageData);
        // Set success flag
        request.setAttribute("success", true);
      } catch (IOException e) {
        // Set error flag
        request.setAttribute("error", true);
        e.printStackTrace();
      }
    } else {
      // Set error flag if any field is missing
      request.setAttribute("error", true);
    }
  }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<<<<<<< HEAD
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
      --text-muted: rgba(255,255,255,0.7);
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

    /* Header Styles */
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

    /* Navigation Styles */
    .navbar ul {
      list-style: none;
      display: flex;
      gap: 25px;
    }

    .nav-link {
      display: flex;
      flex-direction: column;
      align-items: center;
      text-decoration: none;
      color: var(--text-color);
      position: relative;
      padding: 10px 0;
      transition: var(--transition);
    }

    .nav-icon {
      font-size: 1.2rem;
      margin-bottom: 5px;
      transition: var(--transition);
    }

    .nav-text {
      font-size: 0.9rem;
      font-weight: 500;
      transition: var(--transition);
    }

    .nav-underline {
      width: 0;
      height: 2px;
      background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
      position: absolute;
      bottom: 0;
      left: 50%;
      transform: translateX(-50%);
      transition: var(--transition);
    }

    .nav-link:hover,
    .nav-link.active {
      color: var(--primary-color);
      text-shadow: 0 0 10px var(--glow-color);
    }

    .nav-link:hover .nav-icon,
    .nav-link.active .nav-icon {
      transform: translateY(-5px);
      filter: drop-shadow(0 0 5px var(--glow-color));
    }

    .nav-link:hover .nav-underline,
    .nav-link.active .nav-underline {
      width: 100%;
    }

    /* Auth Buttons */
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

    .info-content p, .info-content a {
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
      margin: 0 5% 80px;
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

    /* Footer Styles */
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
      gap: 50px;
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

    .social-link:hover {
      background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
      color: var(--dark-color);
      transform: translateY(-5px);
      box-shadow: 0 10px 20px rgba(0, 242, 254, 0.3);
      border-color: transparent;
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
      padding-top: 50px;
      border-top: 1px solid rgba(0, 242, 254, 0.1);
      color: var(--text-muted);
      font-size: 1rem;
      position: relative;
      z-index: 1;
    }

    .footer-bottom a {
      color: var(--primary-color);
      text-decoration: none;
      transition: var(--transition);
    }

    .footer-bottom a:hover {
      text-shadow: 0 0 10px var(--glow-color);
    }

    /* Scroll To Top Button */
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

    /* Animations */
    @keyframes fadeInUp {
      from {
        opacity: 0;
        transform: translateY(30px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    /* Responsive Design */
    @media (max-width: 1200px) {
      .contact-title {
        font-size: 3.5rem;
      }
    }

    @media (max-width: 992px) {
      .navbar {
        position: fixed;
        top: 80px;
        left: 0;
        width: 100%;
        background: var(--darker-color);
        backdrop-filter: blur(15px);
        -webkit-backdrop-filter: blur(15px);
        border-top: 1px solid rgba(0, 242, 254, 0.1);
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        padding: 20px 0;
        transform: translateY(-150%);
        transition: transform 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        z-index: 999;
      }

      .navbar.active {
        transform: translateY(0);
      }

      .navbar ul {
        flex-direction: column;
        align-items: center;
        gap: 15px;
      }

      .nav-link {
        flex-direction: row;
        gap: 10px;
        padding: 10px 20px;
      }

      .nav-icon {
        margin-bottom: 0;
        font-size: 1rem;
      }

      .nav-text {
        font-size: 1rem;
      }

      .nav-underline {
        display: none;
      }

      .mobile-menu-toggle {
        display: block;
        font-size: 1.5rem;
        cursor: pointer;
        color: var(--text-color);
        transition: var(--transition);
      }

      .mobile-menu-toggle:hover {
        color: var(--primary-color);
      }

      .auth-buttons {
        display: none;
      }

      .contact-title {
        font-size: 3rem;
      }
    }

    @media (max-width: 768px) {
      .contact-title {
        font-size: 2.5rem;
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
=======
  <!-- All your existing head content remains the same -->
  <!-- ... -->
>>>>>>> 7fff411948dcf23ef745a5c695d3a70737054d01
</head>
<body>
<!-- Preloader -->
<div class="preloader">
  <div class="loader"></div>
</div>

<!-- Header Section -->
<header class="header">
<<<<<<< HEAD
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
          <a href="Apply%20Course.jsp" class="nav-link">
            <i class="fas fa-rocket nav-icon"></i>
            <span class="nav-text">Apply</span>
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
=======
  <!-- Your existing header content remains the same -->
  <!-- ... -->
>>>>>>> 7fff411948dcf23ef745a5c695d3a70737054d01
</header>

<!-- Hero Section -->
<section class="hero">
  <!-- Your existing hero content remains the same -->
  <!-- ... -->
</section>

<!-- Contact Information Section -->
<section class="contact-info">
  <!-- Your existing contact info content remains the same -->
  <!-- ... -->
</section>

<!-- Contact Form Section -->
<section class="contact-form">
  <h2>Send Us a Message</h2>

  <%-- Success/Error Messages --%>
  <% if (request.getAttribute("success") != null) { %>
  <div class="alert alert-success" style="background: rgba(0,255,0,0.1); color: #00ff00; padding: 15px; border-radius: 8px; margin-bottom: 20px; border: 1px solid #00ff00;">
    <i class="fas fa-check-circle"></i> Your message has been sent successfully!
  </div>
  <% } %>

<<<<<<< HEAD
  <!-- Contact Form -->
  <div class="contact-form">
    <%-- Success/Error Messages --%>
    <% if (request.getAttribute("success") != null) { %>
    <div class="alert alert-success">
      <i class="fas fa-check-circle"></i> Your message has been sent successfully!
    </div>
    <% } %>

    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-error">
      <i class="fas fa-exclamation-circle"></i> There was an error sending your message. Please try again.
    </div>
    <% } %>

    <form action="contact.jsp" method="POST">
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
=======
  <% if (request.getAttribute("error") != null) { %>
  <div class="alert alert-error" style="background: rgba(255,0,0,0.1); color: #ff0000; padding: 15px; border-radius: 8px; margin-bottom: 20px; border: 1px solid #ff0000;">
    <i class="fas fa-exclamation-circle"></i> There was an error sending your message. Please try again.
>>>>>>> 7fff411948dcf23ef745a5c695d3a70737054d01
  </div>
  <% } %>

  <form action="contact.jsp" method="POST">
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
      <textarea name="message" id="message" placeholder=" " rows="5" required></textarea>
      <label for="message">Your Message</label>
    </div>
    <button type="submit" class="btn-primary"><i class="fas fa-paper-plane"></i> Send Message</button>
  </form>
</section>

<!-- Footer -->
<footer class="footer">
  <!-- Your existing footer content remains the same -->
  <!-- ... -->
</footer>

<!-- Scroll To Top Button -->
<div class="scroll-top">
  <i class="fas fa-arrow-up"></i>
</div>

<!-- Scripts -->
<script>
<<<<<<< HEAD
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
=======
  // Your existing JavaScript remains the same
  // ...
</script>
</body>
</html>
>>>>>>> 7fff411948dcf23ef745a5c695d3a70737054d01
