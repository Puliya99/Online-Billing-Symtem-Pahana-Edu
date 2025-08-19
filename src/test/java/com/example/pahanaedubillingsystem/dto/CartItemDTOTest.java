package com.example.pahanaedubillingsystem.dto;

import com.example.pahanaedubillingsystem.backend.dto.CartItemDTO;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class CartItemDTOTest {

    @Test
    void constructorAndGettersWork() {
        CartItemDTO dto = new CartItemDTO("C001", "I001", 2, 10.0, 20.0);
        assertEquals("C001", dto.getCartId());
        assertEquals("I001", dto.getItemId());
        assertEquals(2, dto.getQty());
        assertEquals(10.0, dto.getUnitPrice(), 1e-9);
        assertEquals(20.0, dto.getLineTotal(), 1e-9);
    }

    @Test
    void settersUpdateFields() {
        CartItemDTO dto = new CartItemDTO();
        dto.setCartId("C002");
        dto.setItemId("I002");
        dto.setQty(0);
        dto.setUnitPrice(0.0);
        dto.setLineTotal(0.0);
        assertEquals("C002", dto.getCartId());
        assertEquals("I002", dto.getItemId());
        assertEquals(0, dto.getQty());
        assertEquals(0.0, dto.getUnitPrice(), 1e-9);
        assertEquals(0.0, dto.getLineTotal(), 1e-9);
    }

    @Test
    void toStringIncludesKeyFields() {
        CartItemDTO dto = new CartItemDTO();
        dto.setCartId("C003");
        dto.setItemId("I003");
        String s = dto.toString();
        assertNotNull(s);
        assertTrue(s.contains("C003"));
        assertTrue(s.contains("I003"));
    }

    @Test
    void handlesNegativeValues() {
        CartItemDTO dto = new CartItemDTO();
        dto.setQty(-1);
        dto.setUnitPrice(-2.0);
        dto.setLineTotal(-3.0);
        assertEquals(-1, dto.getQty());
        assertEquals(-2.0, dto.getUnitPrice(), 1e-9);
        assertEquals(-3.0, dto.getLineTotal(), 1e-9);
    }
}
