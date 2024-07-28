<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <link href="https://fonts.googleapis.com/css?family=Montserrat&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Helvetica+Neue&display=swap" rel="stylesheet" />
    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f0f0f0;
        }
        .error-container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .error-container h1 {
            color: #e74c3c;
            font-size: 24px;
            margin-bottom: 10px;
        }
        .error-container p {
            color: #333;
            font-size: 16px;
            margin-bottom: 20px;
        }
        .error-container a {
            color: #3498db;
            text-decoration: none;
            font-size: 16px;
        }
        .error-container a:hover {
            text-decoration: underline;
        }
    </style>
    <title>Error</title>
</head>

<body>
    <div class="error-container">
        <h1>An Error Occurred</h1>
        <p>Sorry, there was a problem processing your request. Please try again later.</p>
        <a href="AdminDashboard.jsp">Back to Dashboard</a>
    </div>
</body>

</html>
