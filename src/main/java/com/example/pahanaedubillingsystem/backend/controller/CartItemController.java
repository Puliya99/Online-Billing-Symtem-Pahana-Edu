package com.example.pahanaedubillingsystem.backend.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.example.pahanaedubillingsystem.backend.bo.BOFactory;
import com.example.pahanaedubillingsystem.backend.bo.custom.CartItemBo;
import com.example.pahanaedubillingsystem.backend.dto.CartItemDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "CartItemModel", urlPatterns = "/CartItemModel", loadOnStartup = 4)
public class CartItemController extends HttpServlet {
    private final static Logger logger = LoggerFactory.getLogger(CartItemController.class);
    private final ObjectMapper objectMapper = new ObjectMapper();
    private final CartItemBo cartItemBo = (CartItemBo) BOFactory.getBoFactory().getBO(BOFactory.BOTypes.CART_ITEM);

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String cartId = req.getParameter("cart_id");
            if (cartId == null || cartId.trim().isEmpty()) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                resp.getWriter().write("[]");
                return;
            }
            List<CartItemDTO> items = cartItemBo.getItemsForCart(cartId.trim());
            String json = objectMapper.writeValueAsString(items);
            resp.setContentType("application/json");
            resp.getWriter().write(json);
        } catch (Exception e) {
            logger.error("Error fetching cart items", e);
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching cart items");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            CartItemDTO item = objectMapper.readValue(req.getInputStream(), CartItemDTO.class);
            boolean isSaved = cartItemBo.saveCartItem(item);
            resp.getWriter().write(isSaved ? "saved" : "not saved");
            logger.info(isSaved ? "Cart Item Saved" : "Cart Item Not Saved");
        } catch (Exception e) {
            logger.error("Cart Item Not Saved", e);
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Error saving cart item");
        }
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String cartId = req.getParameter("cart_id");
            String itemId = req.getParameter("item_id");
            if (cartId == null || itemId == null || cartId.trim().isEmpty() || itemId.trim().isEmpty()) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                resp.getWriter().write("not deleted");
                return;
            }
            boolean deleted = cartItemBo.removeItem(cartId.trim(), itemId.trim());
            resp.getWriter().write(deleted ? "deleted" : "not deleted");
            logger.info(deleted ? "Cart Item Deleted" : "Cart Item Not Deleted");
        } catch (Exception e) {
            logger.error("Cart Item Not Deleted", e);
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Error deleting cart item");
        }
    }
}
