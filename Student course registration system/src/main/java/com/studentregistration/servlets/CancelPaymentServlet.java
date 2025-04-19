import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/CancelPayment")
public class CancelPaymentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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

            // Rest of your servlet code...

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("notification", "error");
            request.setAttribute("message", "Error processing payment cancellation");
            request.getRequestDispatcher("fee-management.jsp").forward(request, response);
        }
    }

    private boolean validateCsrfToken(HttpServletRequest request) {
        // Your CSRF validation logic
        return true; // Replace with actual implementation
    }
}