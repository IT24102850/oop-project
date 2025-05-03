<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<<<<<<< HEAD
=======
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
>>>>>>> fe20fe5a8563e26ff54b3649bcc50f18a47a489a
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NexoraSkill | Student Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="icon" type="image/png" href="./images/favicon.ico">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Orbitron:wght@400;500;600;700&display=swap" rel="stylesheet">
<<<<<<< HEAD
    <style>
        :root {
            --primary-color: #00f2fe;
            --secondary-color: #4facfe;
            --accent-color: #ff4d7e;
            --success-color: #4caf50;
            --warning-color: #ff9800;
            --dark-color: #0a0f24;
            --darker-color: #050916;
            --text-color: #ffffff;
            --text-muted: rgba(255,255,255,0.7);
            --card-bg: rgba(15, 23, 42, 0.9);
            --glass-bg: rgba(255, 255, 255, 0.08);
            --border-radius: 20px;
            --box-shadow: 0 15px 50px rgba(0, 0, 0, 0.5);
            --transition: all 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, var(--darker-color), var(--dark-color));
            color: var(--text-color);
            min-height: 100vh;
            display: flex;
            overflow-x: hidden;
        }

        /* Sidebar */
        .sidebar {
            width: 300px;
            background: linear-gradient(to bottom, var(--card-bg), rgba(15, 23, 42, 0.95));
            padding: 30px;
            position: fixed;
            height: 100vh;
            overflow-y: auto;
            z-index: 1000;
            box-shadow: 5px 0 30px rgba(0, 0, 0, 0.3);
            transition: transform 0.5s ease-in-out;
        }

        .sidebar.hidden {
            transform: translateX(-100%);
        }

        .logo {
            font-family: 'Orbitron', sans-serif;
            font-size: 2rem;
            margin-bottom: 50px;
            background: linear-gradient(45deg, var(--primary-color), var(--accent-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-align: center;
            position: relative;
        }

        .logo::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 50px;
            height: 2px;
            background: var(--primary-color);
            border-radius: 2px;
        }

        .user-profile {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-bottom: 40px;
            padding: 20px;
            background: var(--glass-bg);
            border-radius: var(--border-radius);
            transition: var(--transition);
        }

        .user-profile:hover {
            transform: scale(1.05);
        }

        .user-avatar {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            font-weight: bold;
            position: relative;
            overflow: hidden;
        }

        .user-avatar::before {
            content: '';
            position: absolute;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.2), transparent);
            animation: rotateGlow 8s linear infinite;
        }

        @keyframes rotateGlow {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .user-info h3 {
            font-size: 1.2rem;
            margin-bottom: 8px;
        }

        .user-info p {
            font-size: 0.9rem;
            color: var(--text-muted);
        }

        .nav-menu {
            list-style: none;
        }

        .nav-item {
            margin-bottom: 20px;
        }

        .nav-link {
            display: flex;
            align-items: center;
            gap: 20px;
            padding: 18px;
            border-radius: var(--border-radius);
            color: var(--text-color);
            text-decoration: none;
            transition: var(--transition);
            position: relative;
            overflow: hidden;
        }

        .nav-link::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(0,242,254,0.2), transparent);
            transition: left 0.7s ease;
        }

        .nav-link:hover::before {
            left: 100%;
        }

        .nav-link:hover {
            background: var(--glass-bg);
            transform: translateX(15px);
        }

        .nav-link.active {
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            border-left: 5px solid var(--accent-color);
            box-shadow: 0 0 20px rgba(0,242,254,0.3);
        }

        .badge {
            background: var(--accent-color);
            color: white;
            border-radius: 50%;
            width: 24px;
            height: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.8rem;
            margin-left: auto;
            animation: pulseBadge 2s infinite;
        }

        @keyframes pulseBadge {
            0% { transform: scale(1); }
            50% { transform: scale(1.2); }
            100% { transform: scale(1); }
        }

        /* Main Content */
        .main-content {
            margin-left: 300px;
            flex: 1;
            padding: 50px;
            position: relative;
            transition: margin-left 0.5s ease-in-out;
        }

        .main-content.full-width {
            margin-left: 0;
        }

        .content-section {
            display: none;
            animation: fadeIn 0.5s ease-in-out;
        }

        .content-section.active {
            display: block;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 50px;
            padding: 20px;
            background: var(--glass-bg);
            border-radius: var(--border-radius);
            backdrop-filter: blur(10px);
        }

        .greeting h1 {
            font-size: 2.5rem;
            margin-bottom: 12px;
            background: linear-gradient(45deg, var(--primary-color), var(--accent-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .greeting p {
            color: var(--text-muted);
            font-size: 1.1rem;
        }

        .user-actions {
            display: flex;
            gap: 20px;
            align-items: center;
        }

        .notification-bell {
            position: relative;
            font-size: 1.5rem;
            cursor: pointer;
            transition: var(--transition);
        }

        .notification-bell:hover {
            color: var(--primary-color);
            transform: rotate(15deg);
        }

        .notification-count {
            position: absolute;
            top: -8px;
            right: -8px;
            background: var(--accent-color);
            color: white;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.8rem;
            animation: pulseBadge 2s infinite;
        }

        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 30px;
            margin-bottom: 50px;
        }

        .stat-card {
            background: var(--card-bg);
            padding: 30px;
            border-radius: var(--border-radius);
            border: 1px solid rgba(0, 242, 254, 0.3);
            transition: var(--transition);
            position: relative;
            overflow: hidden;
            backdrop-filter: blur(5px);
        }

        .stat-card:hover {
            transform: translateY(-10px) rotate(2deg);
            box-shadow: var(--box-shadow);
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 6px;
            height: 100%;
            background: linear-gradient(to bottom, var(--primary-color), var(--accent-color));
        }

        .stat-card h3 {
            font-size: 1.1rem;
            color: var(--text-muted);
            margin-bottom: 12px;
        }

        .stat-value {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 20px;
            background: linear-gradient(45deg, var(--primary-color), var(--secondary-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .stat-change {
            display: flex;
            align-items: center;
            font-size: 1rem;
            gap: 8px;
        }

        .stat-change.positive {
            color: var(--success-color);
        }

        .stat-change.negative {
            color: var(--accent-color);
        }

        /* Courses Section */
        .courses-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 30px;
            margin-bottom: 50px;
        }

        .course-card {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            overflow: hidden;
            transition: var(--transition);
            border: 1px solid rgba(0, 242, 254, 0.3);
            position: relative;
            backdrop-filter: blur(5px);
        }

        .course-card:hover {
            transform: translateY(-10px) scale(1.02);
            box-shadow: var(--box-shadow);
        }

        .course-header {
            padding: 25px;
            border-bottom: 1px solid rgba(0, 242, 254, 0.1);
            position: relative;
            background: linear-gradient(135deg, rgba(0,242,254,0.1), transparent);
        }

        .course-code {
            font-family: 'Orbitron', sans-serif;
            font-size: 1rem;
            color: var(--primary-color);
            margin-bottom: 8px;
        }

        .course-title {
            font-size: 1.4rem;
            margin-bottom: 12px;
        }

        .course-instructor {
            font-size: 1rem;
            color: var(--text-muted);
        }

        .course-progress {
            padding: 25px;
        }

        .progress-text {
            display: flex;
            justify-content: space-between;
            margin-bottom: 12px;
            font-size: 1rem;
        }

        .progress-bar {
            height: 10px;
            background: var(--glass-bg);
            border-radius: 5px;
            overflow: hidden;
        }

        .progress-fill {
            height: 100%;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            border-radius: 5px;
            transition: width 1s ease-in-out;
        }

        .course-actions {
            padding: 20px 25px;
            border-top: 1px solid rgba(0, 242, 254, 0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        /* Upcoming Deadlines */
        .deadlines-container {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            padding: 30px;
            margin-bottom: 50px;
            backdrop-filter: blur(10px);
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .section-header h2 {
            font-size: 1.8rem;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .deadline-item {
            display: flex;
            align-items: center;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 15px;
            background: var(--glass-bg);
            transition: var(--transition);
        }

        .deadline-item:hover {
            transform: translateX(10px);
            background: rgba(0,242,254,0.05);
        }

        .deadline-icon {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: rgba(255, 77, 126, 0.3);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 20px;
            color: var(--accent-color);
            font-size: 1.2rem;
        }

        .deadline-info {
            flex: 1;
        }

        .deadline-title {
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 1.1rem;
        }

        .deadline-course {
            font-size: 0.9rem;
            color: var(--text-muted);
        }

        .deadline-time {
            font-size: 1rem;
            color: var(--accent-color);
        }

        /* Profile Section */
        .profile-container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .profile-card {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            padding: 40px;
            box-shadow: var(--box-shadow);
            backdrop-filter: blur(10px);
        }

        .profile-header {
            display: flex;
            align-items: flex-start;
            gap: 40px;
            margin-bottom: 40px;
            padding-bottom: 40px;
            border-bottom: 1px solid rgba(0, 242, 254, 0.1);
        }

        .user-avatar-holographic {
            position: relative;
            width: 200px;
            height: 200px;
            border-radius: 50%;
            overflow: hidden;
            border: 4px solid var(--primary-color);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .hologram-effect {
            position: absolute;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg,
            rgba(0, 242, 254, 0.3) 0%,
            rgba(79, 172, 254, 0.3) 50%,
            rgba(255, 77, 126, 0.3) 100%);
            border-radius: 50%;
            animation: hologramPulse 5s infinite alternate;
        }

        @keyframes hologramPulse {
            0% { opacity: 0.4; }
            100% { opacity: 0.8; }
        }

        .avatar-image {
            width: 95%;
            height: 95%;
            border-radius: 50%;
            object-fit: cover;
            position: relative;
            z-index: 1;
        }

        .avatar-actions {
            position: absolute;
            bottom: -30px;
            left: 0;
            right: 0;
            display: flex;
            justify-content: center;
            gap: 15px;
            z-index: 2;
        }

        .profile-info h2 {
            font-size: 2.5rem;
            margin-bottom: 15px;
            background: linear-gradient(45deg, var(--primary-color), var(--accent-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .student-id-badge {
            display: inline-block;
            background: rgba(0, 242, 254, 0.15);
            padding: 8px 20px;
            border-radius: 25px;
            font-family: 'Orbitron', sans-serif;
            margin-bottom: 20px;
            font-size: 1rem;
        }

        .verification-status {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 25px;
        }

        .verification-status .verified {
            color: var(--success-color);
            font-size: 1.2rem;
        }

        .academic-level {
            margin-top: 25px;
        }

        .level-progress {
            height: 10px;
            background: var(--glass-bg);
            border-radius: 5px;
            margin-bottom: 8px;
        }

        .level-progress .progress-fill {
            height: 100%;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            border-radius: 5px;
        }

        /* Profile Tabs */
        .profile-tabs {
            display: flex;
            border-bottom: 1px solid rgba(0, 242, 254, 0.1);
            margin-bottom: 30px;
            overflow-x: auto;
        }

        .profile-tabs .tab {
            padding: 15px 30px;
            cursor: pointer;
            position: relative;
            font-weight: 600;
            color: var(--text-muted);
            transition: var(--transition);
        }

        .profile-tabs .tab.active {
            color: var(--primary-color);
        }

        .profile-tabs .tab.active::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
        }

        .profile-tabs .tab:hover {
            color: var(--primary-color);
        }

        /* Detail Grid */
        .detail-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 30px;
            margin-bottom: 40px;
        }

        .detail-card {
            background: rgba(15, 23, 42, 0.8);
            border-radius: var(--border-radius);
            padding: 25px;
            border: 1px solid rgba(0, 242, 254, 0.15);
            transition: var(--transition);
        }

        .detail-card:hover {
            transform: translateY(-5px);
        }

        .detail-card h3 {
            font-size: 1.2rem;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 1px solid rgba(0, 242, 254, 0.1);
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .detail-item {
            margin-bottom: 20px;
            padding: 12px;
            background: var(--glass-bg);
            border-radius: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: var(--transition);
        }

        .detail-item:hover {
            background: rgba(0,242,254,0.05);
        }

        .detail-item label {
            font-weight: 500;
            color: var(--primary-color);
            margin-right: 15px;
            min-width: 130px;
        }

        .detail-item p {
            flex: 1;
            font-size: 0.95rem;
        }

        .btn-edit {
            background: none;
            border: none;
            color: var(--text-muted);
            cursor: pointer;
            font-size: 1rem;
            transition: var(--transition);
        }

        .btn-edit:hover {
            color: var(--primary-color);
            transform: scale(1.2);
        }

        /* Enrollment Section */
        .enrollment-section {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            padding: 30px;
            margin-bottom: 30px;
        }

        .enrollment-form {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: var(--text-muted);
        }

        .form-group input[type="text"] {
            width: 100%;
            padding: 12px;
            background: var(--glass-bg);
            border: 1px solid rgba(0, 242, 254, 0.3);
            border-radius: var(--border-radius);
            color: var(--text-color);
        }

        /* Buttons */
        .btn {
            padding: 12px 25px;
            border-radius: var(--border-radius);
            border: none;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 10px;
            font-weight: 600;
            position: relative;
            overflow: hidden;
        }

        .btn::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background: rgba(255,255,255,0.2);
            border-radius: 50%;
            transform: translate(-50%, -50%);
            transition: width 0.6s ease, height 0.6s ease;
        }

        .btn:hover::after {
            width: 300px;
            height: 300px;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: var(--dark-color);
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0, 242, 254, 0.4);
        }

        .btn-outline {
            background: transparent;
            border: 2px solid var(--primary-color);
            color: var(--primary-color);
        }

        .btn-outline:hover {
            background: rgba(0, 242, 254, 0.15);
            color: var(--text-color);
        }

        .btn-danger {
            background: linear-gradient(135deg, var(--accent-color), #ff2d5a);
            color: white;
        }

        .btn-danger:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(255, 77, 126, 0.4);
        }

        /* Status Badges */
        .status {
            display: inline-block;
            padding: 8px 15px;
            border-radius: 25px;
            font-size: 0.9rem;
            font-weight: 500;
        }

        .status.active {
            background: rgba(76, 175, 360, 0.3);
            color: var(--success-color);
        }

        .status.pending {
            background: rgba(255, 152, 0, 0.3);
            color: var(--warning-color);
        }

        .status.overdue {
            background: rgba(255, 77, 126, 0.3);
            color: var(--accent-color);
        }

        /* Messages */
        .message {
            padding: 15px;
            border-radius: var(--border-radius);
            margin-bottom: 30px;
            text-align: center;
        }

        .message.error {
            background: rgba(255, 0, 0, 0.1);
            color: #ff0000;
            border: 1px solid rgba(255, 0, 0, 0.3);
        }

        .message.success {
            background: rgba(0, 255, 0, 0.1);
            color: #00ff00;
            border: 1px solid rgba(0, 255, 0, 0.3);
        }

        /* Settings Section */
        .settings-container {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            padding: 30px;
            margin-bottom: 30px;
        }

        .settings-form {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .settings-form .form-group {
            margin-bottom: 20px;
        }

        .settings-form .form-group label {
            display: block;
            margin-bottom: 8px;
            color: var(--text-muted);
        }

        .settings-form .form-group input {
            width: 100%;
            padding: 12px;
            background: var(--glass-bg);
            border: 1px solid rgba(0, 242, 254, 0.3);
            border-radius: var(--border-radius);
            color: var(--text-color);
        }

        /* Sidebar Toggle */
        .sidebar-toggle {
            position: fixed;
            top: 20px;
            left: 20px;
            z-index: 1001;
            background: var(--primary-color);
            color: var(--dark-color);
            border: none;
            padding: 12px;
            border-radius: 12px;
            cursor: pointer;
            display: none;
            transition: var(--transition);
        }

        .sidebar-toggle:hover {
            transform: rotate(90deg);
        }

        /* Responsive */
        @media (max-width: 1200px) {
            .sidebar {
                width: 90px;
                padding: 20px 15px;
            }

            .logo, .user-info, .nav-link span {
                display: none;
            }

            .nav-link {
                justify-content: center;
                padding: 15px;
            }

            .main-content {
                margin-left: 90px;
            }

            .badge {
                margin-left: 0;
            }
        }

        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
            }

            .sidebar.active {
                transform: translateX(0);
            }

            .main-content {
                margin-left: 0;
            }

            .main-content.full-width {
                margin-left: 0;
            }

            .sidebar-toggle {
                display: block;
            }

            .stats-grid, .courses-container {
                grid-template-columns: 1fr;
            }

            .dashboard-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 20px;
            }

            .enrollment-form, .settings-form {
                grid-template-columns: 1fr;
            }
        }
    </style>
=======
    <link rel="stylesheet" href="styles.css">
>>>>>>> fe20fe5a8563e26ff54b3649bcc50f18a47a489a
</head>
<body>
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
<<<<<<< HEAD
=======
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
>>>>>>> fe20fe5a8563e26ff54b3649bcc50f18a47a489a
        }
    }

<<<<<<< HEAD
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

    // Hardcoded progress for demonstration
    Map<String, String> courseProgress = new HashMap<>();
    courseProgress.put("CS401", "65%");
    courseProgress.put("AI301", "82%");
    courseProgress.put("DB202", "45%");
%>

=======
>>>>>>> fe20fe5a8563e26ff54b3649bcc50f18a47a489a
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
        <li class="nav-item">
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
            <a href="#" class="nav-link active" data-section="payment">
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
<<<<<<< HEAD
    <% if (request.getAttribute("message") != null) { %>
    <div class="message success"><%= request.getAttribute("message") %></div>
=======
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
>>>>>>> fe20fe5a8563e26ff54b3649bcc50f18a47a489a
    <% } %>

    <!-- Dashboard Section -->
    <section id="dashboard" class="content-section">
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
<<<<<<< HEAD
                <form action="auth" method="post" style="display: inline;">
                    <input type="hidden" name="action" value="logout">
                    <button type="submit" class="btn btn-outline">
=======
                <form action="auth" method="post">
                    <input type="hidden" name="action" value="logout">
                    <button type="submit" class="btn btn-outline
>>>>>>> fe20fe5a8563e26ff54b3649bcc50f18a47a489a
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
    <section id="payment" class="content-section active">
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
