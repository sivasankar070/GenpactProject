<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Registration</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 50px;
            text-align: center;
        }
        h2 {
            color: #4a90e2; /* Blue color for header */
        }
        form {
            max-width: 400px;
            margin: auto;
            background-color: #f2f2f2;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, 0.1);
        }
        input[type=text], input[type=password], input[type=email], input[type=number], input[type=date] {
            width: 100%;
            padding: 10px;
            margin: 5px 0 20px 0;
            display: inline-block;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }
        button {
            background-color: #4a90e2; /* Blue color for button */
            color: white;
            padding: 10px 20px;
            margin: 10px 0;
            border: none;
            cursor: pointer;
            width: 100%;
            border-radius: 5px;
        }
        button:hover {
            background-color: #357abd; /* Darker shade of blue on hover */
        }
        .login-link {
            display: block;
            margin-top: 20px;
            text-decoration: none;
            color: #4a90e2; /* Blue color for links */
        }
        .login-link:hover {
            color:black;
        }
        .change-password-link {
            display: block;
            margin-top: 20px;
            text-align: center;
            color: #4a90e2; /* Blue color for links */
            text-decoration: none;
        }
        .change-password-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<h2>Customer Registration</h2>

<form action="customerRegistration" method="post">
    <div class="container">
        <label for="fullName"><b>Full Name</b></label>
        <input type="text" placeholder="Enter Full Name" name="fullName" required>

        <label for="address"><b>Address</b></label>
        <input type="text" placeholder="Enter Address" name="address" required>

        <label for="mobileNo"><b>Mobile No</b></label>
        <input type="text" placeholder="Enter Mobile No" name="mobileNo" required>

        <label for="email"><b>Email</b></label>
        <input type="email" placeholder="Enter Email" name="email" required>

        <label for="accountType"><b>Account Type</b></label>
        <select name="accountType" required>
            <option value="Saving">Saving Account</option>
            <option value="Current">Current Account</option>
        </select>

        <label for="initialBalance"><b>Initial Balance (min 1000)</b></label>
        <input type="number" placeholder="Enter Initial Balance" name="initialBalance" min="1000" required>

        <label for="dob"><b>Date of Birth</b></label>
        <input type="date" name="dob" required>

        <label for="idProof"><b>ID Proof</b></label>
        <input type="text" placeholder="Enter ID Proof" name="idProof" required>

        <button type="submit">Register</button>
    </div>
</form>
<a class="login-link" href="customer_login.jsp">Back to Login</a>

</body>
</html>
