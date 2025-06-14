package com.example.util;

import java.sql.*;
import java.sql.SQLException;


public class DatabaseUtil {
    public static int getCourseCount() throws SQLException {
        String sql = "SELECT COUNT(*) FROM courses";
        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    public static int getStudentCount() throws SQLException {
        String sql = "SELECT COUNT(*) FROM users WHERE role = 'student'";
        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    public static int getFacultyCount() throws SQLException {
        String sql = "SELECT COUNT(*) FROM users WHERE role = 'faculty'";
        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    public static int getActiveCourseCount() throws SQLException {
        String sql = "SELECT COUNT(*) FROM courses WHERE status = 'active'";
        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    // Add more utility methods as needed
}