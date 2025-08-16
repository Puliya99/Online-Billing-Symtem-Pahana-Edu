package com.example.pahanaedubillingsystem.backend.entity;

public class Cart_Item {
    private String cartId;
    private String itemId;
    private int qty;
    private double unitPrice;
    private double lineTotal;

    public Cart_Item(String cartId, String itemId, int qty, double unitPrice, double lineTotal) {
        this.cartId = cartId;
        this.itemId = itemId;
        this.qty = qty;
        this.unitPrice = unitPrice;
        this.lineTotal = lineTotal;
    }

    public Cart_Item() {
    }

    public String getCartId() {
        return cartId;
    }

    public void setCartId(String cartId) {
        this.cartId = cartId;
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

    public double getLineTotal() {
        return lineTotal;
    }

    public void setLineTotal(double lineTotal) {
        this.lineTotal = lineTotal;
    }

    @Override
    public String toString() {
        return "Cart_Item{" +
                "cartId='" + cartId + '\'' +
                ", itemId='" + itemId + '\'' +
                ", qty=" + qty +
                ", unitPrice=" + unitPrice +
                ", lineTotal=" + lineTotal +
                '}';
    }
}
