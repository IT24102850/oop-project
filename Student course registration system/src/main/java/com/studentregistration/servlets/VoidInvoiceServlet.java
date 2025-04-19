@WebServlet("/VoidInvoice")
public class VoidInvoiceServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // CSRF protection
        if (!validateCsrfToken(request)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid CSRF token");
            return;
        }

        String invoiceId = request.getParameter("invoiceId");
        String reason = request.getParameter("reason");
        String otherReason = request.getParameter("otherReason");

        try {
            // Validate invoice ID format
            if (!invoiceId.matches("INV-\\d{4}-\\d{3}")) {
                request.setAttribute("notification", "error");
                request.setAttribute("message", "Invalid Invoice ID format");
                request.getRequestDispatcher("fee-management.jsp").forward(request, response);
                return;
            }

            // Check if invoice exists and can be voided
            if (!InvoiceDAO.invoiceExists(invoiceId)) {
                request.setAttribute("notification", "error");
                request.setAttribute("message", "Invoice not found");
                request.getRequestDispatcher("fee-management.jsp").forward(request, response);
                return;
            }

            if (InvoiceDAO.isInvoiceVoided(invoiceId)) {
                request.setAttribute("notification", "error");
                request.setAttribute("message", "Invoice is already voided");
                request.getRequestDispatcher("fee-management.jsp").forward(request, response);
                return;
            }

            // Combine reason if "Other" was selected
            String finalReason = "Other".equals(reason) ? otherReason : reason;

            // Void invoice
            boolean success = InvoiceDAO.voidInvoice(invoiceId, finalReason);

            if (success) {
                request.setAttribute("notification", "success");
                request.setAttribute("message", "Invoice " + invoiceId + " has been voided");
            } else {
                request.setAttribute("notification", "error");
                request.setAttribute("message", "Failed to void invoice");
            }

            request.getRequestDispatcher("fee-management.jsp").forward(request, response);

        } catch (Exception e) {
            log("Error voiding invoice", e);
            request.setAttribute("notification", "error");
            request.setAttribute("message", "Error voiding invoice");
            request.getRequestDispatcher("fee-management.jsp").forward(request, response);
        }
    }
}
