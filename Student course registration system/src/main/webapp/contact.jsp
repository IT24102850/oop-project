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
  <!-- All your existing head content remains the same -->
  <!-- ... -->
</head>
<body>
<!-- Preloader -->
<div class="preloader">
  <div class="loader"></div>
</div>

<!-- Header Section -->
<header class="header">
  <!-- Your existing header content remains the same -->
  <!-- ... -->
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

  <% if (request.getAttribute("error") != null) { %>
  <div class="alert alert-error" style="background: rgba(255,0,0,0.1); color: #ff0000; padding: 15px; border-radius: 8px; margin-bottom: 20px; border: 1px solid #ff0000;">
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
  // Your existing JavaScript remains the same
  // ...
</script>
</body>
</html>