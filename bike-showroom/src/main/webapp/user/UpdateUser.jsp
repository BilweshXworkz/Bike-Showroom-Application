<%@ page language="java" contentType="text/html; charset=US-ASCII"
        pageEncoding="US-ASCII"%>
 <%@ page isELIgnored="false" %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Showroom</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
         body {
            font-family: 'Montserrat', sans-serif;
            margin: 0;
            padding: 0;
            height: 100vh;
            background: url('resources/images/image9.jpeg') no-repeat center center fixed;
            background-size: cover;
        }
        .card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: white;
        }

        .form-container {
            width: 40%;
            min-height: 400px;
            padding: 20px;
            font-size: 18px;
            border-radius: 15px;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(5px);
            color: white;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.3);
        }

        .form-container .form-label, h2, label, select, input, button {
            font-family: 'Montserrat', sans-serif;
        }

        .form-container .form-label {
            color: white;
            font-size: 22px;
            font-weight: bold;
        }

        h2 {
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .custom-btn {
            width: 200px;
            font-size: 25px;
            font-weight: 600px;
            padding: 6px 12px;
            line-height: 1;
        }
    </style>

</head>
<body>
    <nav class="navbar navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="#">
                <img src="https://www.royalenfield.com/content/dam/royal-enfield/india/logos/logo.svg" alt="" width="200" height="40" class="me-2">
            </a>
            <form class="d-flex">
                <a class="nav-link btn btn-outline-light me-2 px-3 text-info" onclick="history.back()">Back</a>
            </form>
        </div>
    </nav>

    <div class="d-flex justify-content-center align-items-center vh-50 mt-5">
        <div class="form-container">
            <h2 class="text-center mb-4" style="color: black; font-weight: bold;">Rescheduling</h2>
            <form action="updateUser" method="post">
                <div class="row">
                    <div class="mb-3 " id="datetimeContainer">
                        <label class="form-label">Reschedule Date and Time</label>
                        <input type="datetime-local" class="form-control" name="dateTime" id="reasonInput">
                    </div>
                    <div class="mb-3 ">
                        <input type="hidden" name="id" value="${user.id}">
                        <label class="form-label">Reason For Rescheduling</label>
                        <input type="text" class="form-control" name="reason" id="reason" required>
                        <small id="nameError" style="color: white;"></small>
                        <small id="displayName"  style="color: white;"></small>
                    </div>
                <button type="submit" class="btn btn-danger  float-end custom-btn">Update</button>
            </form>
        </div>
    </div>
</body>
</html>
