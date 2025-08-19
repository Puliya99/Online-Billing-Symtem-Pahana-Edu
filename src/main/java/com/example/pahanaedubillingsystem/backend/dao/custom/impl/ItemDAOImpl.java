package com.example.pahanaedubillingsystem.backend.dao.custom.impl;

import com.example.pahanaedubillingsystem.backend.dao.SQLUtil;
import com.example.pahanaedubillingsystem.backend.dao.custom.ItemDAO;
import com.example.pahanaedubillingsystem.backend.entity.Item;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ItemDAOImpl implements ItemDAO {
    private static final String GET_ITEMS = "SELECT * FROM items";
    private static final String SAVE_ITEM = "INSERT INTO items (item_id, name, price, qty) VALUES (?, ?, ?, ?)";
    private static final String UPDATE_ITEM = "UPDATE items SET name = ?, price = ?, qty = ? WHERE item_id = ?";
    private static final String DELETE_ITEM = "DELETE FROM items WHERE item_id = ?";

    @Override
    public boolean save(Item entity) throws SQLException {
        return SQLUtil.execute(SAVE_ITEM, entity.getItemId(), entity.getName(), entity.getPrice(), entity.getQty());
    }

    @Override
    public boolean update(Item entity) throws SQLException {
        return SQLUtil.execute(UPDATE_ITEM, entity.getName(), entity.getPrice(), entity.getQty(), entity.getItemId());
    }

    @Override
    public boolean delete(String itemId) throws SQLException {
        return SQLUtil.execute(DELETE_ITEM, itemId);
    }

    @Override
    public Item search(String itemId) throws SQLException {
        ResultSet rst = SQLUtil.execute("SELECT * FROM items WHERE item_id = ?", itemId);
        if (rst.next()) {
            return new Item(rst.getString("item_id"), rst.getString("name"), rst.getDouble("price"), rst.getInt("qty"));
        }
        return null;
    }

    @Override
    public List<Item> getAll() throws SQLException {
        List<Item> items = new ArrayList<>();
        ResultSet rst = SQLUtil.execute(GET_ITEMS);
        while (rst.next()) {
            items.add(new Item(rst.getString("item_id"), rst.getString("name"), rst.getDouble("price"), rst.getInt("qty")));
        }
        return items;
    }

    @Override
    public List<String> getIds() throws SQLException {
        List<String> ids = new ArrayList<>();
        ResultSet rst = SQLUtil.execute("SELECT item_id FROM items");
        while (rst.next()) {
            ids.add(rst.getString(1));
        }
        return ids;
    }

    @Override
    public Item searchById(String itemId) throws SQLException {
        ResultSet rst = SQLUtil.execute("SELECT * FROM items WHERE item_id = ?", itemId);
        if (rst.next()) {
            return new Item(rst.getString("item_id"), rst.getString("name"), rst.getDouble("price"), rst.getInt("qty"));
        }
        return null;
    }
}