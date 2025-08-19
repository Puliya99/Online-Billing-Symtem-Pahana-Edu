package com.example.pahanaedubillingsystem.dto;

import com.example.pahanaedubillingsystem.backend.dto.CartDTO;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class CartDTOTest {

    @Test
    void constructorAndGettersWork() {
        CartDTO dto = new CartDTO("C001", "desc");
        assertEquals("C001", dto.getCartId());
        assertEquals("desc", dto.getDescription());
    }

    @Test
    void settersUpdateFields() {
        CartDTO dto = new CartDTO();
        dto.setCartId("C002");
        dto.setDescription("d");
        assertEquals("C002", dto.getCartId());
        assertEquals("d", dto.getDescription());
    }

    @Test
    void toStringIncludesKeyFields() {
        CartDTO dto = new CartDTO();
        dto.setCartId("C003");
        String s = dto.toString();
        assertNotNull(s);
        assertTrue(s.contains("C003"));
    }

    @Test
    void handlesNullsGracefully() {
        CartDTO dto = new CartDTO(null, null);
        assertNull(dto.getCartId());
        assertNull(dto.getDescription());
    }
}
