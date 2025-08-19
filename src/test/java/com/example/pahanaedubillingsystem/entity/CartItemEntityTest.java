package com.example.pahanaedubillingsystem.entity;

import com.example.pahanaedubillingsystem.backend.entity.Cart_Item;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class CartItemEntityTest {

    @Test
    void constructorAndGettersWork() {
        Cart_Item ci = new Cart_Item("C001", "I001", 1, 2.0, 2.0);
        assertEquals("C001", ci.getCartId());
        assertEquals("I001", ci.getItemId());
        assertEquals(1, ci.getQty());
        assertEquals(2.0, ci.getUnitPrice(), 1e-9);
        assertEquals(2.0, ci.getLineTotal(), 1e-9);
    }

    @Test
    void settersUpdateFields() {
        Cart_Item ci = new Cart_Item();
        ci.setCartId("C002");
        ci.setItemId("I002");
        ci.setQty(0);
        ci.setUnitPrice(0.0);
        ci.setLineTotal(0.0);
        assertEquals("C002", ci.getCartId());
        assertEquals("I002", ci.getItemId());
        assertEquals(0, ci.getQty());
        assertEquals(0.0, ci.getUnitPrice(), 1e-9);
        assertEquals(0.0, ci.getLineTotal(), 1e-9);
    }

    @Test
    void toStringIncludesKeyFields() {
        Cart_Item ci = new Cart_Item();
        ci.setCartId("C003");
        ci.setItemId("I003");
        String s = ci.toString();
        assertNotNull(s);
        assertTrue(s.contains("C003"));
        assertTrue(s.contains("I003"));
    }

    @Test
    void handlesNegativeValues() {
        Cart_Item ci = new Cart_Item();
        ci.setQty(-1);
        ci.setUnitPrice(-2.0);
        ci.setLineTotal(-3.0);
        assertEquals(-1, ci.getQty());
        assertEquals(-2.0, ci.getUnitPrice(), 1e-9);
        assertEquals(-3.0, ci.getLineTotal(), 1e-9);
    }
}
