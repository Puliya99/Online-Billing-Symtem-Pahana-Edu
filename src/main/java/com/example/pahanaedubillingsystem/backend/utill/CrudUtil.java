package com.example.pahanaedubillingsystem.backend.utill;

import com.example.pahanaedubillingsystem.backend.db.DBConnection;
import com.example.pahanaedubillingsystem.backend.dto.UserDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CrudUtil {
    private static CrudUtil crudUtil;

    private final static String GET_USERS = "SELECT * FROM users";
    private final static String SAVE_USER = "INSERT INTO users (username, password) VALUES (?, ?)";
    private final static String VALIDATE_USER = "SELECT * FROM users WHERE username = ? AND password = ?";

    private CrudUtil() {}

    public static CrudUtil getInstance() {
        return crudUtil == null ? crudUtil = new CrudUtil() : crudUtil;
    }

    private static <T> T executeQuery(Connection con, String sql, Object... args) throws Exception {
        PreparedStatement ps = con.prepareStatement(sql);
        for (int i = 0; i < args.length; i++) {
            ps.setObject(i + 1, args[i]);
        }
        if (sql.toUpperCase().startsWith("SELECT")) {
            return (T) ps.executeQuery();
        }
        return (T) (Boolean) (ps.executeUpdate() > 0);
    }

    public <T> List<T> getAll(Class<T> dtoClass) throws Exception {
        String sql = filterQuery(CrudTypes.GET, dtoClass);
        ResultSet rs = executeQuery(DBConnection.getInstance().getConnection(), sql);
        List<T> dtos = new ArrayList<>();
        while (rs.next()) {
            if (dtoClass.equals(UserDTO.class)) {
                dtos.add((T) new UserDTO(rs.getString("username"), rs.getString("password")));
            }
        }
        return dtos;
    }

    public boolean validateUser(String username, String password) throws Exception {
        ResultSet rs = executeQuery(DBConnection.getInstance().getConnection(), VALIDATE_USER, username, password);
        return rs.next();
    }

    private enum CrudTypes { GET, SAVE, UPDATE, DELETE }

    private <T> String filterQuery(CrudTypes crudType, Class<T> dto) {
        
        if (dto.equals(UserDTO.class)) {
            switch (crudType) {
                case GET: return GET_USERS;
                case SAVE: return SAVE_USER;
            }
        }
        return null;
    }
}
