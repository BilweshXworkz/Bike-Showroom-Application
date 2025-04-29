<%@ page language="java" contentType="text/html; charset=US-ASCII"
        pageEncoding="US-ASCII"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Form Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            margin: 0;
            padding: 0;
            height: 100vh;
            background: url('resources/images/image8.jpg') no-repeat center center fixed;
            background-size: cover;
            color: #fff;
        }

        .navbar {
            margin-bottom: 30px;
        }

        .card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: white;
        }

        .form-container {
            width: 50%;
            min-height: 400px;
            padding: 30px;
            font-size: 18px;
            border-radius: 15px;
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(5px);
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.3);
            margin-top: 120px; /* Ensure space for the navbar */
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
            margin-bottom: 20px;
        }

        .scrollable-table {
            max-height: 400px;
            overflow-y: auto;
            margin-top: 120px;
            background-color: rgba(255, 255, 255, 0.8);
            border-radius: 10px;
            padding: 15px;
        }

        table thead th {
            position: sticky;
            top: 0;
            background-color: #343a40;
            color: white;
            z-index: 2;
        }

        table tbody tr:hover {
            background-color: #f1f1f1;
            cursor: pointer;
        }

        .btn-custom {
            background-color: #ff6600;
            color: white;
            padding: 8px 16px;
            font-size: 16px;
            border-radius: 5px;
            text-decoration: none;
            margin-top: 10px;
        }

        .btn-custom:hover {
            background-color: #e65c00;
        }

        .navbar-nav .nav-link {
            font-size: 16px;
            font-weight: bold;
        }

        .navbar-nav .nav-link:hover {
            color: #ff6600;
        }

    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">
      <img src="https://www.royalenfield.com/content/dam/royal-enfield/india/logos/logo.svg" alt="" width="200" height="40" class="me-2">
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
      aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse justify-content-center" id="navbarSupportedContent">
      <ul class="nav justify-content-center mb-3 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="GoAddShowroom">Register Showroom</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="GoAddBike">Register Bike</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="bikeToShowroom">Assign Bike to Showroom</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="user">New Customer Registration</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="userForm">Customer Details Form</a>
        </li>
        <li class="nav-item">
            <a class="nav-link active" aria-current="page" href="explore">Showroom</a>
        </li>
        <li class="nav-item">
            <a class="nav-link active" aria-current="page" href="exploreBike">Bikes</a>
        </li>
      </ul>
    </div>
  </div>
</nav>

<!-- Main content -->
<div class="container">
    <div class="row justify-content-center">
        <h3 class="text-center text-white mt-5">Customer Details Form</h3>
        <div class="col-md-12 scrollable-table">
            <table class="table table-bordered text-center bg-white shadow-lg">
                <thead class="table-dark">
                    <tr>
                        <th>User ID</th>
                        <th>Full Name</th>
                        <th>Age</th>
                        <th>Phone Number</th>
                        <th>Email ID</th>
                        <th>Address</th>
                        <th>Schedule</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${usersRegistrationForm}" var="user">
                        <tr>
                            <td>${user.getId()}</td>
                            <td>${user.getFullName()}</td>
                            <td>${user.getAge()}</td>
                            <td>${user.getPhoneNumber()}</td>
                            <td>${user.getEmailId()}</td>
                            <td>${user.getAddress()}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${user.getScheduleTask() == 0}">Schedule Test Ride</c:when>
                                    <c:when test="${user.getScheduleTask() == 1}">Booking</c:when>
                                    <c:otherwise>Unknown</c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="fetchById?Id=${user.getId()}" class="btn btn-sm btn-warning">Edit</a>
                                <a href="viewById?Id=${user.getId()}" class="btn btn-sm btn-info">View</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="text-center">
                <a href="getTestRide?scheduleTask=0" class="btn-custom">Test Ride Details</a>
                <a href="getBooking?scheduleTask=1" class="btn-custom">Booking Details</a>
            </div>
        </div>
    </div>
</div>

</body>
</html>
