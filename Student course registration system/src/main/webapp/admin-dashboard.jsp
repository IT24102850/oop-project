<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NexoraSkill | Admin Dashboard</title>
    <link rel="icon" type="image/png" href="./images/favicon.ico">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
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
        }

        .logo {
            font-family: 'Orbitron', sans-serif;
            font-size: 1.8rem;
            margin-bottom: 40px;
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
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

        /* Main Content */
        .main-content {
            margin-left: 280px;
            flex: 1;
            padding: 40px;
        }

        .dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
        }

        .admin-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        /* Stats Grid */
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
        }

        .stat-card h3 {
            margin-bottom: 10px;
            font-size: 1rem;
            color: var(--text-muted);
        }

        .stat-value {
            font-size: 2rem;
            font-weight: 700;
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        /* Action Cards */
        .action-card {
            background: var(--card-bg);
            padding: 25px;
            border-radius: var(--border-radius);
            border: 1px solid rgba(0, 242, 254, 0.2);
            margin-bottom: 20px;
        }

        .action-card h3 {
            margin-bottom: 15px;
            font-family: 'Orbitron', sans-serif;
            letter-spacing: 1px;
        }

        /* Data Tables */
        .data-table {
            width: 100%;
            background: var(--card-bg);
            border-radius: var(--border-radius);
            border-collapse: collapse;
            overflow: hidden;
            margin-bottom: 20px;
        }

        .data-table th, .data-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid rgba(0, 242, 254, 0.1);
        }

        .data-table th {
            background: var(--glass-bg);
            font-family: 'Orbitron', sans-serif;
            letter-spacing: 1px;
        }

        /* Buttons */
        .btn {
            padding: 8px 15px;
            border-radius: 6px;
            border: none;
            cursor: pointer;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            font-family: 'Poppins', sans-serif;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: var(--dark-color);
        }

        .btn-danger {
            background: var(--accent-color);
            color: white;
        }

        .btn-warning {
            background: #ffc107;
            color: var(--dark-color);
        }

        /* Form Elements */
        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: var(--text-muted);
        }

        input[type="text"],
        input[type="email"],
        input[type="password"],
        input[type="tel"],
        select,
        textarea {
            width: 100%;
            padding: 12px;
            background: var(--glass-bg);
            border: 1px solid rgba(0, 242, 254, 0.3);
            border-radius: var(--border-radius);
            color: var(--text-color);
        }

        /* Messages */
        .message {
            padding: 10px;
            border-radius: 6px;
            margin-bottom: 20px;
            text-align: center;
        }

        .message.success {
            background: rgba(0, 255, 0, 0.1);
            color: #00ff00;
        }

        .message.error {
            background: rgba(255, 0, 0, 0.1);
            color: #ff0000;
        }

        /* Status Indicators */
        .status {
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.8rem;
            font-weight: 500;
        }

        .status.active {
            background: rgba(0, 255, 0, 0.1);
            color: #00ff00;
        }

        .status.inactive {
            background: rgba(255, 0, 0, 0.1);
            color: #ff0000;
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 10px;
        }

        /* Section Header */
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        /* Modal */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.8);
            backdrop-filter: blur(10px);
            z-index: 1000;
        }

        .modal-content {
            background: var(--card-bg);
            width: 500px;
            padding: 30px;
            border-radius: var(--border-radius);
            position: relative;
            margin: 5% auto;
        }

        /* Emergency Contact Form */
        .emergency-contact-form {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        /* Content Sections */
        .content-section {
            display: none;
        }
    </style>
</head>
<body>
<!-- Sidebar -->
<div class="sidebar">
    <div class="logo">NexoraSkill Admin</div>
    <ul class="nav-menu">
        <li class="nav-item">
            <a href="#" class="nav-link active" data-section="dashboard">
                <i class="fas fa-chart-line"></i> Dashboard
            </a>
        </li>
        <li class="nav-item">
            <a href="#" class="nav-link" data-section="students">
                <i class="fas fa-users"></i> Student Management
            </a>
        </li>
        <li class="nav-item">
            <a href="#" class="nav-link" data-section="courses">
                <i class="fas fa-book-open"></i> Course Management
            </a>
        </li>
        <li class="nav-item">
            <a href="#" class="nav-link" data-section="emergency">
                <i class="fas fa-exclamation-triangle"></i> Emergency Contacts
            </a>
        </li>
        <li class="nav-item">
            <a href="#" class="nav-link" data-section="admin-tools">
                <i class="fas fa-tools"></i> Admin Tools
            </a>
        </li>
    </ul>
</div>

<!-- Main Content -->
<div class="main-content">
    <!-- Dashboard Header -->
    <div class="dashboard-header">
        <h1>Admin Dashboard</h1>
        <div class="admin-info">
            <span>Admin User</span>
            <form action="auth" method="post" style="display: inline;">
                <input type="hidden" name="action" value="logout">
                <button type="submit" class="btn btn-danger">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </button>
            </form>
        </div>
    </div>

    <!-- Messages -->
    <% if (request.getAttribute("error") != null) { %>
    <div class="message error"><%= request.getAttribute("error") %></div>
    <% } %>
    <% if (request.getAttribute("message") != null) { %>
    <div class="message success"><%= request.getAttribute("message") %></div>
    <% } %>

    <!-- Dashboard Section -->
    <section id="dashboard" class="content-section">
        <!-- Dashboard Stats -->
        <div class="stats-grid">
            <div class="stat-card">
                <h3>Total Students</h3>
                <p class="stat-value">124</p>
            </div>
            <div class="stat-card">
                <h3>Active Courses</h3>
                <p class="stat-value">45</p>
            </div>
            <div class="stat-card">
                <h3>Pending Requests</h3>
                <p class="stat-value">12</p>
            </div>
        </div>
    </section>

    <!-- Student Management Section -->
    <section id="students" class="content-section" style="display:none;">
        <div class="section-header">
            <h2><i class="fas fa-users-cog"></i> Student Management</h2>
            <button class="btn btn-primary" onclick="openModal('addStudent')">
                <i class="fas fa-user-plus"></i> Add Student
            </button>
        </div>

        <table class="data-table">
            <thead>
            <tr>
                <th>Student ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <!-- Sample Data -->
            <tr>
                <td>NS2024001</td>
                <td>John Doe</td>
                <td>john@nexora.com</td>
                <td><span class="status active">Active</span></td>
                <td class="action-buttons">
                    <button class="btn btn-primary"><i class="fas fa-edit"></i></button>
                    <button class="btn btn-danger"><i class="fas fa-ban"></i></button>
                    <button class="btn btn-warning"><i class="fas fa-exclamation-triangle"></i></button>
                </td>
            </tr>
            </tbody>
        </table>
    </section>

    <!-- Course Management Section -->
    <section id="courses" class="content-section" style="display:none;">
        <div class="section-header">
            <h2><i class="fas fa-book"></i> Course Management</h2>
            <button class="btn btn-primary" onclick="openModal('addCourse')">
                <i class="fas fa-plus-circle"></i> Add Course
            </button>
        </div>

        <table class="data-table">
            <thead>
            <tr>
                <th>Course Code</th>
                <th>Course Name</th>
                <th>Instructor</th>
                <th>Enrolled</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <!-- Sample Data -->
            <tr>
                <td>AI101</td>
                <td>Artificial Intelligence</td>
                <td>Dr. Smith</td>
                <td>150</td>
                <td class="action-buttons">
                    <button class="btn btn-primary"><i class="fas fa-edit"></i></button>
                    <button class="btn btn-danger"><i class="fas fa-trash"></i></button>
                </td>
            </tr>
            </tbody>
        </table>
    </section>

    <!-- Emergency Contact Section -->
    <section id="emergency" class="content-section" style="display:none;">
        <div class="section-header">
            <h2><i class="fas fa-exclamation-circle"></i> Emergency Contacts</h2>
        </div>

        <div class="emergency-contact-form">
            <div class="form-group">
                <label>Student ID</label>
                <input type="text" placeholder="Enter Student ID">
            </div>
            <div class="form-group">
                <label>Emergency Contact</label>
                <input type="text" placeholder="Contact Name">
            </div>
            <div class="form-group">
                <label>Phone Number</label>
                <input type="tel" placeholder="Emergency Phone">
            </div>
            <button class="btn btn-primary">Update Contacts</button>
        </div>
    </section>

    <!-- Admin Tools Section -->
    <section id="admin-tools" class="content-section" style="display:none;">
        <h2><i class="fas fa-tools"></i> Admin Tools</h2>

        <!-- Monitor Active Sessions -->
        <div class="action-card">
            <h3>Monitor Active Sessions</h3>
            <a href="admin?action=monitorSessions" class="btn btn-primary">
                <i class="fas fa-eye"></i> View Active Admin Sessions
            </a>
        </div>

        <!-- Force Password Reset -->
        <div class="action-card">
            <h3>Force Password Reset</h3>
            <form action="admin" method="post">
                <input type="hidden" name="action" value="forceReset">
                <div class="form-group">
                    <label for="resetUsername">Username:</label>
                    <input type="text" id="resetUsername" name="username" required>
                </div>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-lock"></i> Force Reset
                </button>
            </form>
        </div>

        <!-- Deactivate Account -->
        <div class="action-card">
            <h3>Deactivate Account</h3>
            <form action="admin" method="post">
                <input type="hidden" name="action" value="deactivate">
                <div class="form-group">
                    <label for="deactivateUsername">Username:</label>
                    <input type="text" id="deactivateUsername" name="username" required>
                </div>
                <button type="submit" class="btn btn-danger">
                    <i class="fas fa-ban"></i> Deactivate
                </button>
            </form>
        </div>

        <!-- Purge Expired Unverified Accounts -->
        <div class="action-card">
            <h3>Purge Expired Unverified Accounts</h3>
            <form action="admin" method="post">
                <input type="hidden" name="action" value="purgeUnverified">
                <button type="submit" class="btn btn-danger">
                    <i class="fas fa-trash-alt"></i> Purge Unverified Accounts
                </button>
            </form>
        </div>
    </section>
</div>

<!-- Modals -->
<div id="addStudent" class="modal">
    <div class="modal-content">
        <h2>Add New Student</h2>
        <form>
            <div class="form-group">
                <label>Full Name</label>
                <input type="text" required>
            </div>
            <div class="form-group">
                <label>Email</label>
                <input type="email" required>
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" required>
            </div>
            <button type="submit" class="btn btn-primary">Create Student</button>
        </form>
    </div>
</div>

<div id="addCourse" class="modal">
    <div class="modal-content">
        <h2>Add New Course</h2>
        <form>
            <div class="form-group">
                <label>Course Name</label>
                <input type="text" required>
            </div>
            <div class="form-group">
                <label>Course Code</label>
                <input type="text" required>
            </div>
            <div class="form-group">
                <label>Instructor</label>
                <select required>
                    <option value="">Select Instructor</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Create Course</button>
        </form>
    </div>
</div>

<script>
    // Navigation Script
    document.querySelectorAll('.nav-link').forEach(link => {
        link.addEventListener('click', (e) => {
            e.preventDefault();
            const section = link.getAttribute('data-section');

            document.querySelectorAll('.content-section').forEach(sec => {
                sec.style.display = 'none';
            });

            document.querySelectorAll('.nav-link').forEach(l => l.classList.remove('active'));
            link.classList.add('active');

            document.getElementById(section).style.display = 'block';
        });
    });

    // Show dashboard by default
    document.getElementById('dashboard').style.display = 'block';

    // Modal Script
    function openModal(modalId) {
        document.getElementById(modalId).style.display = 'block';
    }

    window.onclick = function(e) {
        if(e.target.className === 'modal') {
            e.target.style.display = 'none';
        }
    }
</script>
</body>
</html>