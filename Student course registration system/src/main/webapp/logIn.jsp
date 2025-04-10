<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login - NexoraSkill</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@500;700&family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        /* Minimal CSS for functionality; integrate with your existing styles */
        body {
            font-family: 'Poppins', sans-serif;
            background: #0a0f24;
            color: #ffffff;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .login-container {
            background: rgba(15, 23, 42, 0.8);
            padding: 30px;
            border-radius: 12px;
            width: 100%;
            max-width: 400px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        .toggle-container {
            display: flex;
            justify-content: space-around;
            margin-bottom: 20px;
        }
        .btn-login {
            width: 100%;
            padding: 10px;
            background: #00f2fe;
            border: none;
            border-radius: 5px;
            color: #0a0f24;
            font-weight: 600;
        }
        .error {
            color: red;
            margin-bottom: 10px;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="login-container">
    <h2>ACCESS PORTAL</h2>

    <%-- Display error message if login fails --%>
    <% if (request.getAttribute("error") != null) { %>
    <div class="error"><%= request.getAttribute("error") %></div>
    <% } %>

    <form id="loginForm" action="${pageContext.request.contextPath}/auth" method="post">
        <%-- User Type Toggle --%>
        <div class="form-group toggle-container">
            <label>
                <input type="radio" name="userType" value="admin" checked onclick="updateInputLabels()"> Admin
            </label>
            <label>
                <input type="radio" name="userType" value="student" onclick="updateInputLabels()"> Student
            </label>
        </div>

        <%-- Username/Email Input --%>
        <div class="form-group">
            <label id="usernameLabel" for="username">Username</label>
            <input type="text" id="username" name="username" placeholder="Enter your admin username" required>
        </div>

        <%-- Password Input --%>
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required>
        </div>

        <%-- Submit Button --%>
        <button type="submit" class="btn-login">AUTHENTICATE</button>
    </form>
</div>

<script>
    function updateInputLabels() {
        var userType = document.querySelector('input[name="userType"]:checked').value;
        var usernameLabel = document.getElementById('usernameLabel');
        var usernameInput = document.getElementById('username');
        if (userType === 'admin') {
            usernameLabel.innerHTML = 'Username';
            usernameInput.placeholder = 'Enter your admin username';
        } else if (userType === 'student') {
            usernameLabel.innerHTML = 'Email';
            usernameInput.placeholder = 'Enter your email';
        }
    }
    // Initial update based on default selection
    updateInputLabels();
</script>
</body>
</html>