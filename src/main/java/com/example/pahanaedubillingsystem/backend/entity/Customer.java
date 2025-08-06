package com.example.pahanaedubillingsystem.backend.entity;

public class Customer {
    private String accountNo;
    private String name;
    private String address;
    private String telephone;
    private int unitsConsumed;

    public Customer(String accountNo, String name, String address, String telephone, int unitsConsumed) {
        this.accountNo = accountNo;
        this.name = name;
        this.address = address;
        this.telephone = telephone;
        this.unitsConsumed = unitsConsumed;
    }

    public Customer() {
    }

    public String getAccountNo() {
        return accountNo;
    }

    public void setAccountNo(String accountNo) {
        this.accountNo = accountNo;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public int getUnitsConsumed() {
        return unitsConsumed;
    }

    public void setUnitsConsumed(int unitsConsumed) {
        this.unitsConsumed = unitsConsumed;
    }

    @Override
    public String toString() {
        return "Customer{" +
                "accountNo='" + accountNo + '\'' +
                ", name='" + name + '\'' +
                ", address='" + address + '\'' +
                ", telephone='" + telephone + '\'' +
                ", unitsConsumed=" + unitsConsumed +
                '}';
    }
}

