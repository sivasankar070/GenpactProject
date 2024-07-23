package com.Employee.controller;

import java.io.IOException;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.Employee.dao.TaskDao;
import com.Employee.model.Task;
import com.Employee.model.User;

@WebServlet("/AddTaskServlet")
public class AddTaskServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve session user
        User sessionUser = (User) request.getSession().getAttribute("user");

        // Check if sessionUser is null
        if (sessionUser == null) {
            // Redirect to login page or handle unauthorized access
            response.sendRedirect("login.jsp");
            return;
        }

        // Retrieve form parameters
        String dateStr = request.getParameter("date");
        String startTimeStr = request.getParameter("startTime");
        String endTimeStr = request.getParameter("endTime");
        String category = request.getParameter("category");
        
        String project = request.getParameter("project");

        // Validate form data
        if (dateStr == null || startTimeStr == null || endTimeStr == null || category == null || project == null) {
            // Handle invalid or missing parameters
            response.sendRedirect("addTask.jsp");
            return;
        }

        // Parse date and times
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
        Date date;
        Time startTime;
        Time endTime;
        double numHours = 0.0;

        try {
            date = dateFormat.parse(dateStr); // Parse date string into Date object
            startTime = new Time(timeFormat.parse(startTimeStr).getTime()); // Parse start time string into Time object
            endTime = new Time(timeFormat.parse(endTimeStr).getTime()); // Parse end time string into Time object

            // Calculate num_hours
            long durationInMillis = endTime.getTime() - startTime.getTime();
            numHours = durationInMillis / (1000.0 * 60 * 60); // Convert milliseconds to hours

        } catch (ParseException e) {
            e.printStackTrace();
            response.sendRedirect("addTask.jsp"); // Redirect back to form on error
            return;
        }

        // Create Task object
        Task task = new Task();
        task.setEmpId(sessionUser.getEmpId());
        task.setUsername(sessionUser.getUsername());
        task.setDate(new java.sql.Date(date.getTime())); // Convert java.util.Date to java.sql.Date
        task.setStartTime(startTime);
        task.setEndTime(endTime);
        task.setNumHours(numHours);
        task.setCategory(category);
        task.setProject(project);

        // Insert task into database
        TaskDao taskDao = new TaskDao();
        boolean taskInserted = taskDao.insertTask(task);

        if (taskInserted) {
            // Redirect to employee dashboard upon successful insertion
            response.sendRedirect("employeeDashboard.jsp");
        } else {
            // Handle insertion failure (e.g., display error message or redirect)
        	String errorMessage = "Work hour exceeds more than 8.";
            request.setAttribute("errorMessage", errorMessage);
            request.getRequestDispatcher("addTask.jsp").forward(request, response);;
        }
    }
}
