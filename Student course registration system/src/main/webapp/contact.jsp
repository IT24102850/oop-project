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
      substituter-bottom-color: var(--secondary-color);
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

    .navbar ul li a:hover,
    .navbar ul li a.active {
      color: var(--primary-color);
      text-shadow: 0 0 10px var(--glow-color);
    }

    .navbar ul li a:hover:before {
      left: 100%;
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

    /* Hero Section */
    .hero {
      padding: 180px 5% 100px;
      text-align: center;
      position: relative;
      overflow: hidden;
      z-index: 2;
    }

    .hero:before {
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

    @keyframes rotate {
      0% { transform: rotate(0deg); }
      100% { transform: rotate(360deg); }
    }

    .hero h1 {
      font-size: 4rem;
      margin-bottom: 30px;
      background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      text-shadow: 0 0 30px rgba(0, 242, 254, 0.3);
      animation: textGlow 3s infinite alternate;
    }

    .hero h1:after {
      content: '';
      position: absolute;
      bottom: -10px;
      left: 50%;
      transform: translateX(-50%);
      width: 100px;
      height: 4px;
      background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
      border-radius: 2px;
    }

    .hero p {
      font-size: 1.4rem;
      color: var(--text-muted);
      max-width: 700px;
      margin: 0 auto;
    }

    @keyframes textGlow {
      0% { text-shadow: 0 0 10px rgba(0, 242, 254, 0.3); }
      100% { text-shadow: 0 0 30px rgba(0, 242, 254, 0.6); }
    }

    /* Contact Information Section */
    .contact-info {
      padding: 150px 5%;
      background: linear-gradient(to bottom, transparent, var(--darker-color));
      position: relative;
      z-index: 2;
    }

    .contact-info:before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: url('./images/grid-pattern.png') center/cover;
      opacity: 0.05;
      z-index: -1;
    }

    .contact-info h2 {
      text-align: center;
      font-size: 3rem;
      margin-bottom: 100px;
      background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      position: relative;
      animation: fadeInUp 1s ease-out;
    }

    .contact-info h2:after {
      content: '';
      position: absolute;
      bottom: -20px;
      left: 50%;
      transform: translateX(-50%);
      width: 100px;
      height: 4px;
      background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
      border-radius: 2px;
    }

    .info-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
      gap: 40px;
      max-width: 1300px;
      margin: 0 auto;
    }

    .info-item {
      background: var(--card-bg);
      backdrop-filter: blur(10px);
      border-radius: var(--border-radius);
      padding: 50px 40px;
      text-align: center;
      transition: var(--transition);
      border: 1px solid rgba(0, 242, 254, 0.2);
      box-shadow: var(--box-shadow);
      position: relative;
      overflow: hidden;
      z-index: 1;
      animation: fadeInUp 1s ease-out;
    }

    .info-item:before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: linear-gradient(135deg, rgba(0, 242, 254, 0.1), transparent);
      z-index: -1;
      opacity: 0;
      transition: var(--transition);
    }

    .info-item:hover {
      transform: translateY(-15px);
      box-shadow: 0 20px 50px rgba(0, 0, 0, 0.5);
      border-color: rgba(0, 242, 254, 0.4);
    }

    .info-item:hover:before {
      opacity: 1;
    }

    .info-item i {
      font-size: 4rem;
      margin-bottom: 30px;
      color: var(--primary-color);
      transition: var(--transition);
    }

    .info-item:hover i {
      transform: scale(1.2);
      filter: drop-shadow(0 0 10px var(--glow-color));
    }

    .info-item h3 {
      font-size: 1.8rem;
      margin-bottom: 20px;
      color: var(--text-color);
      transition: var(--transition);
    }

    .info-item:hover h3 {
      color: var(--primary-color);
    }

    .info-item p {
      color: var(--text-muted);
      font-size: 1.1rem;
      transition: var(--transition);
    }

    .info-item:hover p {
      color: var(--text-color);
    }

    .map {
      margin-top: 60px;
      border-radius: var(--border-radius);
      overflow: hidden;
      box-shadow: var(--box-shadow);
      border: 1px solid rgba(0, 242, 254, 0.2);
    }

    /* Contact Form Section */
    .contact-form {
      padding: 150px 5%;
      background: linear-gradient(to bottom, transparent, var(--dark-color));
      position: relative;
      z-index: 2;
    }

    .contact-form:before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: url('./images/dots-pattern.png') center/cover;
      opacity: 0.05;
      z-index: -1;
    }

    .contact-form h2 {
      text-align: center;
      font-size: 3rem;
      margin-bottom: 100px;
      background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      position: relative;
      animation: fadeInUp 1s ease-out;
    }

    .contact-form h2:after {
      content: '';
      position: absolute;
      bottom: -20px;
      left: 50%;
      transform: translateX(-50%);
      width: 100px;
      height: 4px;
      background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
      border-radius: 2px;
    }

    .contact-form form {
      max-width: 700px;
      margin: 0 auto;
      background: var(--card-bg);
      backdrop-filter: blur(10px);
      padding: 40px;
      border-radius: var(--border-radius);
      border: 1px solid rgba(0, 242, 254, 0.2);
      box-shadow: var(--box-shadow);
      transition: var(--transition);
    }

    .contact-form form:hover {
      transform: translateY(-10px);
      box-shadow: 0 20px 50px rgba(0, 0, 0, 0.5);
    }

    .form-group {
      margin-bottom: 20px;
      position: relative;
    }

    .form-group input,
    .form-group textarea {
      width: 100%;
      padding: 15px;
      border: 1px solid rgba(0, 242, 254, 0.2);
      border-radius: 8px;
      background: var(--glass-bg);
      color: var(--text-color);
      font-size: 1rem;
      transition: var(--transition);
    }

    .form-group input:focus,
    .form-group textarea:focus {
      outline: none;
      border-color: var(--primary-color);
      box-shadow: 0 0 10px var(--glow-color);
    }

    .form-group textarea {
      resize: vertical;
      min-height: 150px;
    }

    .form-group label {
      position: absolute;
      top: 15px;
      left: 15px;
      color: var(--text-muted);
      font-size: 1rem;
      transition: var(--transition);
      pointer-events: none;
    }

    .form-group input:focus + label,
    .form-group input:not(:placeholder-shown) + label,
    .form-group textarea:focus + label,
    .form-group textarea:not(:placeholder-shown) + label {
      top: -10px;
      left: 10px;
      font-size: 0.8rem;
      color: var(--primary-color);
      background: var(--card-bg);
      padding: 0 5px;
    }

    .btn-primary {
      width: 100%;
      padding: 15px;
      font-size: 1.2rem;
      background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
      color: var(--dark-color);
      border: none;
      border-radius: 50px;
      cursor: pointer;
      transition: var(--transition);
      box-shadow: 0 10px 25px rgba(0, 242, 254, 0.4);
      position: relative;
      overflow: hidden;
      z-index: 1;
    }

    .btn-primary:before {
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

    .btn-primary:hover {
      transform: translateY(-5px);
      box-shadow: 0 15px 35px rgba(0, 242, 254, 0.6);
    }

    .btn-primary:hover:before {
      width: 100%;
    }

    /* Footer Section */
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

    .footer-links li:hover:before {
      transform: translateX(5px);
    }

    .footer-links a {
      color: var(--text-muted);
      text-decoration: none;
      transition: var(--transition);
      font-size: 1.1rem;
      display: inline-block;
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

    /* Particle System */
    .particles {
      position: absolute;
      width: 100%;
      height: 100%;
      overflow: hidden;
      z-index: 0;
    }

    .particle {
      position: absolute;
      width: 3px;
      height: 3px;
      background: var(--primary-color);
      border-radius: 50%;
      opacity: 0.6;
      filter: blur(1px);
      animation: particleMove linear infinite;
    }

    @keyframes particleMove {
      0% {
        transform: translateY(0) translateX(0);
        opacity: 0;
      }
      10% {
        opacity: 0.6;
      }
      90% {
        opacity: 0.6;
      }
      100% {
        transform: translateY(-1000px) translateX(200px);
        opacity: 0;
      }
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
      .hero h1 {
        font-size: 3.8rem;
      }
    }

    @media (max-width: 992px) {
      .hero {
        padding-top: 200px;
        padding-bottom: 100px;
      }

      .hero h1 {
        font-size: 3rem;
      }

      .hero p {
        font-size: 1.2rem;
      }

      .info-grid {
        grid-template-columns: 1fr;
      }

      .contact-form h2 {
        font-size: 2.5rem;
      }
    }

    @media (max-width: 768px) {
      .navbar {
        display: none;
      }

      .hero h1 {
        font-size: 2.8rem;
      }

      .hero p {
        font-size: 1.1rem;
      }

      .contact-info h2 {
        font-size: 2.5rem;
      }

      .contact-form h2 {
        font-size: 2.2rem;
      }

      .footer-grid {
        grid-template-columns: 1fr;
        gap: 40px;
      }
    }

    @media (max-width: 576px) {
      .auth-buttons {
        display: none;
      }

      .hero h1 {
        font-size: 2.5rem;
      }

      .hero p {
        font-size: 1rem;
      }

      .contact-info h2 {
        font-size: 2rem;
      }

      .contact-form h2 {
        font-size: 1.8rem;
      }

      .footer-logo {
        font-size: 1.8rem;
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
      <img src="${pageContext.request.contextPath}/images/favicon-32x32.png" alt="NexoraSkill Logo">
      <span>NexoraSkill</span>
    </a>

    <nav class="navbar">
      <ul>
        <li><a href="index.jsp">Home</a></li>
        <li><a href="courses.jsp">Courses</a></li>
        <li><a href="Apply%20Course.jsp">Registration</a></li>
        <li><a href="aboutus.jsp">About Us</a></li>
        <li><a href="contact.jsp" class="active">Contact Us</a></li>
      </ul>
    </nav>

    <div class="auth-buttons">
      <a href="logIn.jsp" class="btn btn-login"><i class="fas fa-sign-in-alt"></i> Login</a>
      <a href="signUp.jsp" class="btn btn-signup"><i class="fas fa-user-plus"></i> Sign Up</a>
    </div>
  </div>
</header>

<!-- Hero Section -->
<section class="hero">
  <div class="container">
    <h1>We’re Here to Help!</h1>
    <p>Reach out to us for assistance with course registration, technical issues, or general inquiries.</p>
    <div class="particles" id="particles-js"></div>
  </div>
</section>

<!-- Contact Information Section -->
<section class="contact-info">
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
</section>

<!-- Contact Form Section -->
<section class="contact-form">
  <h2>Send Us a Message</h2>
  <form action="${pageContext.request.contextPath}/contact" method="POST">
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
        <li><a href="Apply%20Course.jsp">Registration</a></li>
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
        <li><a href="#">Careers </a></li>
        <li><a href="#">Press</a></li>
        <li><a href="#">Investors</a></li>
        <li><a href="#">Privacy Policy</a></li>
        <li><a href="#">Terms of Service</a></li>
      </ul>
    </div>
  </div>
  <div class="footer-bottom">
    <p>&copy; 2023 NexoraSkill. All rights reserved. | Designed with <i class="fas fa-heart" style="color: var(--accent-color);"></i> for the future of education</p>
  </div>
</footer> //footer section end

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

  // Header Scroll Effect
  window.addEventListener('scroll', function() {
    const header = document.querySelector('.header');
    if (window.scrollY > 100) {
      header.classList.add('scrolled');
    } else {
      header.classList.remove('scrolled');
    }
  });

  // Scroll To Top Button
  const scrollTop = document.querySelector('.scroll-top');
  window.addEventListener('scroll', function() {
    if (window.scrollY > 300) {
      scrollTop.classList.add('active');
    } else {
      scrollTop.classList.remove('active');
    }
  });

  scrollTop.addEventListener('click', function() {
    window.scrollTo({
      top: 0,
      behavior: 'smooth'
    });
  });

  // Particle System
  document.addEventListener('DOMContentLoaded', function() {
    const particlesContainer = document.getElementById('particles-js');
    const particleCount = 100;

    for (let i = 0; i < particleCount; i++) {
      const particle = document.createElement('div');
      particle.classList.add('particle');

      particle.style.left = Math.random() * 100 + '%';
      particle.style.top = Math.random() * 100 + '%';

      const size = Math.random() * 4 + 1;
      particle.style.width = size + 'px';
      particle.style.height = size + 'px';

      particle.style.opacity = Math.random() * 0.7 + 0.1;

      particle.style.animationDuration = Math.random() * 25 + 15 + 's';
      particle.style.animationDelay = Math.random() * 5 + 's';

      particlesContainer.appendChild(particle);
    }
  });

  // Form Validation
  document.querySelector('form').addEventListener('submit', function(e) {
    const name = document.getElementById('name').value.trim();
    const email = document.getElementById('email').value.trim();
    const subject = document.getElementById('subject').value.trim();
    const message = document.getElementById('message').value.trim();

    if (!name || !email || !subject || !message) {
      e.preventDefault();
      alert('Please fill in all fields.');
      return;
    }

    if (!/^[a-zA-Z\s]+$/.test(name)) {
      e.preventDefault();
      alert('Name should only contain letters and spaces.');
      return;
    }

    if (!/^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/.test(email)) {
      e.preventDefault();
      alert('Please enter a valid email address.');
      return;
    }
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
</script>
</body>
</html>