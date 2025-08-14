package com.example.pahanaedubillingsystem.backend.controller;

import com.example.pahanaedubillingsystem.backend.bo.BOFactory;
import com.example.pahanaedubillingsystem.backend.bo.custom.VendorBO;
import com.example.pahanaedubillingsystem.backend.dto.VendorDTO;
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

@WebServlet(name = "VendorExport", urlPatterns = "/VendorExport", loadOnStartup = 4)
public class VendorExportController extends HttpServlet {
    private static final Logger logger = LoggerFactory.getLogger(VendorExportController.class);
    private final VendorBO vendorBO = (VendorBO) BOFactory.getBoFactory().getBO(BOFactory.BOTypes.VENDOR);

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
        String filename = "vendors-" + date + ".csv";
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
            out.println("grn_id,name,item_id,description,qty,buying_price");

            List<VendorDTO> vendors = vendorBO.getAllVendors();
            for (VendorDTO v : vendors) {
                out.print(escapeCsv(v.getGrnId())); out.print(',');
                out.print(escapeCsv(v.getName())); out.print(',');
                out.print(escapeCsv(v.getItemId())); out.print(',');
                out.print(escapeCsv(v.getDescription())); out.print(',');
                out.print(v.getQty()); out.print(',');
                out.print(formatNumber(v.getBuyingPrice()));
                out.print('\n');
            }
            out.flush();
            logger.info("Exported {} vendors to CSV", vendors.size());
        } catch (Exception e) {
            logger.error("Error exporting vendors", e);
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
        return Double.toString(d);
    }
}
