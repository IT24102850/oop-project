<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<table class="student-table">
    <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Department</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>


        <c:forEach items="${students}" var="student">
            <tr>
                <td>${student.id}</td>
                <td>${student.name}</td>
                <td>${student.email}</td>
                <td>${student.department}</td>
                <td>
                    <a href="editStudent.jsp?id=${student.id}">Edit</a>
                    <a href="${pageContext.request.contextPath}/students?action=delete&id=${student.id}" 
                       onclick="return confirm('Are you sure?')">Delete</a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>