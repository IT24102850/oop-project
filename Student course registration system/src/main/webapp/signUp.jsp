<%@ page import="java.io.*, java.util.*, java.util.UUID" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Handle form submission
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        // Generate random student ID (8 alphanumeric characters)
        String studentId = UUID.randomUUID().toString().substring(0, 8).toUpperCase();
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Basic validation
        List<String> errors = new ArrayList<>();

        if (name == null || name.trim().isEmpty()) {
            errors.add("Name is required");
        }

        if (email == null || email.trim().isEmpty()) {
            errors.add("Email is required");
        } else if (!email.contains("@")) {
            errors.add("Invalid email format");
        }

        if (password == null || password.trim().isEmpty()) {
            errors.add("Password is required");
        } else if (!password.equals(confirmPassword)) {
            errors.add("Passwords do not match");
        }

        // Check if email already exists
        if (errors.isEmpty()) {
            if (emailExists(email)) {
                errors.add("Email already registered");
            }
        }

        // If no errors, save student data
        if (errors.isEmpty()) {
            boolean success = saveStudent(studentId, name, email, password);
            if (success) {
                response.sendRedirect("logIn.jsp?signup=success&generatedId=" + studentId);
                return;
            } else {
                errors.add("Registration failed. Please try again.");
            }
        }

        // Display errors if any
        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("name", name);
            request.setAttribute("email", email);
        }
    }
%>

