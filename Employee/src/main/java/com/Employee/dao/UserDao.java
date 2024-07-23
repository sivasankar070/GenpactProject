package com.Employee.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.Employee.model.User;

public class UserDao {

    // Method to authenticate a user by username and password
    public User authenticate(String username, String password) {
        User user = null;
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, username);
            statement.setString(2, password);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                user = new User();
                user.setEmpId(resultSet.getInt("emp_id"));
                user.setUsername(resultSet.getString("username"));
                user.setRole(resultSet.getString("role"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    // Method to get user details by username
    public User getUserByUsername(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";
        User user = null;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, username);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                user = new User();
                user.setEmpId(resultSet.getInt("emp_id"));
                user.setUsername(resultSet.getString("username"));
                user.setRole(resultSet.getString("role"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    // Method to validate user by username and password (not necessary with authenticate, but included if needed)
    public boolean validateUser(String username, String password) {
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, username);
            statement.setString(2, password);
            ResultSet resultSet = statement.executeQuery();

            return resultSet.next();

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Method to retrieve all employees
    public List<User> getAllEmployees() {
        List<User> employees = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE role = 'employee'";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                User user = new User();
                user.setEmpId(resultSet.getInt("emp_id"));
                user.setUsername(resultSet.getString("username"));
                user.setRole(resultSet.getString("role"));
                employees.add(user);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employees;
    }

    // Method to add a new employee
    public boolean addEmployee(User employee) {
        String sql = "INSERT INTO users (username, password, role) VALUES (?, ?, 'employee')";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, employee.getUsername());
            statement.setString(2, employee.getPassword());

            int rowsInserted = statement.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Method to delete an employee by empId
    public boolean deleteEmployee(int empId) {
        String sql = "DELETE FROM users WHERE emp_id = ? AND role = 'employee'";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, empId);

            int rowsDeleted = statement.executeUpdate();
            return rowsDeleted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public List<User> getUsersByRole(String role) {
        List<User> users = new ArrayList<>();
        try (Connection connection = DatabaseConnection.getConnection()) {
            String sql = "SELECT * FROM users WHERE role = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, role);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                User user = new User();
                user.setEmpId(resultSet.getInt("emp_id"));
                user.setUsername(resultSet.getString("username"));
                user.setPassword(resultSet.getString("password"));
                user.setRole(resultSet.getString("role"));
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }
}
