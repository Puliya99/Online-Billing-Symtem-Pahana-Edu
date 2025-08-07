package com.example.pahanaedubillingsystem.backend.dao.custom;

import com.example.pahanaedubillingsystem.backend.dao.CrudDAO;
import com.example.pahanaedubillingsystem.backend.entity.User;

import java.sql.SQLException;

public interface UserDAO extends CrudDAO<User> {
    boolean validateUser(String username, String password) throws SQLException;
}