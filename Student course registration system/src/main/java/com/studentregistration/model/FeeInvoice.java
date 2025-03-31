package com.studentregistration.model;

import java.time.LocalDate;

public class FeeInvoice {
    private String invoiceId;
    private String studentId;
    private double amount;
    private LocalDate issueDate;
    private LocalDate dueDate;
    private boolean isPaid;
    private boolean isVoided;
    private double lateFee;
    private String description;

    // Constructor
    public FeeInvoice(String invoiceId, String studentId, double amount,
                      LocalDate issueDate, LocalDate dueDate, String description) {
        this.invoiceId = invoiceId;
        this.studentId = studentId;
        this.amount = amount;
        this.issueDate = issueDate;
        this.dueDate = dueDate;
        this.description = description;
        this.isPaid = false;
        this.isVoided = false;
        this.lateFee = 0.0;
    }

    // Getters and Setters
    public String getInvoiceId() { return invoiceId; }
    public String getStudentId() { return studentId; }
    public double getAmount() { return amount; }
    public LocalDate getIssueDate() { return issueDate; }
    public LocalDate getDueDate() { return dueDate; }
    public boolean isPaid() { return isPaid; }
    public boolean isVoided() { return isVoided; }
    public double getLateFee() { return lateFee; }
    public String getDescription() { return description; }

    public void setPaid(boolean paid) { isPaid = paid; }
    public void setVoided(boolean voided) { isVoided = voided; }
    public void setLateFee(double lateFee) { this.lateFee = lateFee; }

    public double getTotalAmount() {
        return amount + lateFee;
    }
}
