package com.example.pahanaedubillingsystem.backend.dto;

public class CartDTO {
    private String cartId;
    private String description;

    public CartDTO(String cartId, String description) {
        this.cartId = cartId;
        this.description = description;
    }

    public CartDTO() {
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
        return "CartDTO{" + "cartId=" + cartId + ", description=" + description + '}';
    }
}

