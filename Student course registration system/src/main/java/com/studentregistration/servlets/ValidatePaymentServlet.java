@WebServlet("/ValidatePayment")
public class ValidatePaymentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        String paymentId = request.getParameter("id");

        boolean exists = PaymentDAO.paymentExists(paymentId);
        response.getWriter().write("{\"exists\":" + exists + "}");
    }
}
