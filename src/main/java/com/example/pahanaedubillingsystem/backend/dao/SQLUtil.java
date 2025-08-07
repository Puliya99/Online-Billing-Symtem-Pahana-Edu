package com.example.pahanaedubillingsystem.backend.dao;

import com.example.pahanaedubillingsystem.backend.db.DBConnection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class SQLUtil {
    public static <T> T execute(String sql, Object... args) throws SQLException {
        PreparedStatement pstm = DBConnection.getInstance().getConnection().prepareStatement(sql);
        for (int i = 0; i < args.length; i++) {
            pstm.setObject(i + 1, args[i]);
        }
        if (sql.toUpperCase().startsWith("SELECT")) {
            return (T) pstm.executeQuery();
        }
        return (T) (Boolean) (pstm.executeUpdate() > 0);
    }
}