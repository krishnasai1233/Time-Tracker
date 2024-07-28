<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="models.Task" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Task List</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <style>
        @charset "UTF-8";

        /* General body styling */
        body {
            background-color: #f0f2f5;
            color: #333;
            margin: 0;
            padding: 0;
            font-family: 'Arial', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            flex-direction: column;
        }

        /* Main container styling */
        .main {
            width: 90%;
            max-width: 1200px;
            background: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }

        /* Grid layout for charts */
        .row {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }

        /* Chart container styling */
        .daily, .weekly, .monthly {
            background: #f9f9f9;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
            flex: 1 1 100%; /* Full width for smaller screens */
        }

        /* Ensure equal height for canvas elements */
        canvas {
            width: 100% !important; /* Full width of the parent container */
            height: 300px; /* Fixed height for consistency */
            border-radius: 5px;
        }

        /* Title styling */
        h1 {
            font-size: 1.8em;
            color: #333;
            text-align: center;
            margin-bottom: 20px;
        }

        /* Responsive design */
        @media (min-width: 768px) {
            .daily, .weekly, .monthly {
                flex: 1 1 30%; /* Adjust width on larger screens */
            }
        }

        @media (max-width: 768px) {
            .daily, .weekly, .monthly {
                margin: 10px 0;
                padding: 15px;
            }

            h1 {
                font-size: 1.5em;
            }
        }
    </style>
</head>
<body>
    <div class="main">
        <h1>Task Stats</h1>
        <div class="row">
            <div class="daily">
                <h1>Daily Stats</h1>
                <canvas id="todaysTasksChart"></canvas>
            </div>
            <div class="weekly">
                <h1>Weekly Stats</h1>
                <canvas id="weeklyTasksChart"></canvas>
            </div>
            <div class="monthly">
                <h1>Monthly Stats</h1>
                <canvas id="monthlyTasksChart"></canvas>
            </div>
        </div>
    </div>
    
    <%
        List<Task> todaysTasks = (List<Task>) request.getAttribute("dailyTasks");
        List<Task> weeklyTasks = (List<Task>) request.getAttribute("weeklyTasks");
        List<Task> monthlyTasks = (List<Task>) request.getAttribute("monthlyTasks");
    %>
   
    <script>
        document.addEventListener('DOMContentLoaded', (event) => {
            const taskCategoriesDaily = {};
            <% for (Task task : todaysTasks) { %>
                const project = "<%= task.getProject() %>";
                const duration = <%= task.getDuration() %>;

                if (!taskCategoriesDaily[project]) {
                    taskCategoriesDaily[project] = 0;
                }
                taskCategoriesDaily[project] += duration;
            <% } %>
            const labelsDaily = Object.keys(taskCategoriesDaily);
            const dataDaily = Object.values(taskCategoriesDaily);

            const ctxDaily = document.getElementById('todaysTasksChart').getContext('2d');
            new Chart(ctxDaily, {
                type: 'pie',
                data: {
                    labels: labelsDaily,
                    datasets: [{
                        label: 'Today\'s Tasks',
                        data: dataDaily,
                        backgroundColor: ['red', 'blue', 'green', 'yellow', 'orange', 'purple']
                    }]
                }
            });
            
            const taskCategoriesWeekly = {};
            <% for (Task task : weeklyTasks) {%>
                const projectWeekly = "<%= task.getProject() %>";
                const durationWeekly = <%= task.getDuration() %>;

                if (!taskCategoriesWeekly[projectWeekly]) {
                    taskCategoriesWeekly[projectWeekly] = 0;
                }
                taskCategoriesWeekly[projectWeekly] += durationWeekly;
            <% } %>
            const labelsWeekly = Object.keys(taskCategoriesWeekly);
            const dataWeekly = Object.values(taskCategoriesWeekly);

            const ctxWeekly = document.getElementById('weeklyTasksChart').getContext('2d');
            new Chart(ctxWeekly, {
                type: 'bar',
                data: {
                    labels: labelsWeekly,
                    datasets: [{
                        label: 'Task Duration (hours)',
                        data: dataWeekly,
                        backgroundColor: 'rgba(75, 192, 192, 0.2)',
                        borderColor: 'rgba(75, 192, 192, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
            
            const taskCategoriesMonthly = {};
            <% for (Task task : monthlyTasks) {%>
                const projectMonthly = "<%= task.getProject() %>";
                const durationMonthly = <%= task.getDuration() %>;

                if (!taskCategoriesMonthly[projectMonthly]) {
                    taskCategoriesMonthly[projectMonthly] = 0;
                }
                taskCategoriesMonthly[projectMonthly] += durationMonthly;
            <% } %>
            const labelsMonthly = Object.keys(taskCategoriesMonthly);
            const dataMonthly = Object.values(taskCategoriesMonthly);

            const ctxMonthly = document.getElementById('monthlyTasksChart').getContext('2d');
            new Chart(ctxMonthly, {
                type: 'bar',
                data: {
                    labels: labelsMonthly,
                    datasets: [{
                        label: 'Task Duration (hours)',
                        data: dataMonthly,
                        backgroundColor: 'rgba(153, 102, 255, 0.2)',
                        borderColor: 'rgba(153, 102, 255, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        });
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
