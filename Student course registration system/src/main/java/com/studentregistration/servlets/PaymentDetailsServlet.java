import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import com.google.gson.Gson;  // Corrected import

@WebServlet("/PaymentDetails")
public class PaymentDetailsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String paymentId = request.getParameter("paymentId");  // Fixed parameter syntax

        try {
            // Validate payment ID format (fixed regex)
            if (paymentId == null || !paymentId.matches("PAY-\\d{4}-\\d{3}")) {
                response.getWriter().write("{\"error\":\"Invalid payment ID\"}");  // Fixed JSON syntax
                return;
            }

            PaymentRecord payment = PaymentDAO.getPaymentDetails(paymentId);
            if (payment == null) {
                response.getWriter().write("{\"error\":\"Payment not found\"}");
                return;
            }

            // Convert to JSON
            String json = new Gson().toJson(payment);  // Using correct Gson class
            response.getWriter().write(json);

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"Server error processing request\"}");
        }
    }
}