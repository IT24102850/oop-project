@WebServlet("/CancelPayment")
public class CancelPaymentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // CSRF protection
        if (!validateCsrfToken(request)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid CSRF token");
            return;
        }

        String paymentId = request.getParameter("paymentId");
        String reason = request.getParameter("reason");
        String otherReason = request.getParameter("otherReason");

        try {
            // Validate payment ID format
            if (!paymentId.matches("PAY-\\d{4}-\\d{3}")) {
                request.setAttribute("notification", "error");
                request.setAttribute("message", "Invalid Payment ID format");
                request.getRequestDispatcher("fee-management.jsp").forward(request, response);
                return;
            }

            // Check if payment exists and can be canceled
            PaymentRecord payment = PaymentDAO.getPayment(paymentId);
            if (payment == null) {
                request.setAttribute("notification", "error");
                request.setAttribute("message", "Payment not found");
                request.getRequestDispatcher("fee-management.jsp").forward(request, response);
                return;
            }

            if ("CANCELED".equals(payment.getStatus())) {
                request.setAttribute("notification", "error");
                request.setAttribute("message", "Payment is already canceled");
                request.getRequestDispatcher("fee-management.jsp").forward(request, response);
                return;
            }

            // Check if within 24-hour cancellation window
            if (!PaymentDAO.isWithinCancellationWindow(paymentId)) {
                request.setAttribute("notification", "error");
                request.setAttribute("message", "Cancellation window has expired (24 hours)");
                request.getRequestDispatcher("fee-management.jsp").forward(request, response);
                return;
            }

            // Combine reason if "Other" was selected
            String finalReason = "Other".equals(reason) ? otherReason : reason;

            // Cancel payment
            boolean success = PaymentDAO.cancelPayment(paymentId, finalReason);

            if (success) {
                request.setAttribute("notification", "success");
                request.setAttribute("message", "Payment " + paymentId + " has been canceled");
            } else {
                request.setAttribute("notification", "error");
                request.setAttribute("message", "Failed to cancel payment");
            }

            request.getRequestDispatcher("fee-management.jsp").forward(request, response);

        } catch (Exception e) {
            log("Error canceling payment", e);
            request.setAttribute("notification", "error");
            request.setAttribute("message", "Error canceling payment");
            request.getRequestDispatcher("fee-management.jsp").forward(request, response);
        }
    }
}