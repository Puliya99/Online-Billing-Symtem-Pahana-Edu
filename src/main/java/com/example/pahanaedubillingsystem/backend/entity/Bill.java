package com.example.pahanaedubillingsystem.backend.entity;

import java.util.Date;

public class Bill {
    private String billId;
    private Date billDate;
    private String accountNo;
    private String itemId;
    private int qty;
    private double unitPrice;
    private double discount;
    private double totalAmount;

    public Bill(String billId, Date billDate, String accountNo, String itemId, int qty, double unitPrice, double discount, double totalAmount) {
        this.billId = billId;
        this.billDate = billDate;
        this.accountNo = accountNo;
        this.itemId = itemId;
        this.qty = qty;
        this.unitPrice = unitPrice;
        this.discount = discount;
        this.totalAmount = totalAmount;
    }

    public Bill() {
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

    public String getItemId() {
        return itemId;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId;
    }

    public int getQty() {
        return qty;
    }

    public void setQty(int qty) {
        this.qty = qty;
    }

    public double getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(double unitPrice) {
        this.unitPrice = unitPrice;
    }

    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    @Override
    public String toString() {
        return "Bill{" +
                "billId='" + billId + '\'' +
                ", billDate=" + billDate +
                ", accountNo='" + accountNo + '\'' +
                ", itemId='" + itemId + '\'' +
                ", qty=" + qty +
                ", unitPrice=" + unitPrice +
                ", discount=" + discount +
                ", totalAmount=" + totalAmount +
                '}';
    }
}
