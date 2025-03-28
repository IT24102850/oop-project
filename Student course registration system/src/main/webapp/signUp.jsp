<form action="${pageContext.request.contextPath}/signup" method="POST">
    <div class="form-group">
        <label for="fullname">Full Name</label>
        <input type="text" id="fullname" name="fullname" required>
    </div>
    <div class="form-group">
        <label for="email">Email</label>
        <input type="email" id="email" name="email" required>
    </div>
    <div class="form-group">
        <label for="password">Password</label>
        <input type="password" id="password" name="password" required>
    </div>
    <div class="form-group">
        <label for="confirm-password">Confirm Password</label>
        <input type="password" id="confirm-password" name="confirm-password" required>
    </div>
    <button type="submit">Sign Up</button>
</form>

<%-- Display error message if passwords didn't match --%>
<% if (request.getParameter("error") != null) { %>
<div class="error">Passwords do not match!</div>
<% } %>