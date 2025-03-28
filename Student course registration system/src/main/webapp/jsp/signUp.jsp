<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Student Registration</title>
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

        .login-container {
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

        input[type="text"]:focus,
        input[type="password"]:focus {
            outline: none;
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(72, 149, 239, 0.3);
        }

        /* Futuristic Toggle Switch */
        .toggle-container {
            display: flex;
            background: rgba(0, 0, 0, 0.3);
            border-radius: 50px;
            padding: 5px;
            margin: 20px 0;
            position: relative;
            overflow: hidden;
            box-shadow: inset 0 0 10px rgba(0, 0, 0, 0.5);
        }

        .toggle-option {
            flex: 1;
            text-align: center;
            padding: 12px;
            z-index: 2;
            cursor: pointer;
            transition: all 0.4s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            color: rgba(255, 255, 255, 0.7);
            position: relative;
        }

        .toggle-option input[type="radio"] {
            position: absolute;
            opacity: 0;
            width: 0;
            height: 0;
        }

        .toggle-option .icon {
            font-size: 1.2rem;
            margin-bottom: 5px;
            transition: all 0.3s;
        }

        .toggle-option .text {
            font-size: 0.9rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .toggle-option input:checked + label {
            color: white;
        }

        .toggle-glider {
            position: absolute;
            height: calc(100% - 10px);
            width: calc(50% - 5px);
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            border-radius: 50px;
            transition: all 0.4s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            z-index: 1;
            box-shadow: 0 4px 15px rgba(67, 97, 238, 0.4);
            top: 5px;
            left: 5px;
        }

        #student:checked ~ .toggle-glider {
            transform: translateX(100%);
            background: linear-gradient(135deg, var(--success), #38b000);
        }

        .btn-login {
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

        .btn-login:hover {
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
    </style>
</head>
<body>
<div class="login-container">
    <h2>Welcome Back</h2>

    <c:if test="${not empty error}">
        <div class="error-message">
            <i class="fas fa-exclamation-circle"></i> ${error}
        </div>
    </c:if>

    <form id="loginForm" action="${pageContext.request.contextPath}/auth" method="post">
        <div class="form-group">
            <label for="username"><i class="fas fa-user"></i> Username</label>
            <input type="text" id="username" name="username" placeholder="Enter your username" required>
        </div>

        <div class="form-group">
            <label for="password"><i class="fas fa-lock"></i> Password</label>
            <input type="password" id="password" name="password" placeholder="Enter your password" required>
        </div>

        <!-- Futuristic Toggle Switch -->
        <div class="form-group">
            <label>Select Role</label>
            <div class="toggle-container">
                <div class="toggle-option">
                    <input type="radio" id="admin" name="userType" value="admin" checked>
                    <label for="admin">
                        <div class="icon"><i class="fas fa-user-shield"></i></div>
                        <div class="text">Admin</div>
                    </label>
                </div>

                <div class="toggle-option">
                    <input type="radio" id="student" name="userType" value="student">
                    <label for="student">
                        <div class="icon"><i class="fas fa-user-graduate"></i></div>
                        <div class="text">Student</div>
                    </label>
                </div>
                <div class="toggle-glider"></div>
            </div>
        </div>

        <button type="submit" class="btn-login">
            <i class="fas fa-sign-in-alt"></i> Login
        </button>

        <div class="auth-links">
            <a href="#"><i class="fas fa-question-circle"></i> Forgot Password?</a>
            <span style="color: rgba(255,255,255,0.5)"> | </span>
            <a href="#"><i class="fas fa-user-plus"></i> Create Account</a>
        </div>
    </form>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const toggleOptions = document.querySelectorAll('.toggle-option input[type="radio"]');
        const toggleGlider = document.querySelector('.toggle-glider');

        // Initialize glider position
        const initialChecked = document.querySelector('input[name="userType"]:checked');
        if (initialChecked.id === 'student') {
            toggleGlider.style.transform = 'translateX(100%)';
            toggleGlider.style.background = 'linear-gradient(135deg, #a8ff78, #78ffd6)';
        }

        // Handle toggle changes
        toggleOptions.forEach(option => {
            option.addEventListener('change', function() {
                if (this.id === 'student') {
                    toggleGlider.style.transform = 'translateX(100%)';
                    toggleGlider.style.background = 'linear-gradient(135deg, #a8ff78, #78ffd6)';
                } else {
                    toggleGlider.style.transform = 'translateX(0)';
                    toggleGlider.style.background = 'linear-gradient(135deg, #00b4db, #0083b0)';
                }
            });
        });

        // Form submission handler
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            const userType = document.querySelector('input[name="userType"]:checked').value;
            console.log('Submitting form with user type:', userType);
            // Add any additional validation here
        });
    });
</script>
</body>
</html>