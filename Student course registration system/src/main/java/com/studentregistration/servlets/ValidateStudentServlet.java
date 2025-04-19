@WebServlet("/ValidateStudent")
public class ValidateStudentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        String studentId = request.getParameter("id");

        boolean exists = StudentDAO.studentExists(studentId);
        response.getWriter().write("{\"exists\":" + exists + "}");
    }
}
