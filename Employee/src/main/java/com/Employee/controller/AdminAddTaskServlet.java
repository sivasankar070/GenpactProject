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
import java.text.ParseException;
import java.text.SimpleDateFormat;

@WebServlet("/AdminAddTaskServlet")
public class AdminAddTaskServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String dateStr = request.getParameter("date");
        String startTimeStr = request.getParameter("startTime");
        String endTimeStr = request.getParameter("endTime");
        String category = request.getParameter("category");
        String project = request.getParameter("project");

        System.out.println("Received data - Username: " + username + ", Date: " + dateStr + ", Start Time: " + startTimeStr + ", End Time: " + endTimeStr + ", Category: " + category + ", Project: " + project);

        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
            Date date = new Date(sdf.parse(dateStr).getTime());
            Time startTime = new Time(timeFormat.parse(startTimeStr).getTime());
            Time endTime = new Time(timeFormat.parse(endTimeStr).getTime());

            // Calculate number of hours
            double numHours = calculateHours(startTime, endTime);
            System.out.println("Calculated hours: " + numHours);

            // Check if total hours for the day will exceed 8
            TaskDao taskDao = new TaskDao();
            double totalHoursForDay = taskDao.getTotalHoursForDay(username, date);
            System.out.println("Total hours for day: " + totalHoursForDay);

            if (totalHoursForDay + numHours > 8) {
                request.setAttribute("errorMessage", "Total hours for the day cannot exceed 8 hours.");
                request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
                return;
            }

            // Retrieve emp_id
            int empId = taskDao.getEmpIdByUsername(username);
            if (empId == -1) {
                request.setAttribute("errorMessage", "Employee ID not found for username: " + username);
                request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
                return;
            }

            // Create and insert task
            Task task = new Task();
            task.setEmpId(empId);
            task.setUsername(username);
            task.setDate(date);
            task.setStartTime(startTime);
            task.setEndTime(endTime);
            task.setNumHours(numHours);
            task.setCategory(category);
            task.setProject(project);

            boolean isInserted = taskDao.insertTask(task);
            System.out.println("Task insertion status: " + isInserted);

            if (isInserted) {
                response.sendRedirect("adminDashboard.jsp");
            } else {
                request.setAttribute("errorMessage", "Failed to add the task.");
                request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
            }
        } catch (ParseException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Invalid date or time format.");
            request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
        }
    }

    // Calculate the number of hours between two Time objects
    private double calculateHours(Time startTime, Time endTime) {
        long differenceInMillis = endTime.getTime() - startTime.getTime();
        return differenceInMillis / (1000.0 * 60 * 60);
    }
}
