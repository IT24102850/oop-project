<%--
  Created by IntelliJ IDEA.
  User: hasir
  Date: 4/19/2025
  Time: 6:22 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <title>My Enrollments</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<h2>My Enrollments</h2>
<%
    List<String> enrollments = (List<String>) request.getAttribute("enrollments");
    if (enrollments != null && !enrollments.isEmpty()) {
        for (String enrollment : enrollments) {
%>
<p><%= enrollment %></p>
<%
    }
} else {
%>
<p>No enrollments found.</p>
<%
    }
%>
<a href="student-dashboard.jsp">Back to Dashboard</a>
</body>
</html>
