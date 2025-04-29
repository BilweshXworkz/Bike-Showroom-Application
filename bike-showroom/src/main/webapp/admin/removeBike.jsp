<%@ page language="java" contentType="text/html; charset=US-ASCII" pageEncoding="US-ASCII"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Bike to Showroom</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            margin: 0;
            padding: 0;
            height: 100vh;
            background: url('resources/images/image10.png') no-repeat center center fixed;
            background-size: cover;
        }
        .form-container {
            width: 50%;
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(6px);
            color: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 0 15px rgba(0,0,0,0.3);
        }
        h2 {
            font-weight: 700;
            color: black;
        }
        .table thead {
            background-color: #343a40;
            color: white;
        }
        .alert {
            font-weight: bold;
        }
    </style>
</head>
<body>

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
      <ul class="navbar-nav">
        <li class="nav-item"><a class="nav-link active" href="GoAddShowroom">Register Showroom</a></li>
        <li class="nav-item"><a class="nav-link active" href="GoAddBike">Register Bike</a></li>
        <li class="nav-item"><a class="nav-link active" href="bikeToShowroom">Assign Bike to Showroom</a></li>
        <li class="nav-item"><a class="nav-link active" href="user">New Customer Registration</a></li>
        <li class="nav-item"><a class="nav-link active" href="userForm">Customer Details Form</a></li>
        <li class="nav-item"><a class="nav-link active" href="explore">Showroom</a></li>
        <li class="nav-item"><a class="nav-link active" href="exploreBike">Bikes</a></li>
      </ul>
    </div>
  </div>
</nav>

<div class="d-flex justify-content-center align-items-center vh-100">
    <div class="form-container">
        <h2 class="text-center mb-4">Add Bike To Showroom</h2>
        <h4 class="text-center mb-3">${showroomName}</h4>

        <c:if test="${not empty success}">
            <div class="alert alert-success" role="alert">
                ${success}
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-danger" role="alert">
                ${error}
            </div>
        </c:if>


        <table class="table table-bordered table-striped bg-white text-dark">
            <thead>
                <tr>
                    <th>Bike Model</th>
                    <th style="width: 100px;">Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="bike" items="${bikes}">
                    <tr>
                        <td>${bike.modelName}</td>
                        <td>
                            <!-- This form deletes only the bike from the showroom -->
                            <form action="${pageContext.request.contextPath}/deleteBike" method="post">
                                <input type="hidden" name="showroomName" value="${showroomName}" />
                                <input type="hidden" name="bikeModel" value="${bike.modelName}" />
                                <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
