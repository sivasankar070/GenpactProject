<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        .container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: 20px auto;
        }
        h1 {
            color: #4a90e2; /* Changed header color to blue */
            margin-bottom: 20px;
            text-align: center;
        }
        .dashboard-link {
            display: block;
            margin-bottom: 10px;
            padding: 10px;
            text-decoration: none;
            background-color: #4a90e2; /* Changed link background color to blue */
            color: white;
            border-radius: 5px;
            text-align: center;
            transition: background-color 0.3s;
        }
        .dashboard-link:hover {
            background-color: #357abd; /* Darkened hover color */
        }
        form {
            text-align: center;
            margin-top: 20px;
        }
        form input[type="submit"] {
            background-color: #4a90e2; /* Changed logout button color to blue */
            color: white;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            border-radius: 4px;
            font-size: 16px;
            transition: background-color 0.3s;
        }
        form input[type="submit"]:hover {
            background-color: #357abd; /* Darkened hover color */
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Welcome to Your Dashboard</h1>
        <a href="ViewBalanceServlet" class="dashboard-link">View Balance</a>
        <a href="ViewTransactionsServlet" class="dashboard-link">View Transactions</a>
        <a href="WithdrawServlet" class="dashboard-link">Withdraw Money</a>
        <a href="DepositServlet" class="dashboard-link">Deposit Money</a>
        <a href="delete_account.jsp" class="dashboard-link">Delete Account</a>
        <form action="customer_login.jsp">
            <input type="submit" value="Logout">
        </form>
    </div>
</body>
</html>
