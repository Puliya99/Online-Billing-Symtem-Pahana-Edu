package com.example.pahanaedubillingsystem.backend.dao;

import java.sql.SQLException;
import java.util.List;

public interface CrudDAO<T> extends SuperDAO {
    boolean save(T entity) throws SQLException;
    boolean update(T entity) throws SQLException;
    boolean delete(String id) throws SQLException;
    T search(String id) throws SQLException;
    List<T> getAll() throws SQLException;
    List<String> getIds() throws SQLException;
    T searchById(String id) throws SQLException;
}