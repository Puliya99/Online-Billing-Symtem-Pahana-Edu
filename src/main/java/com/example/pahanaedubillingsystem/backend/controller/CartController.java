package com.example.pahanaedubillingsystem.backend.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.example.pahanaedubillingsystem.backend.bo.BOFactory;
import com.example.pahanaedubillingsystem.backend.bo.custom.CartBO;
import com.example.pahanaedubillingsystem.backend.dto.CartDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "CartModel", urlPatterns = "/CartModel", loadOnStartup = 4)
public class CartController extends HttpServlet {
    private final static Logger logger = LoggerFactory.getLogger(CartController.class);
    private final ObjectMapper objectMapper = new ObjectMapper();
    private final CartBO cartBO = (CartBO) BOFactory.getBoFactory().getBO(BOFactory.BOTypes.CART);

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<CartDTO> carts = cartBO.getAllCarts();
            String json = objectMapper.writeValueAsString(carts);
            resp.setContentType("application/json");
            resp.getWriter().write(json);
            logger.info("Get All Carts");
        } catch (Exception e) {
            logger.error("Error fetching carts", e);
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching carts");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            CartDTO cart = objectMapper.readValue(req.getInputStream(), CartDTO.class);
            boolean isSaved = cartBO.saveCart(cart);
            resp.getWriter().write(isSaved ? "saved" : "not saved");
            logger.info(isSaved ? "Cart Saved" : "Cart Not Saved");
        } catch (Exception e) {
            logger.error("Cart Not Saved", e);
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Error saving cart");
        }
    }
}
