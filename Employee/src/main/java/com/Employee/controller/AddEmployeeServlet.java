package com.Employee.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.Employee.dao.UserDao;
import com.Employee.model.User;

@WebServlet("/AddEmployeeServlet")
public class AddEmployeeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Create a new User object
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(password);
        newUser.setRole("employee");

        // Add the new user to the database
        UserDao userDao = new UserDao();
        boolean isAdded = userDao.addEmployee(newUser);

        // Redirect to the admin dashboard with a success or error message
        if (isAdded) {
            response.sendRedirect("adminDashboard.jsp?message=Employee added successfully");
        } else {
            response.sendRedirect("adminDashboard.jsp?error=Failed to add employee");
        }
    }
}
