package com.Employee.model;

public class User {
    private int empId;
    private String username;
    private String password;
    private String role;

    // Constructors, getters, and setters
    public User() {}

    public User(int empId, String username, String password, String role) {
        this.empId = empId;
        this.username = username;
        this.password = password;
        this.role = role;
    }

    public int getEmpId() {
        return empId;
    }

    public void setEmpId(int empId) {
        this.empId = empId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
}
