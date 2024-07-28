<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="models.Users,com.dao.TaskDAO,models.Task,java.util.*" %>
<!DOCTYPE html>
<html>

<head>
    <link href="https://fonts.googleapis.com/css?family=Rethink+Sans&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Outfit&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Montserrat&display=swap" rel="stylesheet" />
    <style>
        /* Reset some basic elements */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Body styling */
        body {
            font-family: 'Outfit', sans-serif;
            background-color: #f0f2f5;
            color: #333;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        /* Main container */
        .main {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
            max-width: 900px;
            width: 90%;
        }

        /* Employee section */
        .employee .title {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            border-bottom: 2px solid #ddd;
            padding-bottom: 10px;
        }

        .employee .empn {
            font-size: 20px;
            color: #444;
        }

        .employee .namee {
            font-size: 28px;
            font-weight: bold;
            color: #2c3e50;
        }

        .employee .empid {
            font-size: 16px;
            color: #666;
        }

        .employee .logout {
            background: #e74c3c;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 20px;
            cursor: pointer;
            transition: background 0.3s, transform 0.3s;
        }

        .employee .logout:hover {
            background: #c0392b;
            transform: scale(1.05);
        }

        /* Buttons */
        .btn {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .btn button {
            background: #3498db;
            color: #fff;
            border: none;
            padding: 12px 25px;
            border-radius: 30px;
            cursor: pointer;
            display: flex;
            align-items: center;
            transition: background 0.3s, transform 0.3s;
            font-size: 16px;
        }

        .btn button span {
            margin-right: 8px;
            font-size: 24px;
        }

        .btn button:hover {
            background: #2980b9;
            transform: scale(1.05);
        }

        .atsk {
            background: #f39c12;
        }

        .atsk:hover {
            background: #d68910;
        }

        .view {
            background: #8e44ad;
        }

        .view:hover {
            background: #7d3c98;
        }

        /* Stats form */
        .stats {
            margin-bottom: 20px;
        }

        .stats h1 {
            margin-bottom: 15px;
            font-size: 24px;
            color: #2c3e50;
            border-bottom: 2px solid #ddd;
            padding-bottom: 10px;
        }

        .stats form {
            display: flex;
            align-items: center;
        }

        .stats label {
            margin-right: 15px;
            font-size: 18px;
            color: #2c3e50;
        }

        .stats input {
            padding: 8px;
            font-size: 18px;
            border: 1px solid #ccc;
            border-radius: 20px;
            margin-right: 15px;
            width: 200px;
        }

        .stats .sub {
            background: #3498db;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 20px;
            cursor: pointer;
            transition: background 0.3s, transform 0.3s;
        }

        .stats .sub:hover {
            background: #2980b9;
            transform: scale(1.05);
        }

        /* Table styling */
        .task-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .task-table th, .task-table td {
            padding: 12px;
            text-align: center;
            border: 1px solid #ddd;
        }

        .task-table th {
            background-color: #3498db;
            color: white;
            font-weight: bold;
        }

        .task-table tr:nth-child(even) {
            background-color: #f2f2f2;
        }
    </style>
    <title>Employee Time Tracker</title>
</head>

<body>
<%
    if (session == null || session.getAttribute("Associate") == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
    Users user = (Users) session.getAttribute("Associate");
    int user_id = user.getUserId();
    TaskDAO task = new TaskDAO();
    Map<String, List<Task>> tasks = task.getTaskDetailsByAssociate(user_id);
%>
    <div class="main">
        <div class="employee">
            <div class="title">
                <div class="empn">
                    <p class="namee">Welcome back, <b><%= user.getUsername() %></b></p>
                    <span class="empid">EmpId:<%= user.getUserId() %></span>
                </div>
                <form action="LogoutServlet"><button class="logout" type="submit">Logout</button></form>
            </div>
        </div>
        
        <div class="btn">
            <form action="TaskListServlet">
                <button class="atsk" type="submit">Stats</button>
            </form>
            <button class="atsk" onclick="location.href='AddTask.jsp';">Add Task</button>
        </div>
        
        <%
            for (Map.Entry<String, List<Task>> task_ : tasks.entrySet()) {
                String project = task_.getKey();
                List<Task> task1 = task_.getValue();
        %>
        <div class="project">
            <div class="desc">
                <div class="empn">
                    <p class="projn"><h2><%= project %></h2></p>
                </div>
            </div>

            <table class="task-table">
                <tr>
                    <th>Admin ID</th>
                    <th>Duration</th>
                    <th>Category & Description</th>
                </tr>
                <%
                    for (int i = 0; i < task1.size(); i++) {
                        Task task2 = task1.get(i);
                %>
                <tr>
                    <td><%= task2.getTaskId() %></td>
                    <td><%= task2.getTaskDate() %> <%= task2.getStartTime() %>-<%= task2.getEndTime() %></td>
                    <td><%= task2.getCategory() %><br><%= task2.getDescription() %></td>
                </tr>
                <% }
                %>
            </table>
        </div>
        <% }
        %>
    </div>
</body>

</html>
