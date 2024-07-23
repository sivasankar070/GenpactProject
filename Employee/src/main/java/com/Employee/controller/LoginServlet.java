package com.Employee.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.Employee.dao.UserDao;
import com.Employee.model.User;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        UserDao userDao = new UserDao();
        User user = userDao.authenticate(username, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            
            if ("admin".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect("adminDashboard.jsp");
            } else if ("employee".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect("employeeDashboard.jsp");
            } else {
                response.sendRedirect("login.jsp?error=InvalidRole");
            }
        } else {
            response.sendRedirect("login.jsp?error=InvalidCredentials");
        }
    }
}
