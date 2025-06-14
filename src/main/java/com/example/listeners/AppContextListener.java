package com.example.listeners;

import com.example.util.DatabaseConfig;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.sql.SQLException;

@WebListener
public class AppContextListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // Initialize database connection pool
        System.out.println("Application started. Database connection pool initialized.");

        // You can load initial data here if needed
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Clean up database connection pool
        DatabaseConfig.closeDataSource();
        System.out.println("Application stopped. Database connection pool closed.");
    }
}