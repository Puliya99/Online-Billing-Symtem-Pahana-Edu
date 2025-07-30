package com.example.pahanaedubillingsystem.backend.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.example.pahanaedubillingsystem.backend.dto.ItemDTO;
import com.example.pahanaedubillingsystem.backend.util.CrudUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ItemModel", urlPatterns = "/ItemModel", loadOnStartup = 4)
public class ItemController extends HttpServlet {
    private final static Logger logger = LoggerFactory.getLogger(ItemController.class);
    private ObjectMapper objectMapper = new ObjectMapper();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<ItemDTO> items = CrudUtil.getInstance().getAll(ItemDTO.class);
            String jsonItems = objectMapper.writeValueAsString(items);
            resp.setContentType("application/json");
            resp.getWriter().write(jsonItems);
            logger.info("Get All Items");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching items");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            ItemDTO item = objectMapper.readValue(req.getInputStream(), ItemDTO.class);
            boolean isSaved = CrudUtil.getInstance().save(
                    ItemDTO.class,
                    item.getItemId(),
                    item.getName(),
                    item.getPrice(),
                    item.getQty()
            );
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

            boolean isUpdated = CrudUtil.getInstance().update(
                    ItemDTO.class,
                    item.getName(),
                    item.getPrice(),
                    item.getQty(),
                    item.getItemId()
            );
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
            boolean isDeleted = CrudUtil.getInstance().deleteItem(req.getParameter("item_id"));
            resp.getWriter().write(isDeleted ? "deleted" : "not deleted");
            logger.info(isDeleted ? "Item Deleted" : "Item Not Deleted");
        } catch (Exception e) {
            logger.error("Item Not Deleted", e);
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Error deleting item");
        }
    }
}
