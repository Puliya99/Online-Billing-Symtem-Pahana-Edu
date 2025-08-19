package com.example.pahanaedubillingsystem.dto;

import com.example.pahanaedubillingsystem.backend.dto.CustomerDTO;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class CustomerDTOTest {

    @Test
    void constructorAndGettersWork() {
        CustomerDTO dto = new CustomerDTO("A001", "John", "123 Street", "0771234567", 50);
        assertEquals("A001", dto.getAccountNo());
        assertEquals("John", dto.getName());
        assertEquals("123 Street", dto.getAddress());
        assertEquals("0771234567", dto.getTelephone());
        assertEquals(50, dto.getUnitsConsumed());
    }

    @Test
    void settersUpdateFields() {
        CustomerDTO dto = new CustomerDTO();
        dto.setAccountNo("A002");
        dto.setName("Jane");
        dto.setAddress("456 Road");
        dto.setTelephone("0710000000");
        dto.setUnitsConsumed(0);
        assertEquals("A002", dto.getAccountNo());
        assertEquals("Jane", dto.getName());
        assertEquals("456 Road", dto.getAddress());
        assertEquals("0710000000", dto.getTelephone());
        assertEquals(0, dto.getUnitsConsumed());
    }

    @Test
    void toStringIncludesKeyFields() {
        CustomerDTO dto = new CustomerDTO();
        dto.setAccountNo("A003");
        dto.setName("Doe");
        String s = dto.toString();
        assertNotNull(s);
        assertTrue(s.contains("A003"));
        assertTrue(s.contains("Doe"));
    }

    @Test
    void handlesNegativeUnits() {
        CustomerDTO dto = new CustomerDTO();
        dto.setUnitsConsumed(-5);
        assertEquals(-5, dto.getUnitsConsumed());
    }
}
