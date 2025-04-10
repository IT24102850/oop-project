<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Apply Late Fee Waiver</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 500px;
            margin: 20px auto;
            background: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="number"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .btn {
            background: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }
        .btn:hover {
            background: #45a049;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Apply Late Fee Waiver</h1>
    <p>Invoice: <%= request.getParameter("invoiceId") %></p>

    <form action="../fee-management" method="post">
        <input type="hidden" name="action" value="waiver">
        <input type="hidden" name="invoiceId" value="<%= request.getParameter("invoiceId") %>">
        <input type="hidden" name="studentId" value="<%= request.getParameter("studentId") %>">

        <div class="form-group">
            <label for="waiverAmount">Waiver Amount:</label>
            <input type="number" id="waiverAmount" name="waiverAmount" step="0.01" required>
        </div>

        <button type="submit" class="btn">Apply Waiver</button>
    </form>
</div>
</body>
</html>