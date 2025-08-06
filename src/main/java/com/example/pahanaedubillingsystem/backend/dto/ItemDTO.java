package com.example.pahanaedubillingsystem.backend.dto;

public class ItemDTO {
    private String itemId;
    private String name;
    private double price;
    private int qty;

    public ItemDTO(String itemId, String name, double price, int qty) {
        this.itemId = itemId;
        this.name = name;
        this.price = price;
        this.qty = qty;
    }

    public ItemDTO() {
    }

    public String getItemId() {
        return itemId;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQty() {
        return qty;
    }

    public void setQty(int qty) {
        this.qty = qty;
    }
}