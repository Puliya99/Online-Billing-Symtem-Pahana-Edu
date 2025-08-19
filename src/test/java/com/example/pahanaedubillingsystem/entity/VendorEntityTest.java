package com.example.pahanaedubillingsystem.entity;

import com.example.pahanaedubillingsystem.backend.entity.Vendor;
import org.junit.jupiter.api.Test;

import java.util.Date;

import static org.junit.jupiter.api.Assertions.*;

class VendorEntityTest {

    @Test
    void constructorAndGettersWork() {
        Date d = new Date(0L);
        Vendor v = new Vendor("G001", d, "ABC", "I001", "desc", 1, 2.0);
        assertEquals("G001", v.getGrnId());
        assertEquals(d, v.getGrnDate());
        assertEquals("ABC", v.getName());
        assertEquals("I001", v.getItemId());
        assertEquals("desc", v.getDescription());
        assertEquals(1, v.getQty());
        assertEquals(2.0, v.getBuyingPrice(), 1e-9);
    }

    @Test
    void settersUpdateFields() {
        Vendor v = new Vendor();
        Date d = new Date();
        v.setGrnId("G002");
        v.setGrnDate(d);
        v.setName("XYZ");
        v.setItemId("I002");
        v.setDescription("d");
        v.setQty(0);
        v.setBuyingPrice(0.0);
        assertEquals("G002", v.getGrnId());
        assertEquals(d, v.getGrnDate());
        assertEquals("XYZ", v.getName());
        assertEquals("I002", v.getItemId());
        assertEquals("d", v.getDescription());
        assertEquals(0, v.getQty());
        assertEquals(0.0, v.getBuyingPrice(), 1e-9);
    }

    @Test
    void toStringIncludesKeyFields() {
        Vendor v = new Vendor();
        v.setGrnId("G003");
        v.setName("NAME");
        String s = v.toString();
        assertNotNull(s);
        assertTrue(s.contains("G003"));
        assertTrue(s.contains("NAME"));
    }

    @Test
    void handlesNegativeValues() {
        Vendor v = new Vendor();
        v.setQty(-1);
        v.setBuyingPrice(-1.0);
        assertEquals(-1, v.getQty());
        assertEquals(-1.0, v.getBuyingPrice(), 1e-9);
    }
}
