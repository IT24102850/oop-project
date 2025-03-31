<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Apply Late Fee Waiver</title>
    <link rel="stylesheet" href="../css/styles.css">
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