<%@ page language="java" contentType="text/html; charset=US-ASCII" pageEncoding="US-ASCII"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Test Ride Form</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            margin: 0;
            padding: 0;
            height: 100vh;
            background: url('resources/images/image8.jpg') no-repeat center center fixed;
            background-size: cover;
        }

        .navbar {
            background-color: #343a40 !important;
            padding: 10px;
        }

        .navbar-brand img {
            width: 200px;
            height: 40px;
        }

        .scrollable-table {
            max-height: 450px;
            overflow-y: auto;
            margin-top: 80px;
            background-color: rgba(255, 255, 255, 0.85);
            border-radius: 10px;
            padding: 20px;
        }

        .scrollable-table table {
            border-radius: 10px;
        }

        .scrollable-table th {
            position: sticky;
            top: 0;
            background-color: #212529;
            color: white;
        }

        .table th, .table td {
            text-align: center;
            padding: 12px;
        }

        .table-dark {
            background-color: #212529;
        }

        h3 {
            margin-top: 100px;
            font-weight: 700;
            color: #fff;
            text-transform: uppercase;
        }

        .navbar {
            background-color: #343a40;
        }

        .navbar-brand img {
            width: 180px;
            height: 40px;
        }

        .navbar-nav .nav-link {
            font-size: 16px;
            font-weight: 600;
            padding: 10px 20px;
        }

        .navbar-nav .nav-link.active {
            background-color: #e74c3c;
            border-radius: 25px;
            color: white;
        }

        .btn-back {
            background-color: #6c757d;
            color: white;
            border-radius: 50px;
            font-weight: bold;
        }

        .btn-back:hover {
            background-color: #5a6268;
        }

    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
      <div class="container-fluid">
        <a class="navbar-brand" href="#">
          <img src="https://www.royalenfield.com/content/dam/royal-enfield/india/logos/logo.svg" alt="Royal Enfield Logo" class="me-2">
        </a>
        <!-- Toggler button -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
          aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <!-- Collapsible content -->
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
</nav>

<div class="container mt-5 pt-5">
    <h3 class="text-center">Customer Test Ride Form</h3>
    <div class="row justify-content-center">
        <div class="col-md-12 scrollable-table">
            <table class="table table-bordered text-center table-striped shadow-lg">
                <thead class="table-dark">
                    <tr>
                        <th>Sl No</th>
                        <th>Full Name</th>
                        <th>Age</th>
                        <th>Phone Number</th>
                        <th>Email ID</th>
                        <th>Address</th>
                        <th>Driving License</th>
                        <th>Showroom Name</th>
                        <th>Bike Model</th>
                        <th>Schedule</th>
                        <th>Reason</th>
                        <th>Date and Time</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${usersRegistrationForm}" var="user" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td>${user.fullName}</td>
                            <td>${user.age}</td>
                            <td>${user.phoneNumber}</td>
                            <td>${user.emailId}</td>
                            <td>${user.address}</td>
                            <td>${user.dlNumber}</td>
                            <td>${user.showroomName}</td>
                            <td>${user.modelName}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${user.scheduleTask == 0}">Scheduled Test Ride</c:when>
                                    <c:otherwise>Unknown</c:otherwise>
                                </c:choose>
                            </td>
                            <td>${user.reason}</td>
                            <td>${user.getDateTime()}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
