package com.Bank.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.Bank.dao.DatabaseConnection;

@WebServlet("/deleteCustomer")
public class DeleteCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accountNo = request.getParameter("accountNo");

        if (accountNo == null || accountNo.isEmpty()) {
            // Handle invalid account number
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid account number.");
            return;
        }

        Connection conn = null;
        PreparedStatement psDeleteTransactions = null;
        PreparedStatement psDeleteCustomer = null;
        try {
            DatabaseConnection db = new DatabaseConnection();
            conn = db.getConnection();
            conn.setAutoCommit(false); // Start transaction

            // Delete transactions for the account
            String deleteTransactionsSql = "DELETE FROM transactions WHERE account_no=?";
            psDeleteTransactions = conn.prepareStatement(deleteTransactionsSql);
            psDeleteTransactions.setString(1, accountNo);
            psDeleteTransactions.executeUpdate();

            // Delete customer
            String deleteCustomerSql = "DELETE FROM customers WHERE account_no=?";
            psDeleteCustomer = conn.prepareStatement(deleteCustomerSql);
            psDeleteCustomer.setString(1, accountNo);
            int rowsAffected = psDeleteCustomer.executeUpdate();

            if (rowsAffected > 0) {
                conn.commit(); // Commit transaction if successful
                response.sendRedirect("admin_dashboard.jsp");
            } else {
                conn.rollback(); // Rollback transaction if no rows were affected
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Account not found.");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            // Print the exception message to the response for debugging
            response.getWriter().println("Error: " + e.getMessage());
            try {
                if (conn != null) conn.rollback(); // Rollback transaction on error
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while deleting the account.");
        } finally {
            try {
                if (psDeleteTransactions != null) psDeleteTransactions.close();
                if (psDeleteCustomer != null) psDeleteCustomer.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
