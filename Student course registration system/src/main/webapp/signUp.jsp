<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sign Up - Student Registration</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #4361ee;
            --secondary: #3f37c9;
            --accent: #4895ef;
            --light: #f8f9fa;
            --dark: #212529;
            --success: #4cc9f0;
            --danger: #f72585;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Segoe UI', system-ui, sans-serif;
            background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
            color: var(--light);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .signup-container {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
            border: 1px solid rgba(255, 255, 255, 0.18);
            width: 100%;
            max-width: 450px;
            padding: 40px;
            transition: all 0.3s ease;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
            font-size: 2rem;
            background: linear-gradient(to right, var(--accent), var(--success));
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
        }

        .error-message {
            background: rgba(247, 37, 133, 0.2);
            color: var(--light);
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 25px;
            text-align: center;
            border-left: 4px solid var(--danger);
        }

        .form-group {
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: rgba(255, 255, 255, 0.8);
        }

        input[type="text"],
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 15px;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 10px;
            color: var(--light);
            font-size: 1rem;
            transition: all 0.3s;
        }

        input:focus {
            outline: none;
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(72, 149, 239, 0.3);
        }

        .btn-signup {
            width: 100%;
            padding: 15px;
            background: linear-gradient(to right, var(--primary), var(--secondary));
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-top: 10px;
        }

        .btn-signup:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(67, 97, 238, 0.4);
        }

        .auth-links {
            margin-top: 20px;
            text-align: center;
        }

        .auth-links a {
            color: var(--accent);
            text-decoration: none;
            font-size: 0.9rem;
            transition: all 0.2s;
        }

        .auth-links a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="signup-container">
    <h2>Create Account</h2>

    <%-- Display errors --%>
    <% if (request.getAttribute("errors") != null) { %>
    <div class="error-message">
        <ul style="list-style: none; padding: 0;">
            <%
                List<String> errors = (List<String>) request.getAttribute("errors");
                for (String error : errors) {
            %>
            <li><i class="fas fa-exclamation-circle"></i> <%= error %></li>
            <% } %>
        </ul>
    </div>
    <% } %>

    <form action="signup" method="post">
        <div class="form-group">
            <label for="fullName"><i class="fas fa-user"></i> Full Name</label>
            <input type="text" id="fullName" name="fullName"
                   value="<%= request.getAttribute("fullName") != null ? request.getAttribute("fullName") : "" %>"
                   placeholder="Enter your full name" required>
        </div>

        <div class="form-group">
            <label for="email"><i class="fas fa-envelope"></i> Email</label>
            <input type="email" id="email" name="email"
                   value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>"
                   placeholder="Enter your email" required>
        </div>

        <div class="form-group">
            <label for="password"><i class="fas fa-lock"></i> Password (min 8 characters)</label>
            <input type="password" id="password" name="password"
                   placeholder="Enter your password" required minlength="8">
        </div>

        <div class="form-group">
            <label for="confirmPassword"><i class="fas fa-lock"></i> Confirm Password</label>
            <input type="password" id="confirmPassword" name="confirmPassword"
                   placeholder="Confirm your password" required minlength="8">
        </div>

        <button type="submit" class="btn-signup">
            <i class="fas fa-user-plus"></i> Sign Up
        </button>
    </form>

    <div class="auth-links">
        Already have an account? <a href="login.jsp"><i class="fas fa-sign-in-alt"></i> Login</a>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Client-side password validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;

            if (password !== confirmPassword) {
                e.preventDefault();
                alert('Passwords do not match!');
            }
        });
    });
</script>
</body>
</html>