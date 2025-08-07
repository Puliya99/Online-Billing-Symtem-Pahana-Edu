package com.example.pahanaedubillingsystem.backend.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.example.pahanaedubillingsystem.backend.bo.BOFactory;
import com.example.pahanaedubillingsystem.backend.bo.custom.BillBO;
import com.example.pahanaedubillingsystem.backend.dto.BillDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "BillModel", urlPatterns = "/BillModel", loadOnStartup = 4)
public class BillController extends HttpServlet {
    private final static Logger logger = LoggerFactory.getLogger(BillController.class);
    private final ObjectMapper objectMapper = new ObjectMapper();
    private final BillBO billBO = (BillBO) BOFactory.getBoFactory().getBO(BOFactory.BOTypes.BILL);

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<BillDTO> bills = billBO.getAllBills();
            String jsonBills = objectMapper.writeValueAsString(bills);
            resp.setContentType("application/json");
            resp.getWriter().write(jsonBills);
            logger.info("Get All Bills");
        } catch (Exception e) {
            logger.error("Error fetching bills", e);
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching bills");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            objectMapper.registerModule(new JavaTimeModule());
            BillDTO bill = objectMapper.readValue(req.getInputStream(), BillDTO.class);
            boolean isSaved = billBO.saveBill(bill);
            resp.getWriter().write(isSaved ? "saved" : "not saved");
            logger.info(isSaved ? "Bill Saved" : "Bill Not Saved");
        } catch (Exception e) {
            logger.error("Bill Not Saved", e);
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Error saving bill");
        }
    }
}