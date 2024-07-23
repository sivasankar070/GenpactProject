package com.Employee.controller;

import com.Employee.dao.TaskDao;
import com.Employee.model.Task;
import com.Employee.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/WeeklyTasksChartServlet")
public class WeeklyTasksChartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int empId = user.getEmpId();
        int year = Integer.parseInt(request.getParameter("year"));

        TaskDao taskDao = new TaskDao();
        List<Task> tasks = taskDao.getAllTasksForEmployeeByYear(empId, year);

        if (tasks == null || tasks.isEmpty()) {
            request.setAttribute("message", "No tasks found for the selected year.");
        } else {
            request.setAttribute("tasks", tasks);
        }

        request.getRequestDispatcher("weeklyTasksChart.jsp").forward(request, response);
    }
}
