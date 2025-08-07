package com.example.pahanaedubillingsystem.backend.bo.custom;

import com.example.pahanaedubillingsystem.backend.bo.SuperBO;
import com.example.pahanaedubillingsystem.backend.dto.ItemDTO;
import java.sql.SQLException;
import java.util.List;

public interface ItemBO extends SuperBO {
    boolean saveItem(ItemDTO dto) throws SQLException;
    boolean updateItem(ItemDTO dto) throws SQLException;
    boolean deleteItem(String itemId) throws SQLException;
    ItemDTO searchItem(String itemId) throws SQLException;
    List<ItemDTO> getAllItems() throws SQLException;
    List<String> getItemIds() throws SQLException;
    ItemDTO searchByIdItem(String itemId) throws SQLException;
}