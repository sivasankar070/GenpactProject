package com.Employee.controller;

import com.Employee.dao.TaskDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/AdminDeleteTaskServlet")
public class AdminDeleteTaskServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String taskIdParam = request.getParameter("taskId");
        int taskId = Integer.parseInt(taskIdParam);

        TaskDao taskDao = new TaskDao();
        boolean isDeleted = taskDao.deleteTask(taskId);

        if (isDeleted) {
            response.sendRedirect("adminDashboard.jsp?message=Task+Deleted+Successfully");
        } else {
            response.sendRedirect("adminDashboard.jsp?error=Failed+to+Delete+Task");
        }
    }
}
