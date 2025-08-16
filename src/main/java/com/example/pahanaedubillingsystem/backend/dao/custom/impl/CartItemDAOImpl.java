package com.example.pahanaedubillingsystem.backend.dao.custom.impl;

import com.example.pahanaedubillingsystem.backend.dao.SQLUtil;
import com.example.pahanaedubillingsystem.backend.dao.custom.CartItemDAO;
import com.example.pahanaedubillingsystem.backend.entity.Cart_Item;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CartItemDAOImpl implements CartItemDAO {
    private static final String SAVE_CART_ITEM = "INSERT INTO cart_items (cart_id, item_id, qty, unit_price, line_total) VALUES (?, ?, ?, ?, ?) ON DUPLICATE KEY UPDATE qty = qty + VALUES(qty), unit_price = VALUES(unit_price), line_total = qty * unit_price";
    private static final String DELETE_CART_ITEM = "DELETE FROM cart_items WHERE cart_id = ? AND item_id = ?";

    @Override
    public boolean save(Cart_Item entity) throws SQLException {
        return SQLUtil.execute(SAVE_CART_ITEM, entity.getCartId(), entity.getItemId(), entity.getQty(), entity.getUnitPrice(), entity.getLineTotal());
    }

    @Override
    public boolean update(Cart_Item entity) throws SQLException {
        return false;
    }

    @Override
    public boolean delete(String id) throws SQLException {
        return false;
    }

    @Override
    public Cart_Item search(String id) throws SQLException {
        return null;
    }

    @Override
    public List<Cart_Item> getAll() throws SQLException {
        return List.of();
    }

    @Override
    public List<String> getIds() throws SQLException {
        return List.of();
    }

    @Override
    public Cart_Item searchById(String id) throws SQLException {
        return null;
    }

    @Override
    public List<Cart_Item> findByCartId(String cartId) throws SQLException {
        List<Cart_Item> items = new ArrayList<>();
        ResultSet rs = SQLUtil.execute("SELECT cart_id, item_id, qty, unit_price, line_total FROM cart_items WHERE cart_id = ?", cartId);
        while (rs.next()) {
            items.add(new Cart_Item(
                    rs.getString("cart_id"),
                    rs.getString("item_id"),
                    rs.getInt("qty"),
                    rs.getDouble("unit_price"),
                    rs.getDouble("line_total")
            ));
        }
        return items;
    }

    @Override
    public boolean deleteByCartAndItem(String cartId, String itemId) throws SQLException {
        return SQLUtil.execute(DELETE_CART_ITEM, cartId, itemId);
    }
}
