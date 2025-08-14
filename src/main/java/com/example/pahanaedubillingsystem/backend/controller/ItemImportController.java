package com.example.pahanaedubillingsystem.backend.controller;

import com.example.pahanaedubillingsystem.backend.bo.BOFactory;
import com.example.pahanaedubillingsystem.backend.bo.custom.ItemBO;
import com.example.pahanaedubillingsystem.backend.dto.ItemDTO;
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

@WebServlet(name = "ItemImport", urlPatterns = "/ItemImport", loadOnStartup = 4)
@MultipartConfig
public class ItemImportController extends HttpServlet {
    private static final Logger logger = LoggerFactory.getLogger(ItemImportController.class);
    private final ItemBO itemBO = (ItemBO) BOFactory.getBoFactory().getBO(BOFactory.BOTypes.ITEM);

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

        Part filePart;
        try {
            filePart = req.getPart("file");
        } catch (Exception e) {
            logger.error("CSV file part not found", e);
            filePart = null;
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
            boolean headerChecked = false;
            while ((line = br.readLine()) != null) {
                line = line.trim();
                if (line.isEmpty()) continue;

                if (!headerChecked) {
                    String lower = line.toLowerCase();
                    if ((lower.contains("item") && lower.contains("price") && lower.contains("qty")) || lower.contains("description")) {
                        headerChecked = true;
                        continue;
                    }
                    headerChecked = true;
                }

                total++;
                String[] parts = splitCsv(line);
                if (parts.length < 4) {
                    skipped++;
                    errors.append("Row ").append(total).append(": Invalid column count (expected 4)\n");
                    continue;
                }

                String itemId = parts[0].trim();
                String name = parts[1].trim();
                String priceStr = parts[2].trim();
                String qtyStr = parts[3].trim();

                if (itemId.isEmpty() || name.isEmpty()) {
                    skipped++;
                    errors.append("Row ").append(total).append(": Missing required fields (item_id/name)\n");
                    continue;
                }

                double price;
                try {
                    price = Double.parseDouble(priceStr);
                } catch (NumberFormatException e) {
                    skipped++;
                    errors.append("Row ").append(total).append(": Invalid price '"+priceStr+"'\n");
                    continue;
                }

                int qty;
                try {
                    qty = Integer.parseInt(qtyStr);
                } catch (NumberFormatException e) {
                    skipped++;
                    errors.append("Row ").append(total).append(": Invalid qty '"+qtyStr+"'\n");
                    continue;
                }

                try {
                    boolean ok = itemBO.saveItem(new ItemDTO(itemId, name, price, qty));
                    if (ok) {
                        imported++;
                    } else {
                        skipped++;
                        errors.append("Row ").append(total).append(": Could not save (maybe duplicate item_id)\n");
                    }
                } catch (Exception e) {
                    skipped++;
                    String msg = e.getMessage() != null ? e.getMessage() : e.toString();
                    errors.append("Row ").append(total).append(": Error - ").append(msg).append("\n");
                    logger.error("Error importing item row {}: {}", total, line, e);
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
        logger.info("Item CSV Import completed. Total: {}, Imported: {}, Skipped: {}", total, imported, skipped);
    }

    // Simple CSV splitter supporting quoted fields
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
