<%@ include file="authFilter.jsp" %>
<%
    String role = (String) session.getAttribute("role");
%>

<%@include file="authFilter.jsp"%>
<%@page import="com.studentregistration.model.User"%>
<%
    User user = (User) session.getAttribute("user");
// Ensure only students can access
    if(!"student".equals(user.getRole())) {
        response.sendError(HttpServletResponse.SC_FORBIDDEN);
        return;
    }
%>
<!-- Student dashboard content -->

<html>
<head><title>Dashboard</title></head>
<body>
<h1>Welcome to NexoraSkill, <%= session.getAttribute("username") %>!</h1>

<% if(role.equals("admin")) { %>
<h2>Admin Dashboard</h2>
<p><a href="manageCourses.jsp">Manage Courses</a></p>
<p><a href="viewUsers.jsp">View Users</a></p>
<% } else { %>
<h2>Student Dashboard</h2>
<p><a href="viewCourses.jsp">View Available Courses</a></p>
<p><a href="myCourses.jsp">My Courses</a></p>
<% } %>

<p><a href="logout.jsp">Logout</a></p>
</body>
</html>