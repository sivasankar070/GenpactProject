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
    <title>Delete Task</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 600px;
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
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #f0f0f0;
        }
        .btn-delete {
            padding: 8px 16px;
            background-color: #dc3545;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn-delete:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Delete Task</h1>
        
        <%-- Retrieve tasks for the logged-in employee --%>
        <% User user = (User) session.getAttribute("user");
           if (user != null) {
               TaskDao taskDao = new TaskDao();
               List<Task> tasks = taskDao.getAllTasksForEmployee(user.getEmpId());
               
               // Check if tasks exist
               if (!tasks.isEmpty()) { %>
                   <table>
                       <tr>
                           <th>Date</th>
                           <th>Start Time</th>
                           <th>End Time</th>
                           <th>Number of Hours</th>
                           <th>Category</th>
                           <th>Project</th>
                           <th>Action</th>
                       </tr>
                       
                       <% for (Task task : tasks) { %>
                           <tr>
                               <td><%= task.getDate() %></td>
                               <td><%= task.getStartTime() %></td>
                               <td><%= task.getEndTime() %></td>
                               <td><%= task.getNumHours() %></td>
                               <td><%= task.getCategory() %></td>
                               <td><%= task.getProject() %></td>
                               <td>
                                   <form action="DeleteTaskServlet" method="POST">
                                       <input type="hidden" name="taskId" value="<%= task.getId() %>">
                                       <button type="submit" class="btn-delete">Delete</button>
                                   </form>
                               </td>
                           </tr>
                       <% } %>
                   </table>
               <% } else { %>
                   <div>No tasks found for the logged-in user.</div>
               <% }
           } else { %>
               <div>User session not found.</div>
           <% } %>
        
    </div>
</body>
</html>
