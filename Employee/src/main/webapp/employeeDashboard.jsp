<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.Employee.model.Task" %>
<%@ page import="com.Employee.model.User" %>
<%@ page import="com.Employee.dao.TaskDao" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Employee Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
        }
        .links {
            text-align: center;
            margin-bottom: 20px;
        }
        .links a {
            text-decoration: none;
            padding: 10px 20px;
            margin: 0 10px;
            background-color: #007bff;
            color: #fff;
            border-radius: 4px;
        }
        .links a:hover {
            background-color: #0056b3;
        }
        .task-list {
            margin-top: 20px;
            width: 100%;
            border-collapse: collapse;
        }
        .task-list th, .task-list td {
            padding: 10px;
            border: 1px solid #ccc;
            text-align: left;
        }
        .task-list th {
            background-color: #007bff;
            color: #fff;
        }
        .task-list td {
            background-color: #f9f9f9;
        }
        .chart {
            margin-top: 20px;
            text-align: center;
        }
        .chart img {
            max-width: 100%;
            height: auto;
            display: block;
            margin: 0 auto;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Welcome <%= ((User) session.getAttribute("user")).getUsername() %></h1>

        <!-- Links to Add, Edit, Delete tasks -->
        <div class="links">
            <a href="addTask.jsp">Add Task</a>
            <a href="editTask.jsp">Edit Task</a>
            <a href="deleteTask.jsp">Delete Task</a>
        </div>

        <!-- Display Existing Tasks as Table -->
        <div class="task-list">
            <h2>Existing Tasks</h2>
            <table>
                <thead>
                    <tr>
                        <th>Task ID</th> <!-- New column for Task ID -->
                        <th>Date</th>
                        <th>Start Time</th>
                        <th>End Time</th>
                        <th>Hours</th>
                        <th>Category</th>
                        <th>Project</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        TaskDao taskDao = new TaskDao();
                        List<Task> tasks = taskDao.getAllTasksForEmployee(((User) session.getAttribute("user")).getEmpId());
                        for (Task task : tasks) {
                    %>
                    <tr>
                        <td><%= task.getId() %></td> <!-- Display Task ID -->
                        <td><%= task.getDate() %></td>
                        <td><%= task.getStartTime() %></td>
                        <td><%= task.getEndTime() %></td>
                        <td><%= task.getNumHours() %></td>
                        <td><%= task.getCategory() %></td>
                        <td><%= task.getProject() %></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <!-- Display Charts -->
        <div class="chart">
            <h2>Daily Tasks/Hours (Pie Chart)</h2>
            <a href="dailyTasksChart.jsp" >Daily Task</a>

            <h2>Weekly Tasks (Bar Chart)</h2>
            <a href="weeklyTasksChart.jsp" >Weekly Task</a>

            <h2>Monthly Tasks (Bar Chart)</h2>
            <a href="monthlyTasksChart.jsp" >Monthly Task</a>
        </div>
    </div>
</body>
</html>