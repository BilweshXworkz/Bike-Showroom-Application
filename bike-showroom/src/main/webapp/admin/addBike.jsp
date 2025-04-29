<%@ page language="java" contentType="text/html; charset=US-ASCII" pageEncoding="US-ASCII" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register Bike - Bike Showroom</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            margin: 0;
            padding: 0;
            height: 100vh;
            background: url('resources/images/image9.jpeg') no-repeat center center fixed;
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
            width: 50%;
            min-height: 500px;
            padding: 30px;
            border-radius: 15px;
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(10px);
            color: white;
            box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.3);
        }

        .form-container .form-label, h2, label, select, input, button {
            font-family: 'Montserrat', sans-serif;
        }

        .form-container .form-label {
            color: white;
            font-size: 20px;
            font-weight: 600;
        }

        h2 {
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: #fff;
        }

        .custom-btn {
            width: 200px;
            font-size: 20px;
            font-weight: 600;
            background-color: #D9534F;
            border: none;
            transition: background-color 0.3s ease;
        }

        .custom-btn:hover {
            background-color: #C9302C;
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

<div class="d-flex justify-content-center align-items-center" style="min-height: 100vh; padding-top: 120px;">
    <div class="form-container">
        <h2 class="text-center mb-4">Register Bike</h2>
        <form action="addBike" method="post" enctype="multipart/form-data">
            <c:if test="${not empty error}">
                <div class="alert alert-danger text-center">${error}</div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="alert alert-success text-center">${success}</div>
            </c:if>
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Model Name</label>
                    <input type="text" class="form-control" name="modelName" id="modelName" onChange="onModel()" required>
                    <small id="modelError" class="text-warning"></small>
                    <small id="displaymodel" class="text-warning"></small>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Engine</label>
                    <input type="text" class="form-control" name="engine" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Price</label>
                    <input type="text" class="form-control" name="price" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Torque</label>
                    <input type="text" class="form-control" name="torque" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Brakes</label>
                    <input type="text" class="form-control" name="brakes" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Power</label>
                    <input type="text" class="form-control" name="power" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Mileage</label>
                    <input type="text" class="form-control" name="mileage" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Tyre Type</label>
                    <input type="text" class="form-control" name="tyreType" required>
                </div>

                <div class="col-12 mb-3">
                    <label class="form-label">Colours</label>
                    <div id="colorContainer">
                        <input type="text" class="form-control mb-2" name="bikeColours" required>
                    </div>
                    <button type="button" class="btn btn-sm btn-outline-light mt-1" onclick="addColorInput()">+ Add More</button>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Front Image</label>
                    <input type="file" class="form-control" name="frontImage" accept="image/*" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Back Image</label>
                    <input type="file" class="form-control" name="backImage" accept="image/*" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Right Image</label>
                    <input type="file" class="form-control" name="rightImage" accept="image/*" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Left Image</label>
                    <input type="file" class="form-control" name="leftImage" accept="image/*" required>
                </div>
            </div>

            <div class="text-end">
                <button type="submit" class="btn custom-btn px-4">Add Bike</button>
            </div>
        </form>
    </div>
</div>

<script>
    function addColorInput() {
        let container = document.getElementById("colorContainer");
        let input = document.createElement("input");
        input.type = "text";
        input.name = "bikeColours";
        input.className = "form-control mb-2";
        input.required = true;
        container.appendChild(input);
    }

    function onModel() {
        var model = document.getElementById('modelName');
        var modelValue = model.value.trim();

        var xhttp = new XMLHttpRequest();
        if (modelValue !== "") {
            xhttp.open("GET", "http://localhost:8080/bike-showroom/modelName/" + encodeURIComponent(modelValue), true);
            xhttp.send();

            xhttp.onload = function() {
                if (this.status === 200) {
                    document.getElementById("displaymodel").innerText = this.responseText;
                } else {
                    console.error("Error fetching model validation.");
                }
            };
        }
    }
</script>
</body>
</html>
