package com.Bank.servlet;

import com.Bank.dao.DatabaseConnection;
import com.Bank.utils.EmailUtility;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Random;

@WebServlet("/approveCustomer")
public class ApproveCustomerServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int customerId = Integer.parseInt(request.getParameter("customerId"));

        DatabaseConnection dbConn = null;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            dbConn = new DatabaseConnection();
            conn = dbConn.getConnection();

            // Fetch customer details from pending_customers table
            String fetchSql = "SELECT * FROM pending_customers WHERE id = ?";
            stmt = conn.prepareStatement(fetchSql);
            stmt.setInt(1, customerId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                String fullName = rs.getString("full_name");
                String address = rs.getString("address");
                String mobileNo = rs.getString("mobile_no");
                String emailId = rs.getString("email");
                String accountType = rs.getString("account_type");
                double initialBalance = rs.getDouble("initial_balance");
                String dob = rs.getString("date_of_birth");
                String idProof = rs.getString("id_proof");

                // Generate account number and temporary password
                String accountNumber = generateAccountNumber();
                String tempPassword = generateTempPassword();

                // Insert approved customer details into customers table
                String insertSql = "INSERT INTO customers (account_no, full_name, address, mobile_no, email, account_type, balance, date_of_birth, id_proof, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement insertStmt = conn.prepareStatement(insertSql);
                insertStmt.setString(1, accountNumber);
                insertStmt.setString(2, fullName);
                insertStmt.setString(3, address);
                insertStmt.setString(4, mobileNo);
                insertStmt.setString(5, emailId);
                insertStmt.setString(6, accountType);
                insertStmt.setDouble(7, initialBalance);
                insertStmt.setString(8, dob);
                insertStmt.setString(9, idProof);
                insertStmt.setString(10, tempPassword);
                insertStmt.executeUpdate();

                // Delete customer details from pending_customers table
                String deleteSql = "DELETE FROM pending_customers WHERE id = ?";
                PreparedStatement deleteStmt = conn.prepareStatement(deleteSql);
                deleteStmt.setInt(1, customerId);
                deleteStmt.executeUpdate();

                // Send email with account number and temporary password
                EmailUtility.sendEmail(emailId, accountNumber, tempPassword);
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (dbConn != null) dbConn.closeConnection();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect("admin_dashboard.jsp");
    }

    private String generateAccountNumber() {
        Random rand = new Random();
        int num = rand.nextInt(999999999);
        return String.format("%09d", num);
    }

    private String generateTempPassword() {
        Random rand = new Random();
        int num = rand.nextInt(999999);
        return String.format("%06d", num);
    }
}
