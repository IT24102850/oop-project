<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<html>

<head>
    <title>Login - NexoraSkill</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="icon" type="image/png" href="./images/favicon.ico">
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@500;700&family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #00f2fe;
            --primary-dark: #00d9e6;
            --secondary: #4facfe;
            --dark: #0a0f24;
            --darker: #070b1a;
            --light: rgba(255, 255, 255, 0.9);
            --glass: rgba(15, 23, 42, 0.6);
            --glass-border: rgba(255, 255, 255, 0.1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: var(--dark);
            color: var(--light);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            overflow: hidden;
            position: relative;
        }

        /* Animated background elements */
        body::before, body::after {
            content: '';
            position: absolute;
            width: 300px;
            height: 300px;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(0, 242, 254, 0.15) 0%, rgba(0, 242, 254, 0) 70%);
            z-index: -1;
        }

        body::before {
            top: -100px;
            left: -100px;
            animation: float 15s infinite alternate ease-in-out;
        }

        body::after {
            bottom: -100px;
            right: -100px;
            animation: float 18s infinite alternate-reverse ease-in-out;
        }

        @keyframes float {
            0% { transform: translate(0, 0) scale(1); }
            50% { transform: translate(50px, 50px) scale(1.1); }
            100% { transform: translate(-50px, -50px) scale(0.9); }
        }

        .login-container {
            background: var(--glass);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            padding: 40px;
            border-radius: 20px;
            width: 100%;
            max-width: 450px;
            box-shadow: 0 25px 50px -12px rgba(0, 242, 254, 0.25);
            position: relative;
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .login-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(90deg, var(--primary), var(--secondary));
        }

        .login-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 30px 60px -12px rgba(0, 242, 254, 0.35);
        }

        h2 {
            font-family: 'Orbitron', sans-serif;
            text-align: center;
            margin-bottom: 30px;
            color: var(--primary);
            font-weight: 700;
            letter-spacing: 2px;
            text-transform: uppercase;
            position: relative;
        }

        h2::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 50px;
            height: 3px;
            background: linear-gradient(90deg, var(--primary), var(--secondary));
            border-radius: 3px;
        }

        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: rgba(255, 255, 255, 0.8);
        }

        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 15px 20px;
            border-radius: 10px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            background: rgba(10, 15, 30, 0.5);
            color: white;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        input[type="text"]:focus, input[type="password"]:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 2px rgba(0, 242, 254, 0.3);
        }

        /* Futuristic Toggle Switch */
        .toggle-container {
            display: flex;
            justify-content: center;
            margin-bottom: 30px;
            position: relative;
            background: rgba(10, 15, 30, 0.5);
            border-radius: 50px;
            padding: 5px;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .toggle-option {
            position: relative;
            z-index: 1;
            padding: 10px 25px;
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: center;
            flex: 1;
            color: rgba(255, 255, 255, 0.7);
            font-weight: 500;
        }

        .toggle-option.active {
            color: var(--dark);
        }

        .toggle-bg {
            position: absolute;
            top: 5px;
            left: 5px;
            height: calc(100% - 10px);
            width: calc(50% - 10px);
            background: linear-gradient(90deg, var(--primary), var(--secondary));
            border-radius: 50px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0, 242, 254, 0.3);
        }

        .toggle-container input[type="radio"] {
            position: absolute;
            opacity: 0;
            width: 0;
            height: 0;
        }

        .btn-login {
            width: 100%;
            padding: 15px;
            background: linear-gradient(90deg, var(--primary), var(--secondary));
            border: none;
            border-radius: 10px;
            color: var(--dark);
            font-weight: 600;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-top: 10px;
            position: relative;
            overflow: hidden;
        }

        .btn-login:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0, 242, 254, 0.3);
        }

        .btn-login:active {
            transform: translateY(0);
        }

        .btn-login::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, rgba(255, 255, 255, 0.1), rgba(255, 255, 255, 0.05));
            transform: translateX(-100%);
            transition: transform 0.4s ease;
        }

        .btn-login:hover::after {
            transform: translateX(0);
        }

        .error {
            color: #ff4d4d;
            margin-bottom: 15px;
            text-align: center;
            padding: 10px;
            background: rgba(255, 77, 77, 0.1);
            border-radius: 5px;
            border-left: 3px solid #ff4d4d;
            animation: shake 0.5s ease;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            20%, 60% { transform: translateX(-5px); }
            40%, 80% { transform: translateX(5px); }
        }

        .input-icon {
            position: absolute;
            right: 20px;
            top: 40px;
            color: rgba(255, 255, 255, 0.5);
        }

        .forgot-password {
            text-align: right;
            margin-top: -15px;
            margin-bottom: 20px;
        }

        .forgot-password a {
            color: rgba(255, 255, 255, 0.6);
            text-decoration: none;
            font-size: 14px;
            transition: color 0.3s ease;
        }

        .forgot-password a:hover {
            color: var(--primary);
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
        <div class="toggle-container">
            <div class="toggle-bg"></div>
            <label class="toggle-option active" id="adminOption">
                <input type="radio" name="userType" value="admin" checked>
                <span>Admin</span>
            </label>
            <label class="toggle-option" id="studentOption">
                <input type="radio" name="userType" value="student">
                <span>Student</span>
            </label>
        </div>

        <%-- Username/Email Input --%>
        <div class="form-group">
            <label id="usernameLabel" for="username">Username</label>
            <input type="text" id="username" name="username" placeholder="Enter your admin username" required>
            <i class="fas fa-user input-icon"></i>
        </div>

        <%-- Password Input --%>
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required>
            <i class="fas fa-lock input-icon"></i>
        </div>

        <div class="forgot-password">
            <a href="#">Forgot Password?</a>
        </div>

        <%-- Submit Button --%>
        <button type="submit" class="btn-login">
            <span>AUTHENTICATE</span>
            <i class="fas fa-arrow-right" style="margin-left: 10px;"></i>
        </button>
    </form>
</div>

<script>
    // Toggle switch functionality
    const adminOption = document.getElementById('adminOption');
    const studentOption = document.getElementById('studentOption');
    const toggleBg = document.querySelector('.toggle-bg');
    const usernameLabel = document.getElementById('usernameLabel');
    const usernameInput = document.getElementById('username');

    function updateToggle() {
        const adminRadio = adminOption.querySelector('input');
        const studentRadio = studentOption.querySelector('input');

        if (adminRadio.checked) {
            adminOption.classList.add('active');
            studentOption.classList.remove('active');
            toggleBg.style.transform = 'translateX(0)';
            usernameLabel.innerHTML = 'Username';
            usernameInput.placeholder = 'Enter your admin username';
        } else {
            adminOption.classList.remove('active');
            studentOption.classList.add('active');
            toggleBg.style.transform = 'translateX(100%)';
            usernameLabel.innerHTML = 'Email';
            usernameInput.placeholder = 'Enter your email';
        }
    }

    adminOption.addEventListener('click', function() {
        adminOption.querySelector('input').checked = true;
        updateToggle();
    });

    studentOption.addEventListener('click', function() {
        studentOption.querySelector('input').checked = true;
        updateToggle();
    });

    // Initial update
    updateToggle();

    // Add focus effects to inputs
    const inputs = document.querySelectorAll('input[type="text"], input[type="password"]');
    inputs.forEach(input => {
        input.addEventListener('focus', function() {
            this.parentElement.querySelector('i').style.color = 'var(--primary)';
        });

        input.addEventListener('blur', function() {
            this.parentElement.querySelector('i').style.color = 'rgba(255, 255, 255, 0.5)';
        });
    });
</script>
</body>
</html>