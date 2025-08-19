package com.example.pahanaedubillingsystem.backend.db;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

public class DBConnection {
    private static DBConnection dbConnection;
    private DataSource dataSource;

    private DBConnection() {
        initDataSource();
    }

    private void initDataSource() {
        try {
            InitialContext context = new InitialContext();
            this.dataSource = (DataSource) context.lookup("java:comp/env/jdbc/PahanaEduBillingSystem");
        } catch (NamingException e) {
            System.err.println("[DBConnection] JNDI lookup failed for java:comp/env/jdbc/PahanaEduBillingSystem: " + e.getMessage());
            this.dataSource = null;
        }
    }

    public static DBConnection getInstance() {
        return (dbConnection == null) ? (dbConnection = new DBConnection()) : dbConnection;
    }

    public Connection getConnection() throws SQLException {
        if (this.dataSource == null) {
            initDataSource();
        }
        if (this.dataSource == null) {
            throw new SQLException("DataSource not available. Check JNDI resource configuration.");
        }
        return this.dataSource.getConnection();
    }
}