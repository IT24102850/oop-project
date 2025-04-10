<table class="student-table">
  <!-- Table headers... -->
  <tbody>
  <c:forEach items="${students}" var="student">
    <tr>
      <td>${student.id}</td>
      <td>${student.name}</td>
      <td>${student.email}</td>
      <td>${student.department}</td>
      <td>
        <c:choose>
          <c:when test="${student.active}">
            <form action="StudentServlet" method="POST" style="display:inline;">
              <input type="hidden" name="action" value="deactivate">
              <input type="hidden" name="id" value="${student.id}">
              <button type="submit" class="btn-deactivate">Deactivate</button>
            </form>
          </c:when>
          <c:otherwise>
            <span class="status-inactive">Graduated</span>
          </c:otherwise>
        </c:choose>
      </td>
    </tr>
  </c:forEach>
  </tbody>
</table>