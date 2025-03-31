<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.studentregistration.model.FeeInvoice" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <title>Payment History</title>
    <link rel="stylesheet" href="../css/styles.css">
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
                            <td>
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
                                       class="btn btn-small btn-danger">Void</a>
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