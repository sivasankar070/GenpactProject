package com.Employee.controller;

import com.Employee.dao.TaskDao;
import com.Employee.model.Task;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.sql.Time;

@WebServlet("/AdminEditTaskServlet")
public class AdminEditTaskServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve form parameters
            int taskId = Integer.parseInt(request.getParameter("taskId"));
            String username = request.getParameter("username");
            int empId = Integer.parseInt(request.getParameter("empId"));
            Date date = Date.valueOf(request.getParameter("date"));
            Time startTime = Time.valueOf(request.getParameter("startTime"));
            Time endTime = Time.valueOf(request.getParameter("endTime"));
            double numHours = Double.parseDouble(request.getParameter("numHours"));
            String category = request.getParameter("category");
            String project = request.getParameter("project");

            // Create a Task object with updated values
            Task updatedTask = new Task();
            updatedTask.setId(taskId); // ID should remain the same
            updatedTask.setUsername(username); // Username should remain the same
            updatedTask.setEmpId(empId); // Employee ID should remain the same
            updatedTask.setDate(date);
            updatedTask.setStartTime(startTime);
            updatedTask.setEndTime(endTime);
            updatedTask.setNumHours(numHours);
            updatedTask.setCategory(category);
            updatedTask.setProject(project);

            // Use TaskDao to update the task in the database
            TaskDao taskDao = new TaskDao();

            // Validate total hours per day
            double existingHours = taskDao.getTotalHoursForDay(empId, date);
            Task existingTask = taskDao.getTaskById(taskId);
            double adjustedHours = existingHours - existingTask.getNumHours() + numHours;

            if (adjustedHours <= 8.0) {
                boolean result = taskDao.updateTask(updatedTask);

                // Check the result and redirect accordingly
                if (result) {
                    response.sendRedirect("adminDashboard.jsp?message=Task updated successfully");
                } else {
                    response.sendRedirect("adminDashboard.jsp?error=Failed to update task");
                }
            } else {
                response.sendRedirect("adminDashboard.jsp?error=Total hours exceed 8 per day");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminDashboard.jsp?error=An error occurred");
        }
    }
}
