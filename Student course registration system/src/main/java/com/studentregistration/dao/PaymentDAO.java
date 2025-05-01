package com.studentregistration.dao;

import com.studentregistration.model.PaymentRecord;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class PaymentDAO {
    private static final Logger logger = LoggerFactory.getLogger(PaymentDAO.class);

    public static List<PaymentRecord> getPaymentHistory(String studentId, String startDate, String endDate) {
        List<PaymentRecord> records = new ArrayList<>();

        String sql = "SELECT payment_id, student_id, amount, payment_date, " +
                "payment_method, status FROM payments WHERE student_id = ?";

        // Add date filters if provided
        if (startDate != null && !startDate.isEmpty() &&
                endDate != null && !endDate.isEmpty()) {
            sql += " AND payment_date BETWEEN ? AND ?";
        }
        sql += " ORDER BY payment_date DESC";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            // Set parameters
            stmt.setString(1, studentId);

            if (startDate != null && !startDate.isEmpty() &&
                    endDate != null && !endDate.isEmpty()) {
                stmt.setString(2, startDate);
                stmt.setString(3, endDate);
            }

            // Execute query and process results
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    PaymentRecord record = new PaymentRecord();
                    record.setPaymentId(rs.getString("payment_id"));
                    record.setStudentId(rs.getString("student_id"));
                    record.setAmount(rs.getDouble("amount"));
                    record.setPaymentDate(rs.getString("payment_date"));
                    record.setPaymentMethod(rs.getString("payment_method"));
                    record.setStatus(rs.getString("status"));

                    // Calculate cancellation status
                    if (rs.getTimestamp("payment_date") != null) {
                        long paymentTime = rs.getTimestamp("payment_date").getTime();
                        long twentyFourHours = 24 * 60 * 60 * 1000;
                        record.setCanCancel((System.currentTimeMillis() - paymentTime) < twentyFourHours);
                        record.setTimestamp(paymentTime);
                    }

                    records.add(record);
                }
            }
        } catch (SQLException e) {
            logger.error("Error retrieving payment history for student: {}", studentId, e);
            throw new DataAccessException("Failed to retrieve payment history", e);
        }

        return records;
    }
}