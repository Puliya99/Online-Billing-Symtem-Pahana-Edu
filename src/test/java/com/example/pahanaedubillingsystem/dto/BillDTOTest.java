package com.example.pahanaedubillingsystem.dto;

import com.example.pahanaedubillingsystem.backend.dto.BillDTO;
import org.junit.jupiter.api.Test;

import java.util.Date;

import static org.junit.jupiter.api.Assertions.*;

class BillDTOTest {

    @Test
    void constructorAndGettersWork() {
        Date d = new Date(0L);
        BillDTO dto = new BillDTO("B001", d, "A001", "C001", 10, 123.45);
        assertEquals("B001", dto.getBillId());
        assertEquals(d, dto.getBillDate());
        assertEquals("A001", dto.getAccountNo());
        assertEquals("C001", dto.getCartId());
        assertEquals(10, dto.getDiscount());
        assertEquals(123.45, dto.getTotalAmount(), 1e-9);
    }

    @Test
    void settersUpdateFields() {
        BillDTO dto = new BillDTO();
        Date d = new Date();
        dto.setBillId("B002");
        dto.setBillDate(d);
        dto.setAccountNo("A002");
        dto.setCartId("C002");
        dto.setDiscount(5);
        dto.setTotalAmount(99.99);
        assertEquals("B002", dto.getBillId());
        assertEquals(d, dto.getBillDate());
        assertEquals("A002", dto.getAccountNo());
        assertEquals("C002", dto.getCartId());
        assertEquals(5, dto.getDiscount());
        assertEquals(99.99, dto.getTotalAmount(), 1e-9);
    }

    @Test
    void toStringIncludesKeyFields() {
        BillDTO dto = new BillDTO();
        dto.setBillId("B003");
        dto.setAccountNo("ACC");
        String s = dto.toString();
        assertNotNull(s);
        assertTrue(s.contains("B003"));
        assertTrue(s.contains("ACC"));
    }

    @Test
    void handlesZeroAndNegativeValues() {
        BillDTO dto = new BillDTO();
        dto.setDiscount(-1);
        dto.setTotalAmount(0.0);
        assertEquals(-1, dto.getDiscount());
        assertEquals(0.0, dto.getTotalAmount(), 1e-9);
    }
}
