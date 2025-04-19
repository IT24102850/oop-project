public class PaymentDAO {
    public static List<PaymentRecord> getPaymentHistory(String studentId, String startDate, String endDate) {
        // Implementation to query database
    }

    public static PaymentRecord getPayment(String paymentId) {
        // Implementation to get single payment
    }

    public static boolean paymentExists(String paymentId) {
        // Implementation to check if payment exists
    }

    public static boolean isWithinCancellationWindow(String paymentId) {
        // Implementation to check cancellation window
    }

    public static boolean cancelPayment(String paymentId, String reason) {
        // Implementation to cancel payment
    }

    public static PaymentRecord getPaymentDetails(String paymentId) {
        // Implementation to get detailed payment info
    }
}
