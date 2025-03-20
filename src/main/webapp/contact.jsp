<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Contact Us - NexoraSkill</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/contactus.css">
  <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.ico">
  <style>
    /* General Reset */
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    :root {
      --primary-color: #009acd;
      --secondary-color: #00ffcc;
      --accent-color: #ff6b6b;
      --dark-color: #0a192f;
      --text-color: #ffffff;
      --hover-color: #007ba7;
      --glow-color: rgba(0, 255, 204, 0.6);
    }

    body {
      font-family: 'Poppins', sans-serif;
      background: var(--dark-color);
      color: var(--text-color);
      overflow-x: hidden;
    }

    /* Header Section */
    .header {
      position: fixed;
      top: 0;
      width: 100%;
      z-index: 1000;
      background-color: var(--dark-color);
      padding: 20px 0;
      border-bottom: 1px solid #333;
    }

    .container {
      width: 90%;
      max-width: 1200px;
      margin: 0 auto;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .logo {
      display: flex;
      align-items: center;
      gap: 10px;
      font-size: 1.5rem;
      font-weight: 600;
      color: var(--text-color);
    }

    .logo img {
      height: 40px;
      transition: transform 0.3s ease;
    }

    .logo:hover img {
      transform: rotate(15deg);
    }

    .navbar ul {
      list-style: none;
      display: flex;
      gap: 20px;
    }

    .navbar ul li a {
      text-decoration: none;
      color: var(--text-color);
      font-weight: 500;
      transition: color 0.3s ease;
    }

    .navbar ul li a:hover,
    .navbar ul li a.active {
      color: var(--primary-color);
    }

    .auth-buttons {
      display: flex;
      gap: 10px;
    }

    .btn-login, .btn-signup {
      padding: 10px 20px;
      border-radius: 25px;
      text-decoration: none;
      font-weight: 500;
      transition: all 0.3s ease;
    }

    .btn-login {
      background: transparent;
      border: 2px solid var(--primary-color);
      color: var(--text-color);
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
      background: var(--hover-color);
    }

    /* Hero Section */
    .hero {
      padding: 150px 0 100px;
      text-align: center;
      background-color: var(--dark-color);
    }

    .hero h1 {
      font-size: 3rem;
      margin-bottom: 20px;
      color: var(--text-color);
      text-shadow: 0 0 10px var(--glow-color);
    }

    .hero p {
      font-size: 1.2rem;
      color: var(--text-color);
    }

    /* Contact Information Section */
    .contact-info {
      padding: 80px 0;
      background-color: var(--dark-color);
    }

    .contact-info h2 {
      text-align: center;
      margin-bottom: 40px;
      font-size: 2.5rem;
      color: var(--text-color);
      text-shadow: 0 0 10px var(--glow-color);
    }

    .info-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
      gap: 20px;
      text-align: center;
    }

    .info-item {
      background-color: #1f1f1f;
      padding: 20px;
      border-radius: 10px;
      transition: transform 0.3s ease;
    }

    .info-item:hover {
      transform: translateY(-10px);
    }

    .info-item i {
      font-size: 32px;
      margin-bottom: 15px;
      color: var(--primary-color);
    }

    .info-item h3 {
      font-size: 24px;
      margin-bottom: 10px;
      color: var(--text-color);
    }

    .info-item p {
      font-size: 16px;
      color: var(--text-color);
    }

    .map {
      margin-top: 40px;
      border-radius: 10px;
      overflow: hidden;
    }

    /* Contact Form Section */
    .contact-form {
      padding: 80px 0;
      background-color: var(--dark-color);
    }

    .contact-form h2 {
      text-align: center;
      margin-bottom: 40px;
      font-size: 2.5rem;
      color: var(--text-color);
      text-shadow: 0 0 10px var(--glow-color);
    }

    .contact-form form {
      max-width: 600px;
      margin: 0 auto;
    }

    .form-group {
      margin-bottom: 20px;
    }

    .form-group input,
    .form-group textarea {
      width: 100%;
      padding: 10px;
      border: 1px solid #333;
      border-radius: 5px;
      background-color: #1f1f1f;
      color: var(--text-color);
      font-size: 16px;
    }

    .form-group textarea {
      resize: vertical;
    }

    .contact-form .btn-primary {
      width: 100%;
      padding: 15px;
      font-size: 18px;
      background: var(--primary-color);
      color: var(--dark-color);
      border: none;
      border-radius: 5px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    .contact-form .btn-primary:hover {
      background: var(--hover-color);
    }

    /* Footer Section */
    .footer {
      background-color: var(--dark-color);
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
      color: var(--text-color);
      transition: color 0.3s ease;
    }

    .footer-links a:hover {
      color: var(--primary-color);
    }

    .footer-social {
      display: flex;
      gap: 15px;
    }

    .footer-social a {
      color: var(--text-color);
      font-size: 24px;
      transition: color 0.3s ease;
    }

    .footer-social a:hover {
      color: var(--primary-color);
    }

    .footer-newsletter {
      text-align: center;
    }

    .footer-newsletter p {
      margin-bottom: 10px;
      color: var(--text-color);
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
      color: var(--text-color);
      font-size: 16px;
    }

    .footer-newsletter button {
      padding: 10px 20px;
      background: var(--primary-color);
      color: var(--dark-color);
      border: none;
      border-radius: 5px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    .footer-newsletter button:hover {
      background: var(--hover-color);
    }
  </style>
</head>
<body>
<!-- Header Section -->
<header class="header">
  <div class="container">
    <div class="logo">
      <img src="./images/favicon-32x32.png" alt="NexoraSkill Logo">
    </div>

    <!-- Navigation Menu -->
    <nav class="navbar">
      <ul>
        <li><a href="index.jsp">Home</a></li>
        <li><a href="courses.jsp">Courses</a></li>
        <li><a href="registration.jsp">Registration</a></li>
        <li><a href="aboutus.jsp">About Us</a></li>
        <li><a href="contact us.jsp" class="active">Contact Us</a></li>
      </ul>
    </nav>

    <!-- Call-to-Action Buttons -->
    <div class="auth-buttons">
      <a href="logIn.jsp" class="btn-login">Login</a>
      <a href="signUp.jsp" class="btn-signup">Sign Up</a>
    </div>
  </div>
</header>

<!-- Hero Section -->
<section class="hero">
  <div class="container">
    <h1>We’re Here to Help!</h1>
    <p>Reach out to us for assistance with course registration, technical issues, or general inquiries.</p>
  </div>
</section>

<!-- Contact Information Section -->
<section class="contact-info">
  <div class="container">
    <h2>Get in Touch</h2>
    <div class="info-grid">
      <div class="info-item">
        <i class="fas fa-phone"></i>
        <h3>Phone</h3>
        <p>+1 (123) 456-7890</p>
      </div>
      <div class="info-item">
        <i class="fas fa-envelope"></i>
        <h3>Email</h3>
        <p>support@nexoraskill.com</p>
      </div>
      <div class="info-item">
        <i class="fas fa-map-marker-alt"></i>
        <h3>Address</h3>
        <p>123 Education Lane, Campus City, CC 12345</p>
      </div>
    </div>
    <div class="map">
      <iframe src="https://www.google.com/maps/embed?pb=..." width="100%" height="400" style="border:0;" allowfullscreen="" loading="lazy"></iframe>
    </div>
  </div>
</section>

<!-- Contact Form Section -->
<section class="contact-form">
  <div class="container">
    <h2>Send Us a Message</h2>
    <form action="${pageContext.request.contextPath}/contact" method="POST">
      <div class="form-group">
        <input type="text" name="name" placeholder="Your Name" required>
      </div>
      <div class="form-group">
        <input type="email" name="email" placeholder="Your Email" required>
      </div>
      <div class="form-group">
        <input type="text" name="subject" placeholder="Subject" required>
      </div>
      <div class="form-group">
        <textarea name="message" placeholder="Your Message" rows="5" required></textarea>
      </div>
      <button type="submit" class="btn btn-primary">Send Message</button>
    </form>
  </div>
</section>


</html>