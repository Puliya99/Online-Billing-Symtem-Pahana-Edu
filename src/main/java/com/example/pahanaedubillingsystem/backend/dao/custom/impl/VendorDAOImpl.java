package com.example.pahanaedubillingsystem.backend.dao.custom.impl;

import com.example.pahanaedubillingsystem.backend.dao.SQLUtil;
import com.example.pahanaedubillingsystem.backend.dao.custom.VendorDAO;
import com.example.pahanaedubillingsystem.backend.entity.Vendor;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class VendorDAOImpl implements VendorDAO {

    private static final String GET_VENDORS = "SELECT * FROM vendors";
    private static final String SAVE_VENDORS = "INSERT INTO vendors (grn_id, grn_date, name, item_id, description, qty, buying_price) VALUES (?, ?, ?, ?, ?, ?, ?)";
    private static final String UPDATE_VENDORS = "UPDATE vendors SET grn_date = ?, name = ?, item_id = ?, description = ?, qty = ?, buying_price = ? WHERE grn_id = ?";
    private static final String DELETE_VENDORS = "DELETE FROM vendors WHERE grn_id = ?";

    @Override
    public boolean save(Vendor entity) throws SQLException {
        return SQLUtil.execute(SAVE_VENDORS, entity.getGrnId(), entity.getGrnDate(), entity.getName(), entity.getItemId(), entity.getDescription(), entity.getQty(), entity.getBuyingPrice());
    }

    @Override
    public boolean update(Vendor entity) throws SQLException {
        return SQLUtil.execute(UPDATE_VENDORS,
                entity.getGrnDate(),
                entity.getName(),
                entity.getItemId(),
                entity.getDescription(),
                entity.getQty(),
                entity.getBuyingPrice(),
                entity.getGrnId());
    }

    @Override
    public boolean delete(String grnId) throws SQLException {
        return SQLUtil.execute(DELETE_VENDORS, grnId);
    }

    @Override
    public Vendor search(String grnId) throws SQLException {
        ResultSet rst = SQLUtil.execute("SELECT * FROM vendors WHERE grn_id = ?", grnId);
        if (rst.next()) {
            return new Vendor(rst.getString("grn_id"), rst.getDate("grn_date"), rst.getString("name"), rst.getString("item_id"), rst.getString("description"), rst.getInt("qty"), rst.getDouble("buying_price"));
        }
        return null;
    }

    @Override
    public List<Vendor> getAll() throws SQLException {
        List<Vendor> vendors = new ArrayList<>();
        ResultSet rst = SQLUtil.execute(GET_VENDORS);
        while (rst.next()) {
            vendors.add(new Vendor(rst.getString("grn_id"), rst.getDate("grn_date"), rst.getString("name"), rst.getString("item_id"), rst.getString("description"), rst.getInt("qty"), rst.getDouble("buying_price")));
        }
        return vendors;
    }

    @Override
    public List<String> getIds() throws SQLException {
        List<String> ids = new ArrayList<>();
        ResultSet rst = SQLUtil.execute("SELECT grn_id FROM vendors");
        while (rst.next()) {
            ids.add(rst.getString(1));
        }
        return ids;
    }

    @Override
    public Vendor searchById(String grnId) throws SQLException {
        ResultSet rst = SQLUtil.execute("SELECT * FROM vendors WHERE grn_id = ?", grnId);
        if (rst.next()) {
            return new Vendor(rst.getString("grn_id"), rst.getDate("grn_date"), rst.getString("name"), rst.getString("item_id"), rst.getString("description"), rst.getInt("qty"), rst.getDouble("buying_price"));
        }
        return null;
    }

}
