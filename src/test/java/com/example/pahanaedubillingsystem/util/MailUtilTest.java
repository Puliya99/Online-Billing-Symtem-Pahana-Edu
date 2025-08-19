package com.example.pahanaedubillingsystem.util;

import com.example.pahanaedubillingsystem.backend.util.MailUtil;
import org.junit.jupiter.api.*;

import static org.junit.jupiter.api.Assertions.*;

class MailUtilTest {

    @BeforeAll
    static void enableTestMode() {
        System.setProperty("test.mode", "true");
    }

    @AfterEach
    void cleanup() {
        System.clearProperty("mail.host");
        System.clearProperty("mail.user");
        System.clearProperty("mail.pass");
    }

    @Test
    void isConfiguredFalseByDefault() {
        System.clearProperty("mail.host");
        assertFalse(MailUtil.isConfigured());
    }

    @Test
    void isConfiguredTrueWhenSystemPropertySet() {
        System.setProperty("mail.host", "smtp.example.com");
        assertTrue(MailUtil.isConfigured());
    }

    @Test
    void sendReturnsFalseWhenHostNotConfigured() {
        System.clearProperty("mail.host");
        boolean result = MailUtil.send("someone@example.com", "sub", "body");
        assertFalse(result);
    }

    @Test
    void sendDoesNotThrowOnInvalidCredentials() {
        System.setProperty("mail.host", "smtp.gmail.com");
        System.setProperty("mail.port", "587");
        System.setProperty("mail.user", "fakeuser@gmail.com");
        System.setProperty("mail.pass", "wrong");
        boolean result = MailUtil.send("someone@example.com", "subject", "body");
        assertFalse(result);
    }
}
