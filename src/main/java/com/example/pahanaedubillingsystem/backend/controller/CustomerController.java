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
import java.sql.SQLException;
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
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write(jsonCustomers);
            logger.info("Get All Customers");
        } catch (Exception e) {
            logger.error("Error fetching customers", e);
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching customers");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/plain");
        resp.setCharacterEncoding("UTF-8");
        try {
            CustomerDTO customer = objectMapper.readValue(req.getInputStream(), CustomerDTO.class);
            boolean isSaved = customerBO.saveCustomer(customer);
            resp.getWriter().write(isSaved ? "saved" : "not saved");
            logger.info(isSaved ? "Customer Saved: " + customer.getAccountNo() : "Customer Not Saved: " + customer.getAccountNo());
        } catch (Exception e) {
            logger.error("Customer Not Saved", e);
            resp.setStatus(HttpServletResponse.SC_OK);
            resp.getWriter().write("not saved");
        }
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/plain");
        resp.setCharacterEncoding("UTF-8");
        try {
            CustomerDTO customer = objectMapper.readValue(req.getInputStream(), CustomerDTO.class);
            boolean isUpdated = customerBO.updateCustomer(customer);
            resp.getWriter().write(isUpdated ? "updated" : "not updated");
            logger.info(isUpdated ? "Customer Updated: " + customer.getAccountNo() : "Customer Not Updated: " + customer.getAccountNo());
        } catch (Exception e) {
            logger.error("Customer Not Updated", e);
            resp.setStatus(HttpServletResponse.SC_OK);
            resp.getWriter().write("not updated");
        }
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/plain");
        resp.setCharacterEncoding("UTF-8");
        try {
            String accountNo = req.getParameter("account_no");

            logger.info("Attempting to delete customer with account_no: " + accountNo);

            if (accountNo == null || accountNo.trim().isEmpty()) {
                logger.error("Account number is null or empty");
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                resp.getWriter().write("not deleted");
                return;
            }

            CustomerDTO existingCustomer = customerBO.searchCustomer(accountNo);
            if (existingCustomer == null) {
                logger.error("Customer not found with account_no: " + accountNo);
                resp.getWriter().write("not deleted");
                return;
            }

            logger.info("Customer found: " + existingCustomer.getName() + ", proceeding with deletion");

            boolean isDeleted = customerBO.deleteCustomer(accountNo);

            if (isDeleted) {
                logger.info("Customer successfully deleted: " + accountNo);
                resp.getWriter().write("deleted");
            } else {
                logger.error("Customer deletion failed for account_no: " + accountNo + " - This might be due to foreign key constraints (customer has associated bills)");
                resp.getWriter().write("not deleted");
            }

        } catch (SQLException e) {
            if (e.getMessage().contains("foreign key constraint") ||
                    e.getMessage().contains("FOREIGN KEY") ||
                    e.getMessage().contains("Cannot delete or update a parent row")) {
                logger.error("Cannot delete customer - has associated bills. Account: " + req.getParameter("account_no"), e);
                resp.getWriter().write("not deleted");
            } else {
                logger.error("SQL error during customer deletion", e);
                resp.getWriter().write("not deleted");
            }
        } catch (Exception e) {
            logger.error("Unexpected error during customer deletion", e);
            resp.setStatus(HttpServletResponse.SC_OK);
            resp.getWriter().write("not deleted");
        }
    }
}