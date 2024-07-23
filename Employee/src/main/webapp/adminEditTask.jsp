<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.Employee.dao.TaskDao" %>
<%@ page import="com.Employee.model.Task" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Task</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }
        .card {
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        .card h2 {
            margin-top: 0;
        }
        label {
            display: block;
            margin-bottom: 10px;
        }
        input[type="text"],
        input[type="date"],
        input[type="time"],
        input[type="number"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        input[type="submit"] {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
    <script>
        function calculateNumHours() {
            var startTime = document.getElementById("startTime").value;
            var endTime = document.getElementById("endTime").value;
            if (startTime && endTime) {
                var start = new Date("1970-01-01T" + startTime + "Z");
                var end = new Date("1970-01-01T" + endTime + "Z");
                var diff = (end - start) / (1000 * 60 * 60); // Difference in hours
                if (diff < 0) diff += 24; // Handle case where endTime is after midnight
                document.getElementById("numHours").value = diff.toFixed(1);
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="card">
            <h2>Edit Task</h2>
            <form action="AdminEditTaskServlet" method="post">
                <% 
                    String taskIdParam = request.getParameter("taskId");
                    int taskId = Integer.parseInt(taskIdParam); // Convert String to int
                    TaskDao taskDao = new TaskDao();
                    Task task = taskDao.getTaskById(taskId);
                %>
                <input type="hidden" name="taskId" value="<%= task.getId() %>">
                
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" value="<%= task.getUsername() %>" readonly>

                <label for="empId">Employee ID:</label>
                <input type="text" id="empId" name="empId" value="<%= task.getEmpId() %>" readonly>

                <label for="date">Date:</label>
                <input type="date" id="date" name="date" value="<%= task.getDate() %>" required>

                <label for="startTime">Start Time:</label>
                <input type="time" id="startTime" name="startTime" value="<%= task.getStartTime() %>" step="1" required onchange="calculateNumHours()">

                <label for="endTime">End Time:</label>
                <input type="time" id="endTime" name="endTime" value="<%= task.getEndTime() %>" step="1" required onchange="calculateNumHours()">

                <label for="numHours">Number of Hours:</label>
                <input type="number" id="numHours" name="numHours" value="<%= task.getNumHours() %>" step="0.1" required readonly>

                <label for="category">Category:</label>
                <input type="text" id="category" name="category" value="<%= task.getCategory() %>" required>

                <label for="project">Project:</label>
                <input type="text" id="project" name="project" value="<%= task.getProject() %>" required>

                <input type="submit" value="Update Task">
            </form>
        </div>
    </div>
</body>
</html>
