package com.Employee.controller;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.Employee.dao.TaskDao;
import com.Employee.model.Task;

@WebServlet("/GenerateEmployeeChartServlet")
public class GenerateEmployeeChartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String type = request.getParameter("type");
        TaskDao taskDao = new TaskDao();
        List<Task> taskList = null;
        Map<Integer, Map<String, Double>> weeklyEmployeeHoursMap = null;
        Map<Integer, Map<String, Double>> monthlyEmployeeHoursMap = null;

        try {
            if ("daily".equals(type)) {
                LocalDate date = LocalDate.parse(request.getParameter("dailyDate"));
                taskList = taskDao.getTasksByDate(Date.valueOf(date));
                request.setAttribute("tasks", taskList);

            } else if ("weekly".equals(type)) {
                int month = Integer.parseInt(request.getParameter("weekMonth"));
                int year = Integer.parseInt(request.getParameter("weekYear"));
                weeklyEmployeeHoursMap = taskDao.getEmployeeHoursForWeeksInMonth(year, month);
                request.setAttribute("weeklyEmployeeHours", weeklyEmployeeHoursMap);

            } else if ("monthly".equals(type)) {
                int year = Integer.parseInt(request.getParameter("monthYear"));
                monthlyEmployeeHoursMap = taskDao.getEmployeeHoursForMonthsInYear(year);
                request.setAttribute("monthlyEmployeeHours", monthlyEmployeeHoursMap);
            }

            // Set the chart type for conditional rendering in JSP
            request.setAttribute("type", type);
            request.getRequestDispatcher("showEmployeeChart.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error generating chart: " + e.getMessage());
        }
    }
}
