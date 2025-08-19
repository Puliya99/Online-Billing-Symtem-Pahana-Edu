package com.example.pahanaedubillingsystem.backend.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class MailUtil {
    private static final Logger log = LoggerFactory.getLogger(MailUtil.class);
    private static final Properties appProps = loadProperties();

    private static Properties loadProperties() {
        Properties props = new Properties();

        if ("true".equals(System.getProperty("test.mode"))) {
            log.info("Skipping application.properties load in test mode");
            return props;
        }

        try (InputStream in = MailUtil.class.getClassLoader().getResourceAsStream("application.properties")) {
            if (in != null) {
                props.load(in);
                log.info("Successfully loaded application.properties");
            } else {
                log.info("application.properties not found on classpath; relying on env/system properties");
            }
        } catch (IOException e) {
            log.warn("Failed to load application.properties: {}", e.getMessage());
        }
        return props;
    }

    public static boolean send(String to, String subject, String body) {
        try {
            String host = getCfg("mail.host", getCfg("MAIL_HOST", "smtp.gmail.com"));
            String port = getCfg("mail.port", getCfg("MAIL_PORT", "587"));
            String user = getCfg("mail.user", getCfg("MAIL_USER", null));
            String pass = getCfg("mail.pass", getCfg("MAIL_PASS", null));
            String from = getCfg("mail.from", getCfg("MAIL_FROM", user != null ? user : "noreply@example.com"));
            String tlsCfg = getCfg("mail.tls", getCfg("MAIL_TLS", ""));
            boolean tls = tlsCfg.isEmpty() ? "587".equals(port) : Boolean.parseBoolean(tlsCfg);

            if (host == null || host.trim().isEmpty()) {
                log.info("mail.host not set; skipping email to {} (email delivery disabled)", safe(to));
                return false;
            }

            Properties props = new Properties();
            props.put("mail.smtp.host", host);
            props.put("mail.smtp.port", port);
            props.put("mail.smtp.auth", user != null && pass != null ? "true" : "false");
            props.put("mail.smtp.starttls.enable", tls ? "true" : "false");
            if (tls) props.put("mail.smtp.starttls.required", "true");
            props.put("mail.smtp.ssl.trust", host);
            props.put("mail.smtp.connectiontimeout", "10000");
            props.put("mail.smtp.timeout", "15000");
            props.put("mail.smtp.writetimeout", "15000");

            Authenticator authenticator = null;
            if (user != null && pass != null) {
                final String u = user;
                final String p = pass;
                authenticator = new Authenticator() {
                    @Override
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(u, p);
                    }
                };
            }

            Session session = Session.getInstance(props, authenticator);
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
            message.setSubject(subject);
            message.setText(body);

            if ("true".equals(System.getProperty("test.mode"))) {
                log.info("Test mode active, not sending real email to {}", safe(to));
                return false;
            }

            Transport.send(message);
            log.info("Mail sent to {} with subject '{}'", safe(to), safe(subject));
            return true;

        } catch (AuthenticationFailedException afe) {
            log.warn("SMTP authentication failed: {}", afe.getMessage());
            return false;
        } catch (MessagingException me) {
            log.warn("Failed to send email to {}: {}", safe(to), me.getMessage());
            return false;
        } catch (Exception e) {
            log.error("Failed to send email to {}: {}", safe(to), e.getMessage());
            return false;
        }
    }

    private static String getCfg(String key, String def) {
        String val = trimToNull(appProps.getProperty(key));
        if (val == null) {
            val = trimToNull(System.getenv(key));
            if (val == null) {
                val = trimToNull(System.getProperty(key, def));
            }
        }
        return val != null ? val : def;
    }

    private static String trimToNull(String s) {
        if (s == null) return null;
        String t = s.trim();
        return t.isEmpty() ? null : t;
    }

    private static String safe(String s) {
        if (s == null) return "";
        if (s.length() > 128) return s.substring(0, 125) + "...";
        return s;
    }

    public static boolean isConfigured() {
        String host = getCfg("mail.host", "");
        return host != null && !host.trim().isEmpty();
    }
}