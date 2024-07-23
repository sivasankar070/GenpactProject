package com.Employee.controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.Employee.dao.TaskDao;
import com.Employee.model.Task;
import com.Employee.model.User;

@WebServlet("/EditTaskServlet")
public class EditTaskServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form parameters
        int taskId = Integer.parseInt(request.getParameter("taskId"));
        Date date = Date.valueOf(request.getParameter("date"));
        Time startTime = Time.valueOf(request.getParameter("startTime"));
        Time endTime = Time.valueOf(request.getParameter("endTime"));
        double numHours = Double.parseDouble(request.getParameter("numHours"));
        String category = request.getParameter("category");
        String project = request.getParameter("project");
        
        // Validate total hours for the day
        if (!validateTotalHoursPerDay(((User) request.getSession().getAttribute("user")).getUsername(), date, numHours, taskId)) {
            request.setAttribute("errorMessage", "Total hours limit exceeded for this date.");
            request.getRequestDispatcher("editTask.jsp").forward(request, response);
            return;
        }

        // Create Task object
        User user = (User) request.getSession().getAttribute("user");
        Task task = new Task(taskId, user.getEmpId(), user.getUsername(), date, startTime, endTime, numHours, category, project);

        // Update task in the database
        TaskDao taskDao = new TaskDao();
        boolean updated = taskDao.updateTask(task);

        if (updated) {
            response.sendRedirect("employeeDashboard.jsp");
        } else {
            request.setAttribute("errorMessage", "Failed to update task. Please try again.");
            request.getRequestDispatcher("editTask.jsp").forward(request, response);
        }
    }

    // Method to validate total hours for the day
    private boolean validateTotalHoursPerDay(String username, Date date, double newHours, int taskId) {
        TaskDao taskDao = new TaskDao();
        Task currentTask = taskDao.getTaskById(taskId);
        
        double currentHours = currentTask.getNumHours();
        double totalHours = taskDao.getTotalHoursForDay(username, date);
        
        // Subtract current task hours from total
        totalHours -= currentHours;
        
        // Add new hours to calculate updated total
        totalHours += newHours;
        
        return totalHours <= 8.0; // Return true if total hours are within limit
    }
}
