package com.example.pahanaedubillingsystem.backend.dao;

import com.example.pahanaedubillingsystem.backend.db.DBConnection;
import javax.sql.rowset.CachedRowSet;
import javax.sql.rowset.RowSetProvider;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SQLUtil {
    public static <T> T execute(String sql, Object... args) throws SQLException {
        String trimmed = sql.trim();
        boolean isSelect = trimmed.regionMatches(true, 0, "SELECT", 0, 6);
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement pstm = con.prepareStatement(sql)) {
            for (int i = 0; i < args.length; i++) {
                pstm.setObject(i + 1, args[i]);
            }
            if (isSelect) {
                try (ResultSet rs = pstm.executeQuery()) {
                    CachedRowSet crs = RowSetProvider.newFactory().createCachedRowSet();
                    crs.populate(rs);
                    return (T) crs;
                }
            } else {
                int updated = pstm.executeUpdate();
                return (T) (Boolean) (updated > 0);
            }
        }
    }
}