package com.Employee.controller;

import com.Employee.dao.TaskDao;
import com.Employee.dao.UserDao;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/DeleteEmployeeServlet")
public class DeleteEmployeeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int empId = Integer.parseInt(request.getParameter("empId"));
        
        // First, delete all tasks for this employee
        TaskDao taskDao = new TaskDao();
        taskDao.deleteTasksByEmpId(empId);

        // Then, delete the employee
        UserDao userDao = new UserDao();
        boolean isDeleted = userDao.deleteEmployee(empId);

        if (isDeleted) {
            response.sendRedirect("adminDashboard.jsp");
        } else {
            request.setAttribute("errorMessage", "Failed to delete the employee.");
            request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
        }
    }
}
