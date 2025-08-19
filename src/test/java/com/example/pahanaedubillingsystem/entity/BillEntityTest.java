package com.example.pahanaedubillingsystem.entity;

import com.example.pahanaedubillingsystem.backend.entity.Bill;
import org.junit.jupiter.api.Test;

import java.util.Date;

import static org.junit.jupiter.api.Assertions.*;

class BillEntityTest {

    @Test
    void constructorAndGettersWork() {
        Date d = new Date(0L);
        Bill b = new Bill("B001", d, "A001", "C001", 1, 2.0);
        assertEquals("B001", b.getBillId());
        assertEquals(d, b.getBillDate());
        assertEquals("A001", b.getAccountNo());
        assertEquals("C001", b.getCartId());
        assertEquals(1, b.getDiscount());
        assertEquals(2.0, b.getTotalAmount(), 1e-9);
    }

    @Test
    void settersUpdateFields() {
        Bill b = new Bill();
        Date d = new Date();
        b.setBillId("B002");
        b.setBillDate(d);
        b.setAccountNo("A002");
        b.setCartId("C002");
        b.setDiscount(0);
        b.setTotalAmount(0.0);
        assertEquals("B002", b.getBillId());
        assertEquals(d, b.getBillDate());
        assertEquals("A002", b.getAccountNo());
        assertEquals("C002", b.getCartId());
        assertEquals(0, b.getDiscount());
        assertEquals(0.0, b.getTotalAmount(), 1e-9);
    }

    @Test
    void toStringIncludesKeyFields() {
        Bill b = new Bill();
        b.setBillId("B003");
        b.setAccountNo("ACC");
        String s = b.toString();
        assertNotNull(s);
        assertTrue(s.contains("B003"));
        assertTrue(s.contains("ACC"));
    }

    @Test
    void handlesNegativeValues() {
        Bill b = new Bill();
        b.setDiscount(-2);
        b.setTotalAmount(-1);
        assertEquals(-2, b.getDiscount());
        assertEquals(-1.0, b.getTotalAmount(), 1e-9);
    }
}
