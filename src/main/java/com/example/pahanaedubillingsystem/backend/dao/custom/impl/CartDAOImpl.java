package com.example.pahanaedubillingsystem.backend.dao.custom.impl;

import com.example.pahanaedubillingsystem.backend.dao.SQLUtil;
import com.example.pahanaedubillingsystem.backend.dao.custom.CartDAO;
import com.example.pahanaedubillingsystem.backend.entity.Cart;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CartDAOImpl implements CartDAO {
    private static final String SAVE_CART = "INSERT INTO carts (cart_id, description) VALUES (?, ?)";
    private static final String UPDATE_CART = "UPDATE carts SET description = ? WHERE cart_id = ?";
    private static final String DELETE_CART = "DELETE FROM carts WHERE cart_id = ?";
    private static final String GET_CARTS = "SELECT * FROM carts";

    @Override
    public boolean save(Cart entity) throws SQLException {
        return SQLUtil.execute(SAVE_CART, entity.getCartId(), entity.getDescription());
    }

    @Override
    public boolean update(Cart entity) throws SQLException {
        return SQLUtil.execute(UPDATE_CART, entity.getDescription(), entity.getCartId());
    }

    @Override
    public boolean delete(String id) throws SQLException {
        return SQLUtil.execute(DELETE_CART, id);
    }

    @Override
    public Cart search(String id) throws SQLException {
        ResultSet rst = SQLUtil.execute("SELECT * FROM carts WHERE cart_id = ?", id);
        if (rst.next()) {
            return new Cart(rst.getString("cart_id"), rst.getString("description"));
        }
        return null;
    }

    @Override
    public List<Cart> getAll() throws SQLException {
        List<Cart> list = new ArrayList<>();
        ResultSet rst = SQLUtil.execute(GET_CARTS);
        while (rst.next()) {
            list.add(new Cart(rst.getString("cart_id"), rst.getString("description")));
        }
        return list;
    }

    @Override
    public List<String> getIds() throws SQLException {
        List<String> ids = new ArrayList<>();
        ResultSet rst = SQLUtil.execute("SELECT cart_id FROM carts");
        while (rst.next()) {
            ids.add(rst.getString(1));
        }
        return ids;
    }

    @Override
    public Cart searchById(String id) throws SQLException {
        return search(id);
    }
}
