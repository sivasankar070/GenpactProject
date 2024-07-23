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
    <title>Edit Task</title>
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
        input[type="text"], input[type="date"], input[type="time"], input[type="number"], select {
            width: 100%;
            padding: 8px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        button {
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
        .alert {
            padding: 10px;
            background-color: #f44336;
            color: white;
            margin-bottom: 15px;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Edit Task</h1>
        
        <%-- Retrieve tasks for the logged-in employee --%>
        <% User user = (User) session.getAttribute("user");
           if (user != null) {
               TaskDao taskDao = new TaskDao();
               List<Task> tasks = taskDao.getAllTasksForEmployee(user.getEmpId());
               
               // Check if tasks exist
               if (!tasks.isEmpty()) {
                   // Display tasks in a form for updating
                   for (Task task : tasks) { %>
                       
                       <form action="EditTaskServlet" method="POST">
                           <input type="hidden" name="taskId" value="<%= task.getId() %>">
                           
                           <div class="form-group">
                               <label>Date</label>
                               <input type="date" name="date" value="<%= task.getDate() %>" required>
                           </div>
                           
                           <div class="form-group">
                               <label>Start Time</label>
                               <input type="time" step="1" name="startTime" id="startTime_<%= task.getId() %>" value="<%= task.getStartTime() %>" required>
                           </div>
                           
                           <div class="form-group">
                               <label>End Time</label>
                               <input type="time" step="1" name="endTime" id="endTime_<%= task.getId() %>" value="<%= task.getEndTime() %>" required>
                           </div>
                           
                           <div class="form-group">
                               <label>Number of Hours</label>
                               <input type="number" step="0.5" name="numHours" id="numHours_<%= task.getId() %>" value="<%= task.getNumHours() %>" required readonly>
                           </div>
                           
                           <div class="form-group">
                               <label>Category</label>
                               <input type="text" name="category" value="<%= task.getCategory() %>" required>
                           </div>
                           
                           <div class="form-group">
                               <label>Project</label>
                               <input type="text" name="project" value="<%= task.getProject() %>" required>
                           </div>
                           
                           <%-- Display error message if set --%>
                           <% String errorMessage = (String) request.getAttribute("errorMessage");
                              if (errorMessage != null && !errorMessage.isEmpty()) { %>
                               <div class="alert">
                                   <%= errorMessage %>
                               </div>
                           <% } %>
                           
                           <button type="submit">Update Task</button>
                       </form>
                       
                   <% }
               } else { %>
                   <div class="alert">
                       No tasks found for the logged-in user.
                   </div>
               <% }
           } else { %>
               <div class="alert">
                   User session not found.
               </div>
           <% } %>
        
    </div>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Retrieve all task elements
            const tasks = document.querySelectorAll('form[action="EditTaskServlet"]');

            // Add event listeners to calculate hours for each task form
            tasks.forEach(function(taskForm) {
                const startTimeInput = taskForm.querySelector('input[name="startTime"]');
                const endTimeInput = taskForm.querySelector('input[name="endTime"]');
                const numHoursInput = taskForm.querySelector('input[name="numHours"]');

                startTimeInput.addEventListener('change', calculateNumHours);
                endTimeInput.addEventListener('change', calculateNumHours);

                function calculateNumHours() {
                    const startTime = startTimeInput.value;
                    const endTime = endTimeInput.value;

                    if (startTime && endTime) {
                        const startParts = startTime.split(':');
                        const endParts = endTime.split(':');

                        const startHour = parseInt(startParts[0], 10);
                        const startMinute = parseInt(startParts[1], 10);
                        const startSecond = parseInt(startParts[2], 10);

                        const endHour = parseInt(endParts[0], 10);
                        const endMinute = parseInt(endParts[1], 10);
                        const endSecond = parseInt(endParts[2], 10);

                        const startDate = new Date(0, 0, 0, startHour, startMinute, startSecond);
                        const endDate = new Date(0, 0, 0, endHour, endMinute, endSecond);

                        let diff = (endDate.getTime() - startDate.getTime()) / 1000 / 60 / 60;
                        if (diff < 0) {
                            diff += 24;
                        }

                        numHoursInput.value = diff.toFixed(2);
                    } else {
                        numHoursInput.value = '';
                    }
                }
            });
        });
    </script>
    
</body>
</html>
