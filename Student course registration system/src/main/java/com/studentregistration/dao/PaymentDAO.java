package com.studentregistration.dao;

import com.studentregistration.model.Payment; // Import the Payment class
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class PaymentDAO {
    private String filePath;

    public PaymentDAO(String filePath) {
        this.filePath = filePath;
    }

    // Retrieve all payments from payments.txt
    public List<Payment> getAllPayments() throws IOException {
        List<Payment> payments = new ArrayList<>();
        File file = new File(filePath);
        if (!file.exists()) {
            return payments;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.trim().isEmpty()) continue;
                String[] parts = line.split(",");
                if (parts.length < 11) continue;

                try {
                    Payment payment = new Payment(
                            parts[0], // invoiceId
                            parts[1], // studentId
                            Double.parseDouble(parts[2].replace("$", "")), // amount
                            parts[3], // dueDate
                            parts[4], // status
                            parts[5], // paymentDate
                            Boolean.parseBoolean(parts[6]), // waiverApplied
                            Double.parseDouble(parts[7].replace("$", "")), // lateFee
                            parts[8], // paymentMethod
                            parts[9], // subscriptionPlan
                            parts[10] // startDate
                    );
                    payments.add(payment);
                } catch (NumberFormatException e) {
                    System.out.println("Error parsing payment data: " + line);
                }
            }
        }
        return payments;
    }

    // Update payment status and payment date
    public boolean updatePaymentStatus(String invoiceId, String newStatus, String paymentDate) throws IOException {
        List<Payment> payments = getAllPayments();
        boolean updated = false;

        for (Payment payment : payments) {
            if (payment.getInvoiceId().equals(invoiceId)) {
                payment.setStatus(newStatus);
                payment.setPaymentDate(paymentDate);
                updated = true;
                break;
            }
        }

        if (updated) {
            // Write updated payments back to file
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
                for (Payment payment : payments) {
                    writer.write(payment.toString());
                    writer.newLine();
                }
            }
        }
        return updated;
    }
}