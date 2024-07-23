<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.Employee.model.Task" %>
<%@ page import="com.Employee.model.User" %>
<%@ page import="com.Employee.dao.TaskDao" %>
<%@ page import="java.sql.Date" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Daily Tasks Chart</title>
    <!-- Load Google Charts API -->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
        google.charts.load('current', {'packages':['corechart']});
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {
            // Fetch data from the servlet
            var tasksData = [
                ['Category', 'Hours']
                <% 
                    if (request.getAttribute("tasks") != null) {
                        List<Task> tasks = (List<Task>) request.getAttribute("tasks");
                        for (Task task : tasks) {
                %>
                ,['<%= task.getCategory() %>', <%= task.getNumHours() %>]
                <%       }
                    }
                %>
            ];

            var data = google.visualization.arrayToDataTable(tasksData);

            var options = {
                title: 'Daily Tasks Distribution',
                is3D: true,
            };

            var chart = new google.visualization.PieChart(document.getElementById('piechart'));

            chart.draw(data, options);
        }
    </script>
</head>
<body>
    <h1>Daily Tasks Chart</h1>
    <form method="get" action="DailyTasksChartServlet">
        <label for="date">Select Date:</label>
        <input type="date" id="date" name="date" required>
        <input type="submit" value="Generate Chart">
    </form>

    <div id="piechart" style="width: 900px; height: 500px;"></div>
    
    <% 
        if (request.getAttribute("tasks") != null) {
            List<Task> tasks = (List<Task>) request.getAttribute("tasks");
    %>
    <h2>Tasks for <%= request.getParameter("date") %></h2>
    <ul>
        <% if (tasks.isEmpty()) { %>
            <li>No tasks found for <%= request.getParameter("date") %>.</li>
        <% } else { %>
            <% for (Task task : tasks) { %>
                <li><%= task.getId() %> - <%= task.getCategory() %> - <%= task.getNumHours() %> hours</li>
            <% } %>
        <% } %>
    </ul>
    <% } %>
</body>
</html>
