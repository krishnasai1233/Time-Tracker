<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <link href="https://fonts.googleapis.com/css?family=Montserrat&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Helvetica+Neue&display=swap" rel="stylesheet" />
    <style><%@ include file="CSS/AddEmployee.css" %></style>
    <title>Add Employee</title>
</head>

<body class="page">
    <form class="form-control" action="AddEmployeeServlet" method="post">
        <p class="title">Add Employee</p>
        <div class="input-field">
            <input required="" class="input" type="text" name="username"/>
            <label class="label" for="input">Enter Username:</label>
        </div>
        <div class="input-field">
            <input required="" class="input" type="password" name="password"/>
            <label class="label" for="input">Enter Password</label>
        </div>
        <div class="input-field">
            <select required="" class="input" name="role">
                <option value="Admin">Admin</option>
                <option value="Associate">Associate</option>
            </select>
            <label class="label" for="input">Select Role</label>
        </div>
        <button class="submit-btn" type="submit">Add Employee</button>
    </form>
</body>
</html>
