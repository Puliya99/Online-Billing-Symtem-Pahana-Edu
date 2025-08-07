package com.example.pahanaedubillingsystem.backend.bo.custom.impl;

import com.example.pahanaedubillingsystem.backend.bo.custom.ItemBO;
import com.example.pahanaedubillingsystem.backend.dao.DAOFactory;
import com.example.pahanaedubillingsystem.backend.dao.custom.ItemDAO;
import com.example.pahanaedubillingsystem.backend.dto.ItemDTO;
import com.example.pahanaedubillingsystem.backend.entity.Item;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ItemBOImpl implements ItemBO {
    private final ItemDAO itemDAO = (ItemDAO) DAOFactory.getDaoFactory().getDAO(DAOFactory.DAOTypes.ITEM);

    @Override
    public boolean saveItem(ItemDTO dto) throws SQLException {
        return itemDAO.save(new Item(dto.getItemId(), dto.getName(), dto.getPrice(), dto.getQty()));
    }

    @Override
    public boolean updateItem(ItemDTO dto) throws SQLException {
        return itemDAO.update(new Item(dto.getItemId(), dto.getName(), dto.getPrice(), dto.getQty()));
    }

    @Override
    public boolean deleteItem(String itemId) throws SQLException {
        return itemDAO.delete(itemId);
    }

    @Override
    public ItemDTO searchItem(String itemId) throws SQLException {
        Item item = itemDAO.search(itemId);
        if (item != null) {
            return new ItemDTO(item.getItemId(), item.getName(), item.getPrice(), item.getQty());
        }
        return null;
    }

    @Override
    public List<ItemDTO> getAllItems() throws SQLException {
        List<ItemDTO> items = new ArrayList<>();
        List<Item> all = itemDAO.getAll();
        for (Item i : all) {
            items.add(new ItemDTO(i.getItemId(), i.getName(), i.getPrice(), i.getQty()));
        }
        return items;
    }

    @Override
    public List<String> getItemIds() throws SQLException {
        return itemDAO.getIds();
    }

    @Override
    public ItemDTO searchByIdItem(String itemId) throws SQLException {
        Item item = itemDAO.searchById(itemId);
        if (item != null) {
            return new ItemDTO(item.getItemId(), item.getName(), item.getPrice(), item.getQty());
        }
        return null;
    }
}