package com.example.pahanaedubillingsystem.backend.bo.custom.impl;

import com.example.pahanaedubillingsystem.backend.bo.custom.CartBO;
import com.example.pahanaedubillingsystem.backend.dao.DAOFactory;
import com.example.pahanaedubillingsystem.backend.dao.custom.CartDAO;
import com.example.pahanaedubillingsystem.backend.dto.CartDTO;
import com.example.pahanaedubillingsystem.backend.entity.Cart;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CartBOImpl implements CartBO {
    private final CartDAO cartDAO = (CartDAO) DAOFactory.getDaoFactory().getDAO(DAOFactory.DAOTypes.CART);

    @Override
    public boolean saveCart(CartDTO dto) throws SQLException {
        return cartDAO.save(new Cart(dto.getCartId(), dto.getDescription()));
    }

    @Override
    public boolean updateCart(CartDTO dto) throws SQLException {
        return cartDAO.update(new Cart(dto.getCartId(), dto.getDescription()));
    }

    @Override
    public boolean deleteCart(String cartId) throws SQLException {
        return cartDAO.delete(cartId);
    }

    @Override
    public CartDTO searchCart(String cartId) throws SQLException {
        Cart c = cartDAO.search(cartId);
        return c != null ? new CartDTO(c.getCartId(), c.getDescription()) : null;
    }

    @Override
    public List<CartDTO> getAllCarts() throws SQLException {
        List<CartDTO> list = new ArrayList<>();
        for (Cart c : cartDAO.getAll()) {
            list.add(new CartDTO(c.getCartId(), c.getDescription()));
        }
        return list;
    }

    @Override
    public List<String> getCartIds() throws SQLException {
        return cartDAO.getIds();
    }

    @Override
    public CartDTO searchByIdCart(String cartId) throws SQLException {
        Cart c = cartDAO.searchById(cartId);
        return c != null ? new CartDTO(c.getCartId(), c.getDescription()) : null;
    }
}
