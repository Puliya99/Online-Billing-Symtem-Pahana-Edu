package com.example.pahanaedubillingsystem.backend.bo.custom;

import com.example.pahanaedubillingsystem.backend.bo.SuperBO;
import com.example.pahanaedubillingsystem.backend.dto.CartDTO;

import java.sql.SQLException;
import java.util.List;

public interface CartBO extends SuperBO {
    boolean saveCart(CartDTO dto) throws SQLException;
    boolean updateCart(CartDTO dto) throws SQLException;
    boolean deleteCart(String cartId) throws SQLException;
    CartDTO searchCart(String cartId) throws SQLException;
    List<CartDTO> getAllCarts() throws SQLException;
    List<String> getCartIds() throws SQLException;
    CartDTO searchByIdCart(String cartId) throws SQLException;
}
