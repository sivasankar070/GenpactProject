<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Account</title>
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
            margin-bottom: 20px;
            text-align: center;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .button {
            padding: 10px 20px;
            background-color: #4a90e2; /* Blue button color */
            color: white;
            text-decoration: none;
            border-radius: 5px;
            text-align: center;
            display: inline-block;
            margin-top: 10px;
            cursor: pointer;
            border: none;
        }
        .button:hover {
            background-color: #357abd; /* Darker shade of blue on hover */
        }
        form input[type="submit"] {
            background-color: #4a90e2; /* Blue submit button color */
            color: white;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            border-radius: 4px;
            font-size: 16px;
            transition: background-color 0.3s;
            margin-top: 10px;
            width: 100%;
        }
        form input[type="submit"]:hover {
            background-color: #357abd; /* Darker shade of blue on hover */
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
        <h1>Delete Account</h1>
        <form action="DeleteAccountServlet" method="post">
            <div class="form-group">
                <label for="accountNo">Account Number:</label>
                <input type="text" id="accountNo" name="accountNo" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <button type="submit" class="button">Delete Account</button>
        </form>
        <a href="customer_dashboard.jsp">Back to Dashboard</a>
    </div>
</body>
</html>
