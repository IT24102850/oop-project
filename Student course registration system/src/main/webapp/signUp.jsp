<%@ page import="java.io.*, java.util.*, javax.servlet.ServletContext" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isErrorPage="false" %>

<%!
    // Constants for file path and password hashing
    private static final String DATA_FILE = "/WEB-INF/user_data.txt";
    private static final String DEFAULT_ROLE = "student";

    // Method to check if email exists
    private boolean emailExists(HttpServletRequest request, String email) throws IOException {
        ServletContext context = request.getServletContext();
        String filePath = context.getRealPath(DATA_FILE);
        File file = new File(filePath);

        if (!file.exists()) {
            return false;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|");
                if (parts.length > 2 && parts[2].equalsIgnoreCase(email)) {
                    return true;
                }
            }
        }
        return false;
    }

    // Method to save user data with basic password hashing
    private boolean saveUser(HttpServletRequest request, String name, String email, String password) throws IOException {
        ServletContext context = request.getServletContext();
        String filePath = context.getRealPath(DATA_FILE);
        File file = new File(filePath);

        // Create parent directories if they don't exist
        if (!file.getParentFile().exists()) {
            file.getParentFile().mkdirs();
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file, true))) {
            // Generate a simple ID (timestamp)
            String id = String.valueOf(System.currentTimeMillis());

            // Basic password hashing (in a real app, use proper hashing like BCrypt)
            String hashedPassword = Integer.toString(password.hashCode());

            // Format: id|name|email|password|role|active|registrationDate
            String userData = String.join("|",
                    id,
                    sanitizeInput(name),
                    sanitizeInput(email),
                    hashedPassword,
                    DEFAULT_ROLE,
                    "true",
                    new Date().toString());

            writer.write(userData);
            writer.newLine();
            return true;
        }
    }

    // Basic input sanitization
    private String sanitizeInput(String input) {
        if (input == null) return "";
        return input.replace("|", "").replace("\n", "").trim();
    }
%>

