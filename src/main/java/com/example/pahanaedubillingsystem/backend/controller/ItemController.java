package com.example.pahanaedubillingsystem.backend.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.example.pahanaedubillingsystem.backend.bo.BOFactory;
import com.example.pahanaedubillingsystem.backend.bo.custom.ItemBO;
import com.example.pahanaedubillingsystem.backend.dto.ItemDTO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ItemModel", urlPatterns = "/ItemModel", loadOnStartup = 4)
public class ItemController extends HttpServlet {
    private final static Logger logger = LoggerFactory.getLogger(ItemController.class);
    private final ObjectMapper objectMapper = new ObjectMapper();
    private final ItemBO itemBO = (ItemBO) BOFactory.getBoFactory().getBO(BOFactory.BOTypes.ITEM);

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<ItemDTO> items = itemBO.getAllItems();
            String jsonItems = objectMapper.writeValueAsString(items);
            resp.setContentType("application/json");
            resp.getWriter().write(jsonItems);
            logger.info("Get All Items");
        } catch (Exception e) {
            logger.error("Error fetching items", e);
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching items");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            ItemDTO item = objectMapper.readValue(req.getInputStream(), ItemDTO.class);
            boolean isSaved = itemBO.saveItem(item);
            resp.getWriter().write(isSaved ? "saved" : "not saved");
            logger.info(isSaved ? "Item Saved" : "Item Not Saved");
        } catch (Exception e) {
            logger.error("Item Not Saved", e);
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Error saving item");
        }
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            ItemDTO item = objectMapper.readValue(req.getInputStream(), ItemDTO.class);
            boolean isUpdated = itemBO.updateItem(item);
            resp.getWriter().write(isUpdated ? "updated" : "not updated");
            logger.info(isUpdated ? "Item Updated" : "Item Not Updated");
        } catch (Exception e) {
            logger.error("Item Not Updated", e);
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Error updating item");
        }
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String itemId = req.getParameter("item_id");
            boolean isDeleted = itemBO.deleteItem(itemId);
            resp.getWriter().write(isDeleted ? "deleted" : "not deleted");
            logger.info(isDeleted ? "Item Deleted" : "Item Not Deleted");
        } catch (Exception e) {
            logger.error("Item Not Deleted", e);
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Error deleting item");
        }
    }
}