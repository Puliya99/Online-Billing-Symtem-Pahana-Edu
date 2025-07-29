package com.example.pahanaedubillingsystem.backend.util;

import com.example.pahanaedubillingsystem.backend.db.DBConnection;
import com.example.pahanaedubillingsystem.backend.dto.BillDTO;
import com.example.pahanaedubillingsystem.backend.dto.CustomerDTO;
import com.example.pahanaedubillingsystem.backend.dto.ItemDTO;
import com.example.pahanaedubillingsystem.backend.dto.UserDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CrudUtil {
    private static CrudUtil crudUtil;

    private final static String GET_CUSTOMERS = "SELECT * FROM customers";
    private final static String SAVE_CUSTOMER = "INSERT INTO customers (account_no, name, address, telephone, units_consumed) VALUES (?, ?, ?, ?, ?)";
    private final static String UPDATE_CUSTOMER = "UPDATE customers SET name = ?, address = ?, telephone = ?, units_consumed = ? WHERE account_no = ?";
    private final static String DELETE_CUSTOMER = "DELETE FROM customers WHERE account_no = ?";

    private final static String GET_ITEMS = "SELECT * FROM items";
    private final static String SAVE_ITEM = "INSERT INTO items (item_id, name, price, qty) VALUES (?, ?, ?, ?)";
    private final static String UPDATE_ITEM = "UPDATE items SET name = ?, price = ?, qty = ? WHERE item_id = ?";
    private final static String DELETE_ITEM = "DELETE FROM items WHERE item_id = ?";

    private final static String GET_BILLS = "SELECT * FROM bills";
    private final static String SAVE_BILL = "INSERT INTO bills (bill_id, account_no, total_amount, bill_date) VALUES (?, ?, ?, ?)";
    private final static String CHECK_CUSTOMER_BILLS = "SELECT bill_id FROM bills WHERE account_no = ? LIMIT 1";
    private final static String DELETE_BILLS_FOR_CUSTOMER = "DELETE FROM bills WHERE account_no = ?";

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
            if (dtoClass.equals(CustomerDTO.class)) {
                dtos.add((T) new CustomerDTO(rs.getString("account_no"), rs.getString("name"), rs.getString("address"), rs.getString("telephone"), rs.getInt("units_consumed")));
            } else if (dtoClass.equals(ItemDTO.class)) {
                dtos.add((T) new ItemDTO(rs.getString("item_id"), rs.getString("name"), rs.getDouble("price"), rs.getInt("qty")));
            } else if (dtoClass.equals(BillDTO.class)) {
                dtos.add((T) new BillDTO(rs.getString("bill_id"), rs.getDate("bill_date"), rs.getString("account_no"), rs.getDouble("total_amount")));
            } else if (dtoClass.equals(UserDTO.class)) {
                dtos.add((T) new UserDTO(rs.getString("username"), rs.getString("password")));
            }
        }
        return dtos;
    }

    public <T> boolean save(Class<T> dtoClass, Object... args) throws Exception {
        return executeQuery(DBConnection.getInstance().getConnection(), filterQuery(CrudTypes.SAVE, dtoClass), args);
    }

    public <T> boolean update(Class<T> dtoClass, Object... args) throws Exception {
        return executeQuery(DBConnection.getInstance().getConnection(), filterQuery(CrudTypes.UPDATE, dtoClass), args);
    }

    public boolean deleteCustomer(String accountNo) throws Exception {
        Connection con = DBConnection.getInstance().getConnection();
        try {
            con.setAutoCommit(false);
            ResultSet rs = executeQuery(con, CHECK_CUSTOMER_BILLS, accountNo);
            if (rs.next()) {
                boolean isDelBills = executeQuery(con, DELETE_BILLS_FOR_CUSTOMER, accountNo);
                if (isDelBills) {
                    boolean isDelCus = executeQuery(con, DELETE_CUSTOMER, accountNo);
                    if (isDelCus) {
                        con.commit();
                        return true;
                    }
                }
            } else {
                boolean isDelCus = executeQuery(con, DELETE_CUSTOMER, accountNo);
                if (isDelCus) {
                    con.commit();
                    return true;
                }
            }
            con.rollback();
            return false;
        } catch (SQLException e) {
            con.rollback();
            e.printStackTrace();
            return false;
        } finally {
            con.setAutoCommit(true);
        }
    }

    public boolean deleteItem(String itemId) throws Exception {
        return executeQuery(DBConnection.getInstance().getConnection(), DELETE_ITEM, itemId);
    }

    public boolean validateUser(String username, String password) throws Exception {
        ResultSet rs = executeQuery(DBConnection.getInstance().getConnection(), VALIDATE_USER, username, password);
        return rs.next();
    }

    private enum CrudTypes { GET, SAVE, UPDATE, DELETE }

    private <T> String filterQuery(CrudTypes crudType, Class<T> dto) {
        if (dto.equals(CustomerDTO.class)) {
            switch (crudType) {
                case GET: return GET_CUSTOMERS;
                case SAVE: return SAVE_CUSTOMER;
                case UPDATE: return UPDATE_CUSTOMER;
                case DELETE: return DELETE_CUSTOMER;
            }
        } else if (dto.equals(ItemDTO.class)) {
            switch (crudType) {
                case GET: return GET_ITEMS;
                case SAVE: return SAVE_ITEM;
                case UPDATE: return UPDATE_ITEM;
                case DELETE: return DELETE_ITEM;
            }
        } else if (dto.equals(BillDTO.class)) {
            switch (crudType) {
                case GET: return GET_BILLS;
                case SAVE: return SAVE_BILL;
            }
        } else if (dto.equals(UserDTO.class)) {
            switch (crudType) {
                case GET: return GET_USERS;
                case SAVE: return SAVE_USER;
            }
        }
        return null;
    }
}