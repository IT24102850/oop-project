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


    <!-- Add this to the navigation menu -->
    <li class="nav-item">
        <a href="#" class="nav-link" data-section="profile">
            <i class="fas fa-user"></i> <span>Profile</span>
        </a>
    </li>


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
    <!-- Profile Section -->
    <section id="profile" class="content-section">
        <div class="dashboard-header">
            <div class="greeting">
                <h1>Student Profile</h1>
                <p>Manage your personal information and account settings</p>
            </div>
        </div>

        <div class="profile-container">
            <div class="profile-card">
                <div class="profile-header">
                    <div class="user-avatar-large">
                        <img src="https://via.placeholder.com/150" alt="Profile Picture">
                        <button class="btn btn-outline avatar-upload">
                            <i class="fas fa-camera"></i> Update Photo
                        </button>
                    </div>
                    <div class="profile-info">
                        <h2>John Doe</h2>
                        <p class="student-id">NS20230045</p>
                        <div class="status-badge">
                            <i class="fas fa-check-circle"></i> Verified Student
                        </div>
                    </div>
                </div>

                <div class="profile-details">
                    <div class="detail-group">
                        <h3>Personal Information</h3>
                        <div class="detail-item">
                            <label>Full Name:</label>
                            <p>John Michael Doe</p>
                        </div>
                        <div class="detail-item">
                            <label>Date of Birth:</label>
                            <p>15 March 2001</p>
                        </div>
                        <div class="detail-item">
                            <label>Contact Email:</label>
                            <p>john.doe@nexora.edu</p>
                        </div>
                        <div class="detail-item">
                            <label>Phone Number:</label>
                            <p>+94 77 123 4567</p>
                        </div>
                    </div>

                    <div class="detail-group">
                        <h3>Academic Information</h3>
                        <div class="detail-item">
                            <label>Program:</label>
                            <p>BSc in Computer Science</p>
                        </div>
                        <div class="detail-item">
                            <label>Enrollment Year:</label>
                            <p>2020</p>
                        </div>
                        <div class="detail-item">
                            <label>Current Semester:</label>
                            <p>Semester 6</p>
                        </div>
                        <div class="detail-item">
                            <label>Academic Advisor:</label>
                            <p>Dr. Samantha Smith</p>
                        </div>
                    </div>

                    <div class="detail-group">
                        <h3>Account Security</h3>
                        <div class="detail-item">
                            <label>Password:</label>
                            <p>••••••••</p>
                            <button class="btn btn-outline">
                                <i class="fas fa-lock"></i> Change Password
                            </button>
                        </div>
                        <div class="detail-item">
                            <label>Two-Factor Auth:</label>
                            <p>Not Enabled</p>
                            <button class="btn btn-outline">
                                <i class="fas fa-shield-alt"></i> Enable 2FA
                            </button>
                        </div>
                    </div>
                </div>

                <div class="profile-actions">
                    <button class="btn btn-primary">
                        <i class="fas fa-save"></i> Save Changes
                    </button>
                    <button class="btn btn-outline">
                        <i class="fas fa-file-pdf"></i> Download Academic Record
                    </button>
                </div>
            </div>
        </div>
    </section>


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

                <!-- Profile Section -->
                <section id="profile" class="content-section">
                    <div class="dashboard-header">
                        <div class="greeting">
                            <h1>Student Profile</h1>
                            <p>Manage your personal information and academic details</p>
                        </div>
                        <div class="user-actions">
                            <button class="btn btn-primary">
                                <i class="fas fa-sync-alt"></i> Refresh Data
                            </button>
                        </div>
                    </div>

                    <div class="profile-container">
                        <div class="profile-card">
                            <!-- Profile Header with Holographic Avatar -->
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
                                        <span>Level 3 Student (78%)</span>
                                    </div>
                                </div>
                            </div>

                            <!-- Profile Tabs -->
                            <div class="profile-tabs">
                                <div class="tab active" data-tab="personal">Personal</div>
                                <div class="tab" data-tab="academic">Academic</div>
                                <div class="tab" data-tab="security">Security</div>
                                <div class="tab" data-tab="achievements">Achievements</div>
                                <div class="tab" data-tab="analytics">Analytics</div>
                            </div>

                            <!-- Tab Content -->
                            <div class="tab-content">
                                <!-- Personal Information Tab -->
                                <div class="tab-pane active" id="personal-tab">
                                    <div class="detail-grid">
                                        <div class="detail-card">
                                            <h3><i class="fas fa-user-tag"></i> Basic Information</h3>
                                            <div class="detail-item">
                                                <label>Full Name:</label>
                                                <p>John Michael Doe</p>
                                                <button class="btn-edit"><i class="fas fa-pencil-alt"></i></button>
                                            </div>
                                            <div class="detail-item">
                                                <label>Date of Birth:</label>
                                                <p>March 15, 2001 (22 years)</p>
                                            </div>
                                            <div class="detail-item">
                                                <label>Gender:</label>
                                                <p>Male</p>
                                            </div>
                                            <div class="detail-item">
                                                <label>Nationality:</label>
                                                <p>Sri Lankan</p>
                                            </div>
                                        </div>

                                        <div class="detail-card">
                                            <h3><i class="fas fa-address-book"></i> Contact Details</h3>
                                            <div class="detail-item">
                                                <label>Primary Email:</label>
                                                <p>john.doe@nexora.edu <span class="verified-badge">Verified</span></p>
                                            </div>
                                            <div class="detail-item">
                                                <label>Secondary Email:</label>
                                                <p>johndoe@gmail.com <span class="unverified-badge">Unverified</span></p>
                                            </div>
                                            <div class="detail-item">
                                                <label>Phone Number:</label>
                                                <p>+94 77 123 4567 <span class="verified-badge">Verified</span></p>
                                            </div>
                                            <div class="detail-item">
                                                <label>Emergency Contact:</label>
                                                <p>Jane Doe (Mother) +94 76 987 6543</p>
                                            </div>
                                        </div>

                                        <div class="detail-card">
                                            <h3><i class="fas fa-map-marker-alt"></i> Address Information</h3>
                                            <div class="detail-item">
                                                <label>Current Address:</label>
                                                <p>123 University Dorm, Colombo 03, Sri Lanka</p>
                                            </div>
                                            <div class="detail-item">
                                                <label>Permanent Address:</label>
                                                <p>456 Main Street, Kandy, Sri Lanka</p>
                                            </div>
                                        </div>

                                        <div class="detail-card">
                                            <h3><i class="fas fa-heart"></i> Social Profiles</h3>
                                            <div class="social-links">
                                                <a href="#" class="social-link linkedin"><i class="fab fa-linkedin"></i> LinkedIn</a>
                                                <a href="#" class="social-link github"><i class="fab fa-github"></i> GitHub</a>
                                                <a href="#" class="social-link twitter"><i class="fab fa-twitter"></i> Twitter</a>
                                                <button class="btn btn-outline add-social">
                                                    <i class="fas fa-plus"></i> Add Profile
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Academic Information Tab -->
                                <div class="tab-pane" id="academic-tab">
                                    <div class="detail-grid">
                                        <div class="detail-card">
                                            <h3><i class="fas fa-graduation-cap"></i> Program Details</h3>
                                            <div class="detail-item">
                                                <label>Degree Program:</label>
                                                <p>BSc in Computer Science</p>
                                            </div>
                                            <div class="detail-item">
                                                <label>Specialization:</label>
                                                <p>Artificial Intelligence</p>
                                            </div>
                                            <div class="detail-item">
                                                <label>Enrollment Date:</label>
                                                <p>September 15, 2020</p>
                                            </div>
                                            <div class="detail-item">
                                                <label>Expected Graduation:</label>
                                                <p>June 2024</p>
                                            </div>
                                        </div>

                                        <div class="detail-card">
                                            <h3><i class="fas fa-calendar-alt"></i> Current Semester</h3>
                                            <div class="detail-item">
                                                <label>Semester:</label>
                                                <p>Semester 6 of 8</p>
                                            </div>
                                            <div class="detail-item">
                                                <label>Status:</label>
                                                <p><span class="status active">Active</span></p>
                                            </div>
                                            <div class="detail-item">
                                                <label>GPA:</label>
                                                <p>3.72/4.00 <span class="positive">(Top 15%)</span></p>
                                            </div>
                                            <div class="detail-item">
                                                <label>Credits Completed:</label>
                                                <p>92 of 120</p>
                                            </div>
                                        </div>

                                        <div class="detail-card">
                                            <h3><i class="fas fa-user-tie"></i> Academic Support</h3>
                                            <div class="detail-item">
                                                <label>Academic Advisor:</label>
                                                <p>Dr. Samantha Smith</p>
                                            </div>
                                            <div class="detail-item">
                                                <label>Department:</label>
                                                <p>Computer Science</p>
                                            </div>
                                            <div class="detail-item">
                                                <label>Advisor Contact:</label>
                                                <p>s.smith@nexora.edu</p>
                                            </div>
                                            <div class="detail-item">
                                                <label>Next Meeting:</label>
                                                <p>November 15, 2023 <a href="#" class="schedule-link">(Reschedule)</a></p>
                                            </div>
                                        </div>

                                        <div class="detail-card">
                                            <h3><i class="fas fa-award"></i> Academic History</h3>
                                            <div class="academic-history">
                                                <div class="history-item">
                                                    <div class="history-year">2022-2023</div>
                                                    <div class="history-details">
                                                        <p>Dean's List - Semester 4</p>
                                                        <p>Best Project Award - CS301</p>
                                                    </div>
                                                </div>
                                                <div class="history-item">
                                                    <div class="history-year">2021-2022</div>
                                                    <div class="history-details">
                                                        <p>Academic Excellence Scholarship</p>
                                                    </div>
                                                </div>
                                                <button class="btn btn-outline view-full-history">
                                                    <i class="fas fa-history"></i> View Full History
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Security Tab -->
                                <div class="tab-pane" id="security-tab">
                                    <div class="detail-grid">
                                        <div class="detail-card security-card">
                                            <h3><i class="fas fa-lock"></i> Account Security</h3>
                                            <div class="security-item">
                                                <div class="security-info">
                                                    <i class="fas fa-key"></i>
                                                    <div>
                                                        <h4>Password</h4>
                                                        <p>Last changed 3 months ago</p>
                                                    </div>
                                                </div>
                                                <button class="btn btn-outline">
                                                    <i class="fas fa-sync-alt"></i> Change Password
                                                </button>
                                            </div>

                                            <div class="security-item">
                                                <div class="security-info">
                                                    <i class="fas fa-shield-alt"></i>
                                                    <div>
                                                        <h4>Two-Factor Authentication</h4>
                                                        <p>Currently disabled</p>
                                                    </div>
                                                </div>
                                                <button class="btn btn-primary">
                                                    <i class="fas fa-toggle-on"></i> Enable 2FA
                                                </button>
                                            </div>

                                            <div class="security-item">
                                                <div class="security-info">
                                                    <i class="fas fa-desktop"></i>
                                                    <div>
                                                        <h4>Active Sessions</h4>
                                                        <p>2 devices currently active</p>
                                                    </div>
                                                </div>
                                                <button class="btn btn-outline">
                                                    <i class="fas fa-list"></i> View All
                                                </button>
                                            </div>
                                        </div>

                                        <div class="detail-card security-card">
                                            <h3><i class="fas fa-bell"></i> Login Alerts</h3>
                                            <div class="switch-item">
                                                <div>
                                                    <h4>Email Notifications</h4>
                                                    <p>Receive alerts for new logins</p>
                                                </div>
                                                <label class="switch">
                                                    <input type="checkbox" checked>
                                                    <span class="slider round"></span>
                                                </label>
                                            </div>

                                            <div class="switch-item">
                                                <div>
                                                    <h4>SMS Notifications</h4>
                                                    <p>Receive text message alerts</p>
                                                </div>
                                                <label class="switch">
                                                    <input type="checkbox">
                                                    <span class="slider round"></span>
                                                </label>
                                            </div>

                                            <div class="switch-item">
                                                <div>
                                                    <h4>Unusual Activity</h4>
                                                    <p>Alert for suspicious logins</p>
                                                </div>
                                                <label class="switch">
                                                    <input type="checkbox" checked>
                                                    <span class="slider round"></span>
                                                </label>
                                            </div>
                                        </div>

                                        <div class="detail-card security-card danger-zone">
                                            <h3><i class="fas fa-exclamation-triangle"></i> Danger Zone</h3>
                                            <div class="danger-item">
                                                <div>
                                                    <h4>Deactivate Account</h4>
                                                    <p>Temporarily disable your account</p>
                                                </div>
                                                <button class="btn btn-danger">
                                                    <i class="fas fa-power-off"></i> Deactivate
                                                </button>
                                            </div>

                                            <div class="danger-item">
                                                <div>
                                                    <h4>Request Data Export</h4>
                                                    <p>Download all your personal data</p>
                                                </div>
                                                <button class="btn btn-outline">
                                                    <i class="fas fa-file-export"></i> Request
                                                </button>
                                            </div>

                                            <div class="danger-item">
                                                <div>
                                                    <h4>Delete Account</h4>
                                                    <p>Permanently remove your account</p>
                                                </div>
                                                <button class="btn btn-danger">
                                                    <i class="fas fa-trash-alt"></i> Delete
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Profile Actions -->
                            <div class="profile-actions">
                                <button class="btn btn-outline">
                                    <i class="fas fa-file-pdf"></i> Export Profile
                                </button>
                                <button class="btn btn-primary">
                                    <i class="fas fa-save"></i> Save Changes
                                </button>
                            </div>
                        </div>
                    </div>
                </section>

                <style>
                    /* Profile Section Specific Styles */
                    .profile-container {
                        max-width: 1200px;
                        margin: 0 auto;
                    }

                    .profile-card {
                        background: var(--card-bg);
                        border-radius: var(--border-radius);
                        padding: 30px;
                        box-shadow: var(--box-shadow);
                    }

                    .profile-header {
                        display: flex;
                        align-items: flex-start;
                        gap: 30px;
                        margin-bottom: 30px;
                        padding-bottom: 30px;
                        border-bottom: 1px solid rgba(0, 242, 254, 0.1);
                    }

                    .user-avatar-holographic {
                        position: relative;
                        width: 180px;
                        height: 180px;
                        border-radius: 50%;
                        overflow: hidden;
                        border: 3px solid var(--primary-color);
                        display: flex;
                        align-items: center;
                        justify-content: center;
                    }

                    .hologram-effect {
                        position: absolute;
                        width: 100%;
                        height: 100%;
                        background: linear-gradient(135deg,
                        rgba(0, 242, 254, 0.2) 0%,
                        rgba(79, 172, 254, 0.2) 50%,
                        rgba(255, 77, 126, 0.2) 100%);
                        border-radius: 50%;
                        animation: hologramPulse 6s infinite alternate;
                    }

                    @keyframes hologramPulse {
                        0% { opacity: 0.3; }
                        100% { opacity: 0.7; }
                    }

                    .avatar-image {
                        width: 94%;
                        height: 94%;
                        border-radius: 50%;
                        object-fit: cover;
                        position: relative;
                        z-index: 1;
                    }

                    .avatar-actions {
                        position: absolute;
                        bottom: -20px;
                        left: 0;
                        right: 0;
                        display: flex;
                        justify-content: center;
                        gap: 10px;
                        z-index: 2;
                    }

                    .profile-info {
                        flex: 1;
                    }

                    .profile-info h2 {
                        font-size: 2.2rem;
                        margin-bottom: 10px;
                        background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
                        -webkit-background-clip: text;
                        -webkit-text-fill-color: transparent;
                    }

                    .student-id-badge {
                        display: inline-block;
                        background: rgba(0, 242, 254, 0.1);
                        padding: 5px 15px;
                        border-radius: 20px;
                        font-family: 'Orbitron', sans-serif;
                        margin-bottom: 15px;
                    }

                    .verification-status {
                        display: flex;
                        align-items: center;
                        gap: 8px;
                        margin-bottom: 20px;
                    }

                    .verification-status .verified {
                        color: var(--success-color);
                    }

                    .academic-level {
                        margin-top: 20px;
                    }

                    .level-progress {
                        height: 8px;
                        background: var(--glass-bg);
                        border-radius: 4px;
                        margin-bottom: 5px;
                    }

                    .level-progress .progress-fill {
                        height: 100%;
                        background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
                        border-radius: 4px;
                    }

                    /* Profile Tabs */
                    .profile-tabs {
                        display: flex;
                        border-bottom: 1px solid rgba(0, 242, 254, 0.1);
                        margin-bottom: 25px;
                    }

                    .profile-tabs .tab {
                        padding: 12px 25px;
                        cursor: pointer;
                        position: relative;
                        font-weight: 500;
                        color: var(--text-muted);
                    }

                    .profile-tabs .tab.active {
                        color: var(--primary-color);
                    }

                    .profile-tabs .tab.active::after {
                        content: '';
                        position: absolute;
                        bottom: -1px;
                        left: 0;
                        right: 0;
                        height: 3px;
                        background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
                    }

                    /* Detail Grid Layout */
                    .detail-grid {
                        display: grid;
                        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                        gap: 25px;
                        margin-bottom: 30px;
                    }

                    .detail-card {
                        background: rgba(15, 23, 42, 0.7);
                        border-radius: var(--border-radius);
                        padding: 20px;
                        border: 1px solid rgba(0, 242, 254, 0.1);
                    }

                    .detail-card h3 {
                        font-size: 1.1rem;
                        margin-bottom: 20px;
                        padding-bottom: 10px;
                        border-bottom: 1px solid rgba(0, 242, 254, 0.1);
                        display: flex;
                        align-items: center;
                        gap: 10px;
                    }

                    .detail-item {
                        margin-bottom: 15px;
                        padding: 10px;
                        background: var(--glass-bg);
                        border-radius: 8px;
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                    }

                    .detail-item label {
                        font-weight: 500;
                        color: var(--primary-color);
                        margin-right: 10px;
                        min-width: 120px;
                    }

                    .detail-item p {
                        flex: 1;
                    }

                    .btn-edit {
                        background: none;
                        border: none;
                        color: var(--text-muted);
                        cursor: pointer;
                        transition: var(--transition);
                    }

                    .btn-edit:hover {
                        color: var(--primary-color);
                    }

                    /* Verification Badges */
                    .verified-badge {
                        display: inline-block;
                        background: rgba(76, 175, 80, 0.2);
                        color: var(--success-color);
                        padding: 2px 8px;
                        border-radius: 10px;
                        font-size: 0.7rem;
                        margin-left: 8px;
                    }

                    .unverified-badge {
                        display: inline-block;
                        background: rgba(255, 152, 0, 0.2);
                        color: var(--warning-color);
                        padding: 2px 8px;
                        border-radius: 10px;
                        font-size: 0.7rem;
                        margin-left: 8px;
                    }

                    /* Social Links */
                    .social-links {
                        display: flex;
                        flex-direction: column;
                        gap: 10px;
                    }

                    .social-link {
                        display: flex;
                        align-items: center;
                        gap: 8px;
                        text-decoration: none;
                        padding: 8px 12px;
                        border-radius: 6px;
                        transition: var(--transition);
                    }

                    .social-link:hover {
                        transform: translateX(5px);
                    }

                    .social-link.linkedin {
                        background: rgba(10, 102, 194, 0.1);
                        color: #0a66c2;
                    }

                    .social-link.github {
                        background: rgba(23, 21, 21, 0.1);
                        color: #171515;
                    }

                    .social-link.twitter {
                        background: rgba(29, 161, 242, 0.1);
                        color: #1da1f2;
                    }

                    /* Security Items */
                    .security-item {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        padding: 15px 0;
                        border-bottom: 1px solid rgba(0, 242, 254, 0.1);
                    }

                    .security-info {
                        display: flex;
                        align-items: center;
                        gap: 15px;
                    }

                    .security-info i {
                        font-size: 1.2rem;
                        color: var(--primary-color);
                    }

                    .security-info h4 {
                        margin-bottom: 5px;
                    }

                    .security-info p {
                        font-size: 0.8rem;
                        color: var(--text-muted);
                    }

                    /* Switch Items */
                    .switch-item {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        padding: 15px 0;
                        border-bottom: 1px solid rgba(0, 242, 254, 0.1);
                    }

                    .switch-item h4 {
                        margin-bottom: 5px;
                    }

                    .switch-item p {
                        font-size: 0.8rem;
                        color: var(--text-muted);
                    }

                    .switch {
                        position: relative;
                        display: inline-block;
                        width: 50px;
                        height: 24px;
                    }

                    .switch input {
                        opacity: 0;
                        width: 0;
                        height: 0;
                    }

                    .slider {
                        position: absolute;
                        cursor: pointer;
                        top: 0;
                        left: 0;
                        right: 0;
                        bottom: 0;
                        background-color: var(--glass-bg);
                        transition: .4s;
                    }

                    .slider:before {
                        position: absolute;
                        content: "";
                        height: 16px;
                        width: 16px;
                        left: 4px;
                        bottom: 4px;
                        background-color: var(--text-muted);
                        transition: .4s;
                    }

                    input:checked + .slider {
                        background-color: var(--primary-color);
                    }

                    input:checked + .slider:before {
                        transform: translateX(26px);
                    }

                    .slider.round {
                        border-radius: 34px;
                    }

                    .slider.round:before {
                        border-radius: 50%;
                    }

                    /* Danger Zone */
                    .danger-zone {
                        border: 1px solid rgba(255, 77, 126, 0.3);
                    }

                    .danger-zone h3 {
                        color: var(--accent-color);
                    }

                    .danger-item {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        padding: 15px 0;
                        border-bottom: 1px solid rgba(255, 77, 126, 0.1);
                    }

                    .danger-item h4 {
                        margin-bottom: 5px;
                    }

                    .danger-item p {
                        font-size: 0.8rem;
                        color: var(--text-muted);
                    }

                    .btn-danger {
                        background: linear-gradient(135deg, var(--accent-color), #ff2d5a);
                        color: white;
                    }

                    .btn-danger:hover {
                        transform: translateY(-2px);
                        box-shadow: 0 5px 15px rgba(255, 77, 126, 0.3);
                    }

                    /* Profile Actions */
                    .profile-actions {
                        display: flex;
                        justify-content: flex-end;
                        gap: 15px;
                        margin-top: 30px;
                        padding-top: 20px;
                        border-top: 1px solid rgba(0, 242, 254, 0.1);
                    }

                    /* Responsive Adjustments */
                    @media (max-width: 992px) {
                        .profile-header {
                            flex-direction: column;
                            align-items: center;
                            text-align: center;
                        }

                        .profile-info {
                            text-align: center;
                        }

                        .avatar-actions {
                            position: relative;
                            bottom: auto;
                            margin-top: 15px;
                        }
                    }

                    @media (max-width: 768px) {
                        .profile-tabs {
                            overflow-x: auto;
                            white-space: nowrap;
                        }

                        .detail-grid {
                            grid-template-columns: 1fr;
                        }
                    }
                </style>

                <script>
                    // Profile Tab Switching
                    document.querySelectorAll('.profile-tabs .tab').forEach(tab => {
                        tab.addEventListener('click', () => {
                            const tabId = tab.getAttribute('data-tab');

                            // Update active tab
                            document.querySelectorAll('.profile-tabs .tab').forEach(t => t.classList.remove('active'));
                            tab.classList.add('active');

                            // Hide all tab panes
                            document.querySelectorAll('.tab-pane').forEach(pane => pane.classList.remove('active'));

                            // Show selected pane
                            document.getElementById(`${tabId}-tab`).classList.add('active');
                        });
                    });

                    // Initialize with first tab active
                    document.querySelector('.profile-tabs .tab').click();
                </script>

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
