@WebServlet("/ViewPaymentHistory")
public class ViewPaymentHistoryServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Verify CSRF token
        if (!validateCsrfToken(request)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid CSRF token");
            return;
        }

        String studentId = request.getParameter("studentId");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");

        try {
            // Validate input
            if (!studentId.matches("S\\d{4}")) {
                request.setAttribute("error", "Invalid Student ID format");
                request.getRequestDispatcher("fee-management.jsp").forward(request, response);
                return;
            }

            // Date validation
            if (startDate != null && endDate != null && startDate.compareTo(endDate) > 0) {
                request.setAttribute("error", "End date must be after start date");
                request.getRequestDispatcher("fee-management.jsp").forward(request, response);
                return;
            }

            // Get payment records from database
            List<PaymentRecord> records = PaymentDAO.getPaymentHistory(studentId, startDate, endDate);
            double totalPayments = records.stream().mapToDouble(PaymentRecord::getAmount).sum();

            // Pagination
            int page = 1;
            int pageSize = 10;
            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }

            request.setAttribute("paymentRecords", records);
            request.setAttribute("studentId", studentId);
            request.setAttribute("totalPayments", totalPayments);
            request.setAttribute("page", page);
            request.setAttribute("pageSize", pageSize);

            request.getRequestDispatcher("fee-management.jsp").forward(request, response);

        } catch (Exception e) {
            log("Error retrieving payment history", e);
            request.setAttribute("error", "Error retrieving payment history");
            request.getRequestDispatcher("fee-management.jsp").forward(request, response);
        }
    }

    private boolean validateCsrfToken(HttpServletRequest request) {
        String sessionToken = (String) request.getSession().getAttribute("csrfToken");
        String requestToken = request.getParameter("csrfToken");
        return sessionToken != null && sessionToken.equals(requestToken);
    }
}