<%!
    // Method to check if email exists
    private boolean emailExists(String email) {
        String filePath = getServletContext().getRealPath("/") + "students.txt";
        File file = new File(filePath);

        if (!file.exists()) {
            return false;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length > 2 && parts[2].equalsIgnoreCase(email)) {
                    return true;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return false;
    }

    // Method to save student data
    private boolean saveStudent(String studentId, String name, String email, String password) {
        String filePath = getServletContext().getRealPath("/") + "WEB-INF/data/students.txt";
        File file = new File(filePath);

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file, true))) {
            // Format: studentId,name,email,password
            writer.write(studentId + "," + name + "," + email + "," + password);
            writer.newLine();
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NexoraSkill | Student Registration</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="icon" type="image/png" href="./images/favicon.ico">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Orbitron:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
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
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            position: relative;
            overflow: hidden;
        }

        body:before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(0, 242, 254, 0.05) 0%, transparent 70%);
            animation: rotate 60s linear infinite;
            z-index: -1;
        }

        @keyframes rotate {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .container {
            width: 100%;
            max-width: 600px;
            background: var(--card-bg);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            border-radius: var(--border-radius);
            padding: 50px;
            box-shadow: var(--box-shadow);
            border: 1px solid rgba(0, 242, 254, 0.2);
            position: relative;
            overflow: hidden;
            z-index: 1;
            animation: fadeInUp 1s ease-out;
        }

        .container:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(0, 242, 254, 0.1), transparent);
            z-index: -1;
        }

        h1 {
            font-family: 'Orbitron', sans-serif;
            font-weight: 700;
            letter-spacing: 1.5px;
            text-align: center;
            margin-bottom: 40px;
            font-size: 2.5rem;
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-shadow: 0 0 30px rgba(0, 242, 254, 0.3);
            position: relative;
        }

        h1:after {
            content: '';
            position: absolute;
            bottom: -15px;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 3px;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            border-radius: 2px;
        }

        .form-group {
            margin-bottom: 30px;
            position: relative;
        }

        label {
            display: block;
            margin-bottom: 10px;
            font-weight: 500;
            color: var(--primary-color);
            font-size: 1.1rem;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 15px 20px;
            background: var(--glass-bg);
            border: 1px solid rgba(0, 242, 254, 0.3);
            border-radius: var(--border-radius);
            color: var(--text-color);
            font-size: 1rem;
            transition: var(--transition);
            backdrop-filter: blur(5px);
        }

        input[type="text"]:focus,
        input[type="email"]:focus,
        input[type="password"]:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 15px var(--glow-color);
        }

        input[type="text"]::placeholder,
        input[type="email"]::placeholder,
        input[type="password"]::placeholder {
            color: var(--text-muted);
        }

        .error {
            color: var(--accent-color);
            margin-bottom: 25px;
            animation: fadeInUp 0.5s ease-out;
        }

        .error ul {
            list-style: none;
            margin: 0;
            padding: 0;
        }

        .error li {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 8px;
        }

        .error li:before {
            content: '\f06a';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
        }

        button {
            width: 100%;
            padding: 18px;
            border-radius: 50px;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: var(--dark-color);
            border: none;
            font-weight: 600;
            font-size: 1.1rem;
            cursor: pointer;
            transition: var(--transition);
            margin-top: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
            position: relative;
            overflow: hidden;
            z-index: 1;
            box-shadow: 0 10px 25px rgba(0, 242, 254, 0.3);
        }

        button:before {
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

        button:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(0, 242, 254, 0.5);
        }

        button:hover:before {
            width: 100%;
        }

        .login-link {
            text-align: center;
            margin-top: 30px;
            color: var(--text-muted);
        }

        .login-link a {
            color: var(--primary-color);
            text-decoration: none;
            transition: var(--transition);
            font-weight: 500;
        }

        .login-link a:hover {
            text-shadow: 0 0 10px var(--glow-color);
        }

        .floating-elements {
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
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
            font-size: 1.5rem;
            color: var(--primary-color);
            animation: float 6s ease-in-out infinite;
        }

        .floating-element:nth-child(1) {
            width: 60px;
            height: 60px;
            top: 10%;
            left: 5%;
            animation-delay: 0s;
        }

        .floating-element:nth-child(2) {
            width: 80px;
            height: 80px;
            top: 70%;
            left: 10%;
            animation-delay: 1s;
        }

        .floating-element:nth-child(3) {
            width: 40px;
            height: 40px;
            top: 30%;
            left: 80%;
            animation-delay: 2s;
        }

        .particles {
            position: absolute;
            width: 100%;
            height: 100%;
            overflow: hidden;
            z-index: -2;
        }

        .particle {
            position: absolute;
            width: 3px;
            height: 3px;
            background: var(--primary-color);
            border-radius: 50%;
            opacity: 0.6;
            filter: blur(1px);
            animation: particleMove linear infinite;
        }

        @keyframes particleMove {
            0% {
                transform: translateY(0) translateX(0);
                opacity: 0;
            }
            10% {
                opacity: 0.6;
            }
            90% {
                opacity: 0.6;
            }
            100% {
                transform: translateY(-1000px) translateX(200px);
                opacity: 0;
            }
        }

        @keyframes float {
            0% {
                transform: translateY(0) rotate(0deg);
            }
            50% {
                transform: translateY(-20px) rotate(5deg);
            }
            100% {
                transform: translateY(0) rotate(0deg);
            }
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @media (max-width: 768px) {
            .container {
                padding: 30px;
            }

            h1 {
                font-size: 2rem;
            }
        }

        @media (max-width: 480px) {
            .container {
                padding: 25px 20px;
            }

            h1 {
                font-size: 1.8rem;
            }

            input[type="text"],
            input[type="email"],
            input[type="password"] {
                padding: 12px 15px;
            }

            button {
                padding: 15px;
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="floating-elements">
        <div class="floating-element"><i class="fas fa-atom"></i></div>
        <div class="floating-element"><i class="fas fa-code"></i></div>
        <div class="floating-element"><i class="fas fa-microchip"></i></div>
    </div>
    <div class="particles" id="particles-js"></div>

    <h1 class="animate__animated animate__fadeIn">Create Account</h1>

    <%-- Display errors if any --%>
    <% if (request.getAttribute("errors") != null) { %>
    <div class="error animate__animated animate__fadeIn">
        <ul>
            <% for (String error : (List<String>) request.getAttribute("errors")) { %>
            <li><%= error %></li>
            <% } %>
        </ul>
    </div>
    <% } %>

    <form method="post">
        <div class="form-group animate__animated animate__fadeIn animate__delay-1s">
            <label for="name"><i class="fas fa-user"></i> Full Name</label>
            <input type="text" id="name" name="name" placeholder="Enter your full name"
                   value="<%= request.getAttribute("name") != null ? request.getAttribute("name") : "" %>" required>
        </div>

        <div class="form-group animate__animated animate__fadeIn animate__delay-2s">
            <label for="email"><i class="fas fa-envelope"></i> Email</label>
            <input type="email" id="email" name="email" placeholder="Enter your email"
                   value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>" required>
        </div>

        <div class="form-group animate__animated animate__fadeIn animate__delay-3s">
            <label for="password"><i class="fas fa-lock"></i> Password</label>
            <input type="password" id="password" name="password" placeholder="Create a password" required>
        </div>

        <div class="form-group animate__animated animate__fadeIn animate__delay-4s">
            <label for="confirmPassword"><i class="fas fa-lock"></i> Confirm Password</label>
            <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm your password" required>
        </div>

        <button type="submit" class="animate__animated animate__fadeIn animate__delay-5s">
            <i class="fas fa-user-astronaut"></i> Register Now
        </button>
    </form>

    <div class="login-link animate__animated animate__fadeIn animate__delay-6s">
        Already have an account? <a href="logIn.jsp"><i class="fas fa-sign-in-alt"></i> Login here</a>
    </div>
</div>

<script>
    // Particle System
    document.addEventListener('DOMContentLoaded', function() {
        const particlesContainer = document.getElementById('particles-js');
        const particleCount = 80;

        for (let i = 0; i < particleCount; i++) {
            const particle = document.createElement('div');
            particle.classList.add('particle');

            // Random position
            particle.style.left = Math.random() * 100 + '%';
            particle.style.top = Math.random() * 100 + '%';

            // Random size
            const size = Math.random() * 4 + 1;
            particle.style.width = size + 'px';
            particle.style.height = size + 'px';

            // Random opacity
            particle.style.opacity = Math.random() * 0.7 + 0.1;

            // Random animation duration
            particle.style.animationDuration = Math.random() * 25 + 15 + 's';
            particle.style.animationDelay = Math.random() * 5 + 's';

            particlesContainer.appendChild(particle);
        }
    });
</script>
</body>
</html>