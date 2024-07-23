<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.Employee.model.User" %>
<%@ page import="com.Employee.dao.UserDao" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Employee</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f7f7f7;
        }
        h1 {
            color: #333;
        }
        h2 {
            margin-top: 30px;
            color: #666;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        table, th, td {
            border: 1px solid #ccc;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
            color: #333;
        }
        td form {
            display: inline-block;
            margin-right: 10px;
        }
        td form input[type="submit"] {
            padding: 5px 10px;
            background-color: #f44336;
            color: white;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        td form input[type="submit"]:hover {
            background-color: #e57373;
        }
        .no-employees {
            font-style: italic;
            color: #999;
        }
    </style>
</head>
<body>
    <h1>Delete Employee</h1>

    <!-- View existing employees -->
    <h2>Existing Employees:</h2>
    <table>
        <thead>
            <tr>
                <th>Employee ID</th>
                <th>Username</th>
                <th>Role</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% 
                UserDao userDao = new UserDao();
                List<User> employees = userDao.getAllEmployees();
                if (employees != null && !employees.isEmpty()) {
                    for (User employee : employees) {
            %>
            <tr>
                <td><%= employee.getEmpId() %></td>
                <td><%= employee.getUsername() %></td>
                <td><%= employee.getRole() %></td>
                <td>
                    <!-- Form to delete employee -->
                    <form action="DeleteEmployeeServlet" method="post">
                        <input type="hidden" name="empId" value="<%= employee.getEmpId() %>">
                        <input type="submit" value="Delete">
                    </form>
                </td>
            </tr>
            <% 
                    }
                } else {
            %>
            <tr>
                <td colspan="4" class="no-employees">No employees found.</td>
            </tr>
            <% } %>
        </tbody>
    </table>
</body>
</html>
