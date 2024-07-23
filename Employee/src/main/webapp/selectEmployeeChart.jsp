<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Select Employee Chart</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #333;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        label {
            margin-bottom: 5px;
        }
        input[type="text"], input[type="date"], select {
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 3px;
        }
        .btn {
            padding: 10px 20px;
            border-radius: 3px;
            color: white;
            background-color: #007bff;
            text-decoration: none;
            cursor: pointer;
            transition: background-color 0.3s;
            border: none;
        }
        .btn:hover {
            background-color: #0056b3;
        }
        .hidden {
            display: none;
        }
    </style>
    <script>
        function showInputFields() {
            var type = document.getElementById("type").value;
            document.getElementById("dailyInputs").classList.add("hidden");
            document.getElementById("weeklyInputs").classList.add("hidden");
            document.getElementById("monthlyInputs").classList.add("hidden");
            
            document.getElementById("dailyDate").required = false;
            document.getElementById("weekMonth").required = false;
            document.getElementById("weekYear").required = false;
            document.getElementById("monthYear").required = false;
            
            if (type === "daily") {
                document.getElementById("dailyInputs").classList.remove("hidden");
                document.getElementById("dailyDate").required = true;
            } else if (type === "weekly") {
                document.getElementById("weeklyInputs").classList.remove("hidden");
                document.getElementById("weekMonth").required = true;
                document.getElementById("weekYear").required = true;
            } else if (type === "monthly") {
                document.getElementById("monthlyInputs").classList.remove("hidden");
                document.getElementById("monthYear").required = true;
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>Select Employee Chart</h1>
        <form action="GenerateEmployeeChartServlet" method="post">
            <label for="type">Select Chart Type:</label>
            <select id="type" name="type" onchange="showInputFields()" required>
                <option value="" disabled selected>Select a chart type</option>
                <option value="daily">Daily</option>
                <option value="weekly">Weekly</option>
                <option value="monthly">Monthly</option>
            </select>

            <div id="dailyInputs" class="hidden">
                <h2>Daily Chart (Pie Chart)</h2>
                <label for="dailyDate">Date:</label>
                <input type="date" id="dailyDate" name="dailyDate">
            </div>

            <div id="weeklyInputs" class="hidden">
                <h2>Weekly Chart (Bar Chart)</h2>
                <label for="weekMonth">Month:</label>
                <input type="text" id="weekMonth" name="weekMonth" placeholder="MM">
                
                <label for="weekYear">Year:</label>
                <input type="text" id="weekYear" name="weekYear" placeholder="YYYY">
            </div>

            <div id="monthlyInputs" class="hidden">
                <h2>Monthly Chart (Bar Chart)</h2>
                <label for="monthYear">Year:</label>
                <input type="text" id="monthYear" name="monthYear" placeholder="YYYY">
            </div>

            <input type="submit" value="Generate Chart" class="btn">
        </form>
    </div>
</body>
</html>
