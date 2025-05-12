<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Available Bikes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Poppins&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;

            background-size: cover;
            margin: 0;
            padding: 0;
            color: #2c2c2c;
        }

        .navbar {
            background-color: #1a1a1a !important;
        }

        .navbar-brand img {
            height: 40px;
        }

        h2.section-title {
            font-family: 'Playfair Display', serif;
            font-weight: bold;
            font-size: 38px;
            letter-spacing: 2px;
            color: #a67c00;
            text-transform: uppercase;
            margin-bottom: 50px;
            text-shadow: 1px 1px 1px rgba(0,0,0,0.4);
        }

        .card {
            border-radius: 12px;
            overflow: hidden;
            border: none;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            background-color: #fff5e6;
        }

        .card:hover {
            transform: scale(1.02);
            transition: transform 0.3s ease-in-out;
        }

        .card-img-top {
            height: 220px;
            object-fit: cover;
        }

        .card-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.3rem;
            color: #1a1a1a;
        }

        .card-text {
            font-size: 1rem;
            color: #333;
        }

        .btn-explore {
            background-color: #800000;
            color: #fff;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.3s ease-in-out;
        }

        .btn-explore:hover {
            background-color: #a30000;
        }

        @media (max-width: 767px) {
            .card-img-top {
                height: 180px;
            }

            h2.section-title {
                font-size: 28px;
            }
        }

        .container {
            padding-top: 100px;
            padding-bottom: 60px;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">
            <img src="https://www.royalenfield.com/content/dam/royal-enfield/india/logos/logo.svg" alt="Royal Enfield Logo">
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
    </div>
</nav>

<div class="container">
    <h2 class="text-center section-title">Explore Our Available Bikes</h2>

    <div class="row">
        <c:forEach var="bike" items="${bikes}">
            <div class="col-md-6 col-lg-4 d-flex mb-4">
                <div class="card w-100">
                    <img src="${pageContext.request.contextPath}/images/${bike.rightImage}" class="card-img-top" alt="Bike Image">
                    <div class="card-body d-flex flex-column justify-content-between">
                        <h5 class="card-title">${bike.modelName}</h5>
                        <p class="card-text"><strong>Engine:</strong> ${bike.engine}</p>
                        <p class="card-text"><strong>Price:</strong> ₹${bike.price}</p>
                        <a href="exploreBikes?modelName=${bike.modelName}" class="btn btn-explore mt-3">Explore Bikes</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
