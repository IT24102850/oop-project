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
            <a href="#" class="nav-link" data-section="login-history">
                <i class="fas fa-sign-in-alt"></i> <span>Login History</span>
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
                <a href="${pageContext.request.contextPath}/logIn.jsp?logout=true" class="btn btn-logout">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
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
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%!
        private String[] loadProfileData(String studentId, String filePath) {
            String[] profileData = new String[8];
            for (int i = 0; i < 8; i++) profileData[i] = "";

            File file = new File(filePath);
            if (!file.exists()) return profileData;

            try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    if (!line.trim().isEmpty()) {
                        String[] parts = line.split(",", -1);
                        if (parts.length == 8 && parts[0].equals(studentId)) {
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
        // Assign userStudentId from request parameter with a default
        String userStudentId = request.getParameter("studentId");
        if (userStudentId == null || userStudentId.isEmpty()) {
            userStudentId = "defaultStudentId";
        }

        // Load profile data
        String filePath = application.getRealPath("/WEB-INF/data/profiles.txt");
        String[] profileData = loadProfileData(userStudentId, filePath);

        // Assign profile data to variables with defaults
        String name = profileData[1].isEmpty() ? "" : profileData[1];
        String dob = profileData[2].isEmpty() ? "" : profileData[2];
        String gender = profileData[3].isEmpty() ? "" : profileData[3];
        String nemail = profileData[4].isEmpty() ? "" : profileData[4];
        String phone = profileData[5].isEmpty() ? "" : profileData[5];
        String address = profileData[6].isEmpty() ? "" : profileData[6];
        String imagePath = profileData[7].isEmpty() ? "https://via.placeholder.com/150" : "ProfileServlet?action=getPicture&pic=" + profileData[7];

        // Handle success/error message from redirect
        String message = request.getParameter("message");
    %>


    <head>
        <title>Student Profile</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            :root {
                --primary-color: #00f2fe;
                --accent-color: #ff007a;
                --text-muted: #888;
                --card-bg: #f0f0f0;
                --glass-bg: rgba(255, 255, 255, 0.1);
                --border-radius: 10px;
                --glow-effect: 0 0 10px rgba(0, 242, 254, 0.5);
                --text-color: #333;
                --secondary-color: #ff4d4d;
                --transition: all 0.3s ease;
            }

            .profile-container {
                background: var(--card-bg);
                border-radius: var(--border-radius);
                padding: 20px;
                margin: 20px auto;
                max-width: 800px;
                box-shadow: var(--glow-effect);
            }

            .profile-header {
                display: flex;
                align-items: center;
                gap: 20px;
                margin-bottom: 20px;
            }

            .avatar-image {
                width: 100px;
                height: 100px;
                border-radius: 50%;
                object-fit: cover;
                border: 2px solid var(--primary-color);
            }

            .profile-info h2 {
                font-size: 20px;
                color: var(--primary-color);
                margin: 0 0 5px;
            }

            .student-id-badge {
                font-size: 14px;
                color: var(--text-muted);
            }

            .student-id-badge i {
                margin-right: 5px;
                color: var(--primary-color);
            }

            .detail-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 15px;
            }

            .detail-item {
                margin-bottom: 10px;
            }

            .detail-item label {
                display: block;
                font-size: 14px;
                color: var(--text-muted);
                margin-bottom: 5px;
            }

            .detail-item input, .detail-item select {
                width: 100%;
                padding: 8px;
                border: 1px solid var(--primary-color);
                border-radius: 5px;
                background: #fff;
                color: var(--text-color);
            }

            .detail-item input:focus, .detail-item select:focus {
                border-color: var(--accent-color);
                outline: none;
                box-shadow: var(--glow-effect);
            }

            .error-text {
                color: var(--secondary-color);
                font-size: 12px;
                margin-top: 3px;
            }

            .profile-actions {
                grid-column: 1 / -1;
                text-align: right;
                margin-top: 10px;
            }

            .btn {
                padding: 8px 15px;
                border: none;
                border-radius: 5px;
                background: var(--primary-color);
                color: #fff;
                cursor: pointer;
                transition: var(--transition);
            }

            .btn:hover {
                background: var(--accent-color);
            }

            .message {
                padding: 10px;
                background: rgba(0, 255, 0, 0.1);
                color: #00ff00;
                border: 1px solid rgba(0, 255, 0, 0.3);
                border-radius: var(--border-radius);
                margin: 10px 0;
                text-align: center;
            }

            @media (max-width: 768px) {
                .profile-header {
                    flex-direction: column;
                    text-align: center;
                }

                .detail-grid {
                    grid-template-columns: 1fr;
                }
            }
        </style>
    </head>

    <section id="profile" class="content-section">
        <div class="profile-container">
            <div class="profile-header">
                <div class="user-avatar-holographic">
                    <img src="<%= imagePath %>" alt="Profile Picture" class="avatar-image" id="profileImage">
                </div>
                <div class="profile-info">
                    <h2><%= name.isEmpty() ? "Update Profile" : name %></h2>
                    <div class="student-id-badge">
                        <i class="fas fa-id-card"></i> <%= userStudentId %>
                    </div>
                </div>
            </div>

            <form action="ProfileServlet" method="post" enctype="multipart/form-data" class="detail-grid" onsubmit="return validateProfileForm()">
                <input type="hidden" name="studentId" value="<%= userStudentId %>">
                <div class="detail-item">
                    <label for="name">Name:</label>
                    <input type="text" id="name" name="name" value="<%= name %>" required>
                    <div class="error-text" id="nameError"></div>
                </div>
                <div class="detail-item">
                    <label for="dob">Date of Birth:</label>
                    <input type="date" id="dob" name="dob" value="<%= dob %>" required>
                </div>
                <div class="detail-item">
                    <label for="gender">Gender:</label>
                    <select id="gender" name="gender" required>
                        <option value="" <%= gender.isEmpty() ? "selected" : "" %>>Select</option>
                        <option value="Male" <%= "Male".equals(gender) ? "selected" : "" %>>Male</option>
                        <option value="Female" <%= "Female".equals(gender) ? "selected" : "" %>>Female</option>
                        <option value="Other" <%= "Other".equals(gender) ? "selected" : "" %>>Other</option>
                    </select>
                </div>
                <div class="detail-item">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" value="<%= email %>" required>
                    <div class="error-text" id="emailError"></div>
                </div>
                <div class="detail-item">
                    <label for="phone">Phone:</label>
                    <input type="tel" id="phone" name="phone" value="<%= phone %>" placeholder="+94XXXXXXXXX" required>
                    <div class="error-text" id="phoneError"></div>
                </div>
                <div class="detail-item">
                    <label for="address">Address:</label>
                    <input type="text" id="address" name="address" value="<%= address %>" required>
                </div>
                <div class="detail-item">
                    <label for="avatar">Profile Picture:</label>
                    <input type="file" id="avatar" name="avatar" accept="image/*" onchange="previewImage(event)" required>
                </div>
                <div class="profile-actions">
                    <button type="submit" class="btn">
                        <i class="fas fa-save"></i> Save Profile
                    </button>
                </div>
            </form>

            <% if (message != null && !message.isEmpty()) { %>
            <div class="message"><%= message %></div>
            <% } %>
        </div>
    </section>

    <script>
        // Preview Image
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

        // Form Validation
        function validateProfileForm() {
            let isValid = true;
            const name = document.getElementById("name").value.trim();
            const email = document.getElementById("email").value.trim();
            const phone = document.getElementById("phone").value.trim().replace(/[\s-]/g, "");
            const nameError = document.getElementById("nameError");
            const emailError = document.getElementById("emailError");
            const phoneError = document.getElementById("phoneError");

            nameError.textContent = "";
            emailError.textContent = "";
            phoneError.textContent = "";

            if (name === "") {
                nameError.textContent = "Name is required.";
                isValid = false;
            }

            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailPattern.test(email)) {
                emailError.textContent = "Please enter a valid email address.";
                isValid = false;
            }

            if (!/^\+94\d{9}$/.test(phone)) {
                phoneError.textContent = "Phone must be in +94XXXXXXXXX format.";
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

    <section id="login-history" class="content-section">
        <div class="dashboard-header">
            <div class="greeting">
                <h1>Login History</h1>
                <p>View your recent login activity</p>
            </div>
        </div>

        <div class="login-history-container">
            <div class="login-history-header">
                <h2><i class="fas fa-sign-in-alt"></i> Login Activity</h2>
            </div>

            <!-- Login History Table -->
            <table class="login-history-table" id="loginHistoryTable">
                <thead>
                <tr>
                    <th onclick="sortTable(0)">Timestamp <i class="fas fa-sort"></i></th>
                    <th onclick="sortTable(1)">Username <i class="fas fa-sort"></i></th>
                    <th onclick="sortTable(2)">Role <i class="fas fa-sort"></i></th>
                    <th onclick="sortTable(3)">Status <i class="fas fa-sort"></i></th>
                    <th>Details</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="login" items="${loginHistory}">
                    <c:set var="statusClass" value="${login[3] == 'Success' ? 'success' : 'failed'}"/>
                    <tr>
                        <td><fmt:parseDate value="${login[0]}" pattern="yyyy-MM-dd HH:mm:ss" var="loginDate"/>
                            <fmt:formatDate value="${loginDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                        <td>${login[1]}</td>
                        <td>${login[2]}</td>
                        <td class="status-cell ${statusClass}">${login[3]}</td>
                        <td>${empty login[4] ? 'N/A' : login[4]}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <c:if test="${empty loginHistory}">
                <div class="no-data-message">
                    <p>No login history available.</p>
                </div>
            </c:if>
        </div>

        <style>
            :root {
                --card-bg: #1a1a2e;
                --background-color: #0f0f1a;
                --text-color: #fff;
                --primary-color: #00d4ff;
                --secondary-color: #ff2e63;
                --text-muted: #a0a0a0;
                --glass-bg: rgba(255, 255, 255, 0.05);
                --glow-effect: 0 0 10px rgba(0, 212, 255, 0.3);
                --transition: all 0.3s ease;
            }

            .content-section { padding: 20px; max-width: 1200px; margin: 0 auto; background-color: var(--background-color); color: var(--text-color); }
            .dashboard-header h1 { font-size: 2rem; margin-bottom: 10px; color: var(--primary-color); }
            .dashboard-header p { font-size: 1rem; color: var(--text-muted); }
            .login-history-container { background: var(--card-bg); padding: 20px; border-radius: 10px; box-shadow: var(--glow-effect); }
            .login-history-header h2 { font-size: 1.5rem; display: flex; align-items: center; gap: 10px; color: var(--primary-color); }
            .login-history-table { width: 100%; border-collapse: collapse; margin-top: 10px; color: var(--text-color); }
            .login-history-table th, .login-history-table td { padding: 12px; border-bottom: 1px solid var(--glass-bg); text-align: left; }
            .login-history-table th { background: var(--background-color); color: var(--primary-color); cursor: pointer; }
            .login-history-table th:hover { background: var(--primary-color); color: var(--background-color); }
            .status-cell.success { color: #28a745; }
            .status-cell.failed { color: #ff2e63; }
            .no-data-message { text-align: center; padding: 20px; color: var(--text-muted); }
        </style>

        <script>
            function sortTable(columnIndex) {
                const table = document.getElementById('loginHistoryTable');
                const rows = Array.from(table.rows).slice(1);
                const isAscending = table.getAttribute('data-sort-order') !== 'asc';
                table.setAttribute('data-sort-order', isAscending ? 'asc' : 'desc');

                rows.sort((rowA, rowB) => {
                    let valueA = rowA.cells[columnIndex].innerText.trim();
                    let valueB = rowB.cells[columnIndex].innerText.trim();

                    if (columnIndex === 0) {
                        valueA = new Date(valueA).getTime();
                        valueB = new Date(valueB).getTime();
                    }

                    return isAscending ? (valueA > valueB ? 1 : -1) : (valueA < valueB ? 1 : -1);
                });

                const tbody = table.querySelector('tbody');
                tbody.innerHTML = '';
                rows.forEach(row => tbody.appendChild(row));
            }
        </script>
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






    <%@ page import="java.io.*" %>
    <%@ page import="java.time.LocalDate" %>
    <%@ page import="java.time.LocalDateTime" %>
    <%@ page import="java.time.format.DateTimeFormatter" %>
    <%@ page import="java.util.ArrayList" %>
    <%@ page import="java.util.List" %>
    <%@ page import="java.util.HashSet" %>
    <%@ page import="java.util.Set" %>
    <%@ page import="com.studentregistration.dao.PaymentDAO" %>
    <%@ page import="com.studentregistration.model.Payment" %>

    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="UTF-8">
        <title>Student Dashboard - Payment Section</title>
        <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
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

            body {
                background: linear-gradient(135deg, var(--background-color), #050916);
                color: var(--text-color);
                font-family: 'Poppins', sans-serif;
            }

            .spinner {
                border: 4px solid rgba(255, 255, 255, 0.1);
                border-left: 4px solid var(--primary-color);
                border-radius: 50%;
                width: 20px;
                height: 20px;
                animation: spin 1s linear infinite;
                display: inline-block;
                vertical-align: middle;
                margin-right: 8px;
            }

            @keyframes spin {
                0% { transform: rotate(0deg); }
                100% { transform: rotate(360deg); }
            }

            .fade-out {
                opacity: 0;
                transition: opacity 0.5s ease-out;
            }

            .payment-table {
                width: 100%;
                border-collapse: collapse;
                background: var(--card-bg);
                border-radius: var(--border-radius);
                overflow: hidden;
            }

            .payment-table th,
            .payment-table td {
                padding: 15px;
                text-align: left;
                border-bottom: 1px solid rgba(0, 242, 254, 0.1);
            }

            .payment-table th {
                background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
                color: var(--background-color);
                font-weight: 600;
                cursor: pointer;
                transition: var(--transition);
            }

            .payment-table th:hover {
                background: var(--accent-color);
            }

            .payment-table tr {
                transition: var(--transition);
            }

            .payment-table tr:hover {
                background: var(--glass-bg);
                transform: translateY(-2px);
            }

            .status-cell {
                font-weight: 600;
            }

            .status-cell.paid { color: #00ff00; }
            .status-cell.pending { color: var(--primary-color); }
            .status-cell.overdue { color: #ff4500; }
            .status-cell.error { color: var(--text-muted); }

            .btn-futuristic {
                padding: 8px 15px;
                border-radius: 25px;
                text-decoration: none;
                font-weight: 600;
                font-size: 0.9rem;
                display: inline-flex;
                align-items: center;
                gap: 8px;
                transition: var(--transition);
                cursor: pointer;
                border: none;
                position: relative;
                overflow: hidden;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
            }

            .btn-futuristic:hover {
                transform: translateY(-2px);
                box-shadow: var(--glow-effect);
            }

            .btn-futuristic:disabled {
                background: var(--text-muted);
                cursor: not-allowed;
                transform: none;
                box-shadow: none;
            }

            .btn-futuristic.bg-red-500 {
                background: #ff4500;
                color: var(--text-color);
            }

            .btn-futuristic.bg-red-500:hover {
                background: transparent;
                border: 2px solid #ff4500;
                color: #ff4500;
            }

            .btn-futuristic.bg-yellow-500 {
                background: #ffa500;
                color: var(--background-color);
            }

            .btn-futuristic.bg-yellow-500:hover {
                background: transparent;
                border: 2px solid #ffa500;
                color: #ffa500;
            }

            .btn-futuristic.bg-gray-500 {
                background: var(--text-muted);
                color: var(--background-color);
            }

            .btn-futuristic.bg-gray-500:hover {
                background: transparent;
                border: 2px solid var(--text-muted);
                color: var(--text-muted);
            }

            .btn-futuristic.bg-green-500 {
                background: #00ff00;
                color: var(--background-color);
            }

            .btn-futuristic.bg-green-500:hover {
                background: transparent;
                border: 2px solid #00ff00;
                color: #00ff00;
            }

            .btn-primary {
                background: var(--primary-color);
                color: var(--background-color);
                border: 2px solid transparent;
                padding: 10px 20px;
                border-radius: 25px;
                transition: var(--transition);
            }

            .btn-primary:hover {
                background: transparent;
                color: var(--primary-color);
                border-color: var(--primary-color);
                box-shadow: var(--glow-effect);
            }

            .form-group input,
            .form-group select {
                padding: 10px;
                border-radius: 8px;
                border: 1px solid var(--primary-color);
                background: var(--glass-bg);
                color: var(--text-color);
                transition: var(--transition);
                width: 100%;
            }

            .form-group input:focus,
            .form-group select:focus {
                outline: none;
                border-color: var(--accent-color);
                box-shadow: var(--glow-effect);
            }

            .form-group label {
                color: var(--text-muted);
                font-size: 0.95rem;
                margin-bottom: 8px;
                display: block;
            }

            .pagination button {
                background: var(--primary-color);
                color: var(--background-color);
                padding: 8px 15px;
                border-radius: 8px;
                transition: var(--transition);
            }

            .pagination button:hover:not(:disabled) {
                background: var(--accent-color);
                box-shadow: var(--glow-effect);
            }

            .pagination button:disabled {
                background: var(--text-muted);
                cursor: not-allowed;
            }

            .pagination span {
                color: var(--text-muted);
            }

            .payment-container, .dashboard-header {
                background: var(--card-bg);
            }
        </style>
    </head>
    <body>
    <section id="payment" class="content-section">
        <div class="dashboard-header shadow-md rounded-lg p-6 mb-6">
            <div class="greeting">
                <h1 class="text-3xl font-bold" style="background: linear-gradient(45deg, var(--primary-color), var(--secondary-color)); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Payment Management</h1>
                <p class="text-gray-600">Manage your site subscription to access all courses</p>
            </div>
        </div>

        <div class="payment-container shadow-md rounded-lg p-6">
            <div class="payment-header mb-6">
                <h2 class="text-2xl font-semibold text-gray-800 flex items-center">
                    <i class="fas fa-credit-card mr-2" style="color: var(--primary-color);"></i> Payment Options
                </h2>
            </div>

            <div class="payment-section active" id="make-payment-section">
                <h3 class="text-xl font-semibold mb-4" style="color: var(--accent-color);">Make a Payment</h3>
                <%
                    // Check for payments with null or invalid subscription plans
                    List<Payment> nullPlanPayments = new ArrayList<>();
                    String paymentsFilePath = application.getRealPath("/WEB-INF/data/payments.txt");
                    PaymentDAO paymentDAO = new PaymentDAO(paymentsFilePath);
                    try {
                        List<Payment> allPayments = paymentDAO.getAllPayments();
                        for (Payment payment : allPayments) {
                            String plan = payment.getSubscriptionPlan();
                            if (plan == null || plan.trim().isEmpty() || !plan.matches("^(monthly|quarterly|yearly)$")) {
                                nullPlanPayments.add(payment);
                            }
                        }
                    } catch (IOException e) {
                %>
                <div class="message error mt-4">Error loading payments: <%= e.getMessage() %></div>
                <%
                    }
                %>


                <form id="paymentForm" action="${pageContext.request.contextPath}/ProcessPayment" method="post" class="payment-form space-y-4">
                    <input type="hidden" name="action" value="makePayment">
                    <input type="hidden" name="studentId" value="<%= session.getAttribute("userId") %>">
                    <div class="form-group">
                        <label for="subscriptionPlan">Subscription Plan:</label>
                        <select id="subscriptionPlan" name="subscriptionPlan" class="invoice-select" required onchange="updateSubscriptionAmount()">
                            <option value="">-- Select a Plan --</option>
                            <option value="monthly" data-amount="49.99">Monthly - $49.99</option>
                            <option value="quarterly" data-amount="129.99">Quarterly - $129.99</option>
                            <option value="yearly" data-amount="499.99">Yearly - $499.99</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="subscriptionAmount">Total Amount:</label>
                        <input type="text" id="subscriptionAmount" name="totalAmount" readonly required>
                    </div>
                    <div class="form-group">
                        <label for="partialAmount">Partial Payment Amount:</label>
                        <input type="number" id="partialAmount" name="partialAmount" step="0.01" min="0" placeholder="Enter partial amount" required oninput="updateRemainingAmount()">
                    </div>
                    <div class="form-group">
                        <label for="remainingAmount">Remaining Amount:</label>
                        <input type="text" id="remainingAmount" name="remainingAmount" readonly value="0.00">
                    </div>
                    <div class="form-group">
                        <label for="startDate">Start Date:</label>
                        <input type="date" id="startDate" name="startDate" required min="2025-05-17">
                    </div>
                    <div class="form-group">
                        <label for="paymentMethod">Payment Method:</label>
                        <select id="paymentMethod" name="paymentMethod" class="invoice-select" required>
                            <option value="">-- Select Payment Method --</option>
                            <option value="creditCard">Credit Card</option>
                            <option value="debitCard">Debit Card</option>
                            <option value="bankTransfer">Bank Transfer</option>
                            <option value="payPal">PayPal</option>
                            <option value="crypto">Crypto</option>
                        </select>
                    </div>

                    <div class="payment-actions mt-6">
                        <button type="submit" class="btn-primary" id="makePaymentBtn">
                            <i class="fas fa-check-circle mr-2"></i> Submit Payment
                        </button>
                    </div>
                </form>
                <%
                    String paymentStatus = request.getParameter("paymentStatus");
                    if ("success".equals(paymentStatus)) {
                %>
                <div class="message success mt-4">Payment submitted successfully! Remaining balance can be waived.</div>
                <%
                } else if ("partialWaiverApplied".equals(paymentStatus)) {
                %>
                <div class="message success mt-4">Waiver applied to remaining balance. Payment is now fully settled.</div>
                <%
                } else if (paymentStatus != null && !paymentStatus.isEmpty()) {
                %>
                <div class="message error mt-4">Error processing payment: <%= paymentStatus %></div>
                <%
                    }
                    String userId = (String) session.getAttribute("userId");
                    if (userId == null) {

                    }
                %>
            </div>

            <h3 class="text-xl font-semibold mt-8 mb-4" style="color: var(--accent-color);">Payment History</h3>
            <div class="filter-container flex flex-wrap gap-4 mb-6">
                <button class="btn-futuristic bg-gray-500 text-white px-4 py-2 rounded-md hover:bg-gray-600 flex items-center" id="refreshBtn" onclick="refreshPage()">
                    <i class="fas fa-sync-alt mr-2"></i> Refresh
                </button>
                <button class="btn-futuristic bg-green-500 text-white px-4 py-2 rounded-md hover:bg-green-600 flex items-center" onclick="exportToCSV()">
                    <i class="fas fa-file-export mr-2"></i> Export to CSV
                </button>
            </div>

            <div id="loadingMessage" class="text-center text-blue-600" style="display: none;">
                <span class="spinner"></span> Loading payment history...
            </div>

            <%
                // Load waivers to check existing ones
                Set<String> waivedInvoices = new HashSet<>();
                String waiverFilePath = application.getRealPath("/WEB-INF/data/waiver.txt");
                File waiverFile = new File(waiverFilePath);
                if (waiverFile.exists()) {
                    try (BufferedReader reader = new BufferedReader(new FileReader(waiverFile))) {
                        String line;
                        while ((line = reader.readLine()) != null) {
                            if (line.trim().isEmpty()) continue;
                            String[] waiverEntry = line.split(",");
                            if (waiverEntry.length >= 4) {
                                waivedInvoices.add(waiverEntry[0]);
                            }
                        }
                    } catch (IOException e) {
            %>
            <div class="message error mt-4">Error reading waiver file: <%= e.getMessage() %></div>
            <%
                    }
                }

                // Handle Apply Waiver action for remaining amount
                String applyWaiverInvoiceId = request.getParameter("applyWaiverInvoiceId");
                if (applyWaiverInvoiceId != null && userId != null) {
                    if (!applyWaiverInvoiceId.matches("^[A-Za-z0-9-]+$")) {
            %>
            <div class="message error mt-4">Invalid invoice ID format.</div>
            <%
                    return;
                }

                if (waivedInvoices.contains(applyWaiverInvoiceId)) {
            %>
            <div class="message error mt-4">Waiver already applied for Invoice ID: <%= applyWaiverInvoiceId %></div>
            <%
            } else {
                if (!waiverFile.exists()) {
                    waiverFile.getParentFile().mkdirs();
                    waiverFile.createNewFile();
                }
                try (PrintWriter writer = new PrintWriter(new FileWriter(waiverFile, true))) {
                    String waiverEntry = String.format("%s,%s,true,%s",
                            applyWaiverInvoiceId,
                            userId,
                            LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));
                    writer.println(waiverEntry);
                    waivedInvoices.add(applyWaiverInvoiceId);

                    // Update payments.txt to reflect the waiver covering the remaining amount
                    List<Payment> payments = paymentDAO.getAllPayments();
                    List<Payment> updatedPayments = new ArrayList<>();
                    boolean found = false;
                    for (Payment payment : payments) {
                        if (payment.getInvoiceId().equals(applyWaiverInvoiceId)) {
                            found = true;
                            double originalAmount = payment.getAmount();
                            double totalAmount = 0.0;
                            String plan = payment.getSubscriptionPlan();
                            if (plan != null) {
                                switch (plan) {
                                    case "monthly": totalAmount = 49.99; break;
                                    case "quarterly": totalAmount = 129.99; break;
                                    case "yearly": totalAmount = 499.99; break;
                                }
                            }
                            double remainingAmount = totalAmount - originalAmount;
                            payment.setAmount(totalAmount); // Update to the full amount
                            payment.setStatus("paid");
                            payment.setPaymentDate(LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));
                            payment.setWaiverApplied(true);
                        }
                        updatedPayments.add(payment);
                    }

                    if (found) {
                        try (PrintWriter paymentWriter = new PrintWriter(new FileWriter(paymentsFilePath))) {
                            for (Payment payment : updatedPayments) {
                                paymentWriter.println(payment.toString());
                            }
                        } catch (IOException e) {
            %>
            <div class="message error mt-4">Error updating payments file: <%= e.getMessage() %></div>
            <%
                    return;
                }
            } else {
            %>
            <div class="message error mt-4">Payment record not found for Invoice ID: <%= applyWaiverInvoiceId %></div>
            <%
                    return;
                }
            %>
            <div class="message success mt-4">Waiver applied successfully for Invoice ID: <%= applyWaiverInvoiceId %></div>
            <%
            } catch (IOException e) {
            %>
            <div class="message error mt-4">Error saving waiver: <%= e.getMessage() %></div>
            <%
                        }
                    }
                    response.sendRedirect("student-dashboard.jsp?paymentStatus=partialWaiverApplied#payment");
                    return;
                }

                // Handle Void Payment action
                String voidInvoiceId = request.getParameter("voidInvoiceId");
                if (voidInvoiceId != null) {
                    if (!voidInvoiceId.matches("^[A-Za-z0-9-]+$")) {
            %>
            <div class="message error mt-4">Invalid invoice ID format.</div>
            <%
                    return;
                }

                paymentsFilePath = application.getRealPath("/WEB-INF/data/payments.txt");
                File paymentsFile = new File(paymentsFilePath);
                paymentDAO = new PaymentDAO(paymentsFilePath);
                List<Payment> payments = paymentDAO.getAllPayments();
                List<Payment> updatedPayments = new ArrayList<>();
                boolean found = false;

                for (Payment payment : payments) {
                    if (payment.getInvoiceId().equals(voidInvoiceId)) {
                        found = true;
                        continue;
                    }
                    updatedPayments.add(payment);
                }

                if (found) {
                    try (PrintWriter writer = new PrintWriter(new FileWriter(paymentsFile))) {
                        for (Payment payment : updatedPayments) {
                            writer.println(payment.toString());
                        }
            %>
            <div class="message success mt-4">Payment voided successfully for Invoice ID: <%= voidInvoiceId %></div>
            <%
            } catch (IOException e) {
            %>
            <div class="message error mt-4">Error updating payments file: <%= e.getMessage() %></div>
            <%
                    return;
                }
            } else {
            %>
            <div class="message error mt-4">Payment record not found for Invoice ID: <%= voidInvoiceId %></div>
            <%
                    }
                    response.sendRedirect("student-dashboard.jsp#payment");
                    return;
                }

                // Handle Mark as Paid action
                String markAsPaidInvoiceId = request.getParameter("markAsPaidInvoiceId");
                if (markAsPaidInvoiceId != null) {
                    if (!markAsPaidInvoiceId.matches("^[A-Za-z0-9-]+$")) {
            %>
            <div class="message error mt-4">Invalid invoice ID format.</div>
            <%
                    return;
                }

                paymentDAO = new PaymentDAO(paymentsFilePath);
                boolean updated = paymentDAO.updatePaymentStatus(markAsPaidInvoiceId, "paid", LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));

                if (updated) {
            %>
            <div class="message success mt-4">Payment marked as paid for Invoice ID: <%= markAsPaidInvoiceId %></div>
            <%
            } else {
            %>
            <div class="message error mt-4">Payment record not found or already paid for Invoice ID: <%= markAsPaidInvoiceId %></div>
            <%
                    }
                    response.sendRedirect("student-dashboard.jsp#payment");
                    return;
                }

                // Load payment records using PaymentDAO
                List<Payment> paymentRecords = new ArrayList<>();
                paymentDAO = new PaymentDAO(paymentsFilePath);
                try {
                    paymentRecords = paymentDAO.getAllPayments();
                    for (Payment payment : paymentRecords) {
                        // Calculate due date if not present (already set in the new format)
                        if ("pending".equals(payment.getStatus())) {
                            LocalDate dueDate = LocalDate.parse(payment.getDueDate(), DateTimeFormatter.ISO_LOCAL_DATE);
                            LocalDate today = LocalDate.now();
                            if (dueDate.isBefore(today)) {
                                payment.setStatus("overdue");
                                double lateFee = payment.getAmount() * 0.05;
                                payment.setLateFee(lateFee);
                            }
                        }
                    }
                } catch (IOException e) {
            %>
            <div class="message error mt-4">Error loading payment history: <%= e.getMessage() %></div>
            <%
                    return;
                }
            %>

            <table class="payment-table">
                <thead>
                <tr>
                    <th onclick="sortTable(0)">Invoice ID <i class="fas fa-sort ml-1"></i></th>
                    <th onclick="sortTable(1)">Student ID <i class="fas fa-sort ml-1"></i></th>
                    <th onclick="sortTable(2)">Amount <i class="fas fa-sort ml-1"></i></th>
                    <th onclick="sortTable(3)">Due Date <i class="fas fa-sort ml-1"></i></th>
                    <th onclick="sortTable(4)">Status <i class="fas fa-sort ml-1"></i></th>
                    <th onclick="sortTable(5)">Payment Date <i class="fas fa-sort ml-1"></i></th>
                    <th onclick="sortTable(6)">Waiver Applied <i class="fas fa-sort ml-1"></i></th>
                    <th onclick="sortTable(7)">Late Fee <i class="fas fa-sort ml-1"></i></th>
                    <th onclick="sortTable(8)">Payment Method <i class="fas fa-sort ml-1"></i></th>
                    <th onclick="sortTable(9)">Subscription Plan <i class="fas fa-sort ml-1"></i></th>
                    <th onclick="sortTable(10)">Start Date <i class="fas fa-sort ml-1"></i></th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody id="paymentTableBody">
                <%
                    if (paymentRecords.isEmpty()) {
                %>
                <tr>
                    <td colspan="12" class="text-center py-4">No payment history available.</td>
                </tr>
                <%
                } else {
                    int pageSize = 10;
                    int currentPage = 1;
                    String pageParam = request.getParameter("page");
                    if (pageParam != null) {
                        try {
                            currentPage = Integer.parseInt(pageParam);
                        } catch (NumberFormatException e) {
                            currentPage = 1;
                        }
                    }
                    int start = (currentPage - 1) * pageSize;
                    int end = Math.min(start + pageSize, paymentRecords.size());

                    for (int i = start; i < end; i++) {
                        Payment payment = paymentRecords.get(i);
                        String status = payment.getStatus();
                        boolean isWaived = payment.isWaiverApplied() || waivedInvoices.contains(payment.getInvoiceId());
                %>
                <tr class="payment-row">
                    <td><%= payment.getInvoiceId() %></td>
                    <td><%= payment.getStudentId() != null ? payment.getStudentId() : "null" %></td>
                    <td><%= String.format("%.2f", payment.getAmount()) %></td>
                    <td><%= payment.getDueDate() %></td>
                    <td class="status-cell <%= status %>"><%= status.substring(0, 1).toUpperCase() + status.substring(1) %></td>
                    <td><%= payment.getPaymentDate() == null || payment.getPaymentDate().isEmpty() ? "N/A" : payment.getPaymentDate() %></td>
                    <td><%= isWaived ? "Yes" : "No" %></td>
                    <td><%= String.format("%.2f", payment.getLateFee()) %></td>
                    <td><%= payment.getPaymentMethod() %></td>
                    <td><%= payment.getSubscriptionPlan() %></td>
                    <td><%= payment.getStartDate() %></td>
                    <td class="space-x-2">

                        <button class="btn-futuristic bg-yellow-500 text-white" data-tooltip="Apply waiver for this payment" onclick="applyWaiver('<%= payment.getInvoiceId() %>')" <%= isWaived || !status.equals("pending") ? "disabled" : "" %>>
                            <i class="fas fa-hand-holding-usd mr-1"></i> Waiver
                        </button>


                    </td>
                </tr>
                <%
                    }
                    int totalPages = (int) Math.ceil((double) paymentRecords.size() / pageSize);
                    if (totalPages > 1) {
                %>
                <tr>
                    <td colspan="12">
                        <div class="pagination flex justify-center items-center space-x-4 mt-4">
                            <button onclick="window.location.href='student-dashboard.jsp?page=<%= currentPage - 1 %>#payment'" <%= currentPage == 1 ? "disabled" : "" %>>
                                <i class="fas fa-chevron-left mr-1"></i> Previous
                            </button>
                            <span>Page <%= currentPage %> of <%= totalPages %></span>
                            <button onclick="window.location.href='student-dashboard.jsp?page=<%= currentPage + 1 %>#payment'" <%= currentPage == totalPages ? "disabled" : "" %>>
                                Next <i class="fas fa-chevron-right ml-1"></i>
                            </button>
                        </div>
                    </td>
                </tr>
                <%
                        }
                    }
                %>
                </tbody>
            </table>
        </div>
    </section>

    <script>
        function updateSubscriptionAmount() {
            let select = document.getElementById("subscriptionPlan");
            let amountInput = document.getElementById("subscriptionAmount");
            let partialInput = document.getElementById("partialAmount");
            let remainingInput = document.getElementById("remainingAmount");
            let selectedOption = select.options[select.selectedIndex];
            let totalAmount = parseFloat(selectedOption.getAttribute("data-amount")) || 0;
            amountInput.value = totalAmount.toFixed(2);
            partialInput.value = ''; // Reset partial amount
            remainingInput.value = totalAmount.toFixed(2); // Initially, remaining amount is the total amount
            updateRemainingAmount(); // Ensure initial calculation
        }

        function updateRemainingAmount() {
            let totalInput = document.getElementById("subscriptionAmount");
            let partialInput = document.getElementById("partialAmount");
            let remainingInput = document.getElementById("remainingAmount");
            let totalAmount = parseFloat(totalInput.value) || 0;
            let partialAmount = parseFloat(partialInput.value) || 0;
            let remaining = Math.max(0, totalAmount - partialAmount);
            remainingInput.value = remaining.toFixed(2);
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

        function applyWaiver(invoiceId) {
            if (confirm(`Are you sure you want to apply a waiver for Invoice ID ${invoiceId} to cover the remaining amount?`)) {
                window.location.href = `student-dashboard.jsp?applyWaiverInvoiceId=${invoiceId}#payment`;
            }
        }

        function voidPayment(invoiceId) {
            if (confirm(`Are you sure you want to void the payment for Invoice ID ${invoiceId}? This action cannot be undone.`)) {
                window.location.href = `student-dashboard.jsp?voidInvoiceId=${invoiceId}#payment`;
            }
        }

        function markAsPaid(invoiceId) {
            if (confirm(`Are you sure you want to mark Invoice ID ${invoiceId} as paid?`)) {
                window.location.href = `student-dashboard.jsp?markAsPaidInvoiceId=${invoiceId}#payment`;
            }
        }

        function sortTable(columnIndex) {
            const table = document.querySelector('.payment-table');
            const rows = Array.from(table.querySelectorAll('.payment-row'));
            const isAscending = table.getAttribute('data-sort-order') !== 'asc';
            table.setAttribute('data-sort-order', isAscending ? 'asc' : 'desc');

            rows.sort((rowA, rowB) => {
                let valueA = rowA.cells[columnIndex].innerText.trim();
                let valueB = rowB.cells[columnIndex].innerText.trim();

                if (columnIndex === 2 || columnIndex === 7) {
                    valueA = parseFloat(valueA) || 0;
                    valueB = parseFloat(valueB) || 0;
                } else if (columnIndex === 3 || columnIndex === 5 || columnIndex === 10) {
                    valueA = valueA === 'N/A' ? 0 : new Date(valueA).getTime();
                    valueB = valueB === 'N/A' ? 0 : new Date(valueB).getTime();
                } else if (columnIndex === 6) {
                    valueA = valueA === 'Yes' ? 1 : 0;
                    valueB = valueB === 'Yes' ? 1 : 0;
                }

                return isAscending ? (valueA > valueB ? 1 : -1) : (valueA < valueB ? 1 : -1);
            });

            const tbody = document.getElementById('paymentTableBody');
            tbody.innerHTML = '';
            rows.forEach(row => tbody.appendChild(row));
        }

        function refreshPage() {
            const refreshBtn = document.getElementById('refreshBtn');
            const spinner = document.createElement('span');
            spinner.className = 'spinner';
            refreshBtn.innerHTML = '';
            refreshBtn.appendChild(spinner);
            refreshBtn.appendChild(document.createTextNode(' Refreshing...'));
            refreshBtn.disabled = true;
            setTimeout(() => {
                window.location.href = 'student-dashboard.jsp#payment';
            }, 1000);
        }

        function exportToCSV() {
            if (confirm('Are you sure you want to export payment history to CSV?')) {
                let csv = 'Invoice ID,Student ID,Amount,Due Date,Status,Payment Date,Waiver Applied,Late Fee,Payment Method,Subscription Plan,Start Date\n';
                Array.from(document.querySelectorAll('.payment-row')).forEach(row => {
                    let rowData = [];
                    for (let i = 0; i < 11; i++) {
                        let cell = row.cells[i].innerText.trim();
                        rowData.push(cell.includes(',') ? `"${cell}"` : cell);
                    }
                    csv += rowData.join(',') + '\n';
                });

                let blob = new Blob([csv], { type: 'text/csv' });
                let url = window.URL.createObjectURL(blob);
                let a = document.createElement('a');
                a.href = url;
                a.download = 'payment_history.csv';
                a.click();
                window.URL.revokeObjectURL(url);
            }
        }

        document.addEventListener('DOMContentLoaded', () => {
            const loadingMessage = document.getElementById('loadingMessage');
            if (loadingMessage) {
                loadingMessage.style.display = 'block';
                setTimeout(() => {
                    loadingMessage.classList.add('fade-out');
                    setTimeout(() => {
                        loadingMessage.style.display = 'none';
                    }, 500);
                }, 500);
            }
        });
    </script>
    </body>
    </html>

















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