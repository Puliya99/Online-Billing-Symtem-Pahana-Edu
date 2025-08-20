package com.example.pahanaedubillingsystem.backend.controller;

import com.example.pahanaedubillingsystem.backend.bo.BOFactory;
import com.example.pahanaedubillingsystem.backend.bo.custom.CustomerBO;
import com.example.pahanaedubillingsystem.backend.dto.CustomerDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;

@WebServlet(name = "CustomerImport", urlPatterns = "/CustomerImport", loadOnStartup = 4)
@MultipartConfig
public class CustomerImportController extends HttpServlet {
    private static final Logger logger = LoggerFactory.getLogger(CustomerImportController.class);
    private final CustomerBO customerBO = (CustomerBO) BOFactory.getBoFactory().getBO(BOFactory.BOTypes.CUSTOMER);

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/plain");

        try {
            if (req.getSession(false) == null || req.getSession(false).getAttribute("username") == null) {
                resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                resp.getWriter().write("Unauthorized");
                return;
            }
        } catch (Exception ignored) {}

        Part filePart = null;
        try {
            filePart = req.getPart("file");
        } catch (Exception e) {
            logger.error("CSV file part not found", e);
        }

        if (filePart == null || filePart.getSize() == 0) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write("No file uploaded");
            return;
        }

        int total = 0;
        int imported = 0;
        int skipped = 0;
        StringBuilder errors = new StringBuilder();

        try (InputStream is = filePart.getInputStream();
             BufferedReader br = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8))) {

            String line;
            boolean headerSkipped = false;
            while ((line = br.readLine()) != null) {
                line = line.trim();
                if (line.isEmpty()) continue;

                if (!headerSkipped) {
                    String lower = line.toLowerCase();
                    if (lower.contains("account") && lower.contains("name") && lower.contains("address")) {
                        headerSkipped = true;
                        continue;
                    }
                    headerSkipped = true;
                }

                total++;
                String[] parts = splitCsv(line);
                if (parts.length < 5) {
                    skipped++;
                    errors.append("Row ").append(total).append(": Invalid column count (expected 5)\n");
                    continue;
                }

                String accountNo = parts[0].trim();
                String name = parts[1].trim();
                String address = parts[2].trim();
                String telephone = parts[3].trim();
                String unitsStr = parts[4].trim();

                if (accountNo.isEmpty() || name.isEmpty()) {
                    skipped++;
                    errors.append("Row ").append(total).append(": Missing required fields (account_no/name)\n");
                    continue;
                }

                int units;
                try {
                    units = Integer.parseInt(unitsStr);
                } catch (NumberFormatException e) {
                    skipped++;
                    errors.append("Row ").append(total).append(": Invalid units_consumed '"+unitsStr+"'\n");
                    continue;
                }

                try {
                    CustomerDTO dto = new CustomerDTO(accountNo, name, address, telephone, units);
                    boolean ok = customerBO.saveCustomer(dto);
                    if (ok) {
                        imported++;
                    } else {
                        try {
                            boolean updated = customerBO.updateCustomer(dto);
                            if (updated) {
                                imported++;
                            } else {
                                skipped++;
                                errors.append("Row ").append(total).append(": Could not save or update (account_no may be invalid)\n");
                            }
                        } catch (Exception ex) {
                            skipped++;
                            String umsg = ex.getMessage() != null ? ex.getMessage() : ex.toString();
                            errors.append("Row ").append(total).append(": Update error - ").append(umsg).append("\n");
                            logger.error("Error updating existing customer on row {}: {}", total, line, ex);
                        }
                    }
                } catch (Exception e) {
                    try {
                        CustomerDTO dto = new CustomerDTO(accountNo, name, address, telephone, units);
                        boolean updated = customerBO.updateCustomer(dto);
                        if (updated) {
                            imported++;
                        } else {
                            skipped++;
                            String msg = e.getMessage() != null ? e.getMessage() : e.toString();
                            errors.append("Row ").append(total).append(": Error - ").append(msg).append("; Update also failed\n");
                            logger.error("Error importing customer row {} (save failed, update failed too): {}", total, line, e);
                        }
                    } catch (Exception ex) {
                        skipped++;
                        String msg = e.getMessage() != null ? e.getMessage() : e.toString();
                        String umsg = ex.getMessage() != null ? ex.getMessage() : ex.toString();
                        errors.append("Row ").append(total).append(": Error - ").append(msg).append("; Update error - ").append(umsg).append("\n");
                        logger.error("Error importing customer row {}: {}; then update error: {}", total, line, ex);
                    }
                }
            }
        } catch (Exception e) {
            logger.error("Error reading uploaded CSV", e);
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write("Failed to read CSV file");
            return;
        }

        StringBuilder summary = new StringBuilder();
        summary.append("Total Rows: ").append(total).append('\n');
        summary.append("Imported: ").append(imported).append('\n');
        summary.append("Skipped: ").append(skipped).append('\n');
        if (errors.length() > 0) {
            summary.append("\nDetails:\n").append(errors);
        }

        resp.getWriter().write(summary.toString());
        logger.info("Customer CSV Import completed. Total: {}, Imported: {}, Skipped: {}", total, imported, skipped);
    }

    private String[] splitCsv(String line) {
        java.util.List<String> fields = new java.util.ArrayList<>();
        StringBuilder current = new StringBuilder();
        boolean inQuotes = false;
        for (int i = 0; i < line.length(); i++) {
            char c = line.charAt(i);
            if (c == '"') {
                if (inQuotes && i + 1 < line.length() && line.charAt(i + 1) == '"') {
                    current.append('"');
                    i++;
                } else {
                    inQuotes = !inQuotes;
                }
            } else if (c == ',' && !inQuotes) {
                fields.add(current.toString());
                current.setLength(0);
            } else {
                current.append(c);
            }
        }
        fields.add(current.toString());
        return fields.toArray(new String[0]);
    }
}
