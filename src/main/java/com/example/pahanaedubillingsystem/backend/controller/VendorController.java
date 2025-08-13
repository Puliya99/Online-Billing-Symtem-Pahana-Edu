package com.example.pahanaedubillingsystem.backend.controller;

import com.example.pahanaedubillingsystem.backend.bo.BOFactory;
import com.example.pahanaedubillingsystem.backend.bo.custom.VendorBO;
import com.example.pahanaedubillingsystem.backend.dto.VendorDTO;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "VendorModel", urlPatterns = "/VendorModel", loadOnStartup = 4)
public class VendorController extends HttpServlet {
    private final static Logger logger = LoggerFactory.getLogger(VendorController.class);
    private final ObjectMapper objectMapper = new ObjectMapper();
    private final VendorBO vendorBO = (VendorBO) BOFactory.getBoFactory().getBO(BOFactory.BOTypes.VENDOR);

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<VendorDTO> vendors = vendorBO.getAllVendors();
            String jsonVendors = objectMapper.writeValueAsString(vendors);
            resp.setContentType("application/json");
            resp.getWriter().write(jsonVendors);
            logger.info("Get All Vendors");
        } catch (Exception e) {
            logger.error("Error fetching vendors", e);
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching vendors");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            VendorDTO vendor = objectMapper.readValue(req.getInputStream(), VendorDTO.class);
            boolean isSaved = vendorBO.saveVendor(vendor);
            resp.getWriter().write(isSaved ? "saved" : "not saved");
            logger.info(isSaved ? "Vendor Saved" : "Vendor Not Saved");
        } catch (Exception e) {
            logger.error("Vendor Not Saved", e);
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Error saving item");
        }
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            VendorDTO vendor = objectMapper.readValue(req.getInputStream(), VendorDTO.class);
            boolean isUpdated = vendorBO.updateVendor(vendor);
            resp.getWriter().write(isUpdated ? "updated" : "not updated");
            logger.info(isUpdated ? "Vendor Updated" : "Vendor Not Updated");
        } catch (Exception e) {
            logger.error("Vendor Not Updated", e);
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Error updating vendor");
        }
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String grnId = req.getParameter("grn_id");
            boolean isDeleted = vendorBO.deleteVendor(grnId);
            resp.getWriter().write(isDeleted ? "deleted" : "not deleted");
            logger.info(isDeleted ? "Vendor Deleted" : "Vendor Not Deleted");
        } catch (Exception e) {
            logger.error("Vendor Not Deleted", e);
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Error deleting vendor");
        }
    }
}