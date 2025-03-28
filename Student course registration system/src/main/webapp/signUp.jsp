<form action="signup" method="POST">
    <!-- Your form fields -->
    <button type="submit">Sign Up</button>
</form>

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

<% if (request.getParameter("error") != null) { %>
<div class="error-message">
    <%
        String error = request.getParameter("error");
        if ("1".equals(error)) { %>
    Passwords do not match!
    <% } else if ("2".equals(error)) { %>
    Server error. Please try again.
    <% } else if ("3".equals(error)) { %>
    Please fill all fields!
    <% } %>
</div>
<% } %>

