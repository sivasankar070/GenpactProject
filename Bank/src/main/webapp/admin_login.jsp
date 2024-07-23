<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Login</title>
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

        form {
            max-width: 400px;
            width: 100%;
            background-color: var(--container-bg-color);
            padding: 40px;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
        }

        input[type=text], input[type=password] {
            width: 100%;
            padding: 12px;
            margin: 10px 0 20px 0;
            border: 1px solid var(--input-border-color);
            border-radius: var(--border-radius);
            box-sizing: border-box;
        }

        button {
            background-color: var(--button-bg-color);
            color: white;
            padding: 14px 20px;
            margin: 20px 0;
            border: none;
            border-radius: var(--border-radius);
            cursor: pointer;
            width: 100%;
            font-size: var(--font-size);
            transition: background-color var(--transition-duration) ease;
        }

        button:hover {
            background-color: var(--button-hover-bg-color);
        }

        .login-link {
            display: block;
            margin-top: 20px;
            text-decoration: none;
            color: var(--primary-color);
            transition: color var(--transition-duration) ease;
        }

        .login-link:hover {
            color: var(--primary-hover-color);
        }
        .message {
            margin-top: 20px;
            color: #d9534f; /* Red error message color */
            text-align: center;
        }
    </style>
</head>
<body>

    <h2>Admin Login</h2>

    <form action="adminLogin" method="post">
        <label for="username"><b>Username</b></label>
        <input type="text" placeholder="Enter Username" name="username" required>

        <label for="password"><b>Password</b></label>
        <input type="password" placeholder="Enter Password" name="password" required>

        <button type="submit">Login</button>
    <div class="message">
            <%= request.getAttribute("message") != null ? request.getAttribute("message") : "" %>
    </div>
    <a class="login-link" href="index.jsp">Back to Choose</a>
	    </form>
</body>
</html>
