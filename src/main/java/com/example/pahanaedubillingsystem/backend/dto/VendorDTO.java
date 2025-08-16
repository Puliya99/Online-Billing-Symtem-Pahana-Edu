package com.example.pahanaedubillingsystem.backend.dto;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;

public class VendorDTO {
    private String grnId;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "UTC")
    private Date grnDate;
    private String name;
    private String itemId;
    private String description;
    private int qty;
    private double buyingPrice;

    public VendorDTO(String grnId, Date grnDate, String name, String itemId, String description, int qty, double buyingPrice) {
        this.grnId = grnId;
        this.grnDate = grnDate;
        this.name = name;
        this.itemId = itemId;
        this.description = description;
        this.qty = qty;
        this.buyingPrice = buyingPrice;
    }

    public VendorDTO() {
    }

    public String getGrnId() {
        return grnId;
    }

    public void setGrnId(String grnId) {
        this.grnId = grnId;
    }

    public Date getGrnDate() {
        return grnDate;
    }

    public void setGrnDate(Date grnDate) {
        this.grnDate = grnDate;
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
        return "VendorDTO{" +
                "grnId='" + grnId + '\'' +
                ", grnDate=" + grnDate +
                ", name='" + name + '\'' +
                ", itemId='" + itemId + '\'' +
                ", description='" + description + '\'' +
                ", qty=" + qty +
                ", buyingPrice=" + buyingPrice +
                '}';
    }
}
