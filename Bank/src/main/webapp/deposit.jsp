<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Deposit</title>
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
            max-width: 400px;
            margin: 20px auto;
        }
        h1 {
            color: #4a90e2; /* Blue header color */
            text-align: center;
            margin-bottom: 20px;
        }
        form {
            margin-top: 20px;
            text-align: center;
        }
        label {
            display: block;
            margin-bottom: 8px;
        }
        input[type="number"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        button {
            background-color: #4a90e2; /* Blue button color */
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }
        button:hover {
            background-color: #357abd; /* Darker shade of blue on hover */
        }
        .message {
            margin-top: 20px;
            color: #d9534f; /* Red error message color */
            text-align: center;
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
    </style>
</head>
<body>
    <div class="container">
        <h1>Deposit</h1>
        <form action="DepositServlet" method="post">
            <label for="amount">Amount to Deposit:</label>
            <input type="number" id="amount" name="amount" required>
            <button type="submit" class="submit-button">Deposit</button>
        </form>
        <div class="message">
            <%= request.getAttribute("message") != null ? request.getAttribute("message") : "" %>
        </div>
        <a href="customer_dashboard.jsp">Back to Dashboard</a>
    </div>
</body>
</html>
