<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.Bank.dao.DatabaseConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register Customer</title>
    <style>
        :root {
            --background-color: #f0f2f5;
            --container-bg-color: #ffffff;
            --primary-color: #4a90e2;
            --button-bg-color: #4a90e2;
            --button-hover-bg-color: #357abd;
            --font-family: 'Roboto', sans-serif;
            --font-size: 16px;
            --border-radius: 8px;
            --button-border-radius: 4px;
            --box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            --padding: 20px;
            --margin: 10px;
            --transition-duration: 0.3s;
        }

        body {
            font-family: var(--font-family);
            background-color: var(--background-color);
            margin: 0;
            padding: var(--padding);
        }

        .container {
            background-color: var(--container-bg-color);
            padding: var(--padding);
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            max-width: 1200px;
            margin: var(--margin) auto;
        }

        h1, h2 {
            text-align: center;
            color: var(--primary-color);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: var(--margin) 0;
        }

        table, th, td {
            border: 1px solid #ddd;
            padding: 20px;
        }

        th, td {
            padding: 12px;
            text-align: left;
        }

        th {
            background-color: var(--primary-color);
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .approve-button, .reject-button {
            padding: 10px 20px;
            border: none;
            border-radius: var(--border-radius);
            color: white;
            cursor: pointer;
            transition: background-color var(--transition-duration);
        }

        .approve-button {
            background-color: var(--primary-color);
            min-width: 10px;
        }

        .approve-button:hover {
            background-color: var(--button-hover-bg-color);
        }

        .reject-button {
            background-color: #ff6347;
            min-width: 90px;
        }

        .reject-button:hover {
            background-color: #dc143c;
        }

        form {
            text-align: center;
            margin-bottom: var(--margin);
        }

        form input[type="submit"] {
            background-color: var(--primary-color);
            color: white;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            border-radius: var(--border-radius);
            font-size: var(--font-size);
            transition: background-color var(--transition-duration);
        }

        form input[type="submit"]:hover {
            background-color: var(--button-hover-bg-color);
        }
         a {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #4a90e2; /* Changed link color to blue */
            text-decoration: none;
        }
        a:hover {
            color: black;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Admin Dashboard</h1>
        <h2>Pending Customer Registrations</h2>
        <table>
            <thead>
                <tr>
                    <th>Full Name</th>
                    <th>Address</th>
                    <th>Mobile No</th>
                    <th>Email ID</th>
                    <th>Account Type</th>
                    <th>Initial Balance</th>
                    <th>Date of Birth</th>
                    <th>ID Proof</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    PreparedStatement stmt = null;
                    ResultSet rs = null;
                    DatabaseConnection dbConn = null;
                    try {
                        dbConn = new DatabaseConnection();
                        Connection conn = dbConn.getConnection();

                        String sql = "SELECT * FROM pending_customers";
                        stmt = conn.prepareStatement(sql);
                        rs = stmt.executeQuery();

                        while (rs.next()) {
                            int id = rs.getInt("id");
                            String fullName = rs.getString("full_name");
                            String address = rs.getString("address");
                            String mobileNo = rs.getString("mobile_no");
                            String emailId = rs.getString("email");
                            String accountType = rs.getString("account_type");
                            double initialBalance = rs.getDouble("initial_balance");
                            String dob = rs.getString("date_of_birth");
                            String idProof = rs.getString("id_proof");
                %>
                <tr>
                    <td><%= fullName %></td>
                    <td><%= address %></td>
                    <td><%= mobileNo %></td>
                    <td><%= emailId %></td>
                    <td><%= accountType %></td>
                    <td><%= initialBalance %></td>
                    <td><%= dob %></td>
                    <td><%= idProof %></td>
                    <td>
                        <form action="approveCustomer" method="post" style="display: inline;">
                            <input type="hidden" name="customerId" value="<%= id %>">
                            <button type="submit" class="approve-button">Approve</button>
                        </form>
                        <h1>								
                                               
                        </h1>
                        <form action="rejectCustomer" method="post" style="display: inline;">
                            <input type="hidden" name="customerId" value="<%= id %>">
                            <button type="submit" class="reject-button">Reject</button>
                        </form>
                    </td>
                </tr>
                <%
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
                %>
            </tbody>
        </table>
        <a href="admin_dashboard.jsp" class="back-button">Back to Dashboard</a>
    </div>
</body>
</html>
