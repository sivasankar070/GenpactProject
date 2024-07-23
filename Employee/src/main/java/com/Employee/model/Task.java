package com.Employee.model;

import java.sql.Date;
import java.sql.Time;
import java.util.Calendar;

public class Task {
    private int id;
    private int empId;
    private String username;
    private Date date;
    private Time startTime;
    private Time endTime;
    private double numHours;
    private String category;
    private String project;
    private int weekNumber;
    private int month;

    // Default constructor
    public Task() {}

    // Constructor with parameters
    public Task(int id, int empId, String username, Date date, Time startTime, Time endTime, double numHours, String category, String project) {
        this.id = id;
        this.empId = empId;
        this.username = username;
        this.date = date;
        this.startTime = startTime;
        this.endTime = endTime;
        this.numHours = numHours;
        this.category = category;
        this.project = project;

        // Update week number and month whenever date is set
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        this.weekNumber = calendar.get(Calendar.WEEK_OF_YEAR);
        this.month = calendar.get(Calendar.MONTH) + 1; // Adding 1 because Calendar.MONTH is zero-based
    }

    // Getters and setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;

        // Update week number and month whenever date is set
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        this.weekNumber = calendar.get(Calendar.WEEK_OF_YEAR);
        this.month = calendar.get(Calendar.MONTH) + 1; // Adding 1 because Calendar.MONTH is zero-based
    }

    public Time getStartTime() {
        return startTime;
    }

    public void setStartTime(Time startTime) {
        this.startTime = startTime;
    }

    public Time getEndTime() {
        return endTime;
    }

    public void setEndTime(Time endTime) {
        this.endTime = endTime;
    }

    public double getNumHours() {
        return numHours;
    }

    public void setNumHours(double numHours) {
        this.numHours = numHours;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getProject() {
        return project;
    }

    public void setProject(String project) {
        this.project = project;
    }

    public int getWeekNumber() {
        return weekNumber;
    }

    public void setWeekNumber(int weekNumber) {
        this.weekNumber = weekNumber;
    }

    public int getMonth() {
        return month;
    }

    public void setMonth(int month) {
        this.month = month;
    }
}
