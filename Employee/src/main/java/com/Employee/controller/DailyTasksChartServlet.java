package com.Employee.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.Employee.dao.TaskDao;
import com.Employee.model.Task;
import com.Employee.model.User;

@WebServlet("/DailyTasksChartServlet")
public class DailyTasksChartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve date parameter from the form
        String dateString = request.getParameter("date");
        Date date = Date.valueOf(dateString);

        // Get employee ID from session (assuming user is logged in)
        int empId = ((User) request.getSession().getAttribute("user")).getEmpId();

        // Retrieve tasks for the employee on the specified date
        TaskDao taskDao = new TaskDao();
        List<Task> tasks = taskDao.getAllTasksForEmployeeOnDate(empId, date);

        // Pass tasks and date back to JSP for display
        request.setAttribute("tasks", tasks);
        request.getRequestDispatcher("dailyTasksChart.jsp").forward(request, response);
    }
}
