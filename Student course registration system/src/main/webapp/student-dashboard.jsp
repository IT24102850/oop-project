<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NexoraSkill | Student Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="icon" type="image/png" href="./images/favicon.ico">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Orbitron:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background-color: #0a0f24;
            color: #fff;
            display: flex;
            min-height: 100vh;
        }
        /* Header Section - Holographic Effect */
        .header {
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1000;
            background: rgba(10, 15, 36, 0.95);
            backdrop-filter: blur(15px);
            border-bottom: 1px solid rgba(0, 242, 254, 0.1);
            box-shadow: 0 5px 30px rgba(0, 0, 0, 0.2);
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }
        .container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 5%;
            max-width: 1600px;
            margin: 0 auto;
        }
        .logo {
            font-size: 1.5rem;
            font-weight: 700;
            color: #00f2fe;
            text-decoration: none;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }
        .logo:hover {
            color: #4facfe;
            transform: scale(1.05);
        }
        .navbar ul {
            list-style: none;
            display: flex;
            gap: 25px;
        }
        .navbar ul li a {
            font-family: 'Poppins', sans-serif;
            text-decoration: none;
            color: #ffffff;
            font-weight: 500;
            font-size: 1rem;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }
        .navbar ul li a:hover {
            color: #00f2fe;
            text-shadow: 0 0 10px rgba(0, 242, 254, 0.6);
        }
        .auth-buttons {
            display: flex;
            gap: 15px;
        }
        .btn {
            padding: 8px 15px;
            border-radius: 20px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            font-size: 0.9rem;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        .btn-login {
            background: transparent;
            border: 2px solid #00f2fe;
            color: #00f2fe;
        }
        .btn-login:hover {
            background: #00f2fe;
            color: #0a0f24;
        }
        .btn-signup {
            background: #00f2fe;
            color: #0a0f24;
            border: 2px solid transparent;
        }
        .btn-signup:hover {
            background: transparent;
            color: #00f2fe;
            border-color: #00f2fe;
        }
        .sidebar-toggle {
            display: none;
        }
        .sidebar {
            width: 250px;
            background: #0a0f24;
            height: 100vh;
            padding: 20px 0;
            position: fixed;
            border-right: 1px solid rgba(0, 242, 254, 0.1);
            top: 0;
            left: 0;
        }
        .sidebar .logo {
            text-align: center;
            font-size: 1.5rem;
            margin-bottom: 20px;
        }
        .sidebar .user-profile {
            text-align: center;
            padding: 20px;
            background: rgba(255, 255, 255, 0.05);
            margin: 0 15px;
            border-radius: 10px;
        }
        .sidebar .user-profile .user-avatar {
            background: #00f2fe;
            border-radius: 50%;
            width: 60px;
            height: 60px;
            margin: 0 auto;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 1.2rem;
            color: #0a0f24;
        }
        .sidebar .user-profile h3 {
            margin: 10px 0 5px;
            font-size: 1.1rem;
        }
        .sidebar .user-profile p {
            margin: 0;
            color: #ccc;
            font-size: 0.9rem;
        }
        .sidebar .nav-menu {
            list-style: none;
            padding: 0;
            margin-top: 20px;
        }
        .sidebar .nav-menu .nav-item {
            padding: 10px 20px;
        }
        .sidebar .nav-menu .nav-item a {
            color: #fff;
            text-decoration: none;
            display: flex;
            align-items: center;
            padding: 10px;
            border-radius: 10px;
        }
        .sidebar .nav-menu .nav-item a i {
            margin-right: 10px;
        }
        .sidebar .nav-menu .nav-item a:hover,
        .sidebar .nav-menu .nav-item.active a {
            background: #00f2fe;
            color: #0a0f24;
        }
        .main-content {
            margin-left: 250px;
            padding: 80px 20px 20px;
            width: calc(100% - 250px);
        }
        .dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .dashboard-header .greeting h1 {
            margin: 0;
            font-size: 2rem;
            color: #ff69b4;
        }
        .dashboard-header .greeting p {
            margin: 5px 0 0;
            color: #ccc;
        }
        .dashboard-header .user-actions {
            display: flex;
            align-items: center;
        }
        .dashboard-header .notification-bell {
            position: relative;
            margin-right: 15px;
            cursor: pointer;
        }
        .dashboard-header .notification-bell .notification-count {
            background: #ff4500;
            color: #fff;
            border-radius: 50%;
            padding: 2px 6px;
            font-size: 0.8rem;
            position: absolute;
            top: -5px;
            right: -5px;
        }
        .dashboard-header .btn-outline {
            background: #fff;
            color: #0a0f24;
            border: none;
            padding: 5px 15px;
            border-radius: 20px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
        }
        .stat-card {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 15px;
            padding: 20px;
            text-align: center;
            border: 1px solid rgba(0, 242, 254, 0.2);
        }
        .stat-card h3 {
            margin: 0;
            color: #ccc;
            font-size: 1rem;
        }
        .stat-card .stat-value {
            margin: 10px 0;
            font-size: 2rem;
            color: #00f2fe;
        }
        .stat-card .stat-change {
            font-size: 0.9rem;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 5px;
        }
        .stat-card .positive {
            color: #00ff00;
        }
        .stat-card .negative {
            color: #ff4500;
        }
        .content-section {
            display: none;
        }
        .content-section.active {
            display: block;
        }
        /* Additional styles for other sections */
        .courses-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
        }
        .course-card {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 10px;
            padding: 15px;
        }
        .course-header .course-code {
            font-size: 1.2rem;
            color: #00f2fe;
        }
        .course-header .course-title {
            margin: 5px 0;
        }
        .course-header .course-instructor {
            color: #ccc;
        }
        .course-progress .progress-text {
            display: flex;
            justify-content: space-between;
            margin-bottom: 5px;
        }
        .course-progress .progress-bar {
            background: #333;
            border-radius: 5px;
            height: 10px;
        }
        .course-progress .progress-fill {
            background: #00f2fe;
            height: 100%;
            border-radius: 5px;
        }
        .course-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 10px;
        }
        .course-actions .btn-outline {
            background: transparent;
            border: 1px solid #00f2fe;
            color: #00f2fe;
            padding: 5px 10px;
            border-radius: 5px;
        }
        .course-actions .status.active {
            color: #00ff00;
        }
        .profile-container, .enrollment-section, .deadlines-container, .payment-container, .settings-container {
            background: rgba(255, 255, 255, 0.05);
            border-radius: 10px;
            padding: 20px;
        }
        .profile-header {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        .user-avatar-holographic {
            position: relative;
        }
        .user-avatar-holographic .avatar-image {
            width: 100px;
            height: 100px;
            border-radius: 50%;
        }
        .avatar-actions {
            display: flex;
            gap: 10px;
            margin-top: 10px;
        }
        .profile-tabs {
            display: flex;
            gap: 10px;
            margin: 20px 0;
        }
        .profile-tabs .tab {
            padding: 10px 20px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 5px;
            cursor: pointer;
        }
        .profile-tabs .tab.active {
            background: #00f2fe;
            color: #0a0f24;
        }
        .tab-content .tab-pane {
            display: none;
        }
        .tab-content .tab-pane.active {
            display: block;
        }
        .detail-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }
        .detail-card {
            background: rgba(255, 255, 255, 0.05);
            padding: 15px;
            border-radius: 10px;
        }
        .detail-item {
            margin: 10px 0;
        }
        .detail-item label {
            color: #ccc;
        }
        .profile-actions, .payment-actions {
            margin-top: 20px;
        }
        .btn-primary {
            background: #00f2fe;
            color: #0a0f24;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn-danger {
            background: #ff4500;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
        }
        .enrollment-form, .payment-form, .settings-form {
            display: grid;
            gap: 15px;
            max-width: 500px;
        }
        .form-group {
            display: flex;
            flex-direction: column;
        }
        .form-group label {
            margin-bottom: 5px;
            color: #ccc;
        }
        .form-group input, .form-group select {
            padding: 8px;
            border-radius: 5px;
            border: 1px solid #00f2fe;
            background: transparent;
            color: #fff;
        }
        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 15px;
        }
        .payment-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .payment-table th, .payment-table td {
            padding: 10px;
            border: 1px solid rgba(0, 242, 254, 0.2);
            text-align: left;
        }
        .payment-table th {
            background: rgba(255, 255, 255, 0.1);
        }
        .status-cell.paid { color: #00ff00; }
        .status-cell.pending { color: #00f2fe; }
        .status-cell.overdue { color: #ff4500; }
        .payment-action-form {
            display: inline-block;
            margin-right: 5px;
        }
        .btn-sm {
            padding: 5px 10px;
            font-size: 0.8rem;
        }
        .message {
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .message.success { background: #00ff00; color: #0a0f24; }
        .message.error { background: #ff4500; color: #fff; }
        @media (max-width: 768px) {
            .sidebar {
                width: 200px;
                transform: translateX(-100%);
                transition: transform 0.3s ease;
            }
            .sidebar.active {
                transform: translateX(0);
            }
            .main-content {
                margin-left: 0;
                width: 100%;
            }
            .main-content.full-width {
                margin-left: 200px;
                width: calc(100% - 200px);
            }
            .sidebar-toggle {
                display: block;
                position: fixed;
                top: 20px;
                left: 20px;
                background: #00f2fe;
                border: none;
                padding: 10px;
                border-radius: 5px;
                cursor: pointer;
                z-index: 1001;
            }
        }
    </style>
</head>
<body>
<!-- Header Section -->
<header class="header">
    <div class="container">
        <a href="index.jsp" class="logo">NexoraSkill</a>
        <nav class="navbar">
            <ul>
                <li><a href="index.jsp#home">Home</a></li>
                <li><a href="courses.jsp">Courses</a></li>
                <li><a href="Apply%20Course.jsp">Apply Course</a></li>
                <li><a href="aboutus.jsp">About Us</a></li>
                <li><a href="contact.jsp">Contact</a></li>
            </ul>
        </nav>
        <div class="auth-buttons">
            <a href="logIn.jsp" class="btn btn-login"><i class="fas fa-sign-in-alt"></i> Login</a>
            <a href="signUp.jsp" class="btn btn-signup"><i class="fas fa-user-plus"></i> Sign Up</a>
        </div>
    </div>
</header>

<!-- Sidebar Toggle Button -->
<button class="sidebar-toggle">
    <i class="fas fa-bars"></i>
</button>

<%
    // Retrieve email and studentId from session
    String email = (String) session.getAttribute("email");
    String studentId = (String) session.getAttribute("studentId");
    String displayName = "Guest";
    String firstName = "Guest";
    String initials = "G";
    String studentIdBadge = "NS20230045";

    if (email != null) {
        String studentsFilePath = application.getRealPath("/WEB-INF/data/students.txt");
        try (BufferedReader reader = new BufferedReader(new FileReader(studentsFilePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 3 && parts[2].equals(email)) {
                    studentId = parts[0];
                    session.setAttribute("studentId", studentId);
                    displayName = parts[1].trim();
                    String[] nameParts = displayName.split("\\s+");
                    firstName = nameParts[0];
                    initials = nameParts.length > 1
                            ? nameParts[0].substring(0, 1).toUpperCase() + nameParts[1].substring(0, 1).toUpperCase()
                            : nameParts[0].substring(0, 1).toUpperCase();
                    studentIdBadge = "NS" + studentId.substring(3);
                    break;
                }
            }
        } catch (IOException e) {
            displayName = "Error";
            firstName = "Error";
            initials = "E";
            studentIdBadge = "NS00000000";
            request.setAttribute("error", "Failed to load student data: " + e.getMessage());
        }
    }

    // Fetch enrolled courses and course details
    Map<String, String[]> courseDetailsMap = new HashMap<>();
    String coursesFilePath = application.getRealPath("/WEB-INF/data/courses.txt");
    try (BufferedReader reader = new BufferedReader(new FileReader(coursesFilePath))) {
        String line;
        while ((line = reader.readLine()) != null) {
            String[] parts = line.split(",");
            if (parts.length >= 4) {
                courseDetailsMap.put(parts[0], new String[]{parts[1], parts[2], parts[3]});
            }
        }
    } catch (IOException e) {
        request.setAttribute("error", "Failed to load course data: " + e.getMessage());
    }

    List<String[]> enrolledCourses = new ArrayList<>();
    if (studentId != null) {
        String enrollmentsFilePath = application.getRealPath("/WEB-INF/data/enrollments.txt");
        try (BufferedReader reader = new BufferedReader(new FileReader(enrollmentsFilePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 6 && parts[1].equals(studentId)) {
                    enrolledCourses.add(parts);
                }
            }
        } catch (IOException e) {
            request.setAttribute("error", "Failed to load enrolled courses: " + e.getMessage());
        }
    }

    // Fetch payment history from payments.txt
    List<String[]> paymentHistory = new ArrayList<>();
    if (studentId != null) {
        String paymentsFilePath = application.getRealPath("/WEB-INF/data/payments.txt");
        File paymentsFile = new File(paymentsFilePath);
        if (paymentsFile.exists()) {
            try (BufferedReader reader = new BufferedReader(new FileReader(paymentsFile))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split(",");
                    if (parts.length >= 9 && parts[1].equals(studentId)) {
                        paymentHistory.add(parts);
                    }
                }
            } catch (IOException e) {
                request.setAttribute("error", "Failed to load payment history: " + e.getMessage());
            }
        }
    }

    // Hardcoded progress for demonstration
    Map<String, String> courseProgress = new HashMap<>();
    courseProgress.put("CS401", "65%");
    courseProgress.put("AI301", "82%");
    courseProgress.put("DB202", "45%");

    // Check if invoice is overdue
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    Date currentDate = dateFormat.parse("2025-05-02"); // Current date as of May 02, 2025

    // Handle form submission for making a payment
    String action = request.getParameter("action");
    if ("makePayment".equals(action)) {
        String subscriptionPlan = request.getParameter("subscriptionPlan");
        String amount = request.getParameter("amount");
        String startDate = request.getParameter("startDate");
        String paymentMethod = request.getParameter("paymentMethod");

        // Generate a unique invoice ID
        String invoiceId = "INV" + System.currentTimeMillis();
        String dueDate = "";
        try {
            Date startDateParsed = dateFormat.parse(startDate);
            Calendar cal = Calendar.getInstance();
            cal.setTime(startDateParsed);
            if ("monthly".equals(subscriptionPlan)) {
                cal.add(Calendar.MONTH, 1);
            } else if ("quarterly".equals(subscriptionPlan)) {
                cal.add(Calendar.MONTH, 3);
            } else if ("yearly".equals(subscriptionPlan)) {
                cal.add(Calendar.YEAR, 1);
            }
            dueDate = dateFormat.format(cal.getTime());
        } catch (Exception e) {
            dueDate = "N/A";
        }

        // Payment details
        String status = "pending";
        String paymentDate = "";
        String waiverApplied = "false";
        String lateFee = "0.00";

        // Prepare the payment entry
        String paymentEntry = String.join(",",
                invoiceId, studentId, amount, dueDate, status, paymentDate, waiverApplied, lateFee, paymentMethod, subscriptionPlan, startDate);

        // Write to payments.txt
        String paymentsFilePath = application.getRealPath("/WEB-INF/data/payments.txt");
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(paymentsFilePath, true))) {
            writer.write(paymentEntry);
            writer.newLine();
            paymentHistory.add(paymentEntry.split(","));
            response.sendRedirect("student-dashboard.jsp?message=payment_made");
        } catch (IOException e) {
            request.setAttribute("error", "Failed to save payment: " + e.getMessage());
        }
    }
%>

<!-- Sidebar -->
<div class="sidebar">
    <div class="logo">NexoraSkill</div>
    <div class="user-profile">
        <div class="user-avatar"><%= initials %></div>
        <div class="user-info">
            <h3><%= displayName %></h3>
            <p>Computer Science</p>
        </div>
    </div>
    <ul class="nav-menu">
        <li class="nav-item active">
            <a href="#" class="nav-link" data-section="dashboard">
                <i class="fas fa-home"></i> <span>Dashboard</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="#" class="nav-link" data-section="profile">
                <i class="fas fa-user"></i> <span>Profile</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="#" class="nav-link" data-section="courses">
                <i class="fas fa-book-open"></i> <span>My Courses</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="#" class="nav-link" data-section="enrollment">
                <i class="fas fa-tasks"></i> <span>Enrollment</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="#" class="nav-link" data-section="deadlines">
                <i class="fas fa-calendar-alt"></i> <span>Deadlines</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="#" class="nav-link" data-section="payment">
                <i class="fas fa-credit-card"></i> <span>Payment</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="#" class="nav-link" data-section="settings">
                <i class="fas fa-cog"></i> <span>Settings</span>
            </a>
        </li>
    </ul>
</div>

<!-- Main Content -->
<div class="main-content">
    <!-- Messages -->
    <% if (request.getAttribute("error") != null) { %>
    <div class="message error"><%= request.getAttribute("error") %></div>
    <% } %>
    <% if (request.getParameter("message") != null) { %>
    <div class="message success">
        <% String message = request.getParameter("message");
            if ("payment_made".equals(message)) { %>
        Payment made successfully!
        <% } else if ("waiver_applied".equals(message)) { %>
        Late fee waiver applied successfully!
        <% } else if ("late_fee_applied".equals(message)) { %>
        Late fee applied successfully!
        <% } else if ("invoice_voided".equals(message)) { %>
        Invoice voided successfully!
        <% } else if ("payment_cancelled".equals(message)) { %>
        Payment cancelled successfully!
        <% } %>
    </div>
    <% } %>

    <!-- Dashboard Section -->
    <section id="dashboard" class="content-section active">
        <div class="dashboard-header">
            <div class="greeting">
                <h1>Welcome back, <%= firstName %>!</h1>
                <p>Your academic journey awaits</p>
            </div>
            <div class="user-actions">
                <div class="notification-bell">
                    <i class="fas fa-bell"></i>
                    <span class="notification-count">2</span>
                </div>
                <form action="auth" method="post">
                    <input type="hidden" name="action" value="logout">
                    <button type="submit" class="btn btn-outline">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </button>
                </form>
            </div>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <h3>Active Courses</h3>
                <p class="stat-value"><%= enrolledCourses.size() %></p>
                <div class="stat-change positive">
                    <i class="fas fa-arrow-up"></i> Updated
                </div>
            </div>
            <div class="stat-card">
                <h3>Assignments Due</h3>
                <p class="stat-value">3</p>
                <div class="stat-change negative">
                    <i class="fas fa-exclamation-circle"></i> 1 overdue
                </div>
            </div>
            <div class="stat-card">
                <h3>Overall Progress</h3>
                <p class="stat-value">78%</p>
                <div class="stat-change positive">
                    <i class="fas fa-arrow-up"></i> 5% up
                </div>
            </div>
        </div>

        <div class="courses-container">
            <% for (String[] enrollment : enrolledCourses) {
                String courseId = enrollment[2];
                String[] courseDetails = courseDetailsMap.get(courseId);
                if (courseDetails != null) {
                    String courseCode = courseDetails[0];
                    String courseTitle = courseDetails[1];
                    String instructor = courseDetails[2];
                    String progress = courseProgress.getOrDefault(courseId, "0%");
            %>
            <div class="course-card">
                <div class="course-header">
                    <div class="course-code"><%= courseCode %></div>
                    <h3 class="course-title"><%= courseTitle %></h3>
                    <div class="course-instructor"><%= instructor %></div>
                </div>
                <div class="course-progress">
                    <div class="progress-text">
                        <span>Progress</span>
                        <span><%= progress %></span>
                    </div>
                    <div class="progress-bar">
                        <div class="progress-fill" style="width: <%= progress %>"></div>
                    </div>
                </div>
                <div class="course-actions">
                    <button class="btn btn-outline">
                        <i class="fas fa-book"></i> Continue
                    </button>
                    <span class="status active">Active</span>
                </div>
            </div>
            <% }
            } %>
        </div>
    </section>

    <!-- Profile Section -->
    <section id="profile" class="content-section">
        <div class="dashboard-header">
            <div class="greeting">
                <h1>Your Profile</h1>
                <p>Personalize your academic identity</p>
            </div>
            <div class="user-actions">
                <button class="btn btn-primary">
                    <i class="fas fa-sync-alt"></i> Refresh
                </button>
            </div>
        </div>

        <div class="profile-container">
            <div class="profile-card">
                <div class="profile-header">
                    <div class="user-avatar-holographic">
                        <div class="hologram-effect"></div>
                        <img src="https://via.placeholder.com/150" alt="Profile Picture" class="avatar-image">
                        <div class="avatar-actions">
                            <button class="btn btn-outline avatar-upload">
                                <i class="fas fa-camera"></i> Update
                            </button>
                            <button class="btn btn-outline avatar-edit">
                                <i class="fas fa-magic"></i> Customize
                            </button>
                        </div>
                    </div>
                    <div class="profile-info">
                        <h2><%= displayName %></h2>
                        <div class="student-id-badge">
                            <i class="fas fa-id-card"></i> <%= studentIdBadge %>
                        </div>
                        <div class="verification-status">
                            <i class="fas fa-shield-check verified"></i> Verified Student
                        </div>
                        <div class="academic-level">
                            <div class="level-progress">
                                <div class="progress-fill" style="width: 78%"></div>
                            </div>
                            <span>Level 3 (78%)</span>
                        </div>
                    </div>
                </div>

                <div class="profile-tabs">
                    <div class="tab active" data-tab="personal">Personal</div>
                    <div class="tab" data-tab="academic">Academic</div>
                    <div class="tab" data-tab="security">Security</div>
                </div>

                <div class="tab-content">
                    <div class="tab-pane active" id="personal-tab">
                        <div class="detail-grid">
                            <div class="detail-card">
                                <h3><i class="fas fa-user-tag"></i> Basic Info</h3>
                                <div class="detail-item">
                                    <label>Name:</label>
                                    <p><%= displayName %></p>
                                    <button class="btn-edit"><i class="fas fa-pencil-alt"></i></button>
                                </div>
                                <div class="detail-item">
                                    <label>DOB:</label>
                                    <p>March 15, 2001</p>
                                </div>
                                <div class="detail-item">
                                    <label>Gender:</label>
                                    <p>Male</p>
                                </div>
                            </div>
                            <div class="detail-card">
                                <h3><i class="fas fa-address-book"></i> Contact</h3>
                                <div class="detail-item">
                                    <label>Email:</label>
                                    <p><%= email != null ? email : "john.doe@nexora.edu" %></p>
                                </div>
                                <div class="detail-item">
                                    <label>Phone:</label>
                                    <p>+94 77 123 4567</p>
                                </div>
                                <div class="detail-item">
                                    <label>Address:</label>
                                    <p>123 University Dorm, Colombo</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane" id="academic-tab">
                        <div class="detail-grid">
                            <div class="detail-card">
                                <h3><i class="fas fa-graduation-cap"></i> Program</h3>
                                <div class="detail-item">
                                    <label>Degree:</label>
                                    <p>BSc Computer Science</p>
                                </div>
                                <div class="detail-item">
                                    <label>Enrolled:</label>
                                    <p>September 2020</p>
                                </div>
                                <div class="detail-item">
                                    <label>GPA:</label>
                                    <p>3.72/4.00</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane" id="security-tab">
                        <div class="detail-grid">
                            <div class="detail-card">
                                <h3><i class="fas fa-lock"></i> Security</h3>
                                <div class="detail-item">
                                    <label>Password:</label>
                                    <p>••••••••</p>
                                    <button class="btn btn-outline">
                                        <i class="fas fa-sync-alt"></i> Change
                                    </button>
                                </div>
                                <div class="detail-item">
                                    <label>2FA:</label>
                                    <p>Not Enabled</p>
                                    <button class="btn btn-primary">
                                        <i class="fas fa-toggle-on"></i> Enable
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="profile-actions">
                    <button class="btn btn-primary">
                        <i class="fas fa-save"></i> Save Changes
                    </button>
                </div>
            </div>
        </div>
    </section>

    <!-- Courses Section -->
    <section id="courses" class="content-section">
        <div class="dashboard-header">
            <div class="greeting">
                <h1>My Courses</h1>
                <p>Explore your learning path</p>
            </div>
        </div>

        <div class="courses-container">
            <% if (enrolledCourses.isEmpty()) { %>
            <p>No enrolled courses found.</p>
            <% } else { %>
            <% for (String[] enrollment : enrolledCourses) {
                String courseId = enrollment[2];
                String[] courseDetails = courseDetailsMap.get(courseId);
                if (courseDetails != null) {
                    String courseCode = courseDetails[0];
                    String courseTitle = courseDetails[1];
                    String instructor = courseDetails[2];
                    String progress = courseProgress.getOrDefault(courseId, "0%");
            %>
            <div class="course-card">
                <div class="course-header">
                    <div class="course-code"><%= courseCode %></div>
                    <h3 class="course-title"><%= courseTitle %></h3>
                    <div class="course-instructor"><%= instructor %></div>
                </div>
                <div class="course-progress">
                    <div class="progress-text">
                        <span>Progress</span>
                        <span><%= progress %></span>
                    </div>
                    <div class="progress-bar">
                        <div class="progress-fill" style="width: <%= progress %>"></div>
                    </div>
                </div>
                <div class="course-actions">
                    <button class="btn btn-outline">
                        <i class="fas fa-book"></i> Continue
                    </button>
                    <button class="btn btn-outline">
                        <i class="fas fa-info-circle"></i> Details
                    </button>
                </div>
            </div>
            <% }
            } %>
            <% } %>
        </div>
    </section>

    <!-- Enrollment Section -->
    <section id="enrollment" class="content-section">
        <div class="dashboard-header">
            <div class="greeting">
                <h1>Course Enrollment</h1>
                <p>Manage your course registrations</p>
            </div>
            <a href="enrollment?action=viewEnrollments" class="btn btn-primary">
                <i class="fas fa-list"></i> View My Enrollments
            </a>
        </div>

        <div class="enrollment-section">
            <h2><i class="fas fa-exchange-alt"></i> Change Course Section</h2>
            <form action="enrollment" method="post" class="enrollment-form">
                <input type="hidden" name="action" value="changeSection">
                <div class="form-group">
                    <label for="oldCourseId">Current Course ID:</label>
                    <input type="text" id="oldCourseId" name="oldCourseId" required>
                </div>
                <div class="form-group">
                    <label for="newCourseId">New Course ID:</label>
                    <input type="text" id="newCourseId" name="newCourseId" required>
                </div>
                <div class="form-group">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-exchange-alt"></i> Change Section
                    </button>
                </div>
            </form>
        </div>

        <div class="enrollment-section">
            <h2><i class="fas fa-minus-circle"></i> Drop Course</h2>
            <form action="enrollment" method="post" class="enrollment-form">
                <input type="hidden" name="action" value="dropCourse">
                <div class="form-group">
                    <label for="courseId">Course ID:</label>
                    <input type="text" id="courseId" name="courseId" required>
                </div>
                <div class="form-group">
                    <button type="submit" class="btn btn-danger">
                        <i class="fas fa-minus-circle"></i> Drop Course
                    </button>
                </div>
            </form>
        </div>
    </section>

    <!-- Deadlines Section -->
    <section id="deadlines" class="content-section">
        <div class="dashboard-header">
            <div class="greeting">
                <h1>Upcoming Deadlines</h1>
                <p>Stay on top of your tasks</p>
            </div>
            <button class="btn btn-outline">
                <i class="fas fa-plus"></i> Add Reminder
            </button>
        </div>

        <div class="deadlines-container">
            <div class="deadline-item">
                <div class="deadline-icon">
                    <i class="fas fa-file-alt"></i>
                </div>
                <div class="deadline-info">
                    <div class="deadline-title">Final Project</div>
                    <div class="deadline-course">Advanced Algorithms</div>
                </div>
                <div class="deadline-time">
                    <span class="status overdue">Overdue</span>
                </div>
            </div>
            <div class="deadline-item">
                <div class="deadline-icon">
                    <i class="fas fa-laptop-code"></i>
                </div>
                <div class="deadline-info">
                    <div class="deadline-title">ML Model</div>
                    <div class="deadline-course">Machine Learning</div>
                </div>
                <div class="deadline-time">
                    <span class="status pending">Due in 2 days</span>
                </div>
            </div>
        </div>
    </section>

    <!-- Payment Section -->
    <section id="payment" class="content-section">
        <div class="dashboard-header">
            <div class="greeting">
                <h1>Payment Management</h1>
                <p>Manage your site subscription to access all courses</p>
            </div>
        </div>

        <div class="payment-container">
            <div class="payment-header">
                <h2><i class="fas fa-credit-card"></i> Payment Options</h2>
            </div>

            <div class="payment-section active" id="make-payment-section">
                <h3>Make a Payment</h3>
                <form id="paymentForm" action="student-dashboard.jsp" method="post" class="payment-form">
                    <input type="hidden" name="action" value="makePayment">
                    <input type="hidden" name="studentId" value="<%= studentId %>">
                    <div class="form-group">
                        <label for="subscriptionPlan">Subscription Plan:</label>
                        <select id="subscriptionPlan" name="subscriptionPlan" class="invoice-select" required onchange="updateSubscriptionAmount()">
                            <option value="">-- Select a Plan --</option>
                            <option value="monthly" data-amount="49.99">Monthly Access - $49.99</option>
                            <option value="quarterly" data-amount="129.99">Quarterly Access - $129.99</option>
                            <option value="yearly" data-amount="499.99">Yearly Access - $499.99</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="subscriptionAmount">Amount:</label>
                        <input type="text" id="subscriptionAmount" name="amount" readonly required>
                    </div>
                    <div class="form-group">
                        <label for="startDate">Start Date:</label>
                        <input type="date" id="startDate" name="startDate" required min="2025-05-02">
                    </div>
                    <div class="form-group">
                        <label for="paymentMethod">Payment Method:</label>
                        <select id="paymentMethod" name="paymentMethod" class="invoice-select" required onchange="togglePaymentDetails()">
                            <option value="">-- Select Payment Method --</option>
                            <option value="creditCard">Credit Card</option>
                            <option value="debitCard">Debit Card</option>
                            <option value="bankTransfer">Bank Transfer</option>
                            <option value="payPal">PayPal</option>
                            <option value="crypto">Crypto</option>
                        </select>
                    </div>

                    <!-- Payment Details Section -->
                    <div id="paymentDetails" style="display: none;">
                        <div class="form-grid">
                            <div class="form-group" id="cardNumberGroup">
                                <label for="cardNumber">Card Number:</label>
                                <input type="text" id="cardNumber" name="cardNumber" placeholder="1234 5678 9012 3456">
                            </div>
                            <div class="form-group" id="expiryDateGroup">
                                <label for="expiryDate">Expiry Date:</label>
                                <input type="text" id="expiryDate" name="expiryDate" placeholder="MM/YY">
                            </div>
                            <div class="form-group" id="cvvGroup">
                                <label for="cvv">CVV:</label>
                                <input type="text" id="cvv" name="cvv" placeholder="123">
                            </div>
                            <div class="form-group" id="accountNumberGroup" style="display: none;">
                                <label for="accountNumber">Account Number:</label>
                                <input type="text" id="accountNumber" name="accountNumber" placeholder="Enter account number">
                            </div>
                            <div class="form-group" id="routingNumberGroup" style="display: none;">
                                <label for="routingNumber">Routing Number:</label>
                                <input type="text" id="routingNumber" name="routingNumber" placeholder="Enter routing number">
                            </div>
                            <div class="form-group" id="paypalEmailGroup" style="display: none;">
                                <label for="paypalEmail">PayPal Email:</label>
                                <input type="text" id="paypalEmail" name="paypalEmail" placeholder="Enter PayPal email">
                            </div>
                            <div class="form-group" id="cryptoWalletGroup" style="display: none;">
                                <label for="cryptoWallet">Crypto Wallet Address:</label>
                                <input type="text" id="cryptoWallet" name="cryptoWallet" placeholder="Enter wallet address">
                            </div>
                        </div>
                    </div>

                    <div class="payment-actions">
                        <button type="submit" class="btn btn-primary" id="makePaymentBtn">
                            <i class="fas fa-check-circle"></i> Subscribe Now
                        </button>
                    </div>
                </form>
            </div>

            <!-- Payment History Section -->
            <h3 style="margin-top: 40px;">Payment History</h3>
            <table class="payment-table">
                <thead>
                <tr>
                    <th>Invoice ID</th>
                    <th>Plan</th>
                    <th>Amount</th>
                    <th>Start Date</th>
                    <th>Due Date</th>
                    <th>Status</th>
                    <th>Payment Date</th>
                    <th>Waiver Applied</th>
                    <th>Late Fee</th>
                    <th>Payment Method</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <% for (String[] fee : paymentHistory) {
                    boolean isOverdue = false;
                    try {
                        Date dueDate = dateFormat.parse(fee[3]);
                        isOverdue = dueDate.before(currentDate);
                    } catch (Exception e) {}
                    String paymentStatus = !fee[5].isEmpty() ? "paid" : ("pending".equals(fee[4]) ? (isOverdue ? "overdue" : "pending") : fee[4]);
                    String plan = fee.length > 9 ? fee[9] : "N/A";
                %>
                <tr>
                    <td><%= fee[0] %></td>
                    <td><%= plan %></td>
                    <td><%= fee[2] %></td>
                    <td><%= fee.length > 10 ? fee[10] : "N/A" %></td>
                    <td><%= fee[3] %></td>
                    <td class="status-cell <%= paymentStatus %>"><%= paymentStatus.substring(0, 1).toUpperCase() + paymentStatus.substring(1) %></td>
                    <td><%= fee[5].isEmpty() ? "N/A" : fee[5] %></td>
                    <td><%= "true".equals(fee[6]) ? "Yes" : "No" %></td>
                    <td><%= fee[7] %></td>
                    <td><%= fee[8].isEmpty() ? "N/A" : fee[8] %></td>
                    <td class="payment-actions">
                        <% if ("pending".equals(fee[4]) && !"true".equals(fee[6])) { %>
                        <form action="fee" method="post" class="payment-action-form">
                            <input type="hidden" name="action" value="applyWaiver">
                            <input type="hidden" name="invoiceId" value="<%= fee[0] %>">
                            <input type="hidden" name="amount" value="<%= fee[2] %>">
                            <input type="hidden" name="studentId" value="<%= studentId %>">
                            <button type="submit" class="btn btn-primary btn-sm" title="Apply Waiver">
                                <i class="fas fa-hand-holding-usd"></i>
                            </button>
                        </form>
                        <% } %>
                        <% if ("pending".equals(fee[4]) && isOverdue && !"true".equals(fee[6])) { %>
                        <form action="fee" method="post" class="payment-action-form">
                            <input type="hidden" name="action" value="applyLateFee">
                            <input type="hidden" name="invoiceId" value="<%= fee[0] %>">
                            <input type="hidden" name="amount" value="<%= fee[2] %>">
                            <input type="hidden" name="studentId" value="<%= studentId %>">
                            <div style="display:inline-block; margin-right: 5px;">
                                <input type="text" name="lateFeeAmount" placeholder="Fee" style="width: 80px; padding: 5px;" required>
                            </div>
                            <button type="submit" class="btn btn-warning btn-sm" title="Apply Late Fee">
                                <i class="fas fa-exclamation-triangle"></i>
                            </button>
                        </form>
                        <% } %>
                        <% if ("pending".equals(fee[4])) { %>
                        <form action="fee" method="post" class="payment-action-form">
                            <input type="hidden" name="action" value="void">
                            <input type="hidden" name="invoiceId" value="<%= fee[0] %>">
                            <input type="hidden" name="amount" value="<%= fee[2] %>">
                            <input type="hidden" name="studentId" value="<%= studentId %>">
                            <button type="submit" class="btn btn-danger btn-sm" title="Void Invoice">
                                <i class="fas fa-trash-alt"></i>
                            </button>
                        </form>
                        <% } %>
                        <% if ("paid".equals(fee[4])) { %>
                        <form action="fee" method="post" class="payment-action-form">
                            <input type="hidden" name="action" value="cancelPayment">
                            <input type="hidden" name="invoiceId" value="<%= fee[0] %>">
                            <input type="hidden" name="amount" value="<%= fee[2] %>">
                            <input type="hidden" name="studentId" value="<%= studentId %>">
                            <button type="submit" class="btn btn-outline btn-sm" title="Cancel Payment">
                                <i class="fas fa-undo"></i>
                            </button>
                        </form>
                        <% } %>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </section>

    <!-- Settings Section -->
    <section id="settings" class="content-section">
        <div class="dashboard-header">
            <div class="greeting">
                <h1>Settings</h1>
                <p>Customize your experience</p>
            </div>
        </div>

        <div class="settings-container">
            <div class="settings-form">
                <div class="form-group">
                    <label>Name</label>
                    <input type="text" value="<%= displayName %>">
                </div>
                <div class="form-group">
                    <label>Email</label>
                    <input type="email" value="<%= email != null ? email : "john.doe@nexora.edu" %>">
                </div>
                <div class="form-group">
                    <button class="btn btn-primary">
                        <i class="fas fa-save"></i> Save
                    </button>
                </div>
                <div class="form-group">
                    <form action="delete-account.jsp" method="get">
                        <button type="submit" class="btn btn-danger" onclick="return confirm('Are you sure you want to proceed with deleting your account?');">
                            <i class="fas fa-trash-alt"></i> Delete Account
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </section>
</div>

<script>
    // Navigation
    const navLinks = document.querySelectorAll('.nav-link');
    const sections = document.querySelectorAll('.content-section');

    navLinks.forEach(link => {
        link.addEventListener('click', (e) => {
            e.preventDefault();
            const sectionId = link.getAttribute('data-section');

            navLinks.forEach(l => l.classList.remove('active'));
            link.classList.add('active');

            sections.forEach(section => section.classList.remove('active'));
            document.getElementById(sectionId).classList.add('active');
        });
    });

    // Sidebar Toggle
    const sidebar = document.querySelector('.sidebar');
    const mainContent = document.querySelector('.main-content');
    const toggleBtn = document.querySelector('.sidebar-toggle');

    toggleBtn.addEventListener('click', () => {
        sidebar.classList.toggle('active');
        mainContent.classList.toggle('full-width');
    });

    // Profile Tabs
    document.querySelectorAll('.profile-tabs .tab').forEach(tab => {
        tab.addEventListener('click', () => {
            const tabId = tab.getAttribute('data-tab');

            document.querySelectorAll('.profile-tabs .tab').forEach(t => t.classList.remove('active'));
            tab.classList.add('active');

            document.querySelectorAll('.tab-pane').forEach(pane => pane.classList.remove('active'));
            document.getElementById(`${tabId}-tab`).classList.add('active');
        });
    });

    // Notification
    document.querySelector('.notification-bell').addEventListener('click', () => {
        alert('2 new notifications');
    });

    // Payment Section - Auto-populate subscription amount
    function updateSubscriptionAmount() {
        const subscriptionPlan = document.getElementById('subscriptionPlan');
        const subscriptionAmountInput = document.getElementById('subscriptionAmount');
        const selectedOption = subscriptionPlan.options[subscriptionPlan.selectedIndex];

        if (!selectedOption.value) {
            subscriptionAmountInput.value = '';
            return;
        }

        subscriptionAmountInput.value = selectedOption.getAttribute('data-amount');
    }

    // Toggle Payment Details Fields
    function togglePaymentDetails() {
        const paymentMethod = document.getElementById('paymentMethod').value;
        const paymentDetails = document.getElementById('paymentDetails');
        const cardNumberGroup = document.getElementById('cardNumberGroup');
        const expiryDateGroup = document.getElementById('expiryDateGroup');
        const cvvGroup = document.getElementById('cvvGroup');
        const accountNumberGroup = document.getElementById('accountNumberGroup');
        const routingNumberGroup = document.getElementById('routingNumberGroup');
        const paypalEmailGroup = document.getElementById('paypalEmailGroup');
        const cryptoWalletGroup = document.getElementById('cryptoWalletGroup');

        // Reset all fields to hidden
        paymentDetails.style.display = 'none';
        cardNumberGroup.style.display = 'none';
        expiryDateGroup.style.display = 'none';
        cvvGroup.style.display = 'none';
        accountNumberGroup.style.display = 'none';
        routingNumberGroup.style.display = 'none';
        paypalEmailGroup.style.display = 'none';
        cryptoWalletGroup.style.display = 'none';

        // Clear previous validation requirements
        document.querySelectorAll('#paymentDetails input').forEach(input => {
            input.removeAttribute('required');
        });

        // Show relevant fields based on payment method and set required attributes
        if (paymentMethod) {
            paymentDetails.style.display = 'block';
            if (paymentMethod === 'creditCard' || paymentMethod === 'debitCard') {
                cardNumberGroup.style.display = 'block';
                expiryDateGroup.style.display = 'block';
                cvvGroup.style.display = 'block';
                document.getElementById('cardNumber').setAttribute('required', 'required');
                document.getElementById('expiryDate').setAttribute('required', 'required');
                document.getElementById('cvv').setAttribute('required', 'required');
            } else if (paymentMethod === 'bankTransfer') {
                accountNumberGroup.style.display = 'block';
                routingNumberGroup.style.display = 'block';
                document.getElementById('accountNumber').setAttribute('required', 'required');
                document.getElementById('routingNumber').setAttribute('required', 'required');
            } else if (paymentMethod === 'payPal') {
                paypalEmailGroup.style.display = 'block';
                document.getElementById('paypalEmail').setAttribute('required', 'required');
            } else if (paymentMethod === 'crypto') {
                cryptoWalletGroup.style.display = 'block';
                document.getElementById('cryptoWallet').setAttribute('required', 'required');
            }
        }
    }

    // Form Validation and Submission for Make Payment
    document.getElementById('paymentForm').addEventListener('submit', function(e) {
        const subscriptionPlan = document.getElementById('subscriptionPlan').value;
        const paymentMethod = document.getElementById('paymentMethod').value;

        if (!subscriptionPlan) {
            e.preventDefault();
            alert('Please select a subscription plan.');
            return;
        }

        if (!paymentMethod) {
            e.preventDefault();
            alert('Please select a payment method.');
            return;
        }

        // Additional validation for payment details
        if (paymentMethod === 'creditCard' || paymentMethod === 'debitCard') {
            const cardNumber = document.getElementById('cardNumber').value;
            const expiryDate = document.getElementById('expiryDate').value;
            const cvv = document.getElementById('cvv').value;
            if (!cardNumber || !expiryDate || !cvv) {
                e.preventDefault();
                alert('Please fill all card details.');
                return;
            }
        } else if (paymentMethod === 'bankTransfer') {
            const accountNumber = document.getElementById('accountNumber').value;
            const routingNumber = document.getElementById('routingNumber').value;
            if (!accountNumber || !routingNumber) {
                e.preventDefault();
                alert('Please fill all bank transfer details.');
                return;
            }
        } else if (paymentMethod === 'payPal') {
            const paypalEmail = document.getElementById('paypalEmail').value;
            if (!paypalEmail) {
                e.preventDefault();
                alert('Please enter your PayPal email.');
                return;
            }
        } else if (paymentMethod === 'crypto') {
            const cryptoWallet = document.getElementById('cryptoWallet').value;
            if (!cryptoWallet) {
                e.preventDefault();
                alert('Please enter your crypto wallet address.');
                return;
            }
        }
    });

    // Initialize payment section
    updateSubscriptionAmount();
    togglePaymentDetails();
</script>
</body>
</html>