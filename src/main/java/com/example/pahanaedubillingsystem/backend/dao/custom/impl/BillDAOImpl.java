package com.example.pahanaedubillingsystem.backend.dao.custom.impl;

import com.example.pahanaedubillingsystem.backend.dao.SQLUtil;
import com.example.pahanaedubillingsystem.backend.dao.custom.BillDAO;
import com.example.pahanaedubillingsystem.backend.entity.Bill;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BillDAOImpl implements BillDAO {
    private static final String GET_BILLS = "SELECT * FROM bills";
    private static final String SAVE_BILL = "INSERT INTO bills (bill_id, account_no, total_amount, bill_date) VALUES (?, ?, ?, ?)";

    @Override
    public boolean save(Bill entity) throws SQLException {
        return SQLUtil.execute(SAVE_BILL, entity.getBillId(), entity.getAccountNo(), entity.getTotalAmount(), entity.getBillDate());
    }

    @Override
    public boolean update(Bill entity) throws SQLException {
        throw new UnsupportedOperationException("Bill update not implemented");
    }

    @Override
    public boolean delete(String billId) throws SQLException {
        throw new UnsupportedOperationException("Bill deletion not implemented");
    }

    @Override
    public Bill search(String billId) throws SQLException {
        ResultSet rst = SQLUtil.execute("SELECT * FROM bills WHERE bill_id = ?", billId);
        if (rst.next()) {
            return new Bill(rst.getString("bill_id"), rst.getDate("bill_date"), rst.getString("account_no"), rst.getDouble("total_amount"));
        }
        return null;
    }

    @Override
    public List<Bill> getAll() throws SQLException {
        List<Bill> bills = new ArrayList<>();
        ResultSet rst = SQLUtil.execute(GET_BILLS);
        while (rst.next()) {
            bills.add(new Bill(rst.getString("bill_id"), rst.getDate("bill_date"), rst.getString("account_no"), rst.getDouble("total_amount")));
        }
        return bills;
    }

    @Override
    public List<String> getIds() throws SQLException {
        List<String> ids = new ArrayList<>();
        ResultSet rst = SQLUtil.execute("SELECT bill_id FROM bills");
        while (rst.next()) {
            ids.add(rst.getString(1));
        }
        return ids;
    }

    @Override
    public Bill searchById(String billId) throws SQLException {
        ResultSet rst = SQLUtil.execute("SELECT * FROM bills WHERE bill_id = ?", billId);
        if (rst.next()) {
            return new Bill(rst.getString("bill_id"), rst.getDate("bill_date"), rst.getString("account_no"), rst.getDouble("total_amount"));
        }
        return null;
    }
}