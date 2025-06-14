package com.example.model;

import com.example.util.DatabaseConfig;
import java.sql.*;
import java.util.*;
//import java.util.List;

public class User {
    private int id;
    private String username;
    private String password;
    private String name;
    private String role;
    private String email;

    // Constructors, getters, and setters
    // ...

    // Database operations
    public static User authenticate(String username, String password) throws SQLException {
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            stmt.setString(2, password);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new User(
                            rs.getInt("id"),
                            rs.getString("username"),
                            rs.getString("password"),
                            rs.getString("name"),
                            rs.getString("role"),
                            rs.getString("email")
                    );
                }
            }
        }
        return null;
    }

    public static List<User> getAllUsers() throws SQLException {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users";

        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                users.add(new User(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("name"),
                        rs.getString("role"),
                        rs.getString("email")
                ));
            }
        }
        return users;
    }

    // Add more methods as needed (create, update, delete, etc.)
}