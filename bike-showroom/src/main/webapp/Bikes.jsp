<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Available Bikes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <style>
        body {
            padding-top: 80px; /* Space for navbar */
            background-color: #f8f9fa;
        }

        .card {
            border-radius: 15px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            overflow: hidden;
        }

        .card:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.2);
        }

        .card-img-top {
            height: 200px;
            object-fit: cover;
        }

        .card-body {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: 15px;
        }

        .card-title {
            font-size: 1.25rem;
            font-weight: 600;
        }

        .card-text {
            font-size: 1rem;
            color: #6c757d;
        }

        .btn-explore {
            background-color: #e63946;
            color: white;
            font-weight: 600;
            padding: 10px 20px;
            border-radius: 25px;
            transition: background-color 0.3s ease;
        }

        .btn-explore:hover {
            background-color: #d32f2f;
        }

        .navbar-nav .nav-link {
            font-weight: 600;
            text-transform: uppercase;
        }

        .navbar-nav .nav-link:hover {
            color: #e63946;
        }

        .row > .col-md-6 {
            margin-bottom: 30px;
        }

        @media (max-width: 767px) {
            .card-img-top {
                height: 150px;
            }
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">
            <img src="https://www.royalenfield.com/content/dam/royal-enfield/india/logos/logo.svg" alt="Royal Enfield Logo" width="200" height="40" class="me-2">
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-center" id="navbarSupportedContent">
            <ul class="nav justify-content-center mb-3 mb-lg-0">
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

<div class="container py-5">
    <h2 class="text-center mb-5 text-dark">Explore Our Available Bikes</h2>
    <div class="row">
        <c:forEach var="bike" items="${bikes}">
            <div class="col-md-6 col-lg-4 d-flex">
                <div class="card w-100 shadow-lg">
                    <img src="${pageContext.request.contextPath}/images/${bike.rightImage}" class="card-img-top" alt="Bike Image">
                    <div class="card-body">
                        <h5 class="card-title">${bike.modelName}</h5>
                        <p class="card-text"><strong>Engine:</strong> ${bike.engine}</p>
                        <p class="card-text"><strong>Price:</strong> ₹${bike.price}</p>
                        <a href="#" class="btn btn-explore w-100">Explore Bikes</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
