package com.studentregistration.model;

import java.time.LocalDateTime;

public class PaymentRecord {
    private String paymentId;
    private String studentId;
    private double amount;
    private String paymentDate;
    private String paymentMethod;
    private String status;
    private boolean canCancel;
    private long timestamp;

    // Default constructor
    public PaymentRecord() {
    }

    // Parameterized constructor
    public PaymentRecord(String paymentId, String studentId, double amount,
                         String paymentDate, String paymentMethod, String status,
                         boolean canCancel, long timestamp) {
        this.paymentId = paymentId;
        this.studentId = studentId;
        this.amount = amount;
        this.paymentDate = paymentDate;
        this.paymentMethod = paymentMethod;
        this.status = status;
        this.canCancel = canCancel;
        this.timestamp = timestamp;
    }

    // Getters and Setters
    public String getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(String paymentId) {
        this.paymentId = paymentId;
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

    public String getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(String paymentDate) {
        this.paymentDate = paymentDate;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public boolean isCanCancel() {
        return canCancel;
    }

    public void setCanCancel(boolean canCancel) {
        this.canCancel = canCancel;
    }

    public long getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(long timestamp) {
        this.timestamp = timestamp;
    }

    // Helper method to check if payment can be canceled
    public boolean isWithinCancellationWindow() {
        long currentTime = System.currentTimeMillis();
        long paymentTime = this.timestamp;
        long twentyFourHours = 24 * 60 * 60 * 1000; // 24 hours in milliseconds
        return (currentTime - paymentTime) < twentyFourHours;
    }

    @Override
    public String toString() {
        return "PaymentRecord{" +
                "paymentId='" + paymentId + '\'' +
                ", studentId='" + studentId + '\'' +
                ", amount=" + amount +
                ", paymentDate='" + paymentDate + '\'' +
                ", paymentMethod='" + paymentMethod + '\'' +
                ", status='" + status + '\'' +
                ", canCancel=" + canCancel +
                ", timestamp=" + timestamp +
                '}';
    }
}
