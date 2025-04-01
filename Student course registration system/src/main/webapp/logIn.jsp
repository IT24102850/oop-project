<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - NexoraSkill</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@500;700&family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #00f2fe;
            --secondary-color: #4facfe;
            --accent-color: #ff4d7e;
            --dark-color: #0a0f24;
            --darker-color: #050916;
            --text-color: #ffffff;
            --text-muted: rgba(255,255,255,0.7);
            --glass-bg: rgba(255, 255, 255, 0.08);
            --border-radius: 12px;
            --box-shadow: 0 8px 30px rgba(0, 0, 0, 0.4);
            --transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: radial-gradient(ellipse at bottom, var(--darker-color) 0%, var(--dark-color) 100%);
            color: var(--text-color);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            position: relative;
            overflow: hidden;
        }

        /* Particle Background */
        .particles {
            position: absolute;
            width: 100%;
            height: 100%;
            overflow: hidden;
            z-index: 0;
        }

        .particle {
            position: absolute;
            width: 2px;
            height: 2px;
            background: var(--primary-color);
            border-radius: 50%;
            opacity: 0.6;
            filter: blur(1px);
            animation: particleMove linear infinite;
        }

        @keyframes particleMove {
            0% { transform: translateY(0) translateX(0); opacity: 0; }
            10% { opacity: 0.6; }
            90% { opacity: 0.6; }
            100% { transform: translateY(-1000px) translateX(200px); opacity: 0; }
        }

        /* Holographic Effect */
        .holographic-circle {
            position: absolute;
            width: 400px;
            height: 400px;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(0, 242, 254, 0.1) 0%, transparent 70%);
            box-shadow: 0 0 80px rgba(0, 242, 254, 0.2);
            animation: pulse 6s infinite alternate;
            z-index: -1;
        }

        .holographic-circle:before {
            content: '';
            position: absolute;
            top: 10%;
            left: 10%;
            right: 10%;
            bottom: 10%;
            border-radius: 50%;
            border: 2px solid rgba(0, 242, 254, 0.3);
            animation: rotate 20s linear infinite reverse;
        }

        .holographic-circle:after {
            content: '';
            position: absolute;
            top: 20%;
            left: 20%;
            right: 20%;
            bottom: 20%;
            border-radius: 50%;
            border: 1px dashed rgba(0, 242, 254, 0.2);
            animation: rotate 30s linear infinite;
        }

        @keyframes pulse {
            0% { box-shadow: 0 0 40px rgba(0, 242, 254, 0.2); }
            100% { box-shadow: 0 0 80px rgba(0, 242, 254, 0.4); }
        }

        @keyframes rotate {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Login Container - More Compact */
        .login-container {
            background: rgba(15, 23, 42, 0.8);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            border: 1px solid rgba(0, 242, 254, 0.2);
            width: 100%;
            max-width: 420px;
            padding: 35px;
            transition: var(--transition);
            position: relative;
            overflow: hidden;
            z-index: 2;
        }

        .login-container:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(0, 242, 254, 0.1), transparent);
            z-index: -1;
            opacity: 0;
            transition: var(--transition);
        }

        .login-container:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.5);
            border-color: rgba(0, 242, 254, 0.4);
        }

        .login-container:hover:before {
            opacity: 0.8;
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            font-family: 'Orbitron', sans-serif;
            font-size: 2rem;
            font-weight: 700;
            letter-spacing: 1.5px;
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            text-shadow: 0 0 20px rgba(0, 242, 254, 0.3);
            position: relative;
            animation: textGlow 3s infinite alternate;
        }

        h2:after {
            content: '';
            position: absolute;
            bottom: -12px;
            left: 50%;
            transform: translateX(-50%);
            width: 60px;
            height: 3px;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            border-radius: 2px;
        }

        @keyframes textGlow {
            0% { text-shadow: 0 0 8px rgba(0, 242, 254, 0.3); }
            100% { text-shadow: 0 0 25px rgba(0, 242, 254, 0.6); }
        }


        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(15px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .form-group {
            margin-bottom: 20px;
            position: relative;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--text-muted);
            font-size: 0.95rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 14px 16px;
            background: var(--glass-bg);
            border: 1px solid rgba(0, 242, 254, 0.2);
            border-radius: var(--border-radius);
            color: var(--text-color);
            font-size: 0.95rem;
            transition: var(--transition);
            backdrop-filter: blur(5px);
        }

        input[type="text"]:focus,
        input[type="password"]:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 2px rgba(0, 242, 254, 0.3);
            background: rgba(0, 242, 254, 0.05);
        }

        /* Fixed Toggle Switch */
        .toggle-container {
            display: flex;
            background: rgba(0, 0, 0, 0.3);
            border-radius: 50px;
            padding: 4px;
            margin: 20px 0;
            position: relative;
            overflow: hidden;
            box-shadow: inset 0 0 8px rgba(0, 0, 0, 0.5);
            border: 1px solid rgba(0, 242, 254, 0.2);
        }

        .toggle-option {
            flex: 1;
            text-align: center;
            padding: 10px;
            z-index: 2;
            cursor: pointer;
            transition: var(--transition);
            color: var(--text-muted);
            position: relative;
        }

        .toggle-option input[type="radio"] {
            position: absolute;
            opacity: 0;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            cursor: pointer;
        }

        .toggle-option .icon {
            font-size: 1.2rem;
            margin-bottom: 5px;
            transition: var(--transition);
        }

        .toggle-option .text {
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-family: 'Orbitron', sans-serif;
        }

        .toggle-option input:checked + label {
            color: white;
        }

        .toggle-option:hover {
            color: var(--primary-color);
        }

        .toggle-glider {
            position: absolute;
            height: calc(100% - 8px);
            width: calc(50% - 4px);
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            border-radius: 50px;
            transition: var(--transition);
            z-index: 1;
            box-shadow: 0 3px 15px rgba(0, 242, 254, 0.4);
            top: 4px;
            left: 4px;
        }

        #student:checked ~ .toggle-glider {
            transform: translateX(100%);
            background: linear-gradient(135deg, var(--accent-color), #ff758c);
        }

        /* Login Button */
        .btn-login {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: var(--dark-color);
            border: none;
            border-radius: var(--border-radius);
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-top: 15px;
            font-family: 'Orbitron', sans-serif;
            position: relative;
            overflow: hidden;
            z-index: 1;
            box-shadow: 0 8px 20px rgba(0, 242, 254, 0.4);
        }

        .btn-login:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 0;
            height: 100%;
            background: linear-gradient(135deg, var(--secondary-color), var(--primary-color));
            transition: var(--transition);
            z-index: -1;
        }

        .btn-login:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 25px rgba(0, 242, 254, 0.6);
        }

        .btn-login:hover:before {
            width: 100%;
        }

        /* Auth Links */
        .auth-links {
            margin-top: 20px;
            text-align: center;
            display: flex;
            justify-content: center;
            gap: 12px;
            flex-wrap: wrap;
        }

        .auth-links a {
            color: var(--text-muted);
            text-decoration: none;
            font-size: 0.9rem;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .auth-links a:hover {
            color: var(--primary-color);
            transform: translateY(-2px);
        }

        .auth-links span {
            color: rgba(255,255,255,0.3);
        }

        /* Floating Elements */
        .floating-elements {
            position: absolute;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: -1;
        }

        .floating-element {
            position: absolute;
            background: var(--glass-bg);
            backdrop-filter: blur(5px);
            border: 1px solid rgba(0, 242, 254, 0.3);
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 1.2rem;
            color: var(--primary-color);
            animation: float 6s ease-in-out infinite;
        }

        .floating-element:nth-child(1) {
            width: 50px;
            height: 50px;
            top: 15%;
            left: 10%;
            animation-delay: 0s;
        }

        .floating-element:nth-child(2) {
            width: 60px;
            height: 60px;
            top: 70%;
            left: 80%;
            animation-delay: 1s;
        }

        .floating-element:nth-child(3) {
            width: 35px;
            height: 35px;
            top: 80%;
            left: 15%;
            animation-delay: 2s;
        }

        @keyframes float {
            0% { transform: translateY(0) rotate(0deg); }
            50% { transform: translateY(-15px) rotate(3deg); }
            100% { transform: translateY(0) rotate(0deg); }
        }

        /* Responsive Design */
        @media (max-width: 480px) {
            .login-container {
                padding: 30px 20px;
                max-width: 380px;
            }

            h2 {
                font-size: 1.7rem;
            }

            .auth-links {
                flex-direction: column;
                gap: 10px;
            }

            .auth-links span {
                display: none;
            }
        }
    </style>
</head>
<body>
<!-- Background Elements -->
<div class="particles" id="particles-js"></div>
<div class="holographic-circle" style="top: -150px; right: -150px;"></div>
<div class="floating-elements">
    <div class="floating-element"><i class="fas fa-atom"></i></div>
    <div class="floating-element"><i class="fas fa-code"></i></div>
    <div class="floating-element"><i class="fas fa-microchip"></i></div>
</div>

<!-- Login Container -->
<div class="login-container">
    <h2>ACCESS PORTAL</h2>



    <form id="loginForm" action="${pageContext.request.contextPath}/auth" method="post">
        <div class="form-group">
            <label for="username"><i class="fas fa-user-astronaut"></i> USER ID</label>
            <input type="text" id="username" name="username" placeholder="Enter your credentials" required>
        </div>

        <div class="form-group">
            <label for="password"><i class="fas fa-key"></i> ACCESS CODE</label>
            <input type="password" id="password" name="password" placeholder="Enter your secure code" required>
        </div>

        <!-- Fixed Toggle Switch -->
        <div class="form-group">
            <label><i class="fas fa-user-tag"></i> AUTHORIZATION LEVEL</label>
            <div class="toggle-container" id="toggleContainer">
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
            <i class="fas fa-fingerprint"></i> AUTHENTICATE
        </button>

        <div class="auth-links">
            <a href="#"><i class="fas fa-unlock-alt"></i> Recover Access</a>
            <span>|</span>
            <a href="#"><i class="fas fa-user-plus"></i> Request Authorization</a>
        </div>
    </form>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Particle System
        const particlesContainer = document.getElementById('particles-js');
        const particleCount = 60;

        for (let i = 0; i < particleCount; i++) {
            const particle = document.createElement('div');
            particle.classList.add('particle');

            particle.style.left = Math.random() * 100 + '%';
            particle.style.top = Math.random() * 100 + '%';
            particle.style.width = (Math.random() * 3 + 1) + 'px';
            particle.style.height = particle.style.width;
            particle.style.opacity = Math.random() * 0.7 + 0.1;
            particle.style.animationDuration = (Math.random() * 20 + 10) + 's';
            particle.style.animationDelay = (Math.random() * 5) + 's';

            particlesContainer.appendChild(particle);
        }

        // Fixed Toggle Switch Functionality
        const toggleContainer = document.getElementById('toggleContainer');
        const toggleOptions = toggleContainer.querySelectorAll('input[type="radio"]');
        const toggleGlider = toggleContainer.querySelector('.toggle-glider');

        // Set initial position based on checked option
        updateToggleGlider();

        // Update on change
        toggleOptions.forEach(option => {
            option.addEventListener('change', updateToggleGlider);
        });

        function updateToggleGlider() {
            const checkedOption = toggleContainer.querySelector('input[type="radio"]:checked');
            if (checkedOption.id === 'student') {
                toggleGlider.style.transform = 'translateX(100%)';
                toggleGlider.style.background = 'linear-gradient(135deg, var(--accent-color), #ff758c)';
            } else {
                toggleGlider.style.transform = 'translateX(0)';
                toggleGlider.style.background = 'linear-gradient(135deg, var(--primary-color), var(--secondary-color))';
            }
        }

        // Form submission animation
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            const btn = this.querySelector('.btn-login');
            btn.innerHTML = '<i class="fas fa-circle-notch fa-spin"></i> VERIFYING...';
            btn.style.pointerEvents = 'none';
        });
    });
</script>
</body>
</html>