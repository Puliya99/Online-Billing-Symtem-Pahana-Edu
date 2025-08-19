package com.example.pahanaedubillingsystem.dto;

import com.example.pahanaedubillingsystem.backend.constant.Role;
import com.example.pahanaedubillingsystem.backend.dto.UserDTO;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class UserDTOTest {

    @Test
    void constructorAndGettersWork() {
        UserDTO dto = new UserDTO("u", "p", "e@mail", Role.Admin);
        assertEquals("u", dto.getUsername());
        assertEquals("p", dto.getPassword());
        assertEquals("e@mail", dto.getEmail());
        assertEquals(Role.Admin, dto.getRole());
    }

    @Test
    void settersUpdateFields() {
        UserDTO dto = new UserDTO();
        dto.setUsername("u2");
        dto.setPassword("p2");
        dto.setEmail("e2");
        dto.setRole(Role.User);
        assertEquals("u2", dto.getUsername());
        assertEquals("p2", dto.getPassword());
        assertEquals("e2", dto.getEmail());
        assertEquals(Role.User, dto.getRole());
    }

    @Test
    void toStringIncludesKeyFields() {
        UserDTO dto = new UserDTO();
        dto.setUsername("ux");
        dto.setEmail("ex");
        String s = dto.toString();
        assertNotNull(s);
        assertTrue(s.contains("ux"));
        assertTrue(s.contains("ex"));
    }

    @Test
    void handlesNullRole() {
        UserDTO dto = new UserDTO();
        assertNull(dto.getRole());
        dto.setRole(null);
        assertNull(dto.getRole());
    }
}
