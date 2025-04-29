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
            padding: 20px;
            border-radius: 15px;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(5px);
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
        <h2 class="text-center mb-4" style="color: black;">Register Showroom</h2>
        <form action="addShowroom" method="post">
        <c:if test="${not empty error}">
            <div class="alert alert-danger text-center">${error}</div>
        </c:if>

        <c:if test="${not empty success}">
            <div class="alert alert-success text-center">${success}</div>
        </c:if>
            <div class="mb-3">
                <label class="form-label">Showroom Name</label>
                <input type="text" class="form-control" name="showroomName" id="showroomName" onChange="onShowroomName()" required>
                <small id="showroomName" style="color: red;"></small>
                <small id="displayShowroom"  style="color: red;"></small>
            </div>
            <div class="mb-3">
                <label class="form-label">Location</label>
                <input type="text" class="form-control" name="location" id="location" onChange="onLocation()" required>
                <small id="locationError" style="color: red;"></small>
                <small id="displaylocation"  style="color: red;"></small>
            </div>
            <div class="mb-3">
                <label class="form-label">Contact Number</label>
                <input type="text" class="form-control" name="contact" id="contact" OnChange="onPhone()" required>
                <small id="phoneError" style="color: red;"></small>
                <small id="displayPhone"  style="color: red;"></small>
            </div>
            <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="email" class="form-control" name="email" id="email" onChange="onEmail()" required>
                <small id="email" style="color: white;"></small>
                <small id="displayEmail"  style="color: white;"></small>
            </div class="text-end">
            <button type="submit" class="btn btn-danger w-60 float-end custom-btn">Add Showroom</button>
        </form>
    </div>
</div>

<script>
    function onShowroomName() {
        var showroom = document.getElementById('showroomName');
        var showroomValue = showroom.value.trim();

        var xhttp = new XMLHttpRequest();
        if (showroomValue !== "") {
            xhttp.open("GET", "http://localhost:8080/bike-showroom/showroomName/" + encodeURIComponent(showroomValue), true);
            xhttp.send();

            xhttp.onload = function() {
                if (this.status === 200) {
                    document.getElementById("displayShowroom").innerText = this.responseText;
                } else {
                    console.error("Error fetching showroomName validation.");
                }
            };
        }
    }

    function onLocation() {
        var location = document.getElementById('location');
        var locationValue = location.value.trim();

        var xhttp = new XMLHttpRequest();
        if (locationValue !== "") {
            xhttp.open("GET", "http://localhost:8080/bike-showroom/location/" + encodeURIComponent(locationValue), true);
            xhttp.send();

            xhttp.onload = function() {
                if (this.status === 200) {
                    document.getElementById("displaylocation").innerText = this.responseText;
                } else {
                    console.error("Error fetching location validation.");
                }
            };
        }
    }

    function onPhone() {
        var contact = document.getElementById('contact');
        var contactValue = contact.value.trim();

        if (!/^\d{10}$/.test(contactValue)) {
            document.getElementById("phoneError").innerText = "Invalid phone number format";
            return;
        } else {
            document.getElementById("phoneError").innerText = "";
        }

        var xhttp = new XMLHttpRequest();
        if (contactValue !== "") {
            xhttp.open("GET", "http://localhost:8080/bike-showroom/contact/" + encodeURIComponent(contactValue), true);
            xhttp.send();

            xhttp.onload = function () {
                if (this.status === 200) {
                    console.log("The number exists")
                    document.getElementById("displayPhone").innerText = this.responseText;
                } else {
                    console.error("Error fetching phone validation.");
                }
            };
        }
    }

    function onEmail() {
        var email = document.getElementById('email');
        var emailValue = email.value.trim();

        var xhttp = new XMLHttpRequest();
        if (emailValue !== "") {
            xhttp.open("GET", "http://localhost:8080/bike-showroom/email/" + encodeURIComponent(emailValue), true);
            xhttp.send();

            xhttp.onload = function() {
                if (this.status === 200) {
                    document.getElementById("displayEmail").innerText = this.responseText;
                } else {
                    console.error("Error fetching email validation.");
                }
            };
        }
     }
</script>

</body>
</html>
