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
    private static final String SAVE_BILL = "INSERT INTO bills (bill_id, account_no, item_id, qty, unit_price, discount, total_amount, bill_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String UPDATE_BILL = "UPDATE bills SET account_no = ?, item_id = ?, qty = ?, unit_price = ?, discount = ?, total_amount = ?, bill_date = ? WHERE bill_id = ?";
    private static final String DELETE_BILL = "DELETE FROM bills WHERE bill_id = ?";

    @Override
    public boolean save(Bill entity) throws SQLException {
        java.sql.Date sqlDate = (entity.getBillDate() != null) ? new java.sql.Date(entity.getBillDate().getTime()) : null;
        return SQLUtil.execute(
                SAVE_BILL,
                entity.getBillId(),
                entity.getAccountNo(),
                entity.getItemId(),
                entity.getQty(),
                entity.getUnitPrice(),
                entity.getDiscount(),
                entity.getTotalAmount(),
                sqlDate
        );
    }

    @Override
    public boolean update(Bill entity) throws SQLException {
        java.sql.Date sqlDate = (entity.getBillDate() != null) ? new java.sql.Date(entity.getBillDate().getTime()) : null;
        return SQLUtil.execute(
                UPDATE_BILL,
                entity.getAccountNo(),
                entity.getItemId(),
                entity.getQty(),
                entity.getUnitPrice(),
                entity.getDiscount(),
                entity.getTotalAmount(),
                sqlDate,
                entity.getBillId()
        );
    }

    @Override
    public boolean delete(String billId) throws SQLException {
        return SQLUtil.execute(DELETE_BILL, billId);
    }

    @Override
    public Bill search(String billId) throws SQLException {
        ResultSet rst = SQLUtil.execute("SELECT * FROM bills WHERE bill_id = ?", billId);
        if (rst.next()) {
            return new Bill(rst.getString("bill_id"), rst.getDate("bill_date"), rst.getString("account_no"), rst.getString("item_id"), rst.getInt("qty"), rst.getDouble("unit_price"), rst.getInt("discount"), rst.getDouble("total_amount"));
        }
        return null;
    }

    @Override
    public List<Bill> getAll() throws SQLException {
        List<Bill> bills = new ArrayList<>();
        ResultSet rst = SQLUtil.execute(GET_BILLS);
        while (rst.next()) {
            bills.add(new Bill(rst.getString("bill_id"), rst.getDate("bill_date"), rst.getString("account_no"), rst.getString("item_id"), rst.getInt("qty"), rst.getDouble("unit_price"), rst.getInt("discount"), rst.getDouble("total_amount")));
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
            return new Bill(rst.getString("bill_id"), rst.getDate("bill_date"), rst.getString("account_no"), rst.getString("item_id"), rst.getInt("qty"), rst.getDouble("unit_price"), rst.getInt("discount"), rst.getDouble("total_amount"));
        }
        return null;
    }
}