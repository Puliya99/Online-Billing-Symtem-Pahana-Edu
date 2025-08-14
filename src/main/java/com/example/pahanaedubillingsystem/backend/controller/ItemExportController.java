package com.example.pahanaedubillingsystem.backend.controller;

import com.example.pahanaedubillingsystem.backend.bo.BOFactory;
import com.example.pahanaedubillingsystem.backend.bo.custom.ItemBO;
import com.example.pahanaedubillingsystem.backend.dto.ItemDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet(name = "ItemExport", urlPatterns = "/ItemExport", loadOnStartup = 4)
public class ItemExportController extends HttpServlet {
    private static final Logger logger = LoggerFactory.getLogger(ItemExportController.class);
    private final ItemBO itemBO = (ItemBO) BOFactory.getBoFactory().getBO(BOFactory.BOTypes.ITEM);

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            if (req.getSession(false) == null || req.getSession(false).getAttribute("username") == null) {
                resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                resp.setContentType("text/plain;charset=UTF-8");
                resp.getWriter().write("Unauthorized");
                return;
            }
        } catch (Exception ignored) {}

        String date = LocalDate.now().format(DateTimeFormatter.BASIC_ISO_DATE);
        String filename = "items-" + date + ".csv";
        String headerValue = "attachment; filename=\"" + filename + "\"; filename*=" +
                "UTF-8''" + URLEncoder.encode(filename, StandardCharsets.UTF_8.name());

        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/csv; charset=UTF-8");
        resp.setHeader("Content-Disposition", headerValue);
        resp.setHeader("Pragma", "no-cache");
        resp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        resp.setDateHeader("Expires", 0);

        try (PrintWriter out = resp.getWriter()) {
            out.write('\uFEFF');
            out.println("item_id,name,price,qty");

            List<ItemDTO> items = itemBO.getAllItems();
            for (ItemDTO i : items) {
                out.print(escapeCsv(i.getItemId())); out.print(',');
                out.print(escapeCsv(i.getName())); out.print(',');
                out.print(formatNumber(i.getPrice())); out.print(',');
                out.print(i.getQty());
                out.print('\n');
            }
            out.flush();
            logger.info("Exported {} items to CSV", items.size());
        } catch (Exception e) {
            logger.error("Error exporting items", e);
        }
    }

    private String escapeCsv(String s) {
        if (s == null) return "";
        boolean needQuotes = s.contains(",") || s.contains("\n") || s.contains("\r") || s.contains("\"");
        String val = s.replace("\"", "\"\"");
        if (needQuotes) {
            return '"' + val + '"';
        }
        return val;
    }

    private String formatNumber(double d) {
        String str = Double.toString(d);
        return str;
    }
}
