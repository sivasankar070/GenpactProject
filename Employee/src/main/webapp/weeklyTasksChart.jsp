<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.Employee.model.Task" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Weekly Tasks Chart</title>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
        google.charts.load('current', {packages: ['corechart', 'bar']});
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {
            var data = google.visualization.arrayToDataTable([
                ['Week', 'Hours'],
                <% 
                    List<Task> tasks = (List<Task>) request.getAttribute("tasks");
                    if (tasks != null) {
                        double[] weeklyHours = new double[52];
                        for (Task task : tasks) {
                            int week = task.getWeekNumber() - 1; // Adjust week number to zero-based index
                            weeklyHours[week] += task.getNumHours();
                        }
                        for (int i = 0; i < 52; i++) {
                            out.print("['Week " + (i + 1) + "', " + weeklyHours[i] + "],");
                        }
                    }
                %>
            ]);

            var options = {
                title: 'Weekly Tasks for the Year',
                chartArea: {width: '50%'},
                hAxis: {
                    title: 'Total Hours',
                    minValue: 0
                },
                vAxis: {
                    title: 'Week'
                }
            };

            var chart = new google.visualization.BarChart(document.getElementById('chart_div'));
            chart.draw(data, options);
        }
    </script>
</head>
<body>
    <h1>Weekly Tasks Chart</h1>
    <form action="WeeklyTasksChartServlet" method="get">
        <label for="year">Select Year:</label>
        <input type="number" id="year" name="year" min="2000" max="2100" required>
        <button type="submit">Show Chart</button>
    </form>
    <div id="chart_div" style="width: 100%; height: 500px;"></div>
    <% 
        String message = (String) request.getAttribute("message");
        if (message != null) {
            out.println("<p>" + message + "</p>");
        }
    %>
</body>
</html>
