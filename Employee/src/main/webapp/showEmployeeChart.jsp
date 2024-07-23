<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.Employee.model.Task" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Employee Tasks Chart</title>
    <!-- Load Google Charts API -->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
        google.charts.load('current', {'packages':['corechart']});
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {
            var chartData = [];
            var chartOptions = { title: '', is3D: true };
            var chart;

            <% 
                String chartType = (String) request.getAttribute("type");
                if ("daily".equals(chartType)) {
                    %>
                    chartData.push(['Employee', 'Hours']);
                    <% 
                        List<Task> tasks = (List<Task>) request.getAttribute("tasks");
                        if (tasks != null && !tasks.isEmpty()) {
                            Map<String, Double> employeeHours = new HashMap<>();
                            for (Task task : tasks) {
                                String employee = task.getUsername();
                                Double hours = task.getNumHours();
                                employeeHours.put(employee, employeeHours.getOrDefault(employee, 0.0) + hours);
                            }
                            for (Map.Entry<String, Double> entry : employeeHours.entrySet()) {
                                %>
                                chartData.push(['<%= entry.getKey() %>', <%= entry.getValue() %>]);
                                <% 
                            }
                        } else {
                            %>
                            chartData.push(['No Data', 0]);
                            <% 
                        }
                        %>
                        chartOptions.title = 'Daily Employee Tasks Distribution';
                        chart = new google.visualization.PieChart(document.getElementById('chart_div'));
                        <% 
                } else if ("weekly".equals(chartType)) {
                    %>
                    chartData.push(['Week', 'Hours']);
                    <% 
                        Map<Integer, Map<String, Double>> weeklyEmployeeHours = (Map<Integer, Map<String, Double>>) request.getAttribute("weeklyEmployeeHours");
                        if (weeklyEmployeeHours != null && !weeklyEmployeeHours.isEmpty()) {
                            for (Map.Entry<Integer, Map<String, Double>> weekEntry : weeklyEmployeeHours.entrySet()) {
                                int week = weekEntry.getKey();
                                for (Map.Entry<String, Double> employeeEntry : weekEntry.getValue().entrySet()) {
                                    %>
                                    chartData.push(['Week <%= week %> - <%= employeeEntry.getKey() %>', <%= employeeEntry.getValue() %>]);
                                    <% 
                                }
                            }
                        } else {
                            %>
                            chartData.push(['No Data', 0]);
                            <% 
                        }
                        %>
                        chartOptions.title = 'Weekly Employee Hours';
                        chart = new google.visualization.BarChart(document.getElementById('chart_div'));
                        <% 
                } else if ("monthly".equals(chartType)) {
                    %>
                    chartData.push(['Month', 'Hours']);
                    <% 
                        Map<Integer, Map<String, Double>> monthlyEmployeeHours = (Map<Integer, Map<String, Double>>) request.getAttribute("monthlyEmployeeHours");
                        if (monthlyEmployeeHours != null && !monthlyEmployeeHours.isEmpty()) {
                            for (Map.Entry<Integer, Map<String, Double>> monthEntry : monthlyEmployeeHours.entrySet()) {
                                int month = monthEntry.getKey();
                                for (Map.Entry<String, Double> employeeEntry : monthEntry.getValue().entrySet()) {
                                    %>
                                    chartData.push(['Month <%= month %> - <%= employeeEntry.getKey() %>', <%= employeeEntry.getValue() %>]);
                                    <% 
                                }
                            }
                        } else {
                            %>
                            chartData.push(['No Data', 0]);
                            <% 
                        }
                        %>
                        chartOptions.title = 'Monthly Employee Hours';
                        chart = new google.visualization.BarChart(document.getElementById('chart_div'));
                        <% 
                }
            %>

            var data = google.visualization.arrayToDataTable(chartData);
            chart.draw(data, chartOptions);
        }
    </script>
</head>
<body>
    <h1>Employee Tasks Chart</h1>
    <div id="chart_div" style="width: 900px; height: 500px;"></div>
</body>
</html>
