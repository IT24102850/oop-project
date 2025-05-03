<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.time.*, java.time.format.DateTimeFormatter" %>
<%
  // Handle form submission
  if ("POST".equalsIgnoreCase(request.getMethod())) {
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String subject = request.getParameter("subject");
    String message = request.getParameter("message");

    if (name != null && !name.isEmpty() &&
            email != null && !email.isEmpty() &&
            subject != null && !subject.isEmpty() &&
            message != null && !message.isEmpty()) {

      // Format the message with timestamp
      String timestamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
      String messageData = String.format(
              "[%s]%nName: %s%nEmail: %s%nSubject: %s%nMessage: %s%n%n",
              timestamp, name, email, subject, message
      );

      // Get the real path to data directory
      String dataDir = application.getRealPath("/WEB-INF/data");
      File directory = new File(dataDir);
      if (!directory.exists()) {
        directory.mkdirs();
      }

      // Write to file
      try (PrintWriter writer = new PrintWriter(new FileWriter(dataDir + "/contact_messages.txt", true))) {
        writer.print(messageData);
        request.setAttribute("success", true);
      } catch (IOException e) {
        request.setAttribute("error", true);
        e.printStackTrace();
      }
    } else {
      request.setAttribute("error", true);
    }
  }
%>
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
      line-height: 1.7;
    }

    /* Header and Footer styles would be inherited from your main CSS */

    .contact-hero {
      padding: 180px 5% 100px;
      text-align: center;
      position: relative;
    }

    .contact-title {
      font-family: 'Orbitron', sans-serif;
      font-size: 3.5rem;
      margin-bottom: 30px;
      background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      text-shadow: 0 0 30px rgba(0, 242, 254, 0.3);
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
      gap: 40px;
      max-width: 1200px;
      margin: 0 auto 80px;
      padding: 0 5%;
    }

    .contact-info {
      background: var(--card-bg);
      backdrop-filter: blur(10px);
      border-radius: var(--border-radius);
      padding: 40px;
      border: 1px solid rgba(0, 242, 254, 0.2);
      box-shadow: var(--box-shadow);
    }

    .info-item {
      display: flex;
      align-items: flex-start;
      gap: 20px;
      margin-bottom: 30px;
    }

    .info-icon {
      width: 50px;
      height: 50px;
      background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      color: var(--dark-color);
      font-size: 1.2rem;
      flex-shrink: 0;
    }

    .info-content h3 {
      font-size: 1.3rem;
      margin-bottom: 8px;
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
      padding: 40px;
      border: 1px solid rgba(0, 242, 254, 0.2);
      box-shadow: var(--box-shadow);
    }

    .form-group {
      margin-bottom: 25px;
    }

    .form-group label {
      display: block;
      margin-bottom: 8px;
      color: var(--primary-color);
    }

    .form-group input,
    .form-group textarea {
      width: 100%;
      padding: 12px 15px;
      background: rgba(10, 15, 36, 0.5);
      border: 1px solid rgba(0, 242, 254, 0.3);
      border-radius: 8px;
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

    .submit-btn {
      width: 100%;
      padding: 15px;
      background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
      color: var(--dark-color);
      border: none;
      border-radius: 8px;
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
      border-radius: 8px;
      margin-bottom: 25px;
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
    }

    @media (max-width: 768px) {
      .contact-title {
        font-size: 2.5rem;
      }

      .contact-subtext {
        font-size: 1.1rem;
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
        <li><a href="Apply%20Course.jsp">Apply Course</a></li>
        <li><a href="aboutus.jsp">About Us</a></li>
        <li><a href="contact.jsp" class="active">Contact</a></li>
      </ul>
    </nav>
    <div class="auth-buttons">
      <a href="logIn.jsp" class="btn btn-login"><i class="fas fa-sign-in-alt"></i> Login</a>
      <a href="signUp.jsp" class="btn btn-signup"><i class="fas fa-user-plus"></i> Sign Up</a>
    </div>
  </div>
</header>

<!-- Contact Hero Section -->
<section class="contact-hero">
  <h1 class="contact-title">CONTACT US</h1>
  <p class="contact-subtext">Have questions about our courses or platform? Our team is ready to help you with any inquiries.</p>
</section>

<!-- Contact Container -->
<div class="contact-container">
  <!-- Contact Information -->
  <div class="contact-info">
    <div class="info-item">
      <div class="info-icon">
        <i class="fas fa-map-marker-alt"></i>
      </div>
      <div class="info-content">
        <h3>Our Location</h3>
        <p>123 Future Tech Park<br>Innovation District, Colombo 05<br>Sri Lanka</p>
      </div>
    </div>

    <div class="info-item">
      <div class="info-icon">
        <i class="fas fa-envelope"></i>
      </div>
      <div class="info-content">
        <h3>Email Us</h3>
        <a href="mailto:info@nexoraskill.com">info@nexoraskill.com</a><br>
        <a href="mailto:support@nexoraskill.com">support@nexoraskill.com</a>
      </div>
    </div>

    <div class="info-item">
      <div class="info-icon">
        <i class="fas fa-phone-alt"></i>
      </div>
      <div class="info-content">
        <h3>Call Us</h3>
        <a href="tel:+94112345678">+94 112 345 678</a><br>
        <a href="tel:+94771234567">+94 771 234 567</a>
      </div>
    </div>

    <div class="info-item">
      <div class="info-icon">
        <i class="fas fa-clock"></i>
      </div>
      <div class="info-content">
        <h3>Working Hours</h3>
        <p>Monday-Friday: 8:00 AM - 6:00 PM<br>
          Saturday: 9:00 AM - 2:00 PM<br>
          Sunday: Closed</p>
      </div>
    </div>
  </div>

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
        <label for="name">Your Name</label>
        <input type="text" id="name" name="name" required>
      </div>

      <div class="form-group">
        <label for="email">Your Email</label>
        <input type="email" id="email" name="email" required>
      </div>

      <div class="form-group">
        <label for="subject">Subject</label>
        <input type="text" id="subject" name="subject" required>
      </div>

      <div class="form-group">
        <label for="message">Your Message</label>
        <textarea id="message" name="message" required></textarea>
      </div>

      <button type="submit" class="submit-btn">
        <i class="fas fa-paper-plane"></i> Send Message
      </button>
    </form>
  </div>
</div>

<!-- Map Section -->
<div class="map-container">
  <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3960.798511757687!2d79.8607554153939!3d6.914657295003692!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3ae2596b5b6e7c07%3A0x1c1e7a2b5b6e7c07!2sFuture%20Tech%20Park!5e0!3m2!1sen!2slk!4v1620000000000!5m2!1sen!2slk" allowfullscreen="" loading="lazy"></iframe>
</div>

<!-- Footer -->
<footer class="footer">
  <div class="footer-grid">
    <div class="footer-col">
      <a href="index.jsp" class="footer-logo">NexoraSkill</a>
      <p class="footer-about">The premier platform for future-ready education. We're revolutionizing how the world learns technology.</p>
      <div class="social-links">
        <a href="#" class="social-link"><i class="fab fa-facebook-f"></i></a>
        <a href="#" class="social-link"><i class="fab fa-twitter"></i></a>
        <a href="#" class="social-link"><i class="fab fa-linkedin-in"></i></a>
        <a href="#" class="social-link"><i class="fab fa-instagram"></i></a>
      </div>
    </div>
    <div class="footer-col">
      <h3 class="footer-title">Quick Links</h3>
      <ul class="footer-links">
        <li><a href="index.jsp">Home</a></li>
        <li><a href="courses.jsp">Courses</a></li>
        <li><a href="registration.jsp">Registration</a></li>
        <li><a href="contact.jsp">Contact</a></li>
      </ul>
    </div>
    <div class="footer-col">
      <h3 class="footer-title">Tech Tracks</h3>
      <ul class="footer-links">
        <li><a href="#">AI & Machine Learning</a></li>
        <li><a href="#">Cloud Computing</a></li>
        <li><a href="#">Cybersecurity</a></li>
        <li><a href="#">Data Science</a></li>
      </ul>
    </div>
    <div class="footer-col">
      <h3 class="footer-title">Support</h3>
      <ul class="footer-links">
        <li><a href="#">Help Center</a></li>
        <li><a href="#">Privacy Policy</a></li>
        <li><a href="#">Terms of Service</a></li>
        <li><a href="#">FAQ</a></li>
      </ul>
    </div>
  </div>
  <div class="footer-bottom">
    <p>&copy; 2023 NexoraSkill. All rights reserved.</p>
  </div>
</footer>

<!-- Scroll To Top Button -->
<div class="scroll-top">
  <i class="fas fa-arrow-up"></i>
</div>

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
  });

  // Scroll to top button
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
</script>
</body>
</html>