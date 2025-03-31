<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.studentregistration.model.FeeInvoice" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <title>Payment History</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 1000px;
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
        .data-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .data-table th, .data-table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        .data-table th {
            background-color: #f2f2f2;
        }
        .data-table tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .data-table tr:hover {
            background-color: #f1f1f1;
        }
        .btn {
            display: inline-block;
            padding: 5px 10px;
            font-size: 12px;
            text-decoration: none;
            border-radius: 4px;
        }
        .btn-small {
            background: #4CAF50;
            color: white;
        }
        .btn-small:hover {
            background: #45a049;
        }
        .btn-danger {
            background: #f44336;
            color: white;
        }
        .btn-danger:hover {
            background: #d32f2f;
        }
        .alert {
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 4px;
        }
        .alert-success {
            background-color: #dff0d8;
            color: #3c763d;
            border: 1px solid #d6e9c6;
        }
        .status-paid {
            color: #4CAF50;
            font-weight: bold;
        }
        .status-pending {
            color: #FFC107;
            font-weight: bold;
        }
        .status-voided {
            color: #f44336;
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Payment History for Student ${param.studentId}</h1>

    <% if (request.getParameter("success") != null) { %>
    <div class="alert alert-success">Operation completed successfully!</div>
    <% } %>

    <table class="data-table">
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
        <% List<FeeInvoice> invoices = (List<FeeInvoice>) request.getAttribute("invoices");
            if (invoices != null) {
                for (FeeInvoice invoice : invoices) { %>
        <tr>
            <td><%= invoice.getInvoiceId() %></td>
            <td>$<%= String.format("%.2f", invoice.getTotalAmount()) %></td>
            <td><%= invoice.getDueDate() %></td>
            <td class="<% if (invoice.isVoided()) { %>status-voided<% }
                                      else if (invoice.isPaid()) { %>status-paid<% }
                                      else { %>status-pending<% } %>">
                <% if (invoice.isVoided()) { %>
                VOIDED
                <% } else if (invoice.isPaid()) { %>
                PAID
                <% } else { %>
                PENDING
                <% } %>
            </td>
            <td>
                <a href="applyWaiver.jsp?invoiceId=<%= invoice.getInvoiceId() %>&studentId=<%= invoice.getStudentId() %>"
                   class="btn btn-small">Apply Waiver</a>
                <% if (!invoice.isPaid() && !invoice.isVoided()) { %>
                <a href="voidInvoice.jsp?invoiceId=<%= invoice.getInvoiceId() %>&studentId=<%= invoice.getStudentId() %>"
                   class="btn btn-danger">Void</a>
                <% } %>
            </td>
        </tr>
        <%   }
        } %>
        </tbody>
    </table>
</div>
</body>
</html>