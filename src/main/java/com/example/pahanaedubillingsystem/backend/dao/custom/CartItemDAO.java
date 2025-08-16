package com.example.pahanaedubillingsystem.backend.dao.custom;

import com.example.pahanaedubillingsystem.backend.dao.CrudDAO;
import com.example.pahanaedubillingsystem.backend.entity.Cart_Item;

import java.sql.SQLException;
import java.util.List;

public interface CartItemDAO extends CrudDAO<Cart_Item> {
    List<Cart_Item> findByCartId(String cartId) throws SQLException;
    boolean deleteByCartAndItem(String cartId, String itemId) throws SQLException;
}
