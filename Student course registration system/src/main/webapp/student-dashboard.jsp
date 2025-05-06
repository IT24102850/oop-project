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
        :root {
            --primary-color: #00f2fe;
            --secondary-color: #ff69b4;
            --accent-color: #4facfe;
            --background-color: #0a0f24;
            --card-bg: rgba(15, 23, 42, 0.9);
            --glass-bg: rgba(255, 255, 255, 0.05);
            --text-color: #ffffff;
            --text-muted: rgba(255, 255, 255, 0.7);
            --border-radius: 15px;
            --box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            --glow-effect: 0 0 15px rgba(0, 242, 254, 0.3);
            --transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, var(--background-color), #050916);
            color: var(--text-color);
            min-height: 100vh;
            display: flex;
            overflow-x: hidden;
        }

        /* Header Section */
        .header {
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1000;
            background: linear-gradient(135deg, rgba(10, 15, 36, 0.95), rgba(0, 0, 0, 0.7));
            backdrop-filter: blur(15px);
            border-bottom: 1px solid rgba(0, 242, 254, 0.1);
            box-shadow: var(--box-shadow);
            transition: var(--transition);
        }

        .container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 5%;
            max-width: 1600px;
            margin: 0 auto;
        }

        .logo {
            font-family: 'Orbitron', sans-serif;
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--primary-color);
            text-decoration: none;
            transition: var(--transition);
            text-shadow: 0 0 5px rgba(0, 242, 254, 0.3);
        }

        .logo:hover {
            color: var(--accent-color);
            transform: scale(1.05);
            text-shadow: var(--glow-effect);
        }

        .navbar ul {
            list-style: none;
            display: flex;
            gap: 30px;
            align-items: center;
        }

        .navbar ul li a {
            text-decoration: none;
            color: var(--text-color);
            font-weight: 500;
            font-size: 1.1rem;
            transition: var(--transition);
            position: relative;
        }

        .navbar ul li a::after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            bottom: -5px;
            left: 0;
            background: var(--primary-color);
            transition: width 0.3s ease;
        }

        .navbar ul li a:hover::after {
            width: 100%;
        }

        .navbar ul li a:hover {
            color: var(--primary-color);
            text-shadow: var(--glow-effect);
        }

        .auth-buttons {
            display: flex;
            gap: 15px;
        }

        .btn {
            padding: 10px 20px;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 600;
            font-size: 1rem;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            transition: var(--transition);
            cursor: pointer;
            border: none;
            position: relative;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--glow-effect);
        }

        .btn-login {
            background: transparent;
            border: 2px solid var(--primary-color);
            color: var(--primary-color);
        }

        .btn-login:hover {
            background: var(--primary-color);
            color: var(--background-color);
        }

        .btn-signup {
            background: var(--primary-color);
            color: var(--background-color);
            border: 2px solid transparent;
        }

        .btn-signup:hover {
            background: transparent;
            color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .btn-primary {
            background: var(--primary-color);
            color: var(--background-color);
            border: 2px solid transparent;
        }

        .btn-primary:hover {
            background: transparent;
            color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .btn-danger {
            background: #ff4500;
            color: var(--text-color);
            border: 2px solid transparent;
        }

        .btn-danger:hover {
            background: transparent;
            color: #ff4500;
            border-color: #ff4500;
        }

        .btn-outline {
            background: transparent;
            border: 1px solid var(--primary-color);
            color: var(--primary-color);
            padding: 8px 15px;
            border-radius: 8px;
        }

        .btn-outline:hover {
            background: var(--primary-color);
            color: var(--background-color);
        }

        .btn-logout {
            background: transparent;
            border: 2px solid var(--secondary-color);
            color: var(--secondary-color);
        }

        .btn-logout:hover {
            background: var(--secondary-color);
            color: var(--text-color);
        }

        /* Sidebar */
        .sidebar {
            width: 250px;
            background: linear-gradient(135deg, var(--card-bg), rgba(10, 15, 36, 0.95));
            height: 100vh;
            padding: 25px 0;
            position: fixed;
            border-right: 1px solid rgba(0, 242, 254, 0.1);
            top: 0;
            left: 0;
            transition: transform 0.4s ease-in-out;
            box-shadow: 5px 0 20px rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(10px);
        }

        .sidebar.hidden {
            transform: translateX(-100%);
        }

        .sidebar .logo {
            text-align: center;
            font-size: 1.8rem;
            margin-bottom: 30px;
        }

        .sidebar .user-profile {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 20px;
            background: var(--glass-bg);
            margin: 0 15px 30px;
            border-radius: var(--border-radius);
            transition: var(--transition);
        }

        .sidebar .user-profile:hover {
            transform: translateY(-5px);
            box-shadow: var(--glow-effect);
        }

        .sidebar .user-avatar {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 1.5rem;
            color: var(--background-color);
        }

        .sidebar .user-info h3 {
            font-size: 1.2rem;
            margin-bottom: 5px;
        }

        .sidebar .user-info p {
            font-size: 0.95rem;
            color: var(--text-muted);
        }

        .sidebar .nav-menu {
            list-style: none;
            padding: 0;
            margin-top: 20px;
        }

        .sidebar .nav-item {
            padding: 10px 20px;
        }

        .sidebar .nav-link {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 12px 20px;
            border-radius: var(--border-radius);
            color: var(--text-color);
            text-decoration: none;
            transition: var(--transition);
            cursor: pointer;
        }

        .sidebar .nav-link:hover {
            background: var(--glass-bg);
            transform: translateX(5px);
            box-shadow: var(--glow-effect);
        }

        .sidebar .nav-link.active {
            background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
            color: var(--background-color);
            border-left: 4px solid var(--secondary-color);
            box-shadow: var(--glow-effect);
        }

        .sidebar .nav-link i {
            font-size: 1.2rem;
        }

        /* Main Content */
        .main-content {
            margin-left: 250px;
            flex: 1;
            padding: 90px 30px 30px;
            transition: margin-left 0.4s ease-in-out;
        }

        .main-content.full-width {
            margin-left: 0;
        }

        .content-section {
            display: none;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .content-section.active {
            display: block;
            opacity: 1;
        }

        /* Dashboard Header */
        .dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding: 20px;
            background: var(--glass-bg);
            border-radius: var(--border-radius);
            box-shadow: var(--glow-effect);
        }

        .greeting h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
            background: linear-gradient(45deg, var(--primary-color), var(--secondary-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .greeting p {
            font-size: 1.1rem;
            color: var(--text-muted);
        }

        .user-actions {
            display: flex;
            gap: 15px;
            align-items: center;
        }

        .notification-bell {
            position: relative;
            font-size: 1.5rem;
            cursor: pointer;
            color: var(--text-muted);
            transition: var(--transition);
        }

        .notification-bell:hover {
            color: var(--secondary-color);
            transform: rotate(15deg);
        }

        .notification-count {
            position: absolute;
            top: -8px;
            right: -8px;
            background: var(--secondary-color);
            color: var(--text-color);
            border-radius: 50%;
            width: 20px;
            height: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.8rem;
        }

        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: var(--card-bg);
            padding: 25px;
            border-radius: var(--border-radius);
            border: 1px solid rgba(0, 242, 254, 0.2);
            transition: var(--transition);
            backdrop-filter: blur(5px);
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--box-shadow), var(--glow-effect);
        }

        .stat-card h3 {
            font-size: 1.1rem;
            color: var(--text-muted);
            margin-bottom: 15px;
            text-transform: uppercase;
        }

        .stat-value {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 10px;
            color: var(--primary-color);
        }

        .stat-change {
            display: flex;
            align-items: center;
            font-size: 0.95rem;
            gap: 8px;
        }

        .stat-change.positive {
            color: #00ff00;
        }

        .stat-change.negative {
            color: var(--secondary-color);
        }

        /* Courses Container */
        .courses-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 25px;
        }

        .course-card {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            padding: 20px;
            transition: var(--transition);
            position: relative;
            backdrop-filter: blur(5px);
        }

        .course-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--box-shadow), var(--glow-effect);
        }

        .course-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            background: linear-gradient(to bottom, var(--primary-color), var(--secondary-color));
        }

        .course-header .course-code {
            font-size: 1.3rem;
            color: var(--primary-color);
            font-family: 'Orbitron', sans-serif;
        }

        .course-header .course-title {
            margin: 10px 0;
            font-size: 1.5rem;
        }

        .course-header .course-instructor {
            color: var(--text-muted);
            font-size: 1rem;
        }

        .course-progress .progress-text {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            font-size: 1rem;
            color: var(--text-muted);
        }

        .course-progress .progress-bar {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 5px;
            height: 12px;
            overflow: hidden;
        }

        .course-progress .progress-fill {
            background: linear-gradient(90deg, var(--primary-color), var(--accent-color));
            height: 100%;
            border-radius: 5px;
            transition: width 0.5s ease;
        }

        .course-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 15px;
        }

        .course-actions .status.active {
            color: #00ff00;
            font-weight: 600;
        }

        /* Messages */
        .message {
            padding: 15px;
            border-radius: var(--border-radius);
            margin-bottom: 25px;
            text-align: center;
            box-shadow: var(--glow-effect);
        }

        .message.success {
            background: rgba(0, 255, 0, 0.1);
            color: #00ff00;
            border: 1px solid rgba(0, 255, 0, 0.3);
        }

        .message.error {
            background: rgba(255, 69, 0, 0.1);
            color: var(--secondary-color);
            border: 1px solid rgba(255, 69, 0, 0.3);
        }

        /* Sidebar Toggle */
        .sidebar-toggle {
            display: none;
            position: fixed;
            top: 20px;
            left: 20px;
            z-index: 1001;
            background: var(--primary-color);
            color: var(--background-color);
            border: none;
            padding: 10px 15px;
            border-radius: 50%;
            cursor: pointer;
            transition: var(--transition);
            box-shadow: var(--glow-effect);
        }

        .sidebar-toggle:hover {
            transform: scale(1.1);
            box-shadow: 0 4px 15px rgba(0, 242, 254, 0.5);
        }

        /* Enrollment Form */
        .enrollment-section {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: var(--glow-effect);
        }

        .enrollment-section h2 {
            font-size: 1.5rem;
            margin-bottom: 15px;
            color: var(--primary-color);
        }

        .enrollment-form {
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
            color: var(--text-muted);
        }

        .form-group input,
        .form-group select {
            padding: 8px;
            border-radius: 5px;
            border: 1px solid var(--primary-color);
            background: transparent;
            color: var(--text-color);
            transition: var(--transition);
        }

        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: var(--accent-color);
            box-shadow: var(--glow-effect);
        }

        /* Payment Section */
        .payment-container {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            padding: 20px;
            box-shadow: var(--glow-effect);
        }

        .payment-header h2 {
            font-size: 1.5rem;
            color: var(--primary-color);
            margin-bottom: 20px;
        }

        .payment-section h3 {
            font-size: 1.3rem;
            color: var(--accent-color);
            margin-bottom: 15px;
        }

        .payment-form {
            display: grid;
            gap: 15px;
            max-width: 500px;
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

        .payment-table th,
        .payment-table td {
            padding: 10px;
            border: 1px solid rgba(0, 242, 254, 0.2);
            text-align: left;
        }

        .payment-table th {
            background: var(--glass-bg);
            color: var(--primary-color);
        }

        .status-cell.paid { color: #00ff00; }
        .status-cell.pending { color: var(--primary-color); }
        .status-cell.overdue { color: #ff4500; }

        .payment-action-form {
            display: inline-block;
            margin-right: 5px;
        }

        .btn-sm {
            padding: 5px 10px;
            font-size: 0.8rem;
        }

        /* Settings Section */
        .settings-container {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            padding: 20px;
            box-shadow: var(--glow-effect);
        }

        .settings-form {
            display: grid;
            gap: 15px;
            max-width: 500px;
        }

        /* Deadlines Section */
        .deadlines-container {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            padding: 20px;
            box-shadow: var(--glow-effect);
        }

        .deadline-item {
            display: flex;
            align-items: center;
            padding: 15px;
            border-bottom: 1px solid rgba(0, 242, 254, 0.1);
        }

        .deadline-icon i {
            font-size: 1.5rem;
            color: var(--primary-color);
            margin-right: 15px;
        }

        .deadline-info {
            flex: 1;
        }

        .deadline-title {
            font-size: 1.2rem;
            color: var(--text-color);
        }

        .deadline-course {
            font-size: 1rem;
            color: var(--text-muted);
        }

        .deadline-time .status {
            font-weight: 600;
        }

        .deadline-time .status.overdue {
            color: #ff4500;
        }

        .deadline-time .status.pending {
            color: var(--primary-color);
        }

        /* Profile Section */
        .profile-container {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            padding: 20px;
            box-shadow: var(--glow-effect);
        }

        .profile-header {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-bottom: 20px;
        }

        .user-avatar-holographic {
            position: relative;
        }

        .user-avatar-holographic .avatar-image {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            border: 2px solid var(--primary-color);
        }

        .avatar-actions {
            display: flex;
            gap: 10px;
            margin-top: 10px;
        }

        .profile-info h2 {
            font-size: 1.8rem;
            color: var(--primary-color);
        }

        .student-id-badge,
        .verification-status,
        .academic-level {
            margin-top: 5px;
            font-size: 1rem;
            color: var(--text-muted);
        }

        .student-id-badge i,
        .verification-status i {
            margin-right: 5px;
        }

        .level-progress {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 5px;
            height: 10px;
            margin-top: 5px;
        }

        .level-progress .progress-fill {
            background: var(--primary-color);
            height: 100%;
            border-radius: 5px;
        }

        .profile-tabs {
            display: flex;
            gap: 10px;
            margin: 20px 0;
        }

        .profile-tabs .tab {
            padding: 10px 20px;
            background: var(--glass-bg);
            border-radius: 5px;
            cursor: pointer;
            transition: var(--transition);
        }

        .profile-tabs .tab:hover {
            background: var(--primary-color);
            color: var(--background-color);
        }

        .profile-tabs .tab.active {
            background: var(--primary-color);
            color: var(--background-color);
        }

        .tab-content .tab-pane {
            display: none;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .tab-content .tab-pane.active {
            display: block;
            opacity: 1;
        }

        .detail-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }

        .detail-card {
            background: var(--glass-bg);
            padding: 15px;
            border-radius: var(--border-radius);
            box-shadow: var(--glow-effect);
        }

        .detail-card h3 {
            font-size: 1.2rem;
            color: var(--primary-color);
            margin-bottom: 10px;
        }

        .detail-item {
            margin: 10px 0;
        }

        .detail-item label {
            color: var(--text-muted);
            font-size: 0.95rem;
        }

        .detail-item p {
            color: var(--text-color);
            margin: 5px 0;
        }

        .btn-edit {
            background: transparent;
            border: none;
            color: var(--primary-color);
            cursor: pointer;
            font-size: 0.9rem;
        }

        .profile-actions {
            margin-top: 20px;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .sidebar {
                width: 200px;
                transform: translateX(-100%);
            }

            .sidebar.active {
                transform: translateX(0);
            }

            .main-content {
                margin-left: 0;
                width: 100%;
                padding: 100px 15px 20px;
            }

            .main-content.full-width {
                margin-left: 200px;
                width: calc(100% - 200px);
            }

            .sidebar-toggle {
                display: block;
            }

            .navbar ul {
                display: none;
            }

            .dashboard-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

            .stats-grid, .courses-container, .detail-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<header class="header">
    <div class="container">
        <a href="index.jsp" class="logo">NexoraSkill</a>
        <nav class="navbar">
            <ul>
                <li><a href="index.jsp#home">Home</a></li>
                <li><a href="courses.jsp">Courses</a></li>
                <li><a href="ApplyNewCourse.jsp">Apply Course</a></li>
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

<button class="sidebar-toggle">
    <i class="fas fa-bars"></i>
</button>

<%
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

    Map<String, String> courseProgress = new HashMap<>();
    courseProgress.put("CS401", "65%");
    courseProgress.put("AI301", "82%");
    courseProgress.put("DB202", "45%");

    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    Date currentDate = dateFormat.parse("2025-05-02");

    String action = request.getParameter("action");
    if ("makePayment".equals(action)) {
        String subscriptionPlan = request.getParameter("subscriptionPlan");
        String amount = request.getParameter("amount");
        String startDate = request.getParameter("startDate");
        String paymentMethod = request.getParameter("paymentMethod");

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

        String status = "pending";
        String paymentDate = "";
        String waiverApplied = "false";
        String lateFee = "0.00";

        String paymentEntry = String.join(",",
                invoiceId, studentId, amount, dueDate, status, paymentDate, waiverApplied, lateFee, paymentMethod, subscriptionPlan, startDate);

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
            <a href="#" class="nav-link" data-section="loginHistory">
                <i class="fas fa-history"></i> <span>Login History</span>
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

<div class="main-content">
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
                    <button type="submit" class="btn btn-logout">
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
                    <button class="btn btn-outline" onclick="alert('Continue course: <%= courseTitle %>')">
                        <i class="fas fa-book"></i> Continue
                    </button>
                    <span class="status active">Active</span>
                </div>
            </div>
            <% }
            } %>
        </div>
    </section>


    <%@ page import="java.io.*, java.util.*" %>
    <%!
        private String[] loadProfileData(String studentId, String filePath) {
            String[] profileData = new String[13];
            for (int i = 0; i < 13; i++) profileData[i] = "";

            File file = new File(filePath);
            if (!file.exists()) return profileData;

            try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    if (!line.trim().isEmpty()) {
                        String[] parts = line.split(",", -1);
                        if (parts.length == 13 && parts[0].equals(studentId)) {
                            return parts;
                        }
                    }
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
            return profileData;
        }
    %>

    <%
        // Load profile data
        String filePath = application.getRealPath("/WEB-INF/data/Profile/profiles.txt");
        String[] profileData = loadProfileData(studentIdBadge, filePath);

// Assign profile data to variables with defaults
        String name = profileData[1].isEmpty() ? (displayName != null ? displayName : "Unknown User") : profileData[1];
        String dob = profileData[2].isEmpty() ? "2001-03-15" : profileData[2];
        String gender = profileData[3].isEmpty() ? "Male" : profileData[3];

        String phone = profileData[5].isEmpty() ? "+94 77 123 4567" : profileData[5];
        String address = profileData[6].isEmpty() ? "123 University Dorm, Colombo" : profileData[6];
        String degree = profileData[7].isEmpty() ? "BSc Computer Science" : profileData[7];
        String enrolled = profileData[8].isEmpty() ? "2020-09" : profileData[8];
        String gpa = profileData[9].isEmpty() ? "3.72/4.00" : profileData[9];
        String password = profileData[10];
        String twoFA = profileData[11].isEmpty() ? "Not Enabled" : profileData[11];
        String profilePic = profileData[12];
    %>

    <section id="profile" class="content-section">
        <div class="dashboard-header">
            <div class="greeting">
                <h1>Your Profile</h1>
                <p>Personalize your academic identity</p>
            </div>
            <div class="user-actions">
                <button class="btn btn-primary" onclick="location.reload()">
                    <i class="fas fa-sync-alt"></i> Refresh
                </button>
            </div>
        </div>

        <div class="profile-container">
            <div class="profile-card">
                <div class="profile-header">
                    <div class="user-avatar-holographic">
                        <img src="<%= profilePic != null && !profilePic.isEmpty() ? "ProfileServlet?action=getPicture&studentId=" + studentIdBadge + "&pic=" + profilePic : "https://via.placeholder.com/150" %>" alt="Profile Picture" class="avatar-image" id="profileImage">
                        <div class="avatar-actions">
                            <form action="ProfileServlet" method="post" enctype="multipart/form-data" class="avatar-upload-form" id="uploadForm">
                                <input type="hidden" name="action" value="uploadPicture">
                                <input type="hidden" name="studentId" value="<%= studentIdBadge %>">
                                <input type="file" id="avatarUpload" name="avatar" accept="image/*" onchange="previewImage(event)" required>
                                <button type="submit" class="btn btn-outline avatar-upload" title="Upload new avatar">
                                    <i class="fas fa-camera"></i> Upload
                                </button>
                            </form>
                            <button class="btn btn-outline avatar-edit" onclick="alert('Customize avatar feature not implemented yet')">
                                <i class="fas fa-magic"></i> Customize
                            </button>
                        </div>
                    </div>
                    <div class="profile-info">
                        <h2><%= name %></h2>
                        <div class="student-id-badge">
                            <i class="fas fa-id-card"></i> <%= studentIdBadge != null ? studentIdBadge : "N/A" %>
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
                        <form action="ProfileServlet" method="post" class="detail-grid" onsubmit="return validatePersonalForm()">
                            <input type="hidden" name="action" value="updatePersonal">
                            <input type="hidden" name="studentId" value="<%= studentIdBadge %>">
                            <div class="detail-card">
                                <h3><i class="fas fa-user-tag"></i> Basic Info</h3>
                                <div class="detail-item">
                                    <label for="name">Name:</label>
                                    <input type="text" id="name" name="name" value="<%= name %>" required>
                                    <div class="error-text" id="nameError"></div>
                                </div>
                                <div class="detail-item">
                                    <label for="dob">DOB:</label>
                                    <input type="date" id="dob" name="dob" value="<%= dob %>" required>
                                </div>
                                <div class="detail-item">
                                    <label for="gender">Gender:</label>
                                    <select id="gender" name="gender" required>
                                        <option value="Male" <%= "Male".equals(gender) ? "selected" : "" %>>Male</option>
                                        <option value="Female" <%= "Female".equals(gender) ? "selected" : "" %>>Female</option>
                                        <option value="Other" <%= "Other".equals(gender) ? "selected" : "" %>>Other</option>
                                    </select>
                                </div>
                            </div>
                            <div class="detail-card">
                                <h3><i class="fas fa-address-book"></i> Contact</h3>
                                <div class="detail-item">
                                    <label for="email">Email:</label>
                                    <input type="email" id="email" name="email" value="<%= email %>" required>
                                    <div class="error-text" id="emailError"></div>
                                </div>
                                <div class="detail-item">
                                    <label for="phone">Phone:</label>
                                    <input type="tel" id="phone" name="phone" value="<%= phone %>" required>
                                </div>
                                <div class="detail-item">
                                    <label for="address">Address:</label>
                                    <input type="text" id="address" name="address" value="<%= address %>" required>
                                </div>
                            </div>
                            <div class="profile-actions">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i> Save Changes
                                </button>
                            </div>
                        </form>
                    </div>
                    <div class="tab-pane" id="academic-tab">
                        <form action="ProfileServlet" method="post" class="detail-grid" onsubmit="return validateAcademicForm()">
                            <input type="hidden" name="action" value="updateAcademic">
                            <input type="hidden" name="studentId" value="<%= studentIdBadge %>">
                            <div class="detail-card">
                                <h3><i class="fas fa-graduation-cap"></i> Program</h3>
                                <div class="detail-item">
                                    <label for="degree">Degree:</label>
                                    <input type="text" id="degree" name="degree" value="<%= degree %>" required>
                                </div>
                                <div class="detail-item">
                                    <label for="enrolled">Enrolled:</label>
                                    <input type="month" id="enrolled" name="enrolled" value="<%= enrolled %>" required>
                                </div>
                                <div class="detail-item">
                                    <label for="gpa">GPA:</label>
                                    <input type="text" id="gpa" name="gpa" value="<%= gpa %>" required pattern="[0-4]\.\d{2}/4\.00">
                                    <div class="error-text" id="gpaError"></div>
                                </div>
                            </div>
                            <div class="profile-actions">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i> Save Changes
                                </button>
                            </div>
                        </form>
                    </div>
                    <div class="tab-pane" id="security-tab">
                        <form action="ProfileServlet" method="post" class="detail-grid" onsubmit="return validateSecurityForm()">
                            <input type="hidden" name="action" value="updateSecurity">
                            <input type="hidden" name="studentId" value="<%= studentIdBadge %>">
                            <div class="detail-card">
                                <h3><i class="fas fa-lock"></i> Security</h3>
                                <div class="detail-item">
                                    <label for="password">Password:</label>
                                    <input type="password" id="password" name="password" placeholder="Enter new password">
                                    <div class="error-text" id="passwordError"></div>
                                </div>
                                <div class="detail-item">
                                    <label for="confirmPassword">Confirm Password:</label>
                                    <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm new password">
                                    <div class="error-text" id="confirmPasswordError"></div>
                                </div>
                                <div class="detail-item">
                                    <label>2FA:</label>
                                    <input type="checkbox" id="twoFA" name="twoFA" <%= "Enabled".equals(twoFA) ? "checked" : "" %>>
                                    <label for="twoFA" class="checkbox-label">Enable 2FA</label>
                                </div>
                            </div>
                            <div class="profile-actions">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i> Save Changes
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <script>
        function previewImage(event) {
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('profileImage').src = e.target.result;
                }
                reader.readAsDataURL(file);
            }
        }

        function validatePersonalForm() {
            let isValid = true;
            let name = document.getElementById("name").value.trim();
            let email = document.getElementById("email").value.trim();
            let nameError = document.getElementById("nameError");
            let emailError = document.getElementById("emailError");

            nameError.textContent = "";
            emailError.textContent = "";

            if (name === "") {
                nameError.textContent = "Name is required.";
                isValid = false;
            }
            let emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailPattern.test(email)) {
                emailError.textContent = "Please enter a valid email address.";
                isValid = false;
            }
            return isValid;
        }

        function validateAcademicForm() {
            let isValid = true;
            let gpa = document.getElementById("gpa").value.trim();
            let gpaError = document.getElementById("gpaError");

            gpaError.textContent = "";
            if (!gpa.match(/[0-4]\.\d{2}\/4\.00/)) {
                gpaError.textContent = "GPA must be in format X.XX/4.00 (e.g., 3.72/4.00).";
                isValid = false;
            }
            return isValid;
        }

        function validateSecurityForm() {
            let isValid = true;
            let password = document.getElementById("password").value;
            let confirmPassword = document.getElementById("confirmPassword").value;
            let passwordError = document.getElementById("passwordError");
            let confirmPasswordError = document.getElementById("confirmPasswordError");

            passwordError.textContent = "";
            confirmPasswordError.textContent = "";

            if (password && password.length < 8) {
                passwordError.textContent = "Password must be at least 8 characters.";
                isValid = false;
            }
            if (password && password !== confirmPassword) {
                confirmPasswordError.textContent = "Passwords do not match.";
                isValid = false;
            }
            if (confirmPassword && !password) {
                passwordError.textContent = "Please enter a password.";
                isValid = false;
            }
            return isValid;
        }
    </script>





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
                    <button class="btn btn-outline" onclick="alert('Continue course: <%= courseTitle %>')">
                        <i class="fas fa-book"></i> Continue
                    </button>
                    <button class="btn btn-outline" onclick="alert('Course details: <%= courseTitle %>')">
                        <i class="fas fa-info-circle"></i> Details
                    </button>
                </div>
            </div>
            <% }
            } %>
            <% } %>
        </div>
    </section>

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

    <section id="deadlines" class="content-section">
        <div class="dashboard-header">
            <div class="greeting">
                <h1>Upcoming Deadlines</h1>
                <p>Stay on top of your tasks</p>
            </div>
            <button class="btn btn-outline" onclick="alert('Add reminder')">
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
                        <% if ("pending".equals(fee[4]) && !"true".equals(fee[6]) && isOverdue) { %>
                        <form action="fee" method="post" class="payment-action-form" id="waiverForm-<%= fee[0] %>" style="display: inline-block; margin-right: 5px;">
                            <input type="hidden" name="action" value="applyWaiver">
                            <input type="hidden" name="invoiceId" value="<%= fee[0] %>">
                            <input type="hidden" name="amount" value="<%= fee[2] %>">
                            <input type="hidden" name="studentId" value="<%= studentId %>">
                            <input type="text" name="waiverAmount" placeholder="Waiver Amount" style="width: 80px; padding: 5px;" required>
                            <button type="submit" class="btn btn-primary btn-sm" title="Apply Late Fee Waiver">
                                <i class="fas fa-hand-holding-usd"></i> Apply Waiver
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
                        <% if ("paid".equals(paymentStatus)) { %>
                        <button type="button" class="btn btn-outline btn-sm" title="Cancel Payment" onclick="confirmCancelPayment('<%= fee[0] %>', '<%= fee[2] %>', '<%= studentId %>')">
                            <i class="fas fa-undo"></i> Cancel
                        </button>
                        <form action="fee" method="post" class="payment-action-form" id="cancelForm-<%= fee[0] %>" style="display: none;">
                            <input type="hidden" name="action" value="cancelPayment">
                            <input type="hidden" name="invoiceId" value="<%= fee[0] %>">
                            <input type="hidden" name="amount" value="<%= fee[2] %>">
                            <input type="hidden" name="studentId" value="<%= studentId %>">
                            <button type="submit" class="btn btn-outline btn-sm" style="display: none;">Confirm Cancel</button>
                        </form>
                        <% } %>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </section>

    <script>
        function updateSubscriptionAmount() {
            let select = document.getElementById("subscriptionPlan");
            let amountInput = document.getElementById("subscriptionAmount");
            let selectedOption = select.options[select.selectedIndex];
            amountInput.value = selectedOption.getAttribute("data-amount") || "";
        }

        function togglePaymentDetails() {
            let paymentMethod = document.getElementById("paymentMethod").value;
            let paymentDetails = document.getElementById("paymentDetails");
            let groups = ["cardNumberGroup", "expiryDateGroup", "cvvGroup", "accountNumberGroup", "routingNumberGroup", "paypalEmailGroup", "cryptoWalletGroup"];

            paymentDetails.style.display = paymentMethod ? "block" : "none";
            groups.forEach(group => document.getElementById(group).style.display = "none");

            if (paymentMethod) {
                if (["creditCard", "debitCard"].includes(paymentMethod)) {
                    ["cardNumberGroup", "expiryDateGroup", "cvvGroup"].forEach(group => document.getElementById(group).style.display = "block");
                } else if (paymentMethod === "bankTransfer") {
                    ["accountNumberGroup", "routingNumberGroup"].forEach(group => document.getElementById(group).style.display = "block");
                } else if (paymentMethod === "payPal") {
                    document.getElementById("paypalEmailGroup").style.display = "block";
                } else if (paymentMethod === "crypto") {
                    document.getElementById("cryptoWalletGroup").style.display = "block";
                }
            }
        }

        function confirmCancelPayment(invoiceId, amount, studentId) {
            if (confirm(`Are you sure you want to cancel the payment for Invoice ID ${invoiceId}?`)) {
                let form = document.getElementById(`cancelForm-${invoiceId}`);
                form.submit();
            }
        }
    </script>





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
                    <button class="btn btn-primary" onclick="alert('Settings saved!')">
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

    <%@ page import="java.io.*, java.util.*" %>
    <%!
        private List<String[]> loadLoginHistory(String studentId, String filePath) {
            List<String[]> loginHistory = new ArrayList<>();
            File file = new File(filePath);
            if (!file.exists()) return loginHistory;

            try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    if (!line.trim().isEmpty()) {
                        String[] parts = line.split(",");
                        if (parts.length >= 4 && parts[0].equals(studentId)) {
                            loginHistory.add(parts);
                        }
                    }
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
            return loginHistory;
        }
    %>

    <%
        // Load login history
        String loginHistoryFilePath = application.getRealPath("/WEB-INF/data/login_history.txt");
        List<String[]> loginHistory = loadLoginHistory(studentId, loginHistoryFilePath);
    %>

    <section id="loginHistory" class="content-section">
        <div class="dashboard-header">
            <div class="greeting">
                <h1>Login History</h1>
                <p>View your recent login activity</p>
            </div>
        </div>

        <div class="settings-container">
            <div class="settings-form">
                <% if (loginHistory.isEmpty()) { %>
                <div class="form-group">
                    <p>No login history available.</p>
                </div>
                <% } else { %>
                <% for (String[] login : loginHistory) {
                    String date = login[1];
                    String time = login[2];
                    String ip = login[3];
                    String status = login.length > 4 ? login[4] : "Success";
                %>
                <div class="form-group">
                    <label>Date: <%= date %></label>
                    <p>Time: <%= time %></p>
                    <p>IP Address: <%= ip %></p>
                    <p>Status: <span class="<%= "Failed".equals(status) ? "status-cell overdue" : "status-cell" %>"><%= status %></span></p>
                </div>
                <% } %>
                <% } %>
                <div class="form-group">
                    <button class="btn btn-primary" onclick="alert('Login history refreshed!'); location.reload();">
                        <i class="fas fa-sync-alt"></i> Refresh
                    </button>
                </div>
            </div>
        </div>
    </section>
</div>

<script>
    // Sidebar Navigation
    const navLinks = document.querySelectorAll('.nav-link');
    const sections = document.querySelectorAll('.content-section');

    navLinks.forEach(link => {
        link.addEventListener('click', (e) => {
            e.preventDefault();
            const sectionId = link.getAttribute('data-section');

            // Update active nav link
            navLinks.forEach(l => {
                l.classList.remove('active');
                l.parentElement.classList.remove('active');
            });
            link.classList.add('active');
            link.parentElement.classList.add('active');

            // Show/hide sections
            sections.forEach(section => {
                section.classList.remove('active');
                if (section.id === sectionId) {
                    section.classList.add('active');
                }
            });
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
    const profileTabs = document.querySelectorAll('.profile-tabs .tab');
    profileTabs.forEach(tab => {
        tab.addEventListener('click', () => {
            const tabId = tab.getAttribute('data-tab');

            profileTabs.forEach(t => t.classList.remove('active'));
            tab.classList.add('active');

            const tabPanes = document.querySelectorAll('.tab-pane');
            tabPanes.forEach(pane => {
                pane.classList.remove('active');
                if (pane.id === `${tabId}-tab`) {
                    pane.classList.add('active');
                }
            });
        });
    });

    // Notification Bell
    const notificationBell = document.querySelector('.notification-bell');
    if (notificationBell) {
        notificationBell.addEventListener('click', () => {
            alert('2 new notifications');
        });
    }

    // Payment Form Handling
    function updateSubscriptionAmount() {
        const subscriptionPlan = document.getElementById('subscriptionPlan');
        const subscriptionAmountInput = document.getElementById('subscriptionAmount');
        if (subscriptionPlan && subscriptionAmountInput) {
            const selectedOption = subscriptionPlan.options[subscriptionPlan.selectedIndex];
            subscriptionAmountInput.value = selectedOption.getAttribute('data-amount') || '';
        }
    }

    function togglePaymentDetails() {
        const paymentMethod = document.getElementById('paymentMethod');
        const paymentDetails = document.getElementById('paymentDetails');
        if (!paymentMethod || !paymentDetails) return;

        const groups = {
            card: ['cardNumberGroup', 'expiryDateGroup', 'cvvGroup'],
            bank: ['accountNumberGroup', 'routingNumberGroup'],
            paypal: ['paypalEmailGroup'],
            crypto: ['cryptoWalletGroup']
        };

        paymentDetails.style.display = 'none';
        Object.values(groups).flat().forEach(groupId => {
            const group = document.getElementById(groupId);
            if (group) group.style.display = 'none';
        });

        const method = paymentMethod.value;
        if (method) {
            paymentDetails.style.display = 'block';
            if (['creditCard', 'debitCard'].includes(method)) {
                groups.card.forEach(groupId => {
                    const group = document.getElementById(groupId);
                    if (group) group.style.display = 'block';
                });
            } else if (method === 'bankTransfer') {
                groups.bank.forEach(groupId => {
                    const group = document.getElementById(groupId);
                    if (group) group.style.display = 'block';
                });
            } else if (method === 'payPal') {
                groups.paypal.forEach(groupId => {
                    const group = document.getElementById(groupId);
                    if (group) group.style.display = 'block';
                });
            } else if (method === 'crypto') {
                groups.crypto.forEach(groupId => {
                    const group = document.getElementById(groupId);
                    if (group) group.style.display = 'block';
                });
            }
        }
    }

    // Initialize payment form
    const paymentForm = document.getElementById('paymentForm');
    if (paymentForm) {
        paymentForm.addEventListener('submit', (e) => {
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

            const validateField = (id, message) => {
                const field = document.getElementById(id);
                if (field && !field.value.trim()) {
                    e.preventDefault();
                    alert(message);
                    return false;
                }
                return true;
            };

            if (['creditCard', 'debitCard'].includes(paymentMethod)) {
                if (!validateField('cardNumber', 'Please enter card number.') ||
                    !validateField('expiryDate', 'Please enter expiry date.') ||
                    !validateField('cvv', 'Please enter CVV.')) return;
            } else if (paymentMethod === 'bankTransfer') {
                if (!validateField('accountNumber', 'Please enter account number.') ||
                    !validateField('routingNumber', 'Please enter routing number.')) return;
            } else if (paymentMethod === 'payPal') {
                if (!validateField('paypalEmail', 'Please enter PayPal email.')) return;
            } else if (paymentMethod === 'crypto') {
                if (!validateField('cryptoWallet', 'Please enter crypto wallet address.')) return;
            }
        });

        updateSubscriptionAmount();
        togglePaymentDetails();
    }
</script>
</body>
</html>