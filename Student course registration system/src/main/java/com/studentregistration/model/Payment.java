package com.studentregistration.model;

import java.io.Serializable;

public class Payment implements Serializable {
    private String invoiceId;
    private String studentId;
    private double amount;
    private String dueDate;
    private String status;
    private String paymentDate;
    private boolean waiverApplied;
    private double lateFee;
    private String paymentMethod;
    private String subscriptionPlan;
    private String startDate;

    // Constructor
    public Payment(String invoiceId, String studentId, double amount, String dueDate, String status,
                   String paymentDate, boolean waiverApplied, double lateFee, String paymentMethod,
                   String subscriptionPlan, String startDate) {
        this.invoiceId = invoiceId;
        this.studentId = studentId;
        this.amount = amount;
        this.dueDate = dueDate;
        this.status = status;
        this.paymentDate = paymentDate;
        this.waiverApplied = waiverApplied;
        this.lateFee = lateFee;
        this.paymentMethod = paymentMethod;
        this.subscriptionPlan = subscriptionPlan;
        this.startDate = startDate;
    }

    // Getters and Setters
    public String getInvoiceId() {
        return invoiceId;
    }

    public void setInvoiceId(String invoiceId) {
        this.invoiceId = invoiceId;
    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getDueDate() {
        return dueDate;
    }

    public void setDueDate(String dueDate) {
        this.dueDate = dueDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(String paymentDate) {
        this.paymentDate = paymentDate;
    }

    public boolean isWaiverApplied() {
        return waiverApplied;
    }

    public void setWaiverApplied(boolean waiverApplied) {
        this.waiverApplied = waiverApplied;
    }

    public double getLateFee() {
        return lateFee;
    }

    public void setLateFee(double lateFee) {
        this.lateFee = lateFee;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getSubscriptionPlan() {
        return subscriptionPlan;
    }

    public void setSubscriptionPlan(String subscriptionPlan) {
        this.subscriptionPlan = subscriptionPlan;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    @Override
    public String toString() {
        return String.format("%s,%s,%.2f,%s,%s,%s,%s,%.2f,%s,%s,%s",
                invoiceId, studentId, amount, dueDate, status, paymentDate,
                waiverApplied, lateFee, paymentMethod, subscriptionPlan, startDate);
    }
}