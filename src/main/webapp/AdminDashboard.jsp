<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="models.Users,models.Task,java.util.*" %>
<!DOCTYPE html>
<html>

<head>
    <link href="https://fonts.googleapis.com/css?family=Rethink+Sans&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Outfit&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Montserrat&display=swap" rel="stylesheet" />
    <link rel="stylesheet"
        href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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

        .addEmp {
            background: #27ae60;
        }

        .addEmp:hover {
            background: #1e8449;
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

        /* Charts section */
        .charts {
            margin-bottom: 20px;
        }

        .charts h1 {
            margin-bottom: 15px;
            font-size: 24px;
            color: #2c3e50;
            border-bottom: 2px solid #ddd;
            padding-bottom: 10px;
        }

        .charts form {
            display: flex;
            align-items: center;
        }

        .charts .sub {
            background: #3498db;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 20px;
            cursor: pointer;
            transition: background 0.3s, transform 0.3s;
        }

        .charts .sub:hover {
            background: #2980b9;
            transform: scale(1.05);
        }
    </style>

    <title>Employee Time Tracker</title>
</head>

<body>

    <%
        Users user = (Users) session.getAttribute("Admin");
    %>
    <div class="main">

        <div class="employee">
            <div class="title">
                <div class="empn">
                    <p class="namee">Welcome back, <b><%=user.getUsername() %></b></p>
                    <span class="empid">EmpId:<%= user.getUserId() %></span>
                </div>
                <form action="LogoutServlet"><button class="logout" type="submit">Logout</button></form>
            </div>
        </div>
        <div class="btn">
            <button class="view" onclick="location.href='ViewTask.jsp';"><span
                    class="material-symbols-outlined">visibility</span>View Task</button>
            <button class="atsk" onclick="location.href='AddTask_Employee.jsp';"><span
                    class="material-symbols-outlined">add</span>Add Task</button>
            <button class="addEmp" onclick="location.href='AddEmployee.jsp';"><span
                    class="material-symbols-outlined">person_add</span>Add Employee</button>
        </div>


        <div class="stats">
            <h1>Employee Stats</h1>

            <form action="TaskListServletAdmin">
                <label for="user_id">User ID:</label>
                <input type="text" id="user_id" name="user_id" required>
                <button type="submit" class="sub">Submit</button>
            </form>
        </div>

        <div class="charts">
            <h1>Employee overall stats</h1>
            <form action="ChartsAdmin">
                <button type="submit" class="sub">Get overall stats</button>
            </form>
        </div>
    </div>
</body>

</html>