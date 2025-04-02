<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NexoraSkill | My Profile</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>
<%@ include file="header.jsp" %>

<main class="profile-container">
    <div class="profile-header">
        <div class="avatar-section">
            <div class="avatar-edit">
                <img src="${pageContext.request.contextPath}/images/users/${user.profilePic}"
                     alt="${user.fullName}" class="avatar">
                <label for="avatar-upload" class="edit-icon">
                    <i class="fas fa-camera"></i>
                </label>
                <input type="file" id="avatar-upload" accept="image/*" style="display:none;">
            </div>
            <h1>${user.fullName}</h1>
            <p class="member-since">Member since <span>${user.joinDate}</span></p>
        </div>

        <div class="profile-stats">
            <div class="stat-card">
                <i class="fas fa-book-open"></i>
                <span>${enrolledCourses}</span>
                <p>Courses</p>
            </div>
            <div class="stat-card">
                <i class="fas fa-certificate"></i>
                <span>${completedCourses}</span>
                <p>Certificates</p>
            </div>
            <div class="stat-card">
                <i class="fas fa-star"></i>
                <span>${user.rating}</span>
                <p>Rating</p>
            </div>
        </div>
    </div>

    <div class="profile-content">
        <section class="profile-section">
            <h2><i class="fas fa-user-cog"></i> Account Settings</h2>
            <form action="updateProfile" method="POST" class="profile-form">
                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" name="fullName" value="${user.fullName}" required>
                </div>
                <div class="form-group">
                    <label>Email</label>
                    <input type="email" name="email" value="${user.email}" required>
                </div>
                <div class="form-group">
                    <label>Bio</label>
                    <textarea name="bio">${user.bio}</textarea>
                </div>
                <button type="submit" class="btn-primary">Update Profile</button>
            </form>
        </section>

        <section class="profile-section">
            <h2><i class="fas fa-lock"></i> Security</h2>
            <form action="changePassword" method="POST" class="profile-form">
                <div class="form-group">
                    <label>Current Password</label>
                    <input type="password" name="currentPassword" required>
                </div>
                <div class="form-group">
                    <label>New Password</label>
                    <input type="password" name="newPassword" required>
                </div>
                <div class="form-group">
                    <label>Confirm New Password</label>
                    <input type="password" name="confirmPassword" required>
                </div>
                <button type="submit" class="btn-primary">Change Password</button>
            </form>
        </section>

        <section class="profile-section">
            <h2><i class="fas fa-chart-line"></i> Learning Progress</h2>
            <c:forEach items="${userCourses}" var="course">
                <div class="course-progress">
                    <h3>${course.name}</h3>
                    <div class="progress-bar">
                        <div class="progress" style="width: ${course.progress}%"></div>
                        <span>${course.progress}% complete</span>
                    </div>
                    <a href="/course?id=${course.id}" class="btn-secondary">Continue Learning</a>
                </div>
            </c:forEach>
        </section>
    </div>
</main>

<%@ include file="footer.jsp" %>

<script>
    // Avatar upload preview
    document.getElementById('avatar-upload').addEventListener('change', function(e) {
        const file = e.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(event) {
                document.querySelector('.avatar').src = event.target.result;
                // Here you would typically upload to server
            };
            reader.readAsDataURL(file);
        }
    });

    // Password validation
    document.querySelector('form[action="changePassword"]').addEventListener('submit', function(e) {
        const newPass = this.querySelector('input[name="newPassword"]').value;
        const confirmPass = this.querySelector('input[name="confirmPassword"]').value;

        if (newPass !== confirmPass) {
            e.preventDefault();
            alert("Passwords don't match!");
        }
    });
</script>
</body>
</html>
