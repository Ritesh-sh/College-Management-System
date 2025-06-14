package com.example.servlets;

import com.example.model.DynamicVariable;
import com.example.util.DatabaseConfig;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/variables")
public class VariableServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String name = request.getParameter("name");
        String type = request.getParameter("type");
        String value = request.getParameter("value");
        String scope = request.getParameter("scope");

        try {
            if ("create".equals(action)) {
                createVariable(name, type, value, scope);
            } else if ("update".equals(action)) {
                updateVariable(name, value, scope);
            } else if ("delete".equals(action)) {
                deleteVariable(name, scope);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error occurred");
        }

        response.sendRedirect(request.getContextPath() + "/admin/variables.jsp");
    }

    private void createVariable(String name, String type, String value, String scope)
            throws SQLException {
        String sql = "INSERT INTO dynamic_variables (name, type, value, scope) VALUES (?, ?, ?, ?)";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, name);
            stmt.setString(2, type);
            stmt.setString(3, value);
            stmt.setString(4, scope);
            stmt.executeUpdate();
        }
    }

    private void updateVariable(String name, String value, String scope)
            throws SQLException {
        String sql = "UPDATE dynamic_variables SET value = ? WHERE name = ? AND scope = ?";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, value);
            stmt.setString(2, name);
            stmt.setString(3, scope);
            stmt.executeUpdate();
        }
    }

    private void deleteVariable(String name, String scope) throws SQLException {
        String sql = "DELETE FROM dynamic_variables WHERE name = ? AND scope = ?";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, name);
            stmt.setString(2, scope);
            stmt.executeUpdate();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Map<String, DynamicVariable> appVars = getVariablesByScope("application");
            Map<String, DynamicVariable> sessionVars = getVariablesByScope("session");
            Map<String, DynamicVariable> requestVars = getVariablesByScope("request");

            request.setAttribute("applicationVariables", appVars);
            request.setAttribute("sessionVariables", sessionVars);
            request.setAttribute("requestVariables", requestVars);

            request.getRequestDispatcher("/admin/variables.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp?error=db");
        }
    }

    private Map<String, DynamicVariable> getVariablesByScope(String scope)
            throws SQLException {
        Map<String, DynamicVariable> variables = new HashMap<>();
        String sql = "SELECT * FROM dynamic_variables WHERE scope = ?";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, scope);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    DynamicVariable var = new DynamicVariable(
                            rs.getString("name"),
                            DynamicVariable.VariableType.valueOf(rs.getString("type")),
                            rs.getString("value"),
                            rs.getString("scope")
                    );
                    variables.put(var.getName(), var);
                }
            }
        }
        return variables;
    }
}