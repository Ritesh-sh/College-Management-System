package com.example.servlets;

import com.example.model.User;
import com.example.util.DatabaseConfig;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        java.lang.String username = request.getParameter("username");
        java.lang.String password = request.getParameter("password");
        java.lang.String remember = request.getParameter("remember");

        try {
            User authenticatedUser = User.authenticate(username, password);

            if (authenticatedUser != null) {
                // Rest of the login logic remains the same
                HttpSession session = request.getSession();
                session.setAttribute("user", authenticatedUser);

                // Cookie handling remains the same
                // ...

                response.sendRedirect(request.getContextPath() + "/" +
                        authenticatedUser.getRole() + "/dashboard.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/login.jsp?error=1");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=2");
        }
    }
}