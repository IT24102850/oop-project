<%-- Keep your existing header and styles --%>

<!-- Update just the form and messages section: -->
<section class="login-section">
    <div class="login-container">
        <%-- Error/Success Messages --%>
        <% if (request.getParameter("registered") != null) { %>
        <div class="success-message">Registration successful!</div>
        <% } %>
        <% if (request.getParameter("error") != null) { %>
        <div class="error-message">
            <%= request.getParameter("error").equals("1")
                    ? "Passwords don't match"
                    : "Email already exists" %>
        </div>
        <% } %>

        <%-- The Form --%>
        <form action="${pageContext.request.contextPath}/signup" method="POST">
            <%-- Your form fields here --%>
            <button type="submit">Sign Up</button>
        </form>
    </div>
</section>

<form class="login-form" action="${pageContext.request.contextPath}/signup" method="POST">
    <div class="form-group">
        <label for="fullname">Full Name</label>
        <input type="text" id="fullname" name="fullname" placeholder="Enter your full name" required>
    </div>
    <div class="form-group">
        <label for="email">Email</label>
        <input type="email" id="email" name="email" placeholder="Enter your email" required>
    </div>
    <div class="form-group">
        <label for="password">Password</label>
        <input type="password" id="password" name="password" placeholder="Enter your password" required>
    </div>
    <div class="form-group">
        <label for="confirm-password">Confirm Password</label>
        <input type="password" id="confirm-password" name="confirm-password" placeholder="Confirm your password" required>
    </div>
    <button type="submit" class="btn-login">Sign Up</button>
    <p class="signup-link">Already have an account? <a href="${pageContext.request.contextPath}/navigation/logIn.jsp">Login here</a></p>
</form>