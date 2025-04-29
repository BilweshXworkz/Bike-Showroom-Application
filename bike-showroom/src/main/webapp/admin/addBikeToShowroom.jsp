<%@ page language="java" contentType="text/html; charset=US-ASCII" pageEncoding="US-ASCII"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assign Bike to Showroom</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            margin: 0;
            padding: 0;
            height: 100vh;
            background: url('resources/images/image7.jpg') no-repeat center center fixed;
            background-size: cover;
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

        .card {
            background: rgba(255, 255, 255, 0.3);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: white;
        }

        .form-container {
            width: 80%;
            min-height: 450px;
            margin-top: 70px;
            padding: 30px;
            border-radius: 15px;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(5px);
            box-shadow: 0px 0px 25px rgba(0, 0, 0, 0.4);
        }

        .form-container h2 {
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }

        .table {
            background: rgba(255, 255, 255, 0.8);
            border-radius: 10px;
        }

        .table th, .table td {
            text-align: center;
            font-size: 16px;
        }

        .table thead {
            background-color: #e74c3c;
            color: white;
        }

        .btn {
            font-size: 16px;
            font-weight: 600;
            border-radius: 10px;
        }

        .btn-success {
            background-color: #28a745;
        }

        .btn-danger {
            background-color: #dc3545;
        }

        .btn img {
            width: 20px;
            height: 20px;
        }

        .btn:hover {
            opacity: 0.8;
        }

        .btn-sm {
            padding: 6px 12px;
        }

        .navbar-brand img {
             height: 40px;
         }

         .navbar-nav .nav-link {
             font-weight: 500;
             font-size: 16px;
         }

         .navbar-nav .nav-link:hover {
             color: #D9534F !important;
         }
    </style>
</head>

<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
      <div class="container-fluid">
        <a class="navbar-brand" href="#">
          <img src="https://www.royalenfield.com/content/dam/royal-enfield/india/logos/logo.svg" alt="Royal Enfield Logo" class="me-2">
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
          aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-center" id="navbarSupportedContent">
          <ul class="nav justify-content-center mb-3 mb-lg-0">
            <li class="nav-item">
              <a class="nav-link active" href="GoAddShowroom">Register Showroom</a>
            </li>
            <li class="nav-item">
              <a class="nav-link active" href="GoAddBike">Register Bike</a>
            </li>
            <li class="nav-item">
              <a class="nav-link active" href="bikeToShowroom">Assign Bike to Showroom</a>
            </li>
            <li class="nav-item">
              <a class="nav-link active" href="user">New Customer Registration</a>
            </li>
            <li class="nav-item">
              <a class="nav-link active" href="userForm">Customer Details Form</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="explore">Showroom</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="exploreBike">Bikes</a>
            </li>
          </ul>
        </div>
      </div>
    </nav>

    <div class="d-flex justify-content-center align-items-center vh-100">
        <div class="form-container">
            <h2>Assign Bike to Showroom</h2>
            <table class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Showroom Name</th>
                        <th>Bike Models (Available in that showroom)</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="entry" items="${showroomBikeMap}">
                        <tr>
                            <td>${entry.key}</td>
                            <td>
                                <c:forEach var="model" items="${entry.value}" varStatus="status">
                                    ${model}<c:if test="${!status.last}">, </c:if>
                                </c:forEach>
                            </td>
                            <td>
                                <form action="addBikeToShowroomPage" method="get" style="display:inline;">
                                    <input type="hidden" name="showroomName" value="${entry.key}" />
                                    <button type="submit" class="btn btn-success btn-sm">
                                        <img src="https://img.icons8.com/?size=20&id=102544&format=png&color=000000">
                                    </button>
                                </form>
                                <form action="removeMapping" method="post" style="display:inline;">
                                    <input type="hidden" name="showroomName" value="${entry.key}" />
                                    <button type="submit" class="btn btn-danger btn-sm ms-2">
                                        <img src="https://img.icons8.com/?size=20&id=102350&format=png&color=000000">
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>
</body>
</html>
