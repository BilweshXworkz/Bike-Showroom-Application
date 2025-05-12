<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${model.modelName} | Royal Enfield</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to right, #1b1b1b, #333);
            color: #fff;
            margin: 0;
            padding: 0;
        }

        .navbar {
            background-color: #111;
        }

        .container-custom {
            margin-top: 100px;
            margin-bottom: 60px;
        }

        .bike-heading {
            font-family: 'Georgia', serif;
            font-size: 38px;
            font-weight: bold;
            margin-bottom: 20px;
            color: #e63946;
        }

        .bike-details {
            background-color: rgba(255, 255, 255, 0.05);
            padding: 30px;
            border-left: 5px solid #e63946;
            border-radius: 12px;
        }

        .bike-details p {
            font-size: 16px;
            margin-bottom: 12px;
        }

        .carousel-inner img {
            height: 450px;
            object-fit: cover;
            border-radius: 10px;
        }

        .carousel-control-prev-icon,
        .carousel-control-next-icon {
            background-color: rgba(0, 0, 0, 0.6);
            border-radius: 50%;
        }

        .carousel-indicators [data-bs-target] {
            background-color: #e63946;
        }

        @media (max-width: 768px) {
            .bike-heading {
                font-size: 28px;
            }

            .carousel-inner img {
                height: 300px;
            }
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-dark fixed-top shadow">
    <div class="container">
        <a class="navbar-brand" href="#">
            <img src="https://www.royalenfield.com/content/dam/royal-enfield/india/logos/logo.svg" alt="Royal Enfield" height="40">
        </a>
    </div>
</nav>

<!-- Main Container -->
<div class="container container-custom">
    <div class="row align-items-center">
        <!-- Image Carousel -->
        <div class="col-lg-6 mb-4">
            <div id="bikeCarousel" class="carousel slide" data-bs-ride="carousel">
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <img src="${pageContext.request.contextPath}/bike-image/front/${model.modelName}" class="d-block w-100" alt="Front View">
                    </div>
                    <div class="carousel-item">
                        <img src="${pageContext.request.contextPath}/bike-image/back/${model.modelName}" class="d-block w-100" alt="Back View">
                    </div>
                    <div class="carousel-item">
                        <img src="${pageContext.request.contextPath}/bike-image/left/${model.modelName}" class="d-block w-100" alt="Left View">
                    </div>
                    <div class="carousel-item">
                        <img src="${pageContext.request.contextPath}/bike-image/right/${model.modelName}" class="d-block w-100" alt="Right View">
                    </div>
                </div>
                <button class="carousel-control-prev" type="button" data-bs-target="#bikeCarousel" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#bikeCarousel" data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                </button>
            </div>
        </div>

        <!-- Bike Info -->
        <div class="col-lg-6">
            <div class="bike-details">
                <h1 class="bike-heading">${model.modelName}</h1>
                <p><strong>Engine:</strong> ${model.engine}</p>
                <p><strong>Power:</strong> ${model.power}</p>
                <p><strong>Torque:</strong> ${model.torque}</p>
                <p><strong>Mileage:</strong> ${model.mileage}</p>
                <p><strong>Price:</strong> ₹${model.price}</p>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
