<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <title>Showrooms | Royal Enfield</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            background: linear-gradient(135deg, #ece9e6, #ffffff);
            min-height: 100vh;
            margin: 0;
            padding-top: 80px;
        }

        .navbar {
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .card {
            margin-bottom: 30px;
            border: none;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.2);
        }

        .card-img-top {
            height: 250px;
            object-fit: cover;
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
        }

        .card-body {
            text-align: center;
        }

        .btn-custom {
            background-color: #dc3545;
            color: #fff;
            border-radius: 30px;
            padding: 10px 30px;
            font-size: 16px;
            font-weight: 600;
            transition: background-color 0.3s ease;
        }

        .btn-custom:hover {
            background-color: #b02a37;
        }

        h2 {
            font-weight: 700;
            margin-bottom: 40px;
            color: #212529;
        }

        .container-custom {
            padding: 40px 0;
        }
    </style>
</head>

<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
  <div class="container">
    <a class="navbar-brand" href="#">
      <img src="https://www.royalenfield.com/content/dam/royal-enfield/india/logos/logo.svg" alt="Royal Enfield" width="200" height="40">
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
      aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
  </div>
</nav>

<!-- Showrooms Section -->
<div class="container container-custom">
    <h2 class="text-center">Available Showrooms</h2>
    <div class="row justify-content-center">
        <c:forEach var="showroom" items="${showrooms}">
            <div class="col-lg-4 col-md-6 col-sm-12 d-flex align-items-stretch">
                <div class="card">
                    <img src="https://www.royalenfield.com/content/dam/royal-enfield/india/locate-us/landing/dealer-detail.jpg" class="card-img-top" alt="Showroom Image">
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
