<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Void Invoice</title>
    <link rel="stylesheet" href="../css/styles.css">
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
            <a href="viewPaymentHistory.jsp?studentId=<%= request.getParameter("studentId") %>" class="btn">Cancel</a>
        </form>
    </div>
</body>
</html>