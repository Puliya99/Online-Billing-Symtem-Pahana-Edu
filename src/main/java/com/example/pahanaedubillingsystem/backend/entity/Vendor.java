package com.example.pahanaedubillingsystem.backend.entity;

public class Vendor {
    private String grnId;
    private String name;
    private String itemId;
    private String description;
    private int qty;
    private double buyingPrice;

    public Vendor(String grnId, String name, String itemId, String description, int qty, double buyingPrice) {
        this.grnId = grnId;
        this.name = name;
        this.itemId = itemId;
        this.description = description;
        this.qty = qty;
        this.buyingPrice = buyingPrice;
    }

    public Vendor() {
    }

    public String getGrnId() {
        return grnId;
    }

    public void setGrnId(String grnId) {
        this.grnId = grnId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getItemId() {
        return itemId;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getQty() {
        return qty;
    }

    public void setQty(int qty) {
        this.qty = qty;
    }

    public double getBuyingPrice() {
        return buyingPrice;
    }

    public void setBuyingPrice(double buyingPrice) {
        this.buyingPrice = buyingPrice;
    }

    @Override
    public String toString() {
        return "Vendor{" +
                "grnId='" + grnId + '\'' +
                ", name='" + name + '\'' +
                ", itemId='" + itemId + '\'' +
                ", description='" + description + '\'' +
                ", qty=" + qty +
                ", buyingPrice=" + buyingPrice +
                '}';
    }
}
