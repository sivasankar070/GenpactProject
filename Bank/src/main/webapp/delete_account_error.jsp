<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Account Error</title>
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
        }
        h1 {
            color: #4a90e2; /* Changed header color to blue */
        }
        p {
            margin: 20px 0;
        }
        .button {
            padding: 10px 20px;
            text-decoration: none;
            background-color: #4a90e2; /* Changed button color to blue */
            color: white;
            border-radius: 5px;
            text-align: center;
            display: inline-block;
            margin-top: 10px;
        }
        .button:hover {
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
        <h1>Account Deletion Error</h1>
        <p>Your account could not be deleted because it has a non-zero balance or the credentials are incorrect. Please withdraw all funds or provide correct credentials before attempting to delete the account.</p>
        <a href="customer_dashboard.jsp">Go to Dashboard</a>
    </div>
</body>
</html>
