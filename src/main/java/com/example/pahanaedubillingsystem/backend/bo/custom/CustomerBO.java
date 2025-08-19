package com.example.pahanaedubillingsystem.backend.bo.custom;

import com.example.pahanaedubillingsystem.backend.bo.SuperBO;
import com.example.pahanaedubillingsystem.backend.dto.CustomerDTO;
import java.sql.SQLException;
import java.util.List;

public interface CustomerBO extends SuperBO {
    boolean saveCustomer(CustomerDTO dto) throws SQLException;
    boolean updateCustomer(CustomerDTO dto) throws SQLException;
    boolean deleteCustomer(String accountNo) throws SQLException;
    CustomerDTO searchCustomer(String accountNo) throws SQLException;
    List<CustomerDTO> getAllCustomers() throws SQLException;
    List<String> getCustomerIds() throws SQLException;
    CustomerDTO searchByIdCustomer(String accountNo) throws SQLException;
}