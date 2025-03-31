package com.studentregistration.dao;

import com.studentregistration.model.FeeInvoice;
import java.io.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class FeeDAO {
    private static final String FILE_PATH = "src/main/resources/fee_invoices.txt";

    // Create a new invoice
    public String createInvoice(FeeInvoice invoice) throws IOException {
        String invoiceId = "INV-" + UUID.randomUUID().toString().substring(0, 8);
        invoice.setInvoiceId(invoiceId);

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            writer.write(invoiceToFileString(invoice) + "\n");
        }
        return invoiceId;
    }

    // Get all invoices for a student
    public List<FeeInvoice> getInvoicesByStudent(String studentId) throws IOException {
        List<FeeInvoice> invoices = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                FeeInvoice invoice = parseInvoiceFromFile(line);
                if (invoice.getStudentId().equals(studentId)) {
                    invoices.add(invoice);
                }
            }
        }
        return invoices;
    }

    // Apply late fee waiver
    public void applyLateFeeWaiver(String invoiceId, double waiverAmount) throws IOException {
        List<FeeInvoice> invoices = getAllInvoices();
        for (FeeInvoice invoice : invoices) {
            if (invoice.getInvoiceId().equals(invoiceId)) {
                invoice.setLateFee(invoice.getLateFee() - waiverAmount);
                break;
            }
        }
        rewriteAllInvoices(invoices);
    }

    // Void an invoice
    public void voidInvoice(String invoiceId) throws IOException {
        List<FeeInvoice> invoices = getAllInvoices();
        for (FeeInvoice invoice : invoices) {
            if (invoice.getInvoiceId().equals(invoiceId)) {
                invoice.setVoided(true);
                break;
            }
        }
        rewriteAllInvoices(invoices);
    }

    // Helper methods
    private List<FeeInvoice> getAllInvoices() throws IOException {
        List<FeeInvoice> invoices = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                invoices.add(parseInvoiceFromFile(line));
            }
        }
        return invoices;
    }

    private void rewriteAllInvoices(List<FeeInvoice> invoices) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (FeeInvoice invoice : invoices) {
                writer.write(invoiceToFileString(invoice) + "\n");
            }
        }
    }

    private String invoiceToFileString(FeeInvoice invoice) {
        return String.join("|",
                invoice.getInvoiceId(),
                invoice.getStudentId(),
                String.valueOf(invoice.getAmount()),
                invoice.getIssueDate().toString(),
                invoice.getDueDate().toString(),
                String.valueOf(invoice.isPaid()),
                String.valueOf(invoice.isVoided()),
                String.valueOf(invoice.getLateFee()),
                invoice.getDescription());
    }

    private FeeInvoice parseInvoiceFromFile(String line) {
        String[] parts = line.split("\\|");
        FeeInvoice invoice = new FeeInvoice(
                parts[0], parts[1], Double.parseDouble(parts[2]),
                LocalDate.parse(parts[3]), LocalDate.parse(parts[4]), parts[8]);
        invoice.setPaid(Boolean.parseBoolean(parts[5]));
        invoice.setVoided(Boolean.parseBoolean(parts[6]));
        invoice.setLateFee(Double.parseDouble(parts[7]));
        return invoice;
    }
}
