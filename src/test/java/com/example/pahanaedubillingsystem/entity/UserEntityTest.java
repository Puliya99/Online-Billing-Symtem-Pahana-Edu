package com.example.pahanaedubillingsystem.entity;

import com.example.pahanaedubillingsystem.backend.constant.Role;
import com.example.pahanaedubillingsystem.backend.entity.User;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class UserEntityTest {

    @Test
    void constructorAndGettersWork() {
        User u = new User("u", "p", "e", Role.Admin);
        assertEquals("u", u.getUsername());
        assertEquals("p", u.getPassword());
        assertEquals("e", u.getEmail());
        assertEquals(Role.Admin, u.getRole());
    }

    @Test
    void settersUpdateFields() {
        User u = new User();
        u.setUsername("u2");
        u.setPassword("p2");
        u.setEmail("e2");
        u.setRole(Role.User);
        assertEquals("u2", u.getUsername());
        assertEquals("p2", u.getPassword());
        assertEquals("e2", u.getEmail());
        assertEquals(Role.User, u.getRole());
    }

    @Test
    void toStringIncludesKeyFields() {
        User u = new User();
        u.setUsername("ux");
        u.setEmail("ex");
        String s = u.toString();
        assertNotNull(s);
        assertTrue(s.contains("ux"));
        assertTrue(s.contains("ex"));
    }

    @Test
    void allowsNullRole() {
        User u = new User();
        u.setRole(null);
        assertNull(u.getRole());
    }
}
