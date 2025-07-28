package com.example.pahanaedubillingsystem.backend.util;

import com.example.pahanaedubillingsystem.backend.db.DBConnection;
import com.example.pahanaedubillingsystem.backend.dto.CustomerDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CrudUtil {
    private static CrudUtil crudUtil;

    private final static String GET_CUSTOMERS = "SELECT * FROM customers";
    private final static String SAVE_CUSTOMER = "INSERT INTO customers (account_no, name, address, telephone, units_consumed) VALUES (?, ?, ?, ?, ?)";
    private final static String UPDATE_CUSTOMER = "UPDATE customers SET name = ?, address = ?, telephone = ?, units_consumed = ? WHERE account_no = ?";
    private final static String DELETE_CUSTOMER = "DELETE FROM customers WHERE account_no = ?";

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

//    public boolean deleteCustomer(String accountNo) throws Exception {
//        Connection con = DBConnection.getInstance().getConnection();
//        try {
//            con.setAutoCommit(false);
//            ResultSet rs = executeQuery(con, CHECK_CUSTOMER_BILLS, accountNo);
//            if (rs.next()) {
//                boolean isDelBills = executeQuery(con, DELETE_BILLS_FOR_CUSTOMER, accountNo);
//                if (isDelBills) {
//                    boolean isDelCus = executeQuery(con, DELETE_CUSTOMER, accountNo);
//                    if (isDelCus) {
//                        con.commit();
//                        return true;
//                    }
//                }
//            } else {
//                boolean isDelCus = executeQuery(con, DELETE_CUSTOMER, accountNo);
//                if (isDelCus) {
//                    con.commit();
//                    return true;
//                }
//            }
//            con.rollback();
//            return false;
//        } catch (SQLException e) {
//            con.rollback();
//            e.printStackTrace();
//            return false;
//        } finally {
//            con.setAutoCommit(true);
//        }
//    }

    private enum CrudTypes { GET, SAVE, UPDATE, DELETE }

    private <T> String filterQuery(CrudTypes crudType, Class<T> dto) {
        if (dto.equals(CustomerDTO.class)) {
            switch (crudType) {
                case GET: return GET_CUSTOMERS;
                case SAVE: return SAVE_CUSTOMER;
                case UPDATE: return UPDATE_CUSTOMER;
                case DELETE: return DELETE_CUSTOMER;
            }
        }
        return null;
    }
}
