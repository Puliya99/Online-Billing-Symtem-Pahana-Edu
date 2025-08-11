package com.example.pahanaedubillingsystem.backend.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.example.pahanaedubillingsystem.backend.bo.BOFactory;
import com.example.pahanaedubillingsystem.backend.bo.custom.CustomerBO;
import com.example.pahanaedubillingsystem.backend.dto.CustomerDTO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "CustomerModel", urlPatterns = "/CustomerModel", loadOnStartup = 4)
public class CustomerController extends HttpServlet {
    private final static Logger logger = LoggerFactory.getLogger(CustomerController.class);
    private final ObjectMapper objectMapper = new ObjectMapper();
    private final CustomerBO customerBO = (CustomerBO) BOFactory.getBoFactory().getBO(BOFactory.BOTypes.CUSTOMER);

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<CustomerDTO> customers = customerBO.getAllCustomers();
            String jsonCustomers = objectMapper.writeValueAsString(customers);
            resp.setContentType("application/json");
            resp.getWriter().write(jsonCustomers);
            logger.info("Get All Customers");
        } catch (Exception e) {
            logger.error("Error fetching customers", e);
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching customers");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            CustomerDTO customer = objectMapper.readValue(req.getInputStream(), CustomerDTO.class);
            boolean isSaved = customerBO.saveCustomer(customer);
            resp.getWriter().write(isSaved ? "saved" : "not saved");
            logger.info(isSaved ? "Customer Saved" : "Customer Not Saved");
        } catch (Exception e) {
            logger.error("Customer Not Saved", e);
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Error saving customer");
        }
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            CustomerDTO customer = objectMapper.readValue(req.getInputStream(), CustomerDTO.class);
            boolean isUpdated = customerBO.updateCustomer(customer);
            resp.getWriter().write(isUpdated ? "updated" : "not updated");
            logger.info(isUpdated ? "Customer Updated" : "Customer Not Updated");
        } catch (Exception e) {
            logger.error("Customer Not Updated", e);
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Error updating customer");
        }
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String accountNo = req.getParameter("account_no");
            boolean isDeleted = customerBO.deleteCustomer(accountNo);
            resp.getWriter().write(isDeleted ? "deleted" : "not deleted");
            logger.info(isDeleted ? "Customer Deleted" : "Customer Not Deleted");
        } catch (Exception e) {
            logger.error("Customer Not Deleted", e);
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Error deleting customer");
        }
    }
}