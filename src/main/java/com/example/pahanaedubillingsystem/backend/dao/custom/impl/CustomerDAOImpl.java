package com.example.pahanaedubillingsystem.backend.dao.custom.impl;

import com.example.pahanaedubillingsystem.backend.dao.SQLUtil;
import com.example.pahanaedubillingsystem.backend.dao.custom.CustomerDAO;
import com.example.pahanaedubillingsystem.backend.db.DBConnection;
import com.example.pahanaedubillingsystem.backend.entity.Customer;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAOImpl implements CustomerDAO {
    private static final String GET_CUSTOMERS = "SELECT * FROM customers";
    private static final String SAVE_CUSTOMER = "INSERT INTO customers (account_no, name, address, telephone, units_consumed) VALUES (?, ?, ?, ?, ?)";
    private static final String UPDATE_CUSTOMER = "UPDATE customers SET name = ?, address = ?, telephone = ?, units_consumed = ? WHERE account_no = ?";
    private static final String DELETE_CUSTOMER = "DELETE FROM customers WHERE account_no = ?";
    private static final String CHECK_CUSTOMER_BILLS = "SELECT bill_id FROM bills WHERE account_no = ? LIMIT 1";
    private static final String DELETE_BILLS_FOR_CUSTOMER = "DELETE FROM bills WHERE account_no = ?";

    @Override
    public boolean save(Customer entity) throws SQLException {
        return SQLUtil.execute(SAVE_CUSTOMER, entity.getAccountNo(), entity.getName(), entity.getAddress(), entity.getTelephone(), entity.getUnitsConsumed());
    }

    @Override
    public boolean update(Customer entity) throws SQLException {
        return SQLUtil.execute(UPDATE_CUSTOMER, entity.getName(), entity.getAddress(), entity.getTelephone(), entity.getUnitsConsumed(), entity.getAccountNo());
    }

    @Override
    public boolean delete(String accountNo) throws SQLException {
        return SQLUtil.execute(DELETE_CUSTOMER, accountNo);
    }

    @Override
    public Customer search(String accountNo) throws SQLException {
        ResultSet rst = SQLUtil.execute("SELECT * FROM customers WHERE account_no = ?", accountNo);
        if (rst.next()) {
            return new Customer(rst.getString("account_no"), rst.getString("name"), rst.getString("address"), rst.getString("telephone"), rst.getInt("units_consumed"));
        }
        return null;
    }

    @Override
    public List<Customer> getAll() throws SQLException {
        List<Customer> customers = new ArrayList<>();
        ResultSet rst = SQLUtil.execute(GET_CUSTOMERS);
        while (rst.next()) {
            customers.add(new Customer(rst.getString("account_no"), rst.getString("name"), rst.getString("address"), rst.getString("telephone"), rst.getInt("units_consumed")));
        }
        return customers;
    }

    @Override
    public List<String> getIds() throws SQLException {
        List<String> ids = new ArrayList<>();
        ResultSet rst = SQLUtil.execute("SELECT account_no FROM customers");
        while (rst.next()) {
            ids.add(rst.getString(1));
        }
        return ids;
    }

    @Override
    public Customer searchById(String accountNo) throws SQLException {
        ResultSet rst = SQLUtil.execute("SELECT * FROM customers WHERE account_no = ?", accountNo);
        if (rst.next()) {
            return new Customer(rst.getString("account_no"), rst.getString("name"), rst.getString("address"), rst.getString("telephone"), rst.getInt("units_consumed"));
        }
        return null;
    }

    @Override
    public boolean deleteCustomerWithBills(String accountNo) throws SQLException {
        Connection con = DBConnection.getInstance().getConnection();
        try {
            con.setAutoCommit(false);
            ResultSet rs = SQLUtil.execute(CHECK_CUSTOMER_BILLS, accountNo);
            if (rs.next()) {
                boolean isDelBills = SQLUtil.execute(DELETE_BILLS_FOR_CUSTOMER, accountNo);
                if (isDelBills) {
                    boolean isDelCus = SQLUtil.execute(DELETE_CUSTOMER, accountNo);
                    if (isDelCus) {
                        con.commit();
                        return true;
                    }
                }
            } else {
                boolean isDelCus = SQLUtil.execute(DELETE_CUSTOMER, accountNo);
                if (isDelCus) {
                    con.commit();
                    return true;
                }
            }
            con.rollback();
            return false;
        } catch (SQLException e) {
            con.rollback();
            throw e;
        } finally {
            con.setAutoCommit(true);
        }
    }
}