<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Payment History</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #2c3e50;
            border-bottom: 2px solid #3498db;
            padding-bottom: 10px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #3498db;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #e9e9e9;
        }
        .paid { color: #27ae60; font-weight: bold; }
        .pending { color: #f39c12; font-weight: bold; }
        .voided { color: #e74c3c; font-weight: bold; }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: 600;
        }
        input[type="text"],
        input[type="number"],
        input[type="date"],
        textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        textarea {
            height: 100px;
            resize: vertical;
        }
        button {
            background-color: #3498db;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }
        button:hover {
            background-color: #2980b9;
        }
        .btn-danger {
            background-color: #e74c3c;
        }
        .btn-danger:hover {
            background-color: #c0392b;
        }
        .alert {
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 4px;
        }
        .alert-success {
            background-color: #d5f5e3;
            color: #27ae60;
            border: 1px solid #2ecc71;
        }
        .alert-error {
            background-color: #fadbd8;
            color: #e74c3c;
            border: 1px solid #e74c3c;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Payment History for Student ${param.studentId}</h1>

    <%-- Display success/error messages --%>
    <c:if test="${not empty message}">
        <div class="alert ${messageType == 'success' ? 'alert-success' : 'alert-error'}">
                ${message}
        </div>
    </c:if>

    <table>
        <thead>
        <tr>
            <th>Invoice ID</th>
            <th>Amount</th>
            <th>Due Date</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:choose>
            <c:when test="${not empty invoices}">
                <c:forEach items="${invoices}" var="invoice">
                    <tr>
                        <td>${invoice.invoiceId}</td>
                        <td>$${String.format("%.2f", invoice.totalAmount)}</td>
                        <td>${invoice.dueDate}</td>
                        <td class="${invoice.paid ? 'paid' : invoice.voided ? 'voided' : 'pending'}">
                                ${invoice.paid ? 'PAID' : invoice.voided ? 'VOIDED' : 'PENDING'}
                        </td>
                        <td>
                            <form action="fee-management" method="post" style="display: inline-block; margin-right: 5px;">
                                <input type="hidden" name="action" value="waiver">
                                <input type="hidden" name="studentId" value="${param.studentId}">
                                <input type="hidden" name="invoiceId" value="${invoice.invoiceId}">
                                <input type="number" name="waiverAmount" placeholder="Waiver amount"
                                       step="0.01" min="0" max="${invoice.lateFee}" style="width: 120px;">
                                <button type="submit">Apply Waiver</button>
                            </form>
                            <c:if test="${!invoice.paid && !invoice.voided}">
                                <form action="fee-management" method="post" style="display: inline-block;">
                                    <input type="hidden" name="action" value="void">
                                    <input type="hidden" name="studentId" value="${param.studentId}">
                                    <input type="hidden" name="invoiceId" value="${invoice.invoiceId}">
                                    <button type="submit" class="btn-danger">Void Invoice</button>
                                </form>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td colspan="5" style="text-align: center;">No invoices found for this student</td>
                </tr>
            </c:otherwise>
        </c:choose>
        </tbody>
    </table>

    <h2>Generate New Invoice</h2>
    <form action="fee-management" method="post">
        <input type="hidden" name="action" value="generate">

        <div class="form-group">
            <label for="studentId">Student ID:</label>
            <input type="text" id="studentId" name="studentId" value="${param.studentId}" required readonly>
        </div>

        <div class="form-group">
            <label for="amount">Amount ($):</label>
            <input type="number" id="amount" name="amount" step="0.01" min="0" required>
        </div>

        <div class="form-group">
            <label for="dueDate">Due Date:</label>
            <input type="date" id="dueDate" name="dueDate" required>
        </div>

        <div class="form-group">
            <label for="description">Description:</label>
            <textarea id="description" name="description" required></textarea>
        </div>

        <button type="submit">Generate Invoice</button>
    </form>
</div>

<script>
    // Set minimum date to today for due date
    document.getElementById('dueDate').min = new Date().toISOString().split('T')[0];

    // Format currency display
    document.querySelectorAll('td:nth-child(2)').forEach(td => {
        if (td.textContent.startsWith('$')) {
            const amount = parseFloat(td.textContent.substring(1));
            td.textContent = '$' + amount.toFixed(2);
        }
    });
</script>
</body>
</html>