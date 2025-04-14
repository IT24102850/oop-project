<%@ page import="java.util.*" %>
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
        }
    </style>
</head>
<body>
<!-- Sidebar Toggle Button -->
<button class="sidebar-toggle">
    <i class="fas fa-bars"></i>
</button>

<!-- Sidebar -->
<div class="sidebar">
    <div class="logo">NexoraSkill</div>

    <div class="user-profile">
        <div class="user-avatar">JD</div>
        <div class="user-info">
            <h3>John Doe</h3>
            <p>Computer Science</p>
        </div>
    </div>

    <ul class="nav-menu">
        <li class="nav-item">
            <a href="#" class="nav-link active" data-section="dashboard">
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
            <a href="#" class="nav-link" data-section="deadlines">
                <i class="fas fa-calendar-alt"></i> <span>Deadlines</span>
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
    <!-- Dashboard Section -->
    <section id="dashboard" class="content-section active">
        <div class="dashboard-header">
            <div class="greeting">
                <h1>Welcome back, John!</h1>
                <p>Your academic journey awaits</p>
            </div>

            <div class="user-actions">
                <div class="notification-bell">
                    <i class="fas fa-bell"></i>
                    <span class="notification-count">2</span>
                </div>
                <button class="btn btn-outline">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </button>
            </div>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <h3>Active Courses</h3>
                <p class="stat-value">5</p>
                <div class="stat-change positive">
                    <i class="fas fa-arrow-up"></i> 1 new
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
            <div class="course-card">
                <div class="course-header">
                    <div class="course-code">CS401</div>
                    <h3 class="course-title">Advanced Algorithms</h3>
                    <div class="course-instructor">Prof. Smith</div>
                </div>
                <div class="course-progress">
                    <div class="progress-text">
                        <span>Progress</span>
                        <span>65%</span>
                    </div>
                    <div class="progress-bar">
                        <div class="progress-fill" style="width: 65%"></div>
                    </div>
                </div>
                <div class="course-actions">
                    <button class="btn btn-outline">
                        <i class="fas fa-book"></i> Continue
                    </button>
                    <span class="status active">Active</span>
                </div>
            </div>

            <div class="course-card">
                <div class="course-header">
                    <div class="course-code">AI301</div>
                    <h3 class="course-title">Machine Learning</h3>
                    <div class="course-instructor">Dr. Johnson</div>
                </div>
                <div class="course-progress">
                    <div class="progress-text">
                        <span>Progress</span>
                        <span>82%</span>
                    </div>
                    <div class="progress-bar">
                        <div class="progress-fill" style="width: 82%"></div>
                    </div>
                </div>
                <div class="course-actions">
                    <button class="btn btn-outline">
                        <i class="fas fa-book"></i> Continue
                    </button>
                    <span class="status active">Active</span>
                </div>
            </div>

            <div class="course-card">
                <div class="course-header">
                    <div class="course-code">DB202</div>
                    <h3 class="course-title">Database Systems</h3>
                    <div class="course-instructor">Prof. Williams</div>
                </div>
                <div class="course-progress">
                    <div class="progress-text">
                        <span>Progress</span>
                        <span>45%</span>
                    </div>
                    <div class="progress-bar">
                        <div class="progress-fill" style="width: 45%"></div>
                    </div>
                </div>
                <div class="course-actions">
                    <button class="btn btn-outline">
                        <i class="fas fa-book"></i> Continue
                    </button>
                    <span class="status active">Active</span>
                </div>
            </div>
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
                        <h2>John Michael Doe</h2>
                        <div class="student-id-badge">
                            <i class="fas fa-id-card"></i> NS20230045
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
                                    <p>John Michael Doe</p>
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
                                    <p>john.doe@nexora.edu</p>
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
            <div class="course-card">
                <div class="course-header">
                    <div class="course-code">CS401</div>
                    <h3 class="course-title">Advanced Algorithms</h3>
                    <div class="course-instructor">Prof. Smith</div>
                </div>
                <div class="course-progress">
                    <div class="progress-text">
                        <span>Progress</span>
                        <span>65%</span>
                    </div>
                    <div class="progress-bar">
                        <div class="progress-fill" style="width: 65%"></div>
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

            <div class="course-card">
                <div class="course-header">
                    <div class="course-code">AI301</div>
                    <h3 class="course-title">Machine Learning</h3>
                    <div class="course-instructor">Dr. Johnson</div>
                </div>
                <div class="course-progress">
                    <div class="progress-text">
                        <span>Progress</span>
                        <span>82%</span>
                    </div>
                    <div class="progress-bar">
                        <div class="progress-fill" style="width: 82%"></div>
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
                    <input type="text" class="form-control" value="John Doe">
                </div>
                <div class="form-group">
                    <label>Email</label>
                    <input type="email" class="form-control" value="john.doe@nexora.edu">
                </div>
                <button class="btn btn-primary">
                    <i class="fas fa-save"></i> Save
                </button>
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
</script>
</body>
</html>