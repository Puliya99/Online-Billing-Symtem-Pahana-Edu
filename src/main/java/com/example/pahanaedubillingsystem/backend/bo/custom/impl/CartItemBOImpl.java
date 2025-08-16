package com.example.pahanaedubillingsystem.backend.bo.custom.impl;

import com.example.pahanaedubillingsystem.backend.bo.custom.CartItemBo;
import com.example.pahanaedubillingsystem.backend.dao.DAOFactory;
import com.example.pahanaedubillingsystem.backend.dao.custom.CartItemDAO;
import com.example.pahanaedubillingsystem.backend.dto.CartItemDTO;
import com.example.pahanaedubillingsystem.backend.entity.Cart_Item;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CartItemBOImpl implements CartItemBo {
    private final CartItemDAO cartItemDAO = (CartItemDAO) DAOFactory.getDaoFactory().getDAO(DAOFactory.DAOTypes.CART_ITEM);

    @Override
    public boolean saveCartItem(CartItemDTO dto) throws SQLException {
        return cartItemDAO.save(new Cart_Item(dto.getCartId(), dto.getItemId(), dto.getQty(), dto.getUnitPrice(), dto.getLineTotal()));
    }

    @Override
    public boolean updateCartItem(CartItemDTO dto) throws SQLException {
        return false;
    }

    @Override
    public boolean deleteCartItem(String cartId) throws SQLException {
        return false;
    }

    @Override
    public CartItemDTO searchCartItem(String cartId) throws SQLException {
        return null;
    }

    @Override
    public List<CartItemDTO> getAllCartItems() throws SQLException {
        return List.of();
    }

    @Override
    public List<String> getCartItemIds() throws SQLException {
        return List.of();
    }

    @Override
    public CartItemDTO searchByIdCartItem(String cartId) throws SQLException {
        return null;
    }

    @Override
    public List<CartItemDTO> getItemsForCart(String cartId) throws SQLException {
        List<CartItemDTO> list = new ArrayList<>();
        for (Cart_Item ci : cartItemDAO.findByCartId(cartId)) {
            list.add(new CartItemDTO(ci.getCartId(), ci.getItemId(), ci.getQty(), ci.getUnitPrice(), ci.getLineTotal()));
        }
        return list;
    }

    @Override
    public boolean removeItem(String cartId, String itemId) throws SQLException {
        return cartItemDAO.deleteByCartAndItem(cartId, itemId);
    }
}
