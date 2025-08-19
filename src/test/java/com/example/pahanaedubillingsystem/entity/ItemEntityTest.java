package com.example.pahanaedubillingsystem.entity;

import com.example.pahanaedubillingsystem.backend.entity.Item;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class ItemEntityTest {

    @Test
    void constructorAndGettersWork() {
        Item i = new Item("I001", "Pen", 1.5, 10);
        assertEquals("I001", i.getItemId());
        assertEquals("Pen", i.getName());
        assertEquals(1.5, i.getPrice(), 1e-9);
        assertEquals(10, i.getQty());
    }

    @Test
    void settersUpdateFields() {
        Item i = new Item();
        i.setItemId("I002");
        i.setName("Book");
        i.setPrice(0.0);
        i.setQty(0);
        assertEquals("I002", i.getItemId());
        assertEquals("Book", i.getName());
        assertEquals(0.0, i.getPrice(), 1e-9);
        assertEquals(0, i.getQty());
    }

    @Test
    void toStringIncludesKeyFields() {
        Item i = new Item();
        i.setItemId("I003");
        i.setName("Pencil");
        String s = i.toString();
        assertNotNull(s);
        assertTrue(s.contains("I003"));
        assertTrue(s.contains("Pencil"));
    }

    @Test
    void handlesNegativeValues() {
        Item i = new Item();
        i.setPrice(-1.0);
        i.setQty(-2);
        assertEquals(-1.0, i.getPrice(), 1e-9);
        assertEquals(-2, i.getQty());
    }
}
