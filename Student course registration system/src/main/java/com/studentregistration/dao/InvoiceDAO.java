package com.studentregistration.dao;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class InvoiceDAO {
    private static final Logger logger = Logger.getLogger(InvoiceDAO.class.getName());

    // Database connection parameters (configure these for your environment)
    private static final String DB_URL = "jdbc:mysql://localhost:3306/student_registration";
    private static final String DB_USER = "your_db_username";
    private static final String DB_PASSWORD = "your_db_password";

    public static boolean invoiceExists(String invoiceId) {
        String sql = "SELECT COUNT(*) FROM invoices WHERE invoice_id = ?";

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, invoiceId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error checking invoice existence", e);
        }
        return false;
    }

    public static boolean isInvoiceVoided(String invoiceId) {
        String sql = "SELECT status FROM invoices WHERE invoice_id = ?";

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, invoiceId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return "VOIDED".equals(rs.getString("status"));
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error checking invoice status", e);
        }
        return false;
    }

    public static boolean voidInvoice(String invoiceId, String reason) {
        String sql = "UPDATE invoices SET status = 'VOIDED', void_reason = ?, void_date = NOW() WHERE invoice_id = ? AND status != 'VOIDED'";

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, reason);
            stmt.setString(2, invoiceId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error voiding invoice", e);
            return false;
        }
    }

    // Initialize database connection pool (recommended for production)
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            logger.log(Level.SEVERE, "MySQL JDBC Driver not found", e);
        }
    }
}