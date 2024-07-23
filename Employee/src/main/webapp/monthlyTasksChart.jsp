<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.Employee.model.Task" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Monthly Tasks Chart</title>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
        google.charts.load('current', {packages: ['corechart', 'bar']});
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {
            var data = google.visualization.arrayToDataTable([
                ['Month', 'Hours'],
                <% 
                    List<List<Task>> monthlyTasks = (List<List<Task>>) request.getAttribute("monthlyTasks");
                    if (monthlyTasks != null) {
                        double[] monthlyHours = new double[12]; // Assuming 12 months
                        for (int month = 0; month < monthlyTasks.size(); month++) {
                            List<Task> tasks = monthlyTasks.get(month);
                            for (Task task : tasks) {
                                monthlyHours[month] += task.getNumHours();
                            }
                        }
                        for (int i = 0; i < 12; i++) {
                            out.print("['Month " + (i + 1) + "', " + monthlyHours[i] + "],");
                        }
                    }
                %>
            ]);

            var options = {
                title: 'Monthly Tasks for the Year',
                chartArea: {width: '50%'},
                hAxis: {
                    title: 'Total Hours',
                    minValue: 0
                },
                vAxis: {
                    title: 'Month'
                }
            };

            var chart = new google.visualization.BarChart(document.getElementById('chart_div'));
            chart.draw(data, options);
        }
    </script>
</head>
<body>
    <h1>Monthly Tasks Chart</h1>
    <form action="MonthlyTasksChartServlet" method="get">
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
