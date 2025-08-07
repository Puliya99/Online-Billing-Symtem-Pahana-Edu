package com.example.pahanaedubillingsystem.backend.dao.custom.impl;

import com.example.pahanaedubillingsystem.backend.dao.SQLUtil;
import com.example.pahanaedubillingsystem.backend.dao.custom.UserDAO;
import com.example.pahanaedubillingsystem.backend.entity.User;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAOImpl implements UserDAO {
    private static final String GET_USERS = "SELECT * FROM users";
    private static final String SAVE_USER = "INSERT INTO users (username, password) VALUES (?, ?)";
    private static final String VALIDATE_USER = "SELECT * FROM users WHERE username = ? AND password = ?";

    @Override
    public boolean save(User entity) throws SQLException {
        return SQLUtil.execute(SAVE_USER, entity.getUsername(), entity.getPassword());
    }

    @Override
    public boolean update(User entity) throws SQLException {
        throw new UnsupportedOperationException("User update not implemented");
    }

    @Override
    public boolean delete(String username) throws SQLException {
        throw new UnsupportedOperationException("User deletion not implemented");
    }

    @Override
    public User search(String username) throws SQLException {
        ResultSet rst = SQLUtil.execute("SELECT * FROM users WHERE username = ?", username);
        if (rst.next()) {
            return new User(rst.getString("username"), rst.getString("password"));
        }
        return null;
    }

    @Override
    public List<User> getAll() throws SQLException {
        List<User> users = new ArrayList<>();
        ResultSet rst = SQLUtil.execute(GET_USERS);
        while (rst.next()) {
            users.add(new User(rst.getString("username"), rst.getString("password")));
        }
        return users;
    }

    @Override
    public List<String> getIds() throws SQLException {
        List<String> ids = new ArrayList<>();
        ResultSet rst = SQLUtil.execute("SELECT username FROM users");
        while (rst.next()) {
            ids.add(rst.getString(1));
        }
        return ids;
    }

    @Override
    public User searchById(String username) throws SQLException {
        ResultSet rst = SQLUtil.execute("SELECT * FROM users WHERE username = ?", username);
        if (rst.next()) {
            return new User(rst.getString("username"), rst.getString("password"));
        }
        return null;
    }

    @Override
    public boolean validateUser(String username, String password) throws SQLException {
        ResultSet rst = SQLUtil.execute(VALIDATE_USER, username, password);
        return rst.next();
    }
}