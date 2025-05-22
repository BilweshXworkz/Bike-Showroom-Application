<%@ page language="java" contentType="text/html; charset=US-ASCII" pageEncoding="US-ASCII" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            margin: 0;
            padding: 0;
            height: 100vh;
            background: url('resources/images/image9.jpeg') no-repeat center center fixed;
            background-size: cover;
            color: #fff;
        }
        .navbar { background-color: #343a40; }
        .form-container {
            background: rgba(0, 0, 0, 0.5);
            border-radius: 10px;
            padding: 30px;
            width: 50%;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.5);
        }
        .form-container h2 { text-align: center; font-weight: bold; margin-bottom: 30px; }
        .form-label { font-weight: 600; font-size: 18px; }
        .form-control { border-radius: 8px; padding: 12px; font-size: 16px; }
        .btn-custom {
            width: 200px;
            background-color: #d9534f;
            color: white;
            font-weight: bold;
            font-size: 18px;
            border-radius: 8px;
            padding: 12px;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .btn-custom:hover { background-color: #c9302c; }
        .alert { text-align: center; margin-bottom: 20px; }
        small { color: #d9534f; }
    </style>
</head>

<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">
            <img src="https://www.royalenfield.com/content/dam/royal-enfield/india/logos/logo.svg" alt="" width="200" height="40">
        </a>
    </div>
</nav>

<div class="d-flex justify-content-center align-items-center vh-100 mt-5">
    <div class="form-container">
        <h2>Edit Profile</h2>
        <form action="updateProfile" method="post" enctype="multipart/form-data">
            <div class="row">
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>
                <c:if test="${not empty success}">
                    <div class="alert alert-success">${success}</div>
                </c:if>

               <div class="col-md-6 mb-3">
                   <label class="form-label">Profile Pic</label>
                   <input type="file" class="form-control" name="updateProfile" accept="image/*" >
               </div>

                <div class="mb-3 col-md-6">
                    <label class="form-label">Full Name</label>
                    <input type="text" class="form-control" name="fullName" id="fullName" value="${user.fullName}" onchange="onName()" required>
                    <small id="nameError"></small>
                </div>

                <div class="mb-3 col-md-6">
                    <label class="form-label">Age</label>
                    <input type="text" class="form-control" name="age" id="age" value="${user.age}" onchange="validateAge()" required>
                    <small id="ageError"></small>
                </div>

                <div class="mb-3 col-md-6">
                    <label class="form-label">Phone Number</label>
                    <input type="text" class="form-control" name="phoneNumber" id="phoneNumber" value="${user.phoneNumber}" onchange="onPhone()" required>
                    <small id="phoneError"></small>
                </div>

                <div class="mb-3 col-md-6">
                    <label class="form-label">Email Id</label>
                    <input type="email" class="form-control" name="emailId" id="emailId" value="${user.emailId}" onchange="onEmail()" required>
                    <small id="emailError"></small>
                </div>

                <div class="mb-3 col-md-6">
                    <label class="form-label">Address</label>
                    <input type="text" class="form-control" name="address" value="${user.address}" required>
                </div>

                <div class="mb-3 col-md-6">
                    <label class="form-label">Driving License</label>
                    <input type="text" class="form-control" name="dlNumber" value="${user.dlNumber}" required>
                </div>

                <div class="mb-3 col-md-6">
                    <label class="form-label">Showroom Name</label>
                    <select name="showroomName" class="form-control" id="showroomSelect">
                        <option value="" selected disabled>- Select Showroom -</option>
                        <c:forEach var="showroom" items="${showroomList}">
                            <option value="${showroom}">${showroom}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="mb-3 col-md-6">
                    <label class="form-label">Bike Model</label>
                    <select class="form-control" name="modelName" id="bikeModelSelect">
                        <option value="">Select Model</option>
                        <!-- Optionally you can pre-load current selected model if needed -->
                    </select>
                </div>

            </div>

            <div class="text-center">
                <button type="submit" class="btn-custom mt-3">Save</button>
            </div>
        </form>
    </div>
</div>

<script>
    function onName() {
        const name = document.getElementById('fullName').value.trim();
        if (name !== "") {
            fetch("http://localhost:8080/bike-showroom/fullName/" + encodeURIComponent(name))
            .then(response => response.text())
            .then(data => {
                document.getElementById("nameError").innerText = data;
            }).catch(err => console.error(err));
        }
    }

    function onPhone() {
        const phone = document.getElementById('phoneNumber').value.trim();
        if (phone !== "") {
            if (!/^\d{10}$/.test(phone)) {
                document.getElementById("phoneError").innerText = "Invalid phone number format";
                return;
            }
            fetch("http://localhost:8080/bike-showroom/phoneNumber/" + encodeURIComponent(phone))
            .then(response => response.text())
            .then(data => {
                document.getElementById("phoneError").innerText = data;
            }).catch(err => console.error(err));
        }
    }

    function onEmail() {
        const email = document.getElementById('emailId').value.trim();
        if (email !== "") {
            fetch("http://localhost:8080/bike-showroom/emailId/" + encodeURIComponent(email))
            .then(response => response.text())
            .then(data => {
                document.getElementById("emailError").innerText = data;
            }).catch(err => console.error(err));
        }
    }

    function validateAge() {
        const ageInput = document.getElementById("age");
        const ageError = document.getElementById("ageError");
        const age = parseInt(ageInput.value.trim());
        if (isNaN(age) || age < 18) {
            ageError.innerText = "Age must be 18 or above to proceed.";
            ageInput.setCustomValidity("Invalid age");
        } else {
            ageError.innerText = "";
            ageInput.setCustomValidity("");
        }
    }

   document.getElementById("showroomSelect").addEventListener("change", function () {
                    const showroomName = this.value;
                    fetch("/bike-showroom/getBikesByShowroomName?showroomName=" + encodeURIComponent(showroomName))
                        .then(response => response.json())
                        .then(data => {
                            const modelDropdown = document.getElementById("bikeModelSelect");
                            modelDropdown.innerHTML = '<option value="">Select Model</option>';
                            data.forEach(model => {
                                const option = document.createElement("option");
                                option.value = model;
                                option.textContent = model;
                                modelDropdown.appendChild(option);
                            });
                        })
                        .catch(err => {
                            console.error("Error loading bike models:", err);
                            alert("Failed to load bike models.");
                        });
                });

</script>

</body>
</html>
