package com.example.pahanaedubillingsystem.backend.entity;

public class Cart {
    private String cartId;
    private String description;

    public Cart(String cartId, String description) {
        this.cartId = cartId;
        this.description = description;
    }

    public Cart() {
    }

    public String getCartId() {
        return cartId;
    }

    public void setCartId(String cartId) {
        this.cartId = cartId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "Cart{" +
                "cartId='" + cartId + '\'' +
                ", description='" + description + '\'' +
                '}';
    }
}
