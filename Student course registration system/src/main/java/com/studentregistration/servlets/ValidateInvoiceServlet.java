@WebServlet("/ValidateInvoice")
public class ValidateInvoiceServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        String invoiceId = request.getParameter("id");

        boolean exists = InvoiceDAO.invoiceExists(invoiceId);
        response.getWriter().write("{\"exists\":" + exists + "}");
    }
}
