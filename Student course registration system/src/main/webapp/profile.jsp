<%--
  Created by IntelliJ IDEA.
  User: hasir
  Date: 4/9/2025
  Time: 7:49 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile | NexoraSkill</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="icon" type="image/png" href="./images/favicon.ico">
    <!-- Google Fonts -->
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
            --hover-color: #00c6fb;
            --glow-color: rgba(0, 242, 254, 0.6);
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
            overflow-x: hidden;
            line-height: 1.7;
        }

        h1, h2, h3 {
            font-family: 'Orbitron', sans-serif;
            font-weight: 700;
            letter-spacing: 1.5px;
            text-transform: uppercase;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 100px 5% 50px;
        }

        /* Profile Header */
        .profile-header {
            display: flex;
            align-items: center;
            gap: 40px;
            margin-bottom: 50px;
            position: relative;
            z-index: 2;
        }

        .profile-avatar {
            position: relative;
            width: 180px;
            height: 180px;
            border-radius: 50%;
            background: var(--card-bg);
            border: 3px solid var(--primary-color);
            box-shadow: 0 0 30px var(--glow-color);
            overflow: hidden;
            transition: var(--transition);
        }

        .profile-avatar:hover {
            transform: scale(1.05);
            box-shadow: 0 0 50px var(--glow-color);
        }

        .avatar-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .avatar-initials {
            width: 100%;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 4rem;
            font-weight: bold;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: var(--dark-color);
        }

        .avatar-edit {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            background: rgba(0, 0, 0, 0.7);
            text-align: center;
            padding: 10px;
            cursor: pointer;
            transition: var(--transition);
        }

        .avatar-edit:hover {
            background: rgba(0, 0, 0, 0.9);
        }

        .profile-info {
            flex: 1;
        }

        .profile-name {
            font-size: 2.5rem;
            margin-bottom: 10px;
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .profile-title {
            font-size: 1.2rem;
            color: var(--primary-color);
            margin-bottom: 20px;
        }

        .profile-stats {
            display: flex;
            gap: 30px;
        }

        .stat-item {
            text-align: center;
        }

        .stat-number {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 5px;
        }

        .stat-label {
            font-size: 0.9rem;
            color: var(--text-muted);
        }

        /* Profile Content */
        .profile-content {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 40px;
        }

        .profile-section {
            background: var(--card-bg);
            backdrop-filter: blur(10px);
            border-radius: var(--border-radius);
            padding: 30px;
            border: 1px solid rgba(0, 242, 254, 0.2);
            box-shadow: var(--box-shadow);
            transition: var(--transition);
        }

        .profile-section:hover {
            border-color: rgba(0, 242, 254, 0.4);
            transform: translateY(-5px);
        }

        .section-title {
            font-size: 1.5rem;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid rgba(0, 242, 254, 0.3);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .edit-btn {
            background: transparent;
            border: none;
            color: var(--primary-color);
            cursor: pointer;
            font-size: 1rem;
            transition: var(--transition);
        }

        .edit-btn:hover {
            text-shadow: 0 0 10px var(--glow-color);
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            color: var(--text-muted);
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            background: rgba(0, 0, 0, 0.3);
            border: 1px solid rgba(0, 242, 254, 0.2);
            border-radius: 8px;
            color: var(--text-color);
            font-family: 'Poppins', sans-serif;
            transition: var(--transition);
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 10px var(--glow-color);
        }

        .form-select {
            appearance: none;
            background: rgba(0, 0, 0, 0.3) url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='%2300f2fe'%3e%3cpath d='M7 10l5 5 5-5z'/%3e%3c/svg%3e") no-repeat;
            background-position: right 10px center;
            background-size: 20px;
        }

        .btn {
            padding: 12px 30px;
            border-radius: 50px;
            font-weight: 600;
            transition: var(--transition);
            font-size: 1rem;
            cursor: pointer;
            border: none;
            display: inline-flex;
            align-items: center;
            gap: 10px;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: var(--dark-color);
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0, 242, 254, 0.3);
        }

        .btn-outline {
            background: transparent;
            border: 2px solid var(--primary-color);
            color: var(--primary-color);
        }

        .btn-outline:hover {
            background: var(--primary-color);
            color: var(--dark-color);
        }

        /* Skills Section */
        .skills-list {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }

        .skill-tag {
            background: rgba(0, 242, 254, 0.1);
            border: 1px solid var(--primary-color);
            border-radius: 50px;
            padding: 8px 15px;
            font-size: 0.9rem;
            transition: var(--transition);
        }

        .skill-tag:hover {
            background: var(--primary-color);
            color: var(--dark-color);
            transform: translateY(-3px);
        }

        /* Courses Section */
        .courses-list {
            display: grid;
            gap: 15px;
        }

        .course-item {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 15px;
            background: rgba(0, 0, 0, 0.2);
            border-radius: 8px;
            transition: var(--transition);
        }

        .course-item:hover {
            background: rgba(0, 242, 254, 0.1);
            transform: translateX(5px);
        }

        .course-icon {
            width: 40px;
            height: 40px;
            border-radius: 8px;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
        }

        .course-info {
            flex: 1;
        }

        .course-title {
            font-weight: 600;
            margin-bottom: 5px;
        }

        .course-progress {
            height: 5px;
            background: rgba(0, 242, 254, 0.2);
            border-radius: 5px;
            margin-top: 8px;
            overflow: hidden;
        }

        .progress-bar {
            height: 100%;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            border-radius: 5px;
        }

        /* Holographic Effects */
        .holographic-bg {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            opacity: 0.1;
            background: radial-gradient(circle, var(--primary-color) 0%, transparent 70%);
            animation: rotate 60s linear infinite;
        }

        @keyframes rotate {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Responsive Design */
        @media (max-width: 992px) {
            .profile-content {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            .profile-header {
                flex-direction: column;
                text-align: center;
            }

            .profile-stats {
                justify-content: center;
            }
        }

        @media (max-width: 576px) {
            .profile-name {
                font-size: 2rem;
            }

            .profile-stats {
                flex-wrap: wrap;
            }
        }
    </style>
</head>
<body>
<!-- Holographic Background Effect -->
<div class="holographic-bg"></div>

<div class="container">
    <!-- Profile Header -->
    <div class="profile-header">
        <div class="profile-avatar">
            <!-- Display user's profile picture if available, otherwise show initials -->
            <c:choose>
                <c:when test="${not empty user.profilePicture}">
                    <img src="${user.profilePicture}" alt="Profile Picture" class="avatar-image">
                </c:when>
                <c:otherwise>
                    <div class="avatar-initials">${fn:substring(user.firstName, 0, 1)}${fn:substring(user.lastName, 0, 1)}</div>
                </c:otherwise>
            </c:choose>
            <div class="avatar-edit" onclick="document.getElementById('avatar-upload').click()">
                <i class="fas fa-camera"></i> Change Photo
            </div>
            <input type="file" id="avatar-upload" accept="image/*" style="display: none;">
        </div>

        <div class="profile-info">
            <h1 class="profile-name">${user.firstName} ${user.lastName}</h1>
            <p class="profile-title">${user.major} Student</p>

            <div class="profile-stats">
                <div class="stat-item">
                    <div class="stat-number">${user.enrolledCourses}</div>
                    <div class="stat-label">Courses</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">${user.completedCourses}</div>
                    <div class="stat-label">Completed</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">${user.achievements}</div>
                    <div class="stat-label">Achievements</div>
                </div>
            </div>
        </div>
    </div>

    <!-- Profile Content -->
    <div class="profile-content">
        <!-- Personal Information Section -->
        <div class="profile-section">
            <h3 class="section-title">
                Personal Information
                <button class="edit-btn" onclick="toggleEdit('personal-info')">
                    <i class="fas fa-edit"></i> Edit
                </button>
            </h3>

            <form id="personal-info-form">
                <div class="form-group">
                    <label class="form-label">First Name</label>
                    <input type="text" class="form-control" value="${user.firstName}" readonly>
                </div>

                <div class="form-group">
                    <label class="form-label">Last Name</label>
                    <input type="text" class="form-control" value="${user.lastName}" readonly>
                </div>

                <div class="form-group">
                    <label class="form-label">Email</label>
                    <input type="email" class="form-control" value="${user.email}" readonly>
                </div>

                <div class="form-group">
                    <label class="form-label">Major</label>
                    <select class="form-control form-select" disabled>
                        <option>Computer Science</option>
                        <option>Data Science</option>
                        <option>Artificial Intelligence</option>
                        <option>Cybersecurity</option>
                        <option>Software Engineering</option>
                    </select>
                </div>

                <div class="form-group" style="display: none;" id="personal-info-actions">
                    <button type="button" class="btn btn-primary">Save Changes</button>
                    <button type="button" class="btn btn-outline" onclick="toggleEdit('personal-info')">Cancel</button>
                </div>
            </form>
        </div>

        <!-- Account Settings Section -->
        <div class="profile-section">
            <h3 class="section-title">
                Account Settings
                <button class="edit-btn" onclick="toggleEdit('account-settings')">
                    <i class="fas fa-edit"></i> Edit
                </button>
            </h3>

            <form id="account-settings-form">
                <div class="form-group">
                    <label class="form-label">Username</label>
                    <input type="text" class="form-control" value="${user.username}" readonly>
                </div>

                <div class="form-group">
                    <label class="form-label">Change Password</label>
                    <input type="password" class="form-control" placeholder="New Password" readonly>
                </div>

                <div class="form-group">
                    <label class="form-label">Confirm Password</label>
                    <input type="password" class="form-control" placeholder="Confirm New Password" readonly>
                </div>

                <div class="form-group" style="display: none;" id="account-settings-actions">
                    <button type="button" class="btn btn-primary">Update Password</button>
                    <button type="button" class="btn btn-outline" onclick="toggleEdit('account-settings')">Cancel</button>
                </div>
            </form>
        </div>

        <!-- Skills Section -->
        <div class="profile-section">
            <h3 class="section-title">
                My Skills
                <button class="edit-btn" onclick="toggleEdit('skills')">
                    <i class="fas fa-edit"></i> Edit
                </button>
            </h3>

            <div class="skills-list">
                <span class="skill-tag">Java</span>
                <span class="skill-tag">Python</span>
                <span class="skill-tag">Machine Learning</span>
                <span class="skill-tag">SQL</span>
                <span class="skill-tag">JavaScript</span>
            </div>

            <div class="form-group" style="display: none; margin-top: 20px;" id="skills-actions">
                <input type="text" class="form-control" placeholder="Add new skill">
                <div style="margin-top: 15px;">
                    <button type="button" class="btn btn-primary">Save Skills</button>
                    <button type="button" class="btn btn-outline" onclick="toggleEdit('skills')">Cancel</button>
                </div>
            </div>
        </div>

        <!-- Enrolled Courses Section -->
        <div class="profile-section">
            <h3 class="section-title">
                My Courses
            </h3>

            <div class="courses-list">
                <div class="course-item">
                    <div class="course-icon">
                        <i class="fas fa-robot"></i>
                    </div>
                    <div class="course-info">
                        <div class="course-title">Advanced AI Programming</div>
                        <div class="course-progress">
                            <div class="progress-bar" style="width: 75%"></div>
                        </div>
                    </div>
                </div>

                <div class="course-item">
                    <div class="course-icon">
                        <i class="fas fa-lock"></i>
                    </div>
                    <div class="course-info">
                        <div class="course-title">Cybersecurity Fundamentals</div>
                        <div class="course-progress">
                            <div class="progress-bar" style="width: 30%"></div>
                        </div>
                    </div>
                </div>

                <div class="course-item">
                    <div class="course-icon">
                        <i class="fas fa-cloud"></i>
                    </div>
                    <div class="course-info">
                        <div class="course-title">Cloud Architecture</div>
                        <div class="course-progress">
                            <div class="progress-bar" style="width: 90%"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Toggle edit mode for sections
    function toggleEdit(sectionId) {
        const form = document.getElementById(`${sectionId}-form`);
        const actions = document.getElementById(`${sectionId}-actions`);
        const inputs = form ? form.querySelectorAll('.form-control') : [];
        const selects = form ? form.querySelectorAll('.form-select') : [];

        // For skills section which doesn't have a form
        if (sectionId === 'skills') {
            const skillsActions = document.getElementById('skills-actions');
            skillsActions.style.display = skillsActions.style.display === 'none' ? 'block' : 'none';
            return;
        }

        // Toggle readonly/disabled for inputs and selects
        inputs.forEach(input => {
            input.readOnly = !input.readOnly;
        });

        selects.forEach(select => {
            select.disabled = !select.disabled;
        });

        // Toggle actions visibility
        actions.style.display = actions.style.display === 'none' ? 'block' : 'none';
    }

    // Handle avatar upload
    document.getElementById('avatar-upload').addEventListener('change', function(e) {
        if (e.target.files && e.target.files[0]) {
            const reader = new FileReader();

            reader.onload = function(event) {
                const avatarImage = document.querySelector('.avatar-image');
                const avatarInitials = document.querySelector('.avatar-initials');

                if (avatarImage) {
                    avatarImage.src = event.target.result;
                } else if (avatarInitials) {
                    avatarInitials.innerHTML = `<img src="${event.target.result}" alt="Profile Picture" style="width:100%;height:100%;object-fit:cover;">`;
                }

                // Here you would typically upload the image to your server
                // and update the user's profile picture in the database
                alert('Profile picture updated successfully!');
            };

            reader.readAsDataURL(e.target.files[0]);
        }
    });

    // Initialize the page
    document.addEventListener('DOMContentLoaded', function() {
        // Add any initialization code here
    });
</script>
</body>
</html>