package com.example.pahanaedubillingsystem.backend.bo.custom;

import com.example.pahanaedubillingsystem.backend.bo.SuperBO;
import com.example.pahanaedubillingsystem.backend.dto.CartItemDTO;

import java.sql.SQLException;
import java.util.List;

public interface CartItemBo extends SuperBO {
    boolean saveCartItem(CartItemDTO dto) throws SQLException;
    boolean updateCartItem(CartItemDTO dto) throws SQLException;
    boolean deleteCartItem(String cartId) throws SQLException;
    CartItemDTO searchCartItem(String cartId) throws SQLException;
    List<CartItemDTO> getAllCartItems() throws SQLException;
    List<String> getCartItemIds() throws SQLException;
    CartItemDTO searchByIdCartItem(String cartId) throws SQLException;

    // Custom query
    List<CartItemDTO> getItemsForCart(String cartId) throws SQLException;

    // Deletions by composite key
    boolean removeItem(String cartId, String itemId) throws SQLException;
}
