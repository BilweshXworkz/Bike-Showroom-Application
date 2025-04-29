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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
       body {
            margin: 0;
            padding: 0;
            height: 100vh;
            background: url('resources/images/image10.png') no-repeat center center fixed;
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
           border-radius: 15px;
           background: rgba(255, 255, 255, 0.1);
           backdrop-filter: blur(0px);
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
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">
      <img src="https://www.royalenfield.com/content/dam/royal-enfield/india/logos/logo.svg" alt="" width="200" height="40" class="me-2">
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

<div class="d-flex justify-content-center align-items-center vh-100">
    <div class="form-container">
        <h2 class="text-center mb-4" style="color: black;">Add Bike To Showroom</h2>
        <h2>${showroomName}</h2>

        <form action="addBikeToShowroom" method="post">
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
            <input type="hidden" name="showroomName" value="${showroomName}" />

            <label>Select Bike Model to Add:</label>
            <select name="modelName" class="form-control mb-3">
                <c:forEach var="model" items="${bikeModels}">
                    <option value="${model}">${model}</option>
                </c:forEach>
            </select>

            <button type="submit" class="btn btn-primary">Add Bike</button>
        </form>
    </div>
</div>

</body>
</html>
