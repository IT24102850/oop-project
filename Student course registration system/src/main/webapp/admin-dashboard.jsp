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
<div class="container">
    <div class="row">
        <div class="col-md-3">
            <div class="list-group">
                <a href="#" class="list-group-item list-group-item-action active">Dashboard</a>
                <a href="${pageContext.request.contextPath}/courses/list" class="list-group-item list-group-item-action">Manage Courses</a>
                <a href="${pageContext.request.contextPath}/students/list" class="list-group-item list-group-item-action">Manage Students</a>
                <a href="${pageContext.request.contextPath}/registrations/view" class="list-group-item list-group-item-action">View Registrations</a>
                <a href="${pageContext.request.contextPath}/auth/logout" class="list-group-item list-group-item-action">Logout</a>
            </div>
        </div>
        <div class="col-md-9">
            <div class="card">
                <div class="card-header">
                    <h4>Admin Dashboard</h4>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="card text-white bg-primary mb-3">
                                <div class="card-body">
                                    <h5 class="card-title">Total Students</h5>
                                    <p class="card-text">${studentCount}</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card text-white bg-success mb-3">
                                <div class="card-body">
                                    <h5 class="card-title">Total Courses</h5>
                                    <p class="card-text">${courseCount}</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card text-white bg-info mb-3">
                                <div class="card-body">
                                    <h5 class="card-title">Active Registrations</h5>
                                    <p class="card-text">${registrationCount}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
