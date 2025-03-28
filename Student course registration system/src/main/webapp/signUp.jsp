<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Sign Up</title>
    <style>
        .error-message {
            color: red;
            margin: 10px 0;
            padding: 10px;
            border: 1px solid red;
            background-color: #ffeeee;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input[type="text"],
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }
    </style>
</head>
<body>

<h2>Sign Up</h2>

<%-- Display error messages --%>
<c:if test="${not empty param.error}">
    <div class="error-message">
        <c:choose>
            <c:when test="${param.error == '1'}">
                Passwords do not match!
            </c:when>
            <c:when test="${param.error == '2'}">
                Server error. Please try again.
            </c:when>
            <c:when test="${param.error == '3'}">
                Please fill all fields!
            </c:when>
            <c:when test="${param.error == '4'}">
                Email already exists!
            </c:when>
        </c:choose>
    </div>
</c:if>

<form action="${pageContext.request.contextPath}/signup" method="POST" onsubmit="return validateForm()">
    <div class="form-group">
        <label for="fullname">Full Name</label>
        <input type="text" id="fullname" name="fullname"
               value="${param.fullname}" required>
    </div>

    <div class="form-group">
        <label for="email">Email</label>
        <input type="email" id="email" name="email"
               value="${param.email}" required>
    </div>

    <div class="form-group">
        <label for="password">Password</label>
        <input type="password" id="password" name="password" required>
    </div>

    <div class="form-group">
        <label for="confirm-password">Confirm Password</label>
        <input type="password" id="confirm-password" name="confirm-password" required>
    </div>

    <button type="submit">Sign Up</button>
</form>

<script>
    function validateForm() {
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirm-password').value;

        if (password !== confirmPassword) {
            alert('Passwords do not match!');
            return false;
        }
        return true;
    }
</script>

</body>
</html>