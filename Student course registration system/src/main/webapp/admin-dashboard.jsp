<%@include file="authFilter.jsp"%>
<%@page import="com.studentregistration.model.User"%>
<%
    User user = (User) session.getAttribute("user");
// Ensure only admins can access
    if(!"admin".equals(user.getRole())) {
        response.sendError(HttpServletResponse.SC_FORBIDDEN);
        return;
    }
%>
<!-- Admin dashboard content -->
