package com.example.pahanaedubillingsystem.backend.db;

import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;

public class DBConnection {
    private static DBConnection dbConnection;
    private Connection connection;

    private DBConnection() {
        try {
            InitialContext context = new InitialContext();
            DataSource lookup = (DataSource) context.lookup("java:comp/env/jdbc/pahana_edu");
            this.connection = lookup.getConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static DBConnection getInstance() {
        return dbConnection == null ? dbConnection = new DBConnection() : dbConnection;
    }

    public Connection getConnection() {
        return connection;
    }
}