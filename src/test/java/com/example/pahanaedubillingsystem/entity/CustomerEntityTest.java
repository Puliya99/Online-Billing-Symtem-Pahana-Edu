package com.example.pahanaedubillingsystem.entity;

import com.example.pahanaedubillingsystem.backend.entity.Customer;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class CustomerEntityTest {

    @Test
    void constructorAndGettersWork() {
        Customer c = new Customer("A001", "John", "addr", "077", 1);
        assertEquals("A001", c.getAccountNo());
        assertEquals("John", c.getName());
        assertEquals("addr", c.getAddress());
        assertEquals("077", c.getTelephone());
        assertEquals(1, c.getUnitsConsumed());
    }

    @Test
    void settersUpdateFields() {
        Customer c = new Customer();
        c.setAccountNo("A002");
        c.setName("Jane");
        c.setAddress("a");
        c.setTelephone("t");
        c.setUnitsConsumed(0);
        assertEquals("A002", c.getAccountNo());
        assertEquals("Jane", c.getName());
        assertEquals("a", c.getAddress());
        assertEquals("t", c.getTelephone());
        assertEquals(0, c.getUnitsConsumed());
    }

    @Test
    void toStringIncludesKeyFields() {
        Customer c = new Customer();
        c.setAccountNo("A003");
        c.setName("X");
        String s = c.toString();
        assertNotNull(s);
        assertTrue(s.contains("A003"));
        assertTrue(s.contains("X"));
    }

    @Test
    void handlesNegativeUnits() {
        Customer c = new Customer();
        c.setUnitsConsumed(-9);
        assertEquals(-9, c.getUnitsConsumed());
    }
}
