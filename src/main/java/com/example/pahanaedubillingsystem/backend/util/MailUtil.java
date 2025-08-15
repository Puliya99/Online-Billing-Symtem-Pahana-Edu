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
            String from = getCfg("mail.from", getCfg("MAIL_FROM", user != null ? user : "mathagadeerapulinda@gmail.com"));
            String tlsCfg = getCfg("mail.tls", getCfg("MAIL_TLS", ""));
            boolean isO365 = host != null && host.toLowerCase().matches(".*(office365|outlook|live)\\.com$");
            boolean tls = tlsCfg.isEmpty() ? ("587".equals(port) || isO365) : Boolean.parseBoolean(tlsCfg);

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

            Transport.send(message);
            log.info("Mail sent to {} with subject '{}'", safe(to), safe(subject));
            return true;
        } catch (AuthenticationFailedException afe) {
            String msg = afe.getMessage() != null ? afe.getMessage() : afe.toString();
            String lower = msg.toLowerCase();
            String userCfg = safe(getCfg("mail.user", ""));
            String hostCfg = safe(getCfg("mail.host", ""));
            boolean isGmail = (hostCfg.toLowerCase().contains("gmail.com") || lower.contains("support.google.com") || lower.contains("gsmtp"));
            boolean isO365 = (hostCfg.toLowerCase().contains("office365") || hostCfg.toLowerCase().contains("outlook") || lower.contains("authentication unsuccessful") || lower.contains("basic authentication is disabled"));
            if (isGmail) {
                log.warn("SMTP authentication failed for user '{}'. Gmail typically requires an App Password with 2‑Step Verification. Configure: mail.host=smtp.gmail.com, mail.port=587, mail.tls=true, mail.user=<your Gmail>, mail.pass=<App Password>. See https://support.google.com/accounts/answer/185833 and https://support.google.com/mail/?p=BadCredentials. Details: {}", userCfg, msg);
            } else if (lower.contains("535") || isO365) {
                log.warn("SMTP authentication failed for user '{}'. Your mail server may have disabled Basic Auth. If using Office 365, enable SMTP AUTH for the mailbox or use an app password/modern auth. Details: {}", userCfg, msg);
            } else {
                log.warn("SMTP authentication failed: {}", msg);
            }
            return false;
        } catch (MessagingException me) {
            String msg = me.getMessage() != null ? me.getMessage() : me.toString();
            log.warn("Failed to send email to {}: {}", safe(to), msg);
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