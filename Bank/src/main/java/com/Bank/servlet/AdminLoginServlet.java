package com.Bank.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.Bank.dao.DatabaseConnection;

@WebServlet("/adminLogin")
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("admin_login.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        DatabaseConnection dbConn = null;
        try {
            dbConn = new DatabaseConnection();
            Connection conn = dbConn.getConnection();
            String sql = "SELECT * FROM admin WHERE username = ? AND password = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, username);
            statement.setString(2, password);
            ResultSet result = statement.executeQuery();

            if (result.next()) {
                // Admin login successful
                HttpSession session = request.getSession();
                session.setAttribute("adminUsername", username);
                response.sendRedirect("admin_dashboard.jsp");
            } else {
                // Admin login failed
            	request.setAttribute("message", "Wrong username or password. Try again");
            	request.getRequestDispatcher("admin_login.jsp").forward(request, response);
            }
        } catch (ClassNotFoundException | SQLException e) {
            throw new ServletException("Database access error", e);
        } finally {
            try {
                if (dbConn != null) {
                    dbConn.closeConnection();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
