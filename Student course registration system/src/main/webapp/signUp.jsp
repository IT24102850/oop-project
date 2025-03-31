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
    <title>Student Registration</title>
    <style>
        :root {
            --primary-color: #4a6fa5;
            --secondary-color: #166088;
            --success-color: #28a745;
            --error-color: #dc3545;
            --light-gray: #f8f9fa;
            --dark-gray: #343a40;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--light-gray);
            margin: 0;
            padding: 0;
            line-height: 1.6;
        }

        .container {
            max-width: 600px;
            margin: 40px auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: var(--primary-color);
            margin-bottom: 30px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: var(--dark-gray);
        }

        input[type="text"],
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
            transition: border-color 0.3s;
        }

        input:focus {
            border-color: var(--primary-color);
            outline: none;
            box-shadow: 0 0 0 3px rgba(74, 111, 165, 0.25);
        }

        .error-message {
            color: var(--error-color);
            margin-bottom: 20px;
            background-color: #f8d7da;
            padding: 15px;
            border-radius: 4px;
            border: 1px solid #f5c6cb;
        }

        .error-message ul {
            margin: 0;
            padding-left: 20px;
        }

        .success-message {
            color: var(--success-color);
            text-align: center;
            margin-bottom: 20px;
            background-color: #d4edda;
            padding: 15px;
            border-radius: 4px;
            border: 1px solid #c3e6cb;
        }

        button {
            background-color: var(--primary-color);
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
            font-weight: 600;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: var(--secondary-color);
        }

        .login-link {
            text-align: center;
            margin-top: 20px;
            color: var(--dark-gray);
        }

        .login-link a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 600;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        .password-hint {
            font-size: 0.8em;
            color: #6c757d;
            margin-top: 5px;
        }

        @media (max-width: 768px) {
            .container {
                margin: 20px;
                padding: 20px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Student Registration</h1>

    <%-- Display success message if redirected from successful registration --%>
    <% if ("success".equals(request.getParameter("signup"))) { %>
    <div class="success-message">
        Registration successful! Please login with your credentials.
    </div>
    <% } %>

    <%-- Display errors if any --%>
    <% if (request.getAttribute("errors") != null && !((List<String>) request.getAttribute("errors")).isEmpty()) { %>
    <div class="error-message">
        <ul>
            <% for (String error : (List<String>) request.getAttribute("errors")) { %>
            <li><%= error %></li>
            <% } %>
        </ul>
    </div>
    <% } %>

    <form method="post" autocomplete="off">
        <div class="form-group">
            <label for="name">Full Name:</label>
            <input type="text" id="name" name="name"
                   value="<%= request.getAttribute("name") != null ? request.getAttribute("name") : "" %>"
                   required maxlength="100">
        </div>

        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email"
                   value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>"
                   required maxlength="255">
        </div>

        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required minlength="8" maxlength="100">
            <p class="password-hint">Must be at least 8 characters long</p>
        </div>

        <div class="form-group">
            <label for="confirmPassword">Confirm Password:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required minlength="8" maxlength="100">
        </div>

        <div class="form-group">
            <button type="submit">Register</button>
        </div>
    </form>

    <div class="login-link">
        Already have an account? <a href="<%= request.getContextPath() %>/login.jsp">Login here</a>
    </div>
</div>

<script>
    // Client-side password validation
    document.querySelector('form').addEventListener('submit', function(e) {
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;

        if (password !== confirmPassword) {
            alert('Passwords do not match!');
            e.preventDefault();
        }
    });
</script>
</body>
</html