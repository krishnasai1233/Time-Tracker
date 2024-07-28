package com.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import models.Users;
public class EmployeeDAO {

    private static final String jdbcURL = "jdbc:mysql://localhost:3306/employee_db?allowPublicKeyRetrieval=true&useSSL=false";
    private static final String jdbcUsername = "root";
    private static final String jdbcPassword = "root";

    private static final String ADD_USER_SQL = "INSERT INTO Users (username, password, role) VALUES (?, ?, ?)";

    public static Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return connection;
    }

    public static void closeResources(Connection conn, PreparedStatement stmt) {
        try {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void addUser(Users user) throws SQLException {
        Connection connection = null;
        PreparedStatement stmt = null;

        try {
            connection = getConnection();
            stmt = connection.prepareStatement(ADD_USER_SQL);
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getPassword());
            stmt.setString(3, user.getRole());
            stmt.executeUpdate();
        } finally {
            closeResources(connection, stmt);
        }
    }
}

