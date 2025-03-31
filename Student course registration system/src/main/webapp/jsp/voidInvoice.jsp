<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Void Invoice</title>
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
        .btn {
            display: inline-block;
            padding: 10px 15px;
            margin-right: 10px;
            text-decoration: none;
            border-radius: 4px;
            font-size: 14px;
        }
        .btn-danger {
            background: #f44336;
            color: white;
            border: none;
            cursor: pointer;
        }
        .btn-danger:hover {
            background: #d32f2f;
        }
        .btn-default {
            background: #e0e0e0;
            color: #333;
        }
        .btn-default:hover {
            background: #d0d0d0;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Void Invoice</h1>
    <p>Are you sure you want to void invoice <%= request.getParameter("invoiceId") %>?</p>

    <form action="../fee-management" method="post">
        <input type="hidden" name="action" value="void">
        <input type="hidden" name="invoiceId" value="<%= request.getParameter("invoiceId") %>">
        <input type="hidden" name="studentId" value="<%= request.getParameter("studentId") %>">

        <button type="submit" class="btn btn-danger">Confirm Void</button>
        <a href="viewPaymentHistory.jsp?studentId=<%= request.getParameter("studentId") %>" class="btn btn-default">Cancel</a>
    </form>
</div>
</body>
</html>