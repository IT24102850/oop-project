<%@ page import="java.io.*" %>
<%
    String username = (String) session.getAttribute("username");
    if(username == null || username.isEmpty()) {
        response.sendRedirect("logIn.jsp");
        return;
    }
%>