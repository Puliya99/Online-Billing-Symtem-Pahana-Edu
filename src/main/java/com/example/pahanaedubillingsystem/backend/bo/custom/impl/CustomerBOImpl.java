package com.example.pahanaedubillingsystem.backend.bo.custom.impl;

import com.example.pahanaedubillingsystem.backend.bo.custom.CustomerBO;
import com.example.pahanaedubillingsystem.backend.dao.DAOFactory;
import com.example.pahanaedubillingsystem.backend.dao.custom.CustomerDAO;
import com.example.pahanaedubillingsystem.backend.dto.CustomerDTO;
import com.example.pahanaedubillingsystem.backend.entity.Customer;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CustomerBOImpl implements CustomerBO {
    private final CustomerDAO customerDAO = (CustomerDAO) DAOFactory.getDaoFactory().getDAO(DAOFactory.DAOTypes.CUSTOMER);

    @Override
    public boolean saveCustomer(CustomerDTO dto) throws SQLException {
        return customerDAO.save(new Customer(dto.getAccountNo(), dto.getName(), dto.getAddress(), dto.getTelephone(), dto.getUnitsConsumed()));
    }

    @Override
    public boolean updateCustomer(CustomerDTO dto) throws SQLException {
        return customerDAO.update(new Customer(dto.getAccountNo(), dto.getName(), dto.getAddress(), dto.getTelephone(), dto.getUnitsConsumed()));
    }

    @Override
    public boolean deleteCustomer(String accountNo) throws SQLException {
        return customerDAO.delete(accountNo);
    }

    @Override
    public CustomerDTO searchCustomer(String accountNo) throws SQLException {
        Customer customer = customerDAO.search(accountNo);
        if (customer != null) {
            return new CustomerDTO(customer.getAccountNo(), customer.getName(), customer.getAddress(), customer.getTelephone(), customer.getUnitsConsumed());
        }
        return null;
    }

    @Override
    public List<CustomerDTO> getAllCustomers() throws SQLException {
        List<CustomerDTO> customers = new ArrayList<>();
        List<Customer> all = customerDAO.getAll();
        for (Customer c : all) {
            customers.add(new CustomerDTO(c.getAccountNo(), c.getName(), c.getAddress(), c.getTelephone(), c.getUnitsConsumed()));
        }
        return customers;
    }

    @Override
    public List<String> getCustomerIds() throws SQLException {
        return customerDAO.getIds();
    }

    @Override
    public CustomerDTO searchByIdCustomer(String accountNo) throws SQLException {
        Customer customer = customerDAO.searchById(accountNo);
        if (customer != null) {
            return new CustomerDTO(customer.getAccountNo(), customer.getName(), customer.getAddress(), customer.getTelephone(), customer.getUnitsConsumed());
        }
        return null;
    }
}