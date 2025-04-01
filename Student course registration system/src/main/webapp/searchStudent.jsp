<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<form action="${pageContext.request.contextPath}/students" method="get">
    <div class="search-box">
        <input type="text" name="search" placeholder="Search by ID, Name or Department">
        <button type="submit">Search</button>
    </div>

</form>