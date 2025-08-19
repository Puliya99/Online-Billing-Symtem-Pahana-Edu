package com.example.pahanaedubillingsystem.entity;

import com.example.pahanaedubillingsystem.backend.entity.Cart;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class CartEntityTest {

    @Test
    void constructorAndGettersWork() {
        Cart c = new Cart("C001", "d");
        assertEquals("C001", c.getCartId());
        assertEquals("d", c.getDescription());
    }

    @Test
    void settersUpdateFields() {
        Cart c = new Cart();
        c.setCartId("C002");
        c.setDescription("x");
        assertEquals("C002", c.getCartId());
        assertEquals("x", c.getDescription());
    }

    @Test
    void toStringIncludesKeyFields() {
        Cart c = new Cart();
        c.setCartId("C003");
        String s = c.toString();
        assertNotNull(s);
        assertTrue(s.contains("C003"));
    }

    @Test
    void handlesNullsGracefully() {
        Cart c = new Cart(null, null);
        assertNull(c.getCartId());
        assertNull(c.getDescription());
    }
}
