package com.example.pahanaedubillingsystem.backend.entity;

import java.util.Date;

public class Bill {
    private String billId;
    private Date billDate;
    private String accountNo;
    private String cartId;
    private int discount;
    private double totalAmount;

    public Bill(String billId, Date billDate, String accountNo, String cartId, int discount, double totalAmount) {
        this.billId = billId;
        this.billDate = billDate;
        this.accountNo = accountNo;
        this.cartId = cartId;
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

    public String getCartId() {
        return cartId;
    }

    public void setCartId(String cartId) {
        this.cartId = cartId;
    }

    public int getDiscount() {
        return discount;
    }

    public void setDiscount(int discount) {
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
                ", cartId='" + cartId + '\'' +
                ", discount=" + discount +
                ", totalAmount=" + totalAmount +
                '}';
    }
}
