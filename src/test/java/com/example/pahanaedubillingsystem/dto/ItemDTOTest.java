package com.example.pahanaedubillingsystem.dto;

import com.example.pahanaedubillingsystem.backend.dto.ItemDTO;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class ItemDTOTest {

    @Test
    void constructorAndGettersWork() {
        ItemDTO dto = new ItemDTO("I001", "Pen", 12.5, 100);
        assertEquals("I001", dto.getItemId());
        assertEquals("Pen", dto.getName());
        assertEquals(12.5, dto.getPrice(), 1e-9);
        assertEquals(100, dto.getQty());
    }

    @Test
    void settersUpdateFields() {
        ItemDTO dto = new ItemDTO();
        dto.setItemId("I002");
        dto.setName("Book");
        dto.setPrice(0.0);
        dto.setQty(0);
        assertEquals("I002", dto.getItemId());
        assertEquals("Book", dto.getName());
        assertEquals(0.0, dto.getPrice(), 1e-9);
        assertEquals(0, dto.getQty());
    }

    @Test
    void toStringIncludesKeyFields() {
        ItemDTO dto = new ItemDTO();
        dto.setItemId("I003");
        dto.setName("Pencil");
        String s = dto.toString();
        assertNotNull(s);
        assertTrue(s.contains("I003"));
        assertTrue(s.contains("Pencil"));
    }

    @Test
    void handlesNegativeValues() {
        ItemDTO dto = new ItemDTO();
        dto.setPrice(-1.0);
        dto.setQty(-10);
        assertEquals(-1.0, dto.getPrice(), 1e-9);
        assertEquals(-10, dto.getQty());
    }
}
