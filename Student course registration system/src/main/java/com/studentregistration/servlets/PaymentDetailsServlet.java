@WebServlet("/PaymentDetails")
public class PaymentDetailsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String paymentId = request.getParameter("paymentId");

        try {
            if (paymentId == null || !paymentId.matches("PAY-\\d{4}-\\d{3}")) {
                response.getWriter().write("{\"error\":\"Invalid payment ID\"}");
                return;
            }

            PaymentRecord payment = PaymentDAO.getPaymentDetails(paymentId);
            if (payment == null) {
                response.getWriter().write("{\"error\":\"Payment not found\"}");
                return;
            }

            // Convert to JSON
            String json = new Gson().toJson(payment);
            response.getWriter().write(json);

        } catch (Exception e) {
            log("Error retrieving payment details", e);
            response.getWriter().write("{\"error\":\"Error retrieving payment details\"}");
        }
    }
}
