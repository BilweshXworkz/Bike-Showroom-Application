<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bike Details</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            height: 100vh;
            background: url('resources/images/image9.jpeg') no-repeat center center fixed;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #ece9e6, #ffffff);
        }

        .bike-carousel img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 10px;
        }

        .bike-details {
            background: rgba(0, 0, 0, 0.7);
            color: white;
            padding: 30px;
            border-radius: 10px;
            margin-top: 20px;
        }

        .container-custom {
            margin-top: 80px;
        }

        .bike-heading {
            font-size: 36px;
            font-weight: bold;
            margin-bottom: 20px;
            color: #dc3545;
        }
    </style>
</head>

<body>

    <!-- Navbar -->
    <nav class="navbar navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="#">
                    <img src="https://www.royalenfield.com/content/dam/royal-enfield/india/logos/logo.svg" alt="" width="200" height="40">
                </a>
            </div>
        </nav>


    <div class="container container-custom">
        <div class="row">
            <div class="col-md-6 d-flex align-items-center">
                <div id="bikeCarousel" class="carousel slide bike-carousel w-100" data-bs-ride="carousel">
                    <div class="carousel-inner">
                         <div class="carousel-item active">
                             <img src="${pageContext.request.contextPath}/bike-image/${model.frontImage}" class="d-block w-100" alt="Front Bike Image">
                         </div>
                        <div class="carousel-item">
                            <img src="${pageContext.request.contextPath}/bike-image/${model.backImage}" class="d-block w-100" alt="Back Bike Image">
                        </div>
                        <div class="carousel-item">
                            <img src="${pageContext.request.contextPath}/bike-image/${model.rightImage}" class="d-block w-100" alt="Right Bike Image">
                        </div>
                        <div class="carousel-item">
                            <img src="${pageContext.request.contextPath}/bike-image/${model.leftImage}" class="d-block w-100" alt="Left Bike Image">
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-6">
                <div class="bike-details">
                    <h1 class="bike-heading">Royal Enfield ${model.modelName}</h1>
                    <p><strong>Engine:</strong> ${model.engine}</p>
                    <p><strong>Power:</strong> ${model.power} </p>
                    <p><strong>Torque:</strong> ${model.torque}</p>
                    <p><strong>Mileage:</strong> ${model.mileage}</p>
                    <p><strong>Price:</strong> ${model.price}</p>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        // Auto-slide every 2 seconds (2000 ms)
        var myCarousel = document.querySelector('#bikeCarousel');
        var carousel = new bootstrap.Carousel(myCarousel, {
            interval: 2000,
            ride: 'carousel'
        });
    </script>

</body>
</html>

