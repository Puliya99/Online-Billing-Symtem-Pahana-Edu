package com.example.pahanaedubillingsystem.backend.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import com.example.pahanaedubillingsystem.backend.dto.CustomerDTO;
import com.example.pahanaedubillingsystem.backend.util.CrudUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "CustomerModel", urlPatterns = "/CustomerModel", loadOnStartup = 4)
public class CustomerController extends HttpServlet {
    private final static Logger logger = LoggerFactory.getLogger(CustomerController.class);
    private ObjectMapper objectMapper = new ObjectMapper();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<CustomerDTO> customers = CrudUtil.getInstance().getAll(CustomerDTO.class);
            String jsonCustomers = objectMapper.writeValueAsString(customers);
            resp.setContentType("application/json");
            resp.getWriter().write(jsonCustomers);
            logger.info("Get All Customers");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching customers");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            CustomerDTO customer = objectMapper.readValue(req.getInputStream(), CustomerDTO.class);
            boolean isSaved = CrudUtil.getInstance().save(
                    CustomerDTO.class,
                    customer.getAccountNo(),
                    customer.getName(),
                    customer.getAddress(),
                    customer.getTelephone(),
                    customer.getUnitsConsumed()
            );
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
            boolean isUpdated = CrudUtil.getInstance().update(
                    CustomerDTO.class,
                    customer.getName(),
                    customer.getAddress(),
                    customer.getTelephone(),
                    customer.getUnitsConsumed(),
                    customer.getAccountNo()
            );
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
            boolean isDeleted = CrudUtil.getInstance().deleteCustomer(req.getParameter("account_no"));
            resp.getWriter().write(isDeleted ? "deleted" : "not deleted");
            logger.info(isDeleted ? "Customer Deleted" : "Customer Not Deleted");
        } catch (Exception e) {
            logger.error("Customer Not Deleted", e);
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Error deleting customer");
        }
    }
}