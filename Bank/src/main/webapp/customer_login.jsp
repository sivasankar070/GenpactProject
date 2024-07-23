<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 50px;
            text-align: center;
            background-color: #f4f4f4; /* Changed background color */
        }
        h2 {
            color: #4a90e2; /* Changed header color to blue */
        }
        form {
            max-width: 300px;
            margin: auto;
            background-color: #f2f2f2;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.2); /* Adjusted box shadow */
        }
        input[type=text], input[type=password] {
            width: 100%;
            padding: 10px;
            margin: 5px 0 20px 0;
            display: inline-block;
            border: 1px solid #ccc;
            box-sizing: border-box;
            border-radius: 4px; /* Added border radius for inputs */
        }
        button {
            background-color: #4a90e2; /* Changed button color to blue */
            color: white;
            padding: 10px 20px;
            margin: 10px 0;
            border: none;
            cursor: pointer;
            width: 100%;
            border-radius: 4px; /* Added border radius for button */
        }
        button:hover {
            background-color: #357abd; /* Darkened hover color */
        }
        .register-link {
            margin-top: 20px;
        }
        .login-link {
            display: block;
            margin-top: 20px;
            text-decoration: none;
            color: #4a90e2;; /* Changed link color to blue */
        }
        .login-link:hover {
            color: black;
        }
        .change-password-link {
            display: block;
            margin-top: 20px;
            text-align: center;
            color: #4a90e2;; /* Changed link color to blue */
            text-decoration: none;
        }
        .change-password-link:hover {
            color: black;
        }a {
            color: #4a90e2;; /* Changed link color to blue */
        	text-decoration: none;
        }
        a:hover {
            color: black;
        }
        p{
        color: black;
        text-decoration: none;
        }
    </style>
</head>
<body>

<h2>Customer Login</h2>

<div class="container">
    <form action="customerLogin" method="post">
        <label for="accountNo"><b>Account Number</b></label>
        <input type="text" placeholder="Enter Account Number" name="accountNo" required>

        <label for="password"><b>Password</b></label>
        <input type="password" placeholder="Enter Password" name="password" required>

        <button type="submit">Login</button>
    <a href="customer_change_password.jsp" class="change-password-link">Change Password</a>
    <p>New Customer? <a href="customer_registration.jsp">Register Here</a></p>
<a class="login-link" href="index.jsp">Back to choose</a>
    </form>
</div>



</body>
</html>
