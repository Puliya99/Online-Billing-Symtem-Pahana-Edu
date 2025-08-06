package com.example.pahanaedubillingsystem.backend.dto;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;

public class BillDTO {
    private String billId;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "UTC")
    private Date billDate;
    private String accountNo;
    private double totalAmount;

    public BillDTO(String billId, Date billDate, String accountNo, double totalAmount) {
        this.billId = billId;
        this.billDate = billDate;
        this.accountNo = accountNo;
        this.totalAmount = totalAmount;
    }

    public BillDTO() {
    }

    public String getBillId() {
        return billId;
    }

    public void setBillId(String billId) {
        this.billId = billId;
    }

    public Date getBillDate() {
        return billDate;
    }

    public void setBillDate(Date billDate) {
        this.billDate = billDate;
    }

    public String getAccountNo() {
        return accountNo;
    }

    public void setAccountNo(String accountNo) {
        this.accountNo = accountNo;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    @Override
    public String toString() {
        return "BillDTO{" +
                "billId='" + billId + '\'' +
                ", billDate=" + billDate +
                ", accountNo='" + accountNo + '\'' +
                ", totalAmount=" + totalAmount +
                '}';
    }
}
