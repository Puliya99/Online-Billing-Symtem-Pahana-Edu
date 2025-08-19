package com.example.pahanaedubillingsystem.backend.dao.custom;

import com.example.pahanaedubillingsystem.backend.dao.CrudDAO;
import com.example.pahanaedubillingsystem.backend.entity.Customer;

import java.sql.SQLException;

public interface CustomerDAO extends CrudDAO<Customer> {
    boolean deleteCustomerWithBills(String accountNo) throws SQLException;
}