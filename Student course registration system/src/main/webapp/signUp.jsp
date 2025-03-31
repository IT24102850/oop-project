<%@ page import="java.io.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Handle form submission
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String studentId = request.getParameter("studentId");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Basic validation
        List<String> errors = new ArrayList<>();

        if (studentId == null || studentId.trim().isEmpty()) {
            errors.add("Student ID is required");
        }

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

        // Check if student already exists
        if (errors.isEmpty()) {
            if (studentExists(studentId)) {
                errors.add("Student ID already exists");
            }
        }

        // If no errors, save student data
        if (errors.isEmpty()) {
            boolean success = saveStudent(studentId, name, email, password);
            if (success) {
                response.sendRedirect("login.jsp?signup=success");
                return;
            } else {
                errors.add("Registration failed. Please try again.");
            }
        }

        // Display errors if any
        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("studentId", studentId);
            request.setAttribute("name", name);
            request.setAttribute("email", email);
        }
    }
%>

<%!
    // Method to check if student exists
    private boolean studentExists(String studentId) {
        String filePath = getServletContext().getRealPath("/") + "students.txt";
        File file = new File(filePath);

        if (!file.exists()) {
            return false;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length > 0 && parts[0].equals(studentId)) {
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
        String filePath = getServletContext().getRealPath("/") + "students.txt";
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
<html>
<head>
    <title>Student Registration</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 500px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            text-align: center;
            color: #333;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="text"],
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .error {
            color: red;
            margin-bottom: 15px;
        }
        .error ul {
            margin: 0;
            padding-left: 20px;
        }
        button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Student Registration</h1>

    <%-- Display errors if any --%>
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
            <label for="studentId">Student ID:</label>
            <input type="text" id="studentId" name="studentId"
                   value="<%= request.getAttribute("studentId") != null ? request.getAttribute("studentId") : "" %>" required>
        </div>

        <div class="form-group">
            <label for="name">Full Name:</label>
            <input type="text" id="name" name="name"
                   value="<%= request.getAttribute("name") != null ? request.getAttribute("name") : "" %>" required>
        </div>

        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email"
                   value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>" required>
        </div>

        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
        </div>

        <div class="form-group">
            <label for="confirmPassword">Confirm Password:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required>
        </div>

        <div class="form-group">
            <button type="submit">Register</button>
        </div>
    </form>

    <p>Already have an account? <a href="login.jsp">Login here</a></p>
</div>
</body>
</html>