package com.example.pahanaedubillingsystem.dto;

import com.example.pahanaedubillingsystem.backend.dto.VendorDTO;
import org.junit.jupiter.api.Test;

import java.util.Date;

import static org.junit.jupiter.api.Assertions.*;

class VendorDTOTest {

    @Test
    void constructorAndGettersWork() {
        Date d = new Date(0L);
        VendorDTO dto = new VendorDTO("G001", d, "ABC", "I001", "desc", 5, 10.0);
        assertEquals("G001", dto.getGrnId());
        assertEquals(d, dto.getGrnDate());
        assertEquals("ABC", dto.getName());
        assertEquals("I001", dto.getItemId());
        assertEquals("desc", dto.getDescription());
        assertEquals(5, dto.getQty());
        assertEquals(10.0, dto.getBuyingPrice(), 1e-9);
    }

    @Test
    void settersUpdateFields() {
        VendorDTO dto = new VendorDTO();
        Date d = new Date();
        dto.setGrnId("G002");
        dto.setGrnDate(d);
        dto.setName("XYZ");
        dto.setItemId("I002");
        dto.setDescription("d");
        dto.setQty(0);
        dto.setBuyingPrice(0.0);
        assertEquals("G002", dto.getGrnId());
        assertEquals(d, dto.getGrnDate());
        assertEquals("XYZ", dto.getName());
        assertEquals("I002", dto.getItemId());
        assertEquals("d", dto.getDescription());
        assertEquals(0, dto.getQty());
        assertEquals(0.0, dto.getBuyingPrice(), 1e-9);
    }

    @Test
    void toStringIncludesKeyFields() {
        VendorDTO dto = new VendorDTO();
        dto.setGrnId("G003");
        dto.setName("NAME");
        String s = dto.toString();
        assertNotNull(s);
        assertTrue(s.contains("G003"));
        assertTrue(s.contains("NAME"));
    }

    @Test
    void handlesNegativeValues() {
        VendorDTO dto = new VendorDTO();
        dto.setQty(-1);
        dto.setBuyingPrice(-2.5);
        assertEquals(-1, dto.getQty());
        assertEquals(-2.5, dto.getBuyingPrice(), 1e-9);
    }
}
