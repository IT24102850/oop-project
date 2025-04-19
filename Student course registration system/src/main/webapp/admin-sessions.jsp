<%--
  Created by IntelliJ IDEA.
  User: hasir
  Date: 4/19/2025
  Time: 6:21 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.studentregistration.model.User" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <title>Active Admin Sessions</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<h2>Active Admin Sessions</h2>
<%
    List<User> activeAdmins = (List<User>) request.getAttribute("activeAdmins");
    if (activeAdmins != null && !activeAdmins.isEmpty()) {
        for (User admin : activeAdmins) {
%>
<p>Username: <%= admin.getUsername() %>, Last Login: <%= admin.getLastLogin() %></p>
<%
    }
} else {
%>
<p>No active admin sessions.</p>
<%
    }
%>
<a href="admin-dashboard.jsp">Back to Dashboard</a>
</body>
</html>
