package com.example.pahanaedubillingsystem.backend.bo.custom;

import com.example.pahanaedubillingsystem.backend.bo.SuperBO;
import com.example.pahanaedubillingsystem.backend.dto.UserDTO;
import java.sql.SQLException;
import java.util.List;

public interface UserBO extends SuperBO {
    boolean saveUser(UserDTO dto) throws SQLException;
    UserDTO searchUser(String username) throws SQLException;
    List<UserDTO> getAllUsers() throws SQLException;
    List<String> getUserIds() throws SQLException;
    UserDTO searchByIdUser(String username) throws SQLException;
    boolean validateUser(String username, String password) throws SQLException;
}