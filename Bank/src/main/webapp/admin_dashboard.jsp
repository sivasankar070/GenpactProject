<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
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
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            text-align: center;
        }

        h2 {
            color: var(--primary-color);
            font-size: 1.8em;
            margin-bottom: 20px;
        }
        .container {
            min-width: 400px;
            margin: var(--margin) auto;
            background-color: var(--container-bg-color);
            padding: var(--padding);
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
        }

        form {
            text-align: center;
            margin-bottom: 10px;
        }

        form input[type="submit"] {
            background-color: var(--button-bg-color);
            color: white;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            border-radius: var(--border-radius);
            font-size: var(--font-size);
            transition: background-color var(--transition-duration);
            min-width: 300px;
        }

        form input[type="submit"]:hover {
            background-color: var(--button-hover-bg-color);
        }
    </style>
</head>
<body>
<h2>Admin Dashboard</h2>
    <div class="container">
        
        <form action="registerCustomer.jsp">
            <input type="submit" value="Register Customer">
        </form>
        <form action="view_customers.jsp">
            <input type="submit" value="View Customers">
        </form>
        <form action="delete_customers.jsp">
            <input type="submit" value="Delete Customers">
        </form>
        <form action="modify_customers.jsp">
            <input type="submit" value="Modify Customers">
        </form>
        <form action="admin_login.jsp">
            <input type="submit" value="Logout">
        </form>
    </div>
</body>
</html>
