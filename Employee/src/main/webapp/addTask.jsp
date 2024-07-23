<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Task</title>
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
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input[type="text"],
        .form-group input[type="date"],
        .form-group input[type="time"] {
            width: calc(100% - 12px);
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .form-group select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .form-group input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .form-group input[type="submit"]:hover {
            background-color: #0056b3;
        }
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border: 1px solid transparent;
            border-radius: 4px;
        }
        .alert-danger {
            color: #721c24;
            background-color: #f8d7da;
            border-color: #f5c6cb;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Add Task</h1>
        
        <% 
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null && !errorMessage.isEmpty()) {
        %>
        <div class="alert alert-danger" role="alert">
            <%= errorMessage %>
        </div>
        <% } %>
        
        <form action="AddTaskServlet" method="post">
            <div class="form-group">
                <label for="date">Date (YYYY-MM-DD)</label>
                <input type="date" id="date" name="date" pattern="\d{4}-\d{2}-\d{2}" required>
            </div>
            <div class="form-group">
                <label for="startTime">Start Time (HH:MM:SS)</label>
                <input type="time" step="1" id="startTime" name="startTime" required>
            </div>
            <div class="form-group">
                <label for="endTime">End Time (HH:MM:SS)</label>
                <input type="time" step="1" id="endTime" name="endTime" required>
            </div>
            <!-- Display Num Hours (Read-only) -->
            <div class="form-group">
                <label for="numHours">Duration (Hours)</label>
                <input type="text" id="numHours" name="numHours" readonly>
            </div>
            <div class="form-group">
                <label for="category">Category</label>
                <input type="text" id="category" name="category" required>
            </div>
            <div class="form-group">
                <label for="project">Project</label>
                <input type="text" id="project" name="project" required>
            </div>
            <input type="submit" value="Add Task">
        </form>
    </div>

    <!-- Script to calculate and display num_hours -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const startTimeInput = document.getElementById('startTime');
            const endTimeInput = document.getElementById('endTime');
            const numHoursInput = document.getElementById('numHours');

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
    </script>
</body>
</html>