<%
    // Initialize error list
    List<String> errors = new ArrayList<>();

    // Handle form submission
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        // Get and sanitize parameters
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validation
        if (name == null || name.trim().isEmpty()) {
            errors.add("Name is required");
        } else if (name.length() > 100) {
            errors.add("Name must be less than 100 characters");
        }

        if (email == null || email.trim().isEmpty()) {
            errors.add("Email is required");
        } else if (!email.matches("^[\\w-.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
            errors.add("Invalid email format");
        } else if (email.length() > 255) {
            errors.add("Email must be less than 255 characters");
        }

        if (password == null || password.trim().isEmpty()) {
            errors.add("Password is required");
        } else if (password.length() < 8) {
            errors.add("Password must be at least 8 characters");
        } else if (password.length() > 100) {
            errors.add("Password must be less than 100 characters");
        } else if (!password.equals(confirmPassword)) {
            errors.add("Passwords do not match");
        }

        // Check if email already exists
        if (errors.isEmpty()) {
            try {
                if (emailExists(request, email)) {
                    errors.add("Email already registered");
                }
            } catch (IOException e) {
                errors.add("System error during registration. Please try again.");
                e.printStackTrace();
            }
        }

        // If no errors, save user data
        if (errors.isEmpty()) {
            try {
                boolean success = saveUser(request, name, email, password);
                if (success) {
                    response.sendRedirect(request.getContextPath() + "/login.jsp?signup=success");
                    return;
                } else {
                    errors.add("Registration failed. Please try again.");
                }
            } catch (IOException e) {
                errors.add("System error during registration. Please try again.");
                e.printStackTrace();
            }
        }

        // Store values for re-display
        request.setAttribute("errors", errors);
        request.setAttribute("name", name);
        request.setAttribute("email", email);
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Neon Registration Portal</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #00dbde;
            --primary-dark: #00b4d8;
            --secondary: #0077b6;
            --accent: #90e0ef;
            --dark: #03045e;
            --light: #caf0f8;
            --success: #4cc9f0;
            --danger: #f72585;
            --warning: #ff9e00;
            --glass-bg: rgba(202, 240, 248, 0.1);
            --glass-border: rgba(202, 240, 248, 0.2);
            --glass-shadow: 0 8px 32px 0 rgba(0, 123, 182, 0.37);
            --text-primary: rgba(255, 255, 255, 0.95);
            --text-secondary: rgba(255, 255, 255, 0.7);
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Orbitron', 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #03045e, #023e8a, #0077b6);
            color: var(--text-primary);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            line-height: 1.6;
        }

        @font-face {
            font-family: 'Orbitron';
            src: url('https://fonts.googleapis.com/css2?family=Orbitron:wght@400;500;700&display=swap');
        }

        .container {
            background: var(--glass-bg);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            border-radius: 20px;
            box-shadow: var(--glass-shadow);
            border: 1px solid var(--glass-border);
            width: 100%;
            max-width: 500px;
            padding: 2.5rem;
            transition: all 0.3s ease;
            animation: floatIn 0.8s ease-out;
            position: relative;
            overflow: hidden;
        }

        @keyframes floatIn {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .container::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(
                    to bottom right,
                    rgba(0, 219, 222, 0.1),
                    rgba(0, 180, 216, 0.05),
                    transparent
            );
            transform: rotate(30deg);
            z-index: -1;
        }

        h1 {
            text-align: center;
            margin-bottom: 2rem;
            font-size: 2.2rem;
            background: linear-gradient(to right, var(--primary), var(--accent));
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            font-weight: 700;
            letter-spacing: 1px;
            text-transform: uppercase;
            position: relative;
            padding-bottom: 10px;
        }

        h1::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 25%;
            width: 50%;
            height: 3px;
            background: linear-gradient(to right, transparent, var(--primary), transparent);
            border-radius: 3px;
        }

        .notification {
            padding: 1rem;
            border-radius: 10px;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            animation: slideDown 0.4s ease-out;
            border-left: 4px solid;
        }

        @keyframes slideDown {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .error-message {
            background: rgba(247, 37, 133, 0.15);
            border-color: var(--danger);
            color: var(--text-primary);
        }

        .success-message {
            background: rgba(76, 201, 240, 0.15);
            border-color: var(--success);
            color: var(--text-primary);
        }

        .form-group {
            margin-bottom: 1.5rem;
            position: relative;
        }

        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: var(--accent);
            font-size: 0.9rem;
            letter-spacing: 0.5px;
        }

        .input-wrapper {
            position: relative;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 1rem 1rem 1rem 3rem;
            background: rgba(0, 0, 0, 0.2);
            border: 1px solid rgba(202, 240, 248, 0.3);
            border-radius: 8px;
            color: var(--text-primary);
            font-size: 1rem;
            transition: all 0.3s;
            letter-spacing: 0.5px;
        }

        .input-icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--accent);
            transition: all 0.3s;
        }

        input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(0, 219, 222, 0.3);
            background: rgba(0, 0, 0, 0.3);
        }

        input:focus + .input-icon {
            color: var(--primary);
        }

        /* Password visibility toggle */
        .password-toggle {
            position: absolute;
            right: 1rem;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: var(--text-secondary);
            transition: all 0.3s;
        }

        .password-toggle:hover {
            color: var(--primary);
        }

        .password-hint {
            font-size: 0.75rem;
            color: var(--text-secondary);
            margin-top: 0.5rem;
            font-style: italic;
        }

        /* Submit button */
        .btn-submit {
            width: 100%;
            padding: 1rem;
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: var(--dark);
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-top: 1rem;
            position: relative;
            overflow: hidden;
            z-index: 1;
            font-family: 'Orbitron', sans-serif;
        }

        .btn-submit::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, var(--accent), var(--primary));
            transition: all 0.4s;
            z-index: -1;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 219, 222, 0.4);
            color: var(--dark);
        }

        .btn-submit:hover::before {
            left: 0;
        }

        .btn-submit:active {
            transform: translateY(0);
        }

        /* Login link */
        .login-link {
            text-align: center;
            margin-top: 1.5rem;
            color: var(--text-secondary);
            font-size: 0.9rem;
        }

        .login-link a {
            color: var(--accent);
            text-decoration: none;
            transition: all 0.2s;
            font-weight: 500;
            position: relative;
        }

        .login-link a::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 0;
            height: 1px;
            background: var(--primary);
            transition: all 0.3s;
        }

        .login-link a:hover {
            color: var(--primary);
        }

        .login-link a:hover::after {
            width: 100%;
        }

        /* Responsive adjustments */
        @media (max-width: 600px) {
            .container {
                padding: 1.5rem;
            }

            h1 {
                font-size: 1.8rem;
            }
        }

        /* Particles background effect */
        .particles {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            pointer-events: none;
        }

        .particle {
            position: absolute;
            width: 2px;
            height: 2px;
            background: var(--primary);
            border-radius: 50%;
            opacity: 0.5;
            animation: float 15s infinite linear;
        }

        @keyframes float {
            0% {
                transform: translateY(0) translateX(0);
                opacity: 0;
            }
            10% {
                opacity: 0.5;
            }
            100% {
                transform: translateY(-100vh) translateX(100px);
                opacity: 0;
            }
        }

        /* Glow effect */
        .glow {
            text-shadow: 0 0 10px rgba(0, 219, 222, 0.7);
        }

        /* Loading spinner */
        .spinner {
            display: inline-block;
            width: 1rem;
            height: 1rem;
            border: 2px solid rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            border-top-color: white;
            animation: spin 1s ease-in-out infinite;
            margin-right: 0.5rem;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
<!-- Particles background -->
<div class="particles" id="particles"></div>

<div class="container">
    <h1 class="glow">Student Registration</h1>

    <%-- Display success message if redirected from successful registration --%>
    <% if ("success".equals(request.getParameter("signup"))) { %>
    <div class="notification success-message">
        <i class="fas fa-check-circle"></i>
        <span>Registration successful! Please login with your credentials.</span>
    </div>
    <% } %>

    <%-- Display errors if any --%>
    <% if (request.getAttribute("errors") != null && !((List<String>) request.getAttribute("errors")).isEmpty()) { %>
    <div class="notification error-message">
        <i class="fas fa-exclamation-triangle"></i>
        <ul style="list-style: none;">
            <% for (String error : (List<String>) request.getAttribute("errors")) { %>
            <li><%= error %></li>
            <% } %>
        </ul>
    </div>
    <% } %>

    <form method="post" autocomplete="off" id="registerForm">
        <div class="form-group">
            <label for="name"><i class="fas fa-user-astronaut"></i> Full Name</label>
            <div class="input-wrapper">
                <i class="fas fa-user input-icon"></i>
                <input type="text" id="name" name="name"
                       value="<%= request.getAttribute("name") != null ? request.getAttribute("name") : "" %>"
                       required maxlength="100">
            </div>
        </div>

        <div class="form-group">
            <label for="email"><i class="fas fa-envelope"></i> Email</label>
            <div class="input-wrapper">
                <i class="fas fa-at input-icon"></i>
                <input type="email" id="email" name="email"
                       value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>"
                       required maxlength="255">
            </div>
        </div>

        <div class="form-group">
            <label for="password"><i class="fas fa-lock"></i> Password</label>
            <div class="input-wrapper">
                <i class="fas fa-key input-icon"></i>
                <input type="password" id="password" name="password" required minlength="8" maxlength="100">
                <i class="fas fa-eye password-toggle" id="togglePassword"></i>
            </div>
            <p class="password-hint">Minimum 8 characters with mixed case, numbers, and symbols</p>
        </div>

        <div class="form-group">
            <label for="confirmPassword"><i class="fas fa-lock"></i> Confirm Password</label>
            <div class="input-wrapper">
                <i class="fas fa-key input-icon"></i>
                <input type="password" id="confirmPassword" name="confirmPassword" required minlength="8" maxlength="100">
            </div>
        </div>

        <button type="submit" class="btn-submit" id="submitBtn">
            <i class="fas fa-user-plus"></i> <span>Register</span>
        </button>
    </form>

    <div class="login-link">
        Already have an account? <a href="logIn.jsp">Login here</a>
    </div>
</div>

<script>
    // Create particles
    function createParticles() {
        const particlesContainer = document.getElementById('particles');
        const particleCount = 30;

        for (let i = 0; i < particleCount; i++) {
            const particle = document.createElement('div');
            particle.classList.add('particle');

            // Random position
            particle.style.left = `${Math.random() * 100}%`;
            particle.style.top = `${Math.random() * 100}%`;

            // Random size
            const size = Math.random() * 3 + 1;
            particle.style.width = `${size}px`;
            particle.style.height = `${size}px`;

            // Random animation duration
            particle.style.animationDuration = `${Math.random() * 10 + 10}s`;
            particle.style.animationDelay = `${Math.random() * 5}s`;

            particlesContainer.appendChild(particle);
        }
    }

    // Password visibility toggle
    function setupPasswordToggle() {
        const togglePassword = document.getElementById('togglePassword');
        const password = document.getElementById('password');

        togglePassword.addEventListener('click', function() {
            const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
            password.setAttribute('type', type);
            this.classList.toggle('fa-eye');
            this.classList.toggle('fa-eye-slash');
        });
    }

    // Form validation
    function setupFormValidation() {
        const form = document.getElementById('registerForm');
        const submitBtn = document.getElementById('submitBtn');

        form.addEventListener('submit', function(e) {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;

            if (password !== confirmPassword) {
                e.preventDefault();
                alert('Passwords do not match!');
                return;
            }

            // Show loading state
            submitBtn.innerHTML = '<div class="spinner"></div><span>Registering...</span>';
            submitBtn.disabled = true;
        });
    }

    // Initialize everything
    document.addEventListener('DOMContentLoaded', function() {
        createParticles();
        setupPasswordToggle();
        setupFormValidation();
    });
</script>
</body>
</html>