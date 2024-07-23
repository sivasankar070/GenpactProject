<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Deposit Success</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
            text-align: center;
        }
        .container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #4a90e2;
        }
        .message {
            margin-top: 20px;
            color: black;
        }
        a {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
            color: #4a90e2;
            font-size: 18px;
        }
        a:hover {
            color: black;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Deposit Successful</h1>
        <div class="message">
            <p>Deposit successful. Your new balance is: <%= request.getAttribute("newBalance") %></p>
        </div>
        <a href="customer_dashboard.jsp">Back to Dashboard</a>
    </div>
</body>
</html>
