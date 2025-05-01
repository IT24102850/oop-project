<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NexoraSkill - ${course.title}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/course.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.ico">
</head>
<body>

<!-- Header Section -->
<header class="header">
    <div class="container">
        <div class="logo">
            <img src="${pageContext.request.contextPath}/images/favicon-32x32.png" alt="NexoraSkill Logo">
            <span>NexoraSkill</span>
        </div>
        <nav class="navbar">
            <ul>
                <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/courses">Courses</a></li>
                <li><a href="${pageContext.request.contextPath}/registration">Registration</a></li>
                <li><a href="${pageContext.request.contextPath}/about">About Us</a></li>
                <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
            </ul>
        </nav>
        <div class="auth-buttons">
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <a href="${pageContext.request.contextPath}/profile" class="btn-login">Profile</a>
                    <a href="${pageContext.request.contextPath}/logout" class="btn-signup">Logout</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login" class="btn-login">Login</a>
                    <a href="${pageContext.request.contextPath}/register" class="btn-signup">Sign Up</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>

<main>
    <!-- Top Section -->
    <section class="top-section">
        <!-- Left Side: Course Image -->
        <div class="course-image">
            <img src="${pageContext.request.contextPath}/images/${course.image}" alt="${course.title} Illustration">
        </div>

        <!-- Middle Top: Course Description -->
        <div class="course-description">
            <h1>${course.title}</h1>
            <p>${course.description}</p>
        </div>

        <!-- Right Side: Review Section -->
        <div class="review-section">
            <h2>Student Reviews</h2>
            <div class="review-slideshow">
                <c:forEach items="${course.reviews}" var="review">
                    <div class="review-card">
                        <p>"${review.comment}"</p>
                        <h4>- ${review.studentName}</h4>
                    </div>
                </c:forEach>
            </div>
        </div>
    </section>

    <!-- Bottom Section -->
    <section class="bottom-section">
        <!-- Left Side: Instructors Description -->
        <div class="instructors-description">
            <h2>Meet Our Instructors</h2>
            <div class="instructor-list">
                <c:forEach items="${course.instructors}" var="instructor">
                    <div class="instructor-item">
                        <img src="${pageContext.request.contextPath}/images/instructors/${instructor.image}" alt="${instructor.name}">
                        <h3>${instructor.name}</h3>
                        <p>${instructor.expertise}</p>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- Middle Bottom: Why Choose This Course -->
        <div class="why-choose">
            <h2>Why Choose This Course?</h2>
            <ul>
                <c:forEach items="${course.benefits}" var="benefit">
                    <li>${benefit}</li>
                </c:forEach>
            </ul>
        </div>

        <!-- Right Side: Enroll Me Button -->
        <div class="enroll-section">
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <form action="${pageContext.request.contextPath}/enroll" method="post">
                        <input type="hidden" name="courseId" value="${course.id}">
                        <button type="submit" class="enroll-button">Enroll Me</button>
                    </form>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login" class="enroll-button">Login to Enroll</a>
                </c:otherwise>
            </c:choose>
        </div>
    </section>
</main>

<script>
    // Auto-rotate reviews every 5 seconds
    let currentReview = 0;
    const reviews = document.querySelectorAll('.review-card');
    
    function rotateReviews() {
        reviews.forEach((review, index) => {
            review.style.display = index === currentReview ? 'block' : 'none';
        });
        currentReview = (currentReview + 1) % reviews.length;
    }
    
    // Initial rotation and set interval
    rotateReviews();
    setInterval(rotateReviews, 5000);
</script>

</body>
</html>