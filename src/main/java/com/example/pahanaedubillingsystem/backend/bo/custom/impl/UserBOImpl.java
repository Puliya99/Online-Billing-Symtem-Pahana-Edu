package com.example.pahanaedubillingsystem.backend.bo.custom.impl;

import com.example.pahanaedubillingsystem.backend.bo.custom.UserBO;
import com.example.pahanaedubillingsystem.backend.dao.DAOFactory;
import com.example.pahanaedubillingsystem.backend.dao.custom.UserDAO;
import com.example.pahanaedubillingsystem.backend.dto.UserDTO;
import com.example.pahanaedubillingsystem.backend.entity.User;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserBOImpl implements UserBO {
    private final UserDAO userDAO = (UserDAO) DAOFactory.getDaoFactory().getDAO(DAOFactory.DAOTypes.USER);

    @Override
    public boolean saveUser(UserDTO dto) throws SQLException {
        return userDAO.save(new User(dto.getUsername(), dto.getPassword(), dto.getRole()));
    }

    @Override
    public boolean updateUser(UserDTO dto) throws SQLException {
        return userDAO.update(new User(dto.getUsername(), dto.getPassword(), dto.getRole()));
    }

    @Override
    public boolean deleteUser(String username) throws SQLException {
        return userDAO.delete(username);
    }

    @Override
    public UserDTO searchUser(String username) throws SQLException {
        User user = userDAO.search(username);
        if (user != null) {
            return new UserDTO(user.getUsername(), user.getPassword(), user.getRole());
        }
        return null;
    }

    @Override
    public List<UserDTO> getAllUsers() throws SQLException {
        List<UserDTO> users = new ArrayList<>();
        List<User> all = userDAO.getAll();
        for (User u : all) {
            users.add(new UserDTO(u.getUsername(), u.getPassword(), u.getRole()));
        }
        return users;
    }

    @Override
    public List<String> getUserIds() throws SQLException {
        return userDAO.getIds();
    }

    @Override
    public UserDTO searchByIdUser(String username) throws SQLException {
        User user = userDAO.searchById(username);
        if (user != null) {
            return new UserDTO(user.getUsername(), user.getPassword(), user.getRole());
        }
        return null;
    }

    @Override
    public boolean validateUser(String username, String password) throws SQLException {
        return userDAO.validateUser(username, password);
    }
}