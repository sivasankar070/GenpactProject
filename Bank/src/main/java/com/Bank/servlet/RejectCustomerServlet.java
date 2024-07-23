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
import com.Bank.dao.DatabaseConnection;
import com.Bank.utils.EmailUtility;

@WebServlet("/rejectCustomer")
public class RejectCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int customerId = Integer.parseInt(request.getParameter("customerId"));

        // Delete customer from pending_customers table
        Connection conn = null;
        PreparedStatement psDelete = null;
        try {
            DatabaseConnection db = new DatabaseConnection();
            conn = db.getConnection();

            // Send email to inform customer about rejection
            String customerEmail = getEmailById(customerId); // Method to get customer email by id
            if (customerEmail != null) {
                EmailUtility.rejectEmail(customerEmail);
            }
            String deleteSql = "DELETE FROM pending_customers WHERE id=?";
            psDelete = conn.prepareStatement(deleteSql);
            psDelete.setInt(1, customerId);
            psDelete.executeUpdate();

            response.sendRedirect("admin_dashboard.jsp");
        }catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            // Handle exceptions as needed
        } finally {
            try {
                if (psDelete != null) psDelete.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Example method to fetch customer email by id from database
    private String getEmailById(int customerId) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String email = null;
        try {
            DatabaseConnection db = new DatabaseConnection();
            conn = db.getConnection();
            String sql = "SELECT email FROM pending_customers WHERE id=?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, customerId);
            rs = ps.executeQuery();
            if (rs.next()) {
                email = rs.getString("email");
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
        return email;
    }
}
