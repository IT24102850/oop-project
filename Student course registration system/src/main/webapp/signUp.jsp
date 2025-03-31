
<%@ page import="java.io.*, java.util.*" %>
<%@ page import="java.time.LocalDateTime" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Handle form submission
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validation
        List<String> errors = new ArrayList<>();

        if (name == null || name.trim().isEmpty()) {
            errors.add("Full name is required");
        }

        if (email == null || email.trim().isEmpty()) {
            errors.add("Email is required");
        } else if (!email.matches("^[\\w-.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
            errors.add("Invalid email format");
        }

        if (password == null || password.trim().isEmpty()) {
            errors.add("Password is required");
        } else if (password.length() < 6) {
            errors.add("Password must be at least 6 characters");
        } else if (!password.equals(confirmPassword)) {
            errors.add("Passwords do not match");
        }

        // Check if email exists
        if (errors.isEmpty() && emailExists(email)) {
            errors.add("Email already registered");
        }

        // Save if no errors
        if (errors.isEmpty()) {
            if (saveUser(name, email, password)) {
                response.sendRedirect("login.jsp?registration=success");
                return;
            } else {
                errors.add("Registration failed. Please try again.");
            }
        }

        // Show errors if any
        request.setAttribute("errors", errors);
        request.setAttribute("name", name);
        request.setAttribute("email", email);
    }
%>

<%!
    private boolean emailExists(String email) {
        File file = new File("user_data.txt");
        if (!file.exists()) return false;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|");
                if (parts.length > 2 && parts[1].equalsIgnoreCase(email)) {
                    return true;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return false;
    }

    private boolean saveUser(String name, String email, String password) {
        try {
            File file = new File("user_data.txt");
            if (!file.exists()) {
                file.createNewFile();
            }

            try (BufferedWriter writer = new BufferedWriter(new FileWriter(file, true))) {
                String userData = String.join("|",
                        UUID.randomUUID().toString(), // Generate unique ID
                        email,
                        name,
                        password,
                        "student",
                        LocalDateTime.now().toString()
                );
                writer.write(userData);
                writer.newLine();
                return true;
            }
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 20px; }
        .container { max-width: 500px; margin: 0 auto; padding: 20px; border: 1px solid #ddd; border-radius: 5px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; }
        input { width: 100%; padding: 8px; box-sizing: border-box; }
        .error { color: red; margin-bottom: 15px; }
        button { background: #4CAF50; color: white; border: none; padding: 10px; width: 100%; cursor: pointer; }
    </style>
</head>
<body>
<div class="container">
    <h2>Register</h2>

    <% if (request.getAttribute("errors") != null) { %>
    <div class="error">
        <ul>
            <% for (String error : (List<String>) request.getAttribute("errors")) { %>
            <li><%= error %></li>
            <% } %>
        </ul>
    </div>
    <% } %>

    <form method="post">
        <div class="form-group">
            <label>Full Name:</label>
            <input type="text" name="name" value="<%= request.getAttribute("name") != null ? request.getAttribute("name") : "" %>" required>
        </div>

        <div class="form-group">
            <label>Email:</label>
            <input type="email" name="email" value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>" required>
        </div>

        <div class="form-group">
            <label>Password (min 6 characters):</label>
            <input type="password" name="password" minlength="6" required>
        </div>

        <div class="form-group">
            <label>Confirm Password:</label>
            <input type="password" name="confirmPassword" minlength="6" required>
        </div>

        <button type="submit">Register</button>
    </form>

    <p>Already have an account? <a href="login.jsp">Login here</a></p>
</div>
</body>
</html>