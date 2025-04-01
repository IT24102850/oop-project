<table class="student-table">
  <thead>
    <tr>
      <th>ID</th>
      <th>Name</th>
      <th>Email</th>
      <th>Department</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach items="${students}" var="student">
      <tr>
        <td>${student.id}</td>
        <td>${student.name}</td>
        <td>${student.email}</td>
        <td>${student.department}</td>
      </tr>
    </c:forEach>
  </tbody>
</table>

<c:if test="${empty students}">
  <p class="no-results">No students found matching your search.</p>
</c:if>