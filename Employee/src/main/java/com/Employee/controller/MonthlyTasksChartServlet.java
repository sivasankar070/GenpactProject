package com.Employee.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.Employee.dao.TaskDao;
import com.Employee.model.Task;

@WebServlet("/MonthlyTasksChartServlet")
public class MonthlyTasksChartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String yearStr = request.getParameter("year");
        int year = Integer.parseInt(yearStr);

        TaskDao taskDao = new TaskDao();
        List<List<Task>> monthlyTasks = new ArrayList<>();

        for (int month = 1; month <= 12; month++) {
            Calendar calendar = Calendar.getInstance();
            calendar.set(year, month - 1, 1); // Set the calendar to the 1st day of the month
            Date startDate = new Date(calendar.getTimeInMillis());

            calendar.set(year, month - 1, calendar.getActualMaximum(Calendar.DAY_OF_MONTH)); // Set the calendar to the last day of the month
            Date endDate = new Date(calendar.getTimeInMillis());

            List<Task> tasks = taskDao.getTasksForMonth(year, month, startDate, endDate);
            monthlyTasks.add(tasks);
        }

        request.setAttribute("monthlyTasks", monthlyTasks);
        request.getRequestDispatcher("/monthlyTasksChart.jsp").forward(request, response);
    }
}
