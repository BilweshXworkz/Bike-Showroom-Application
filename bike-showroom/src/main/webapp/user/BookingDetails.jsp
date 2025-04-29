<%@ page language="java" contentType="text/html; charset=US-ASCII" pageEncoding="US-ASCII"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Customer Booking Form</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            margin: 0;
            padding: 0;
            height: 100vh;
            background: url('images/image8.jpg') no-repeat center center fixed;
            background-size: cover;
        }
        .navbar {
            background-color: #343a40 !important;
            padding: 15px;
        }
        .navbar-brand img {
            max-width: 200px;
        }
        .navbar-nav .nav-item .nav-link {
            font-size: 16px;
            color: #f8f9fa !important;
        }
        .navbar-nav .nav-item .nav-link:hover {
            color: #ced4da !important;
        }
        .scrollable-table {
            max-height: 500px;
            overflow-y: auto;
            margin-top: 120px; /* Push content below navbar */
            background-color: rgba(255, 255, 255, 0.9); /* Optional: better contrast */
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0px 10px 20px rgba(0, 0, 0, 0.2);
        }
        table {
            font-size: 16px;
            background-color: #ffffff;
        }
        thead th {
            background-color: #343a40;
            color: white;
            position: sticky;
            top: 0;
            z-index: 2;
        }
        tbody tr {
            background-color: #f8f9fa;
        }
        tbody tr:hover {
            background-color: #e9ecef;
        }
        h3 {
            color: white;
            font-weight: 700;
            margin-top: 100px;
        }
        .container {
            padding-top: 120px;
        }
        .btn-outline-light {
            border-radius: 20px;
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

<div class="container">
    <div class="row justify-content-center">
        <h3 class="text-center">Customer Booking Form</h3>
        <div class="col-md-12 scrollable-table">
            <table class="table table-bordered text-center">
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
                        <th>Date and Time Of Delivery</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${usersRegistrationForm}" var="user" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td>${user.getFullName()}</td>
                            <td>${user.getAge()}</td>
                            <td>${user.getPhoneNumber()}</td>
                            <td>${user.getEmailId()}</td>
                            <td>${user.getAddress()}</td>
                            <td>${user.getDlNumber()}</td>
                            <td>${user.getShowroomName()}</td>
                            <td>${user.getModelName()}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${user.scheduleTask == 1}">Bike Booked</c:when>
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-pzjw8f+ua7Kw1TIq0DqtoTyF7hfXk6v+cI8PpHvX3y25tP92a5W9R+e/Rk5gdI+F" crossorigin="anonymous"></script>
</body>
</html>
