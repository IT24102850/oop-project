<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Generate Invoice</title>
    <link rel="stylesheet" href="../css/styles.css">
</head>
<body>
    <div class="container">
        <h1>Generate New Invoice</h1>
        
        <% if (request.getParameter("success") != null) { %>
            <div class="alert alert-success">Invoice generated successfully!</div>
        <% } %>
        
        <form action="../fee-management" method="post">
            <input type="hidden" name="action" value="generate">
            
            <div class="form-group">
                <label for="studentId">Student ID:</label>
                <input type="text" id="studentId" name="studentId" required>
            </div>
            
            <div class="form-group">
                <label for="amount">Amount:</label>
                <input type="number" id="amount" name="amount" step="0.01" required>
            </div>
            
            <div class="form-group">
                <label for="dueDate">Due Date:</label>
                <input type="date" id="dueDate" name="dueDate" required>
            </div>
            
            <div class="form-group">
                <label for="description">Description:</label>
                <textarea id="description" name="description" required></textarea>
            </div>
            
            <button type="submit" class="btn">Generate Invoice</button>
        </form>
    </div>
</body>
</html>