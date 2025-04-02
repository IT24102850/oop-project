<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NexoraSkill | Student Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
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
            background: var(--darker-color);
            color: var(--text-color);
            min-height: 100vh;
            display: flex;
        }

        /* Sidebar */
        .sidebar {
            width: 280px;
            background: var(--card-bg);
            padding: 25px;
            border-right: 1px solid rgba(0, 242, 254, 0.1);
            position: fixed;
            height: 100vh;
            overflow-y: auto;
            z-index: 10;
        }

        .logo {
            font-family: 'Orbitron', sans-serif;
            font-size: 1.8rem;
            margin-bottom: 40px;
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .user-profile {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid rgba(0, 242, 254, 0.1);
        }

        .user-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }

        .user-info h3 {
            font-size: 1.1rem;
            margin-bottom: 5px;
        }

        .user-info p {
            font-size: 0.8rem;
            color: var(--text-muted);
        }

        .nav-menu {
            list-style: none;
        }

        .nav-item {
            margin-bottom: 15px;
        }

        .nav-link {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 15px;
            border-radius: var(--border-radius);
            color: var(--text-color);
            text-decoration: none;
            transition: var(--transition);
        }

        .nav-link:hover {
            background: var(--glass-bg);
            transform: translateX(10px);
        }

        .nav-link.active {
            background: linear-gradient(90deg, var(--primary-color), transparent);
            border-left: 4px solid var(--primary-color);
        }

        .badge {
            background: var(--accent-color);
            color: white;
            border-radius: 20px;
            padding: 3px 8px;
            font-size: 0.7rem;
            margin-left: auto;
        }

        /* Main Content */
        .main-content {
            margin-left: 280px;
            flex: 1;
            padding: 40px;
        }

        .content-section {
            display: none;
        }

        .content-section.active {
            display: block;
        }

        .dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
        }

        .greeting h1 {
            font-size: 2rem;
            margin-bottom: 10px;
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .greeting p {
            color: var(--text-muted);
        }

        .user-actions {
            display: flex;
            gap: 15px;
            align-items: center;
        }

        .notification-bell {
            position: relative;
            font-size: 1.2rem;
            cursor: pointer;
        }

        .notification-count {
            position: absolute;
            top: -5px;
            right: -5px;
            background: var(--accent-color);
            color: white;
            border-radius: 50%;
            width: 18px;
            height: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.7rem;
        }

        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

        .stat-card {
            background: var(--card-bg);
            padding: 25px;
            border-radius: var(--border-radius);
            border: 1px solid rgba(0, 242, 254, 0.2);
            transition: var(--transition);
            position: relative;
            overflow: hidden;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--box-shadow);
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            background: linear-gradient(to bottom, var(--primary-color), var(--secondary-color));
        }

        .stat-card h3 {
            font-size: 1rem;
            color: var(--text-muted);
            margin-bottom: 10px;
        }

        .stat-value {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 15px;
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .stat-change {
            display: flex;
            align-items: center;
            font-size: 0.9rem;
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
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

        .course-card {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            overflow: hidden;
            transition: var(--transition);
            border: 1px solid rgba(0, 242, 254, 0.2);
        }

        .course-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--box-shadow);
        }

        .course-header {
            padding: 20px;
            border-bottom: 1px solid rgba(0, 242, 254, 0.1);
            position: relative;
        }

        .course-code {
            font-family: 'Orbitron', sans-serif;
            font-size: 0.9rem;
            color: var(--primary-color);
            margin-bottom: 5px;
        }

        .course-title {
            font-size: 1.2rem;
            margin-bottom: 10px;
        }

        .course-instructor {
            font-size: 0.9rem;
            color: var(--text-muted);
        }

        .course-progress {
            padding: 20px;
        }

        .progress-text {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            font-size: 0.9rem;
        }

        .progress-bar {
            height: 8px;
            background: var(--glass-bg);
            border-radius: 4px;
            overflow: hidden;
        }

        .progress-fill {
            height: 100%;
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            border-radius: 4px;
            width: 65%;
        }

        .course-actions {
            padding: 15px 20px;
            border-top: 1px solid rgba(0, 242, 254, 0.1);
            display: flex;
            justify-content: space-between;
        }

        /* Upcoming Deadlines */
        .deadlines-container {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            padding: 25px;
            margin-bottom: 40px;
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .section-header h2 {
            font-size: 1.5rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .deadline-item {
            display: flex;
            align-items: center;
            padding: 15px 0;
            border-bottom: 1px solid rgba(0, 242, 254, 0.1);
        }

        .deadline-item:last-child {
            border-bottom: none;
        }

        .deadline-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: rgba(255, 77, 126, 0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            color: var(--accent-color);
        }

        .deadline-info {
            flex: 1;
        }

        .deadline-title {
            font-weight: 500;
            margin-bottom: 5px;
        }

        .deadline-course {
            font-size: 0.8rem;
            color: var(--text-muted);
        }

        .deadline-time {
            font-size: 0.9rem;
            color: var(--accent-color);
        }

        /* Grades Table */
        .grades-table {
            width: 100%;
            background: var(--card-bg);
            border-radius: var(--border-radius);
            border-collapse: collapse;
            overflow: hidden;
            margin-bottom: 40px;
        }

        .grades-table th, .grades-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid rgba(0, 242, 254, 0.1);
        }

        .grades-table th {
            background: var(--glass-bg);
            font-family: 'Orbitron', sans-serif;
            letter-spacing: 1px;
        }

        .grade {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px;
            font-weight: 500;
        }

        .grade.a {
            background: rgba(76, 175, 80, 0.2);
            color: var(--success-color);
        }

        .grade.b {
            background: rgba(139, 195, 74, 0.2);
            color: #8bc34a;
        }

        .grade.c {
            background: rgba(255, 193, 7, 0.2);
            color: var(--warning-color);
        }

        /* Resources Section */
        .resources-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

        .resource-card {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            padding: 20px;
            border: 1px solid rgba(0, 242, 254, 0.2);
            transition: var(--transition);
        }

        .resource-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--box-shadow);
        }

        .resource-icon {
            font-size: 2rem;
            margin-bottom: 15px;
            color: var(--primary-color);
        }

        .resource-title {
            font-size: 1.1rem;
            margin-bottom: 10px;
        }

        .resource-description {
            font-size: 0.9rem;
            color: var(--text-muted);
            margin-bottom: 15px;
        }

        /* Messages Section */
        .messages-container {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            padding: 25px;
            margin-bottom: 40px;
        }

        .message-item {
            display: flex;
            padding: 15px 0;
            border-bottom: 1px solid rgba(0, 242, 254, 0.1);
            cursor: pointer;
        }

        .message-item.unread {
            background: rgba(0, 242, 254, 0.05);
        }

        .message-item:last-child {
            border-bottom: none;
        }

        .message-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: var(--glass-bg);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            flex-shrink: 0;
        }

        .message-content {
            flex: 1;
        }

        .message-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 5px;
        }

        .message-sender {
            font-weight: 500;
        }

        .message-time {
            font-size: 0.8rem;
            color: var(--text-muted);
        }

        .message-preview {
            font-size: 0.9rem;
            color: var(--text-muted);
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        /* Settings Section */
        .settings-container {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            padding: 25px;
            margin-bottom: 40px;
        }

        .settings-tabs {
            display: flex;
            border-bottom: 1px solid rgba(0, 242, 254, 0.1);
            margin-bottom: 20px;
        }

        .settings-tab {
            padding: 10px 20px;
            cursor: pointer;
            border-bottom: 2px solid transparent;
            transition: var(--transition);
        }

        .settings-tab.active {
            border-bottom: 2px solid var(--primary-color);
            color: var(--primary-color);
        }

        .settings-tab:hover {
            color: var(--primary-color);
        }

        .settings-form {
            max-width: 600px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
        }

        .form-control {
            width: 100%;
            padding: 12px;
            background: var(--glass-bg);
            border: 1px solid rgba(0, 242, 254, 0.3);
            border-radius: var(--border-radius);
            color: var(--text-color);
        }

        /* Buttons */
        .btn {
            padding: 10px 20px;
            border-radius: var(--border-radius);
            border: none;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 8px;
            font-weight: 500;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: var(--dark-color);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 242, 254, 0.3);
        }

        .btn-outline {
            background: transparent;
            border: 1px solid var(--primary-color);
            color: var(--primary-color);
        }

        .btn-outline:hover {
            background: rgba(0, 242, 254, 0.1);
        }

        /* Status Badges */
        .status {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
        }

        .status.active {
            background: rgba(76, 175, 80, 0.2);
            color: var(--success-color);
        }

        .status.pending {
            background: rgba(255, 152, 0, 0.2);
            color: var(--warning-color);
        }

        .status.overdue {
            background: rgba(255, 77, 126, 0.2);
            color: var(--accent-color);
        }

        /* Responsive */
        @media (max-width: 992px) {
            .sidebar {
                width: 80px;
                padding: 20px 10px;
                overflow-x: hidden;
            }

            .logo, .user-info, .nav-link span {
                display: none;
            }

            .nav-link {
                justify-content: center;
                padding: 15px 5px;
            }

            .main-content {
                margin-left: 80px;
                padding: 20px;
            }
        }

        @media (max-width: 768px) {
            .stats-grid {
                grid-template-columns: 1fr;
            }

            .courses-container {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
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
            <a href="#" class="nav-link" data-section="courses">
                <i class="fas fa-book-open"></i> <span>My Courses</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="#" class="nav-link" data-section="grades">
                <i class="fas fa-chart-bar"></i> <span>Grades</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="#" class="nav-link" data-section="resources">
                <i class="fas fa-folder-open"></i> <span>Resources</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="#" class="nav-link" data-section="messages">
                <i class="fas fa-envelope"></i> <span>Messages</span>
                <span class="badge">3</span>
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
                <p>Here's what's happening with your courses today</p>
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
                    <i class="fas fa-arrow-up"></i> 1 new this semester
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
                    <i class="fas fa-arrow-up"></i> 5% from last week
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
                        <span>Course Progress</span>
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
                        <span>Course Progress</span>
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
                        <span>Course Progress</span>
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

        <div class="deadlines-container">
            <div class="section-header">
                <h2><i class="fas fa-calendar-alt"></i> Upcoming Deadlines</h2>
                <button class="btn btn-outline">
                    <i class="fas fa-plus"></i> Add Reminder
                </button>
            </div>

            <div class="deadline-item">
                <div class="deadline-icon">
                    <i class="fas fa-file-alt"></i>
                </div>
                <div class="deadline-info">
                    <div class="deadline-title">Final Project Submission</div>
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
                    <div class="deadline-title">ML Model Implementation</div>
                    <div class="deadline-course">Machine Learning</div>
                </div>
                <div class="deadline-time">
                    <span class="status pending">Due in 2 days</span>
                </div>
            </div>

            <div class="deadline-item">
                <div class="deadline-icon">
                    <i class="fas fa-database"></i>
                </div>
                <div class="deadline-info">
                    <div class="deadline-title">SQL Query Optimization</div>
                    <div class="deadline-course">Database Systems</div>
                </div>
                <div class="deadline-time">
                    <span class="status pending">Due in 1 week</span>
                </div>
            </div>
        </div>
    </section>

    <!-- My Courses Section -->
    <section id="courses" class="content-section">
        <div class="dashboard-header">
            <div class="greeting">
                <h1>My Courses</h1>
                <p>All your enrolled courses in one place</p>
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
                        <span>Course Progress</span>
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
                        <span>Course Progress</span>
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

            <div class="course-card">
                <div class="course-header">
                    <div class="course-code">DB202</div>
                    <h3 class="course-title">Database Systems</h3>
                    <div class="course-instructor">Prof. Williams</div>
                </div>
                <div class="course-progress">
                    <div class="progress-text">
                        <span>Course Progress</span>
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
                    <button class="btn btn-outline">
                        <i class="fas fa-info-circle"></i> Details
                    </button>
                </div>
            </div>

            <div class="course-card">
                <div class="course-header">
                    <div class="course-code">SE501</div>
                    <h3 class="course-title">Software Engineering</h3>
                    <div class="course-instructor">Prof. Brown</div>
                </div>
                <div class="course-progress">
                    <div class="progress-text">
                        <span>Course Progress</span>
                        <span>30%</span>
                    </div>
                    <div class="progress-bar">
                        <div class="progress-fill" style="width: 30%"></div>
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
                    <div class="course-code">NW301</div>
                    <h3 class="course-title">Computer Networks</h3>
                    <div class="course-instructor">Prof. Davis</div>
                </div>
                <div class="course-progress">
                    <div class="progress-text">
                        <span>Course Progress</span>
                        <span>90%</span>
                    </div>
                    <div class="progress-bar">
                        <div class="progress-fill" style="width: 90%"></div>
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

    <!-- Grades Section -->
    <section id="grades" class="content-section">
        <div class="dashboard-header">
            <div class="greeting">
                <h1>My Grades</h1>
                <p>Track your academic performance</p>
            </div>
        </div>

        <table class="grades-table">
            <thead>
            <tr>
                <th>Course</th>
                <th>Assignment</th>
                <th>Due Date</th>
                <th>Status</th>
                <th>Grade</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>Advanced Algorithms</td>
                <td>Sorting Algorithms</td>
                <td>15 Mar 2023</td>
                <td><span class="status active">Graded</span></td>
                <td><span class="grade a">A</span></td>
            </tr>
            <tr>
                <td>Machine Learning</td>
                <td>Linear Regression</td>
                <td>22 Mar 2023</td>
                <td><span class="status active">Graded</span></td>
                <td><span class="grade b">B+</span></td>
            </tr>
            <tr>
                <td>Database Systems</td>
                <td>SQL Queries</td>
                <td>28 Mar 2023</td>
                <td><span class="status active">Graded</span></td>
                <td><span class="grade a">A-</span></td>
            </tr>
            <tr>
                <td>Software Engineering</td>
                <td>Project Proposal</td>
                <td>5 Apr 2023</td>
                <td><span class="status pending">Pending</span></td>
                <td>-</td>
            </tr>
            <tr>
                <td>Computer Networks</td>
                <td>TCP/IP Protocol</td>
                <td>12 Apr 2023</td>
                <td><span class="status pending">Pending</span></td>
                <td>-</td>
            </tr>
            </tbody>
        </table>
    </section>

    <!-- Resources Section -->
    <section id="resources" class="content-section">
        <div class="dashboard-header">
            <div class="greeting">
                <h1>Learning Resources</h1>
                <p>Access additional materials to boost your learning</p>
            </div>
        </div>

        <div class="resources-grid">
            <div class="resource-card">
                <div class="resource-icon">
                    <i class="fas fa-book"></i>
                </div>
                <h3 class="resource-title">E-Books Library</h3>
                <p class="resource-description">Access thousands of e-books related to your courses and beyond.</p>
                <button class="btn btn-primary">
                    <i class="fas fa-external-link-alt"></i> Open Library
                </button>
            </div>

            <div class="resource-card">
                <div class="resource-icon">
                    <i class="fas fa-video"></i>
                </div>
                <h3 class="resource-title">Video Tutorials</h3>
                <p class="resource-description">Comprehensive video tutorials covering all course topics.</p>
                <button class="btn btn-primary">
                    <i class="fas fa-external-link-alt"></i> Watch Videos
                </button>
            </div>

            <div class="resource-card">
                <div class="resource-icon">
                    <i class="fas fa-code"></i>
                </div>
                <h3 class="resource-title">Code Repository</h3>
                <p class="resource-description">Sample code and projects for practical learning.</p>
                <button class="btn btn-primary">
                    <i class="fas fa-external-link-alt"></i> View Repository
                </button>
            </div>

            <div class="resource-card">
                <div class="resource-icon">
                    <i class="fas fa-chalkboard-teacher"></i>
                </div>
                <h3 class="resource-title">Tutor Sessions</h3>
                <p class="resource-description">Schedule one-on-one sessions with course tutors.</p>
                <button class="btn btn-primary">
                    <i class="fas fa-external-link-alt"></i> Book Session
                </button>
            </div>

            <div class="resource-card">
                <div class="resource-icon">
                    <i class="fas fa-question-circle"></i>
                </div>
                <h3 class="resource-title">Q&A Forum</h3>
                <p class="resource-description">Get answers to your questions from instructors and peers.</p>
                <button class="btn btn-primary">
                    <i class="fas fa-external-link-alt"></i> Visit Forum
                </button>
            </div>

            <div class="resource-card">
                <div class="resource-icon">
                    <i class="fas fa-file-pdf"></i>
                </div>
                <h3 class="resource-title">Lecture Slides</h3>
                <p class="resource-description">Download all course lecture slides in PDF format.</p>
                <button class="btn btn-primary">
                    <i class="fas fa-external-link-alt"></i> Download
                </button>
            </div>
        </div>
    </section>

    <!-- Messages Section -->
    <section id="messages" class="content-section">
        <div class="dashboard-header">
            <div class="greeting">
                <h1>Messages</h1>
                <p>Communicate with instructors and classmates</p>
            </div>
            <button class="btn btn-primary">
                <i class="fas fa-plus"></i> New Message
            </button>
        </div>

        <div class="messages-container">
            <div class="message-item unread">
                <div class="message-avatar">
                    <i class="fas fa-user-tie"></i>
                </div>
                <div class="message-content">
                    <div class="message-header">
                        <span class="message-sender">Prof. Smith</span>
                        <span class="message-time">Today, 10:30 AM</span>
                    </div>
                    <p class="message-preview">Regarding your submission for the Algorithms assignment, I noticed some issues with the complexity analysis that we should discuss...</p>
                </div>
            </div>

            <div class="message-item unread">
                <div class="message-avatar">
                    <i class="fas fa-user-graduate"></i>
                </div>
                <div class="message-content">
                    <div class="message-header">
                        <span class="message-sender">Study Group</span>
                        <span class="message-time">Yesterday, 8:45 PM</span>
                    </div>
                    <p class="message-preview">Hey everyone! Just a reminder that we're meeting tomorrow in the library at 2pm to work on the ML project...</p>
                </div>
            </div>

            <div class="message-item">
                <div class="message-avatar">
                    <i class="fas fa-user-tie"></i>
                </div>
                <div class="message-content">
                    <div class="message-header">
                        <span class="message-sender">Dr. Johnson</span>
                        <span class="message-time">Mar 28, 2023</span>
                    </div>
                    <p class="message-preview">Your midterm exam results are now available in the grades section. Overall good performance, but let's work on...</p>
                </div>
            </div>

            <div class="message-item">
                <div class="message-avatar">
                    <i class="fas fa-university"></i>
                </div>
                <div class="message-content">
                    <div class="message-header">
                        <span class="message-sender">NexoraSkill Admin</span>
                        <span class="message-time">Mar 25, 2023</span>
                    </div>
                    <p class="message-preview">Important announcement about upcoming maintenance this weekend. The platform will be unavailable from...</p>
                </div>
            </div>

            <div class="message-item">
                <div class="message-avatar">
                    <i class="fas fa-user-tie"></i>
                </div>
                <div class="message-content">
                    <div class="message-header">
                        <span class="message-sender">Prof. Williams</span>
                        <span class="message-time">Mar 20, 2023</span>
                    </div>
                    <p class="message-preview">I've posted additional practice problems for the upcoming quiz on database normalization. These are not...</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Settings Section -->
    <section id="settings" class="content-section">
        <div class="dashboard-header">
            <div class="greeting">
                <h1>Account Settings</h1>
                <p>Manage your profile and preferences</p>
            </div>
        </div>

        <div class="settings-container">
            <div class="settings-tabs">
                <div class="settings-tab active" data-tab="profile">Profile</div>
                <div class="settings-tab" data-tab="security">Security</div>
                <div class="settings-tab" data-tab="notifications">Notifications</div>
                <div class="settings-tab" data-tab="preferences">Preferences</div>
            </div>

            <div class="settings-form">
                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" class="form-control" value="John Doe">
                </div>

                <div class="form-group">
                    <label>Email</label>
                    <input type="email" class="form-control" value="john.doe@nexora.edu">
                </div>

                <div class="form-group">
                    <label>Student ID</label>
                    <input type="text" class="form-control" value="NS20230045" disabled>
                </div>

                <div class="form-group">
                    <label>Program</label>
                    <select class="form-control">
                        <option>Computer Science</option>
                        <option>Information Technology</option>
                        <option>Data Science</option>
                        <option>Software Engineering</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>Bio</label>
                    <textarea class="form-control" rows="3">Computer Science student specializing in AI and Machine Learning</textarea>
                </div>

                <button class="btn btn-primary">
                    <i class="fas fa-save"></i> Save Changes
                </button>
            </div>
        </div>
    </section>
</div>

<script>
    // Navigation Script
    document.querySelectorAll('.nav-link').forEach(link => {
        link.addEventListener('click', (e) => {
            e.preventDefault();
            const sectionId = link.getAttribute('data-section');

            // Update active nav link
            document.querySelectorAll('.nav-link').forEach(l => l.classList.remove('active'));
            link.classList.add('active');

            // Hide all content sections
            document.querySelectorAll('.content-section').forEach(section => {
                section.classList.remove('active');
            });

            // Show the selected section
            document.getElementById(sectionId).classList.add('active');
        });
    });

    // Settings tabs
    document.querySelectorAll('.settings-tab').forEach(tab => {
        tab.addEventListener('click', () => {
            document.querySelectorAll('.settings-tab').forEach(t => t.classList.remove('active'));
            tab.classList.add('active');
            // In a real implementation, this would switch between different settings forms
        });
    });

    // Notification bell interaction
    document.querySelector('.notification-bell').addEventListener('click', () => {
        alert('You have 2 new notifications');
    });
</script>
</body>
</html>
