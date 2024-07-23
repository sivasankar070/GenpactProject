package com.Employee.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.Employee.dao.TaskDao;

@WebServlet("/DeleteTaskServlet")
public class DeleteTaskServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve taskId parameter from the request
        int taskId = Integer.parseInt(request.getParameter("taskId"));
        
        // Instantiate TaskDao
        TaskDao taskDao = new TaskDao();
        
        // Delete task based on taskId
        boolean deleted = taskDao.deleteTask(taskId);
        
        if (deleted) {
            // Task deleted successfully
            response.sendRedirect("deleteTask.jsp"); // Redirect back to deleteTask.jsp
        } else {
            // Error handling, if any
            response.getWriter().println("Failed to delete task.");
        }
    }
}
