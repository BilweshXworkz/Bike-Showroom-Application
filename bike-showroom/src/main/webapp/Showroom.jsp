<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <title>Showrooms | Royal Enfield</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&family=Roboto+Slab:wght@400;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            background: #f8f8f8;
            padding-top: 80px;
        }

        .navbar {
            background-color: #000;
            padding: 0.75rem 2rem;
        }

        .navbar-brand img {
            width: 180px;
        }

        .navbar-nav .nav-link {
            color: #fff;
            font-weight: 600;
            margin: 0 10px;
            padding: 10px 20px;
            transition: 0.3s ease;
        }

        .navbar-nav .nav-link:hover,
        .navbar-nav .nav-link.active {
            background-color: #c00;
            border-radius: 25px;
        }

        h2 {
            font-weight: 700;
            margin-bottom: 40px;
            color: #212529;
            font-family: 'Roboto Slab', serif;
        }

        .container-custom {
            padding: 60px 0;
        }

        .card {
            border: none;
            border-radius: 15px;
            background-color: #fff;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
        }

        .card:hover {
            transform: scale(1.03);
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.15);
        }

        .card-img-top {
            height: 230px;
            object-fit: cover;
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
        }

        .card-body {
            padding: 25px;
            text-align: center;
        }

        .card-title {
            font-size: 20px;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .card-text {
            color: #555;
        }

        .btn-custom {
            background-color: #c00;
            color: #fff;
            border-radius: 50px;
            font-weight: 600;
            padding: 10px 25px;
            text-transform: uppercase;
            transition: background-color 0.3s ease;
        }

        .btn-custom:hover {
            background-color: #a00;
        }

        @media (max-width: 768px) {
            .card-img-top {
                height: 180px;
            }
        }
    </style>
</head>

<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">
            <img src="https://www.royalenfield.com/content/dam/royal-enfield/india/logos/logo.svg" alt="Royal Enfield Logo">
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-center" id="navbarSupportedContent">
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link" href="GoAddShowroom">Register Showroom</a></li>
                <li class="nav-item"><a class="nav-link" href="GoAddBike">Register Bike</a></li>
                <li class="nav-item"><a class="nav-link" href="bikeToShowroom">Assign Bike</a></li>
                <li class="nav-item"><a class="nav-link" href="user">New Customer</a></li>
                <li class="nav-item"><a class="nav-link" href="userForm">Customer Details</a></li>
                <li class="nav-item"><a class="nav-link active" href="explore">Showroom</a></li>
                <li class="nav-item"><a class="nav-link" href="exploreBike">Bikes</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Showrooms Section -->
<div class="container container-custom">
    <h2 class="text-center">Explore Our Premium Showrooms</h2>
    <div class="row justify-content-center">
        <c:forEach var="showroom" items="${showrooms}">
            <div class="col-lg-4 col-md-6 col-sm-12 d-flex align-items-stretch mb-4">
                <div class="card">
                    <img src="https://www.royalenfield.com/content/dam/royal-enfield/india/locate-us/landing/dealer-detail.jpg" class="card-img-top" alt="Showroom">
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title">${showroom.showroomName}</h5>
                        <p class="card-text">${showroom.location}</p>
                        <p class="card-text"><strong>Contact:</strong> ${showroom.contact}</p>
                        <p class="card-text"><strong>Email:</strong> ${showroom.email}</p>
                        <a href="exploreShowroomBikesUser?showroomName=${showroom.showroomName}" class="btn btn-custom mt-auto">Explore Bikes</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
