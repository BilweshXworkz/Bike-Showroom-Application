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
            min-height: 400px;
            padding: 20px;
            font-size: 18px;
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

        .custom-btn {
            width: 200px;
            font-size: 25px;
            font-weight: 600px;
        }

        #datetimeContainer {
            display: none;
          }
    </style>

</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
      <div class="container-fluid">
        <a class="navbar-brand" href="#">
          <img src="https://www.royalenfield.com/content/dam/royal-enfield/india/logos/logo.svg" alt="Royal Enfield Logo" class="me-2">
        </a>
        <!-- Toggler button -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
          aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <!-- Collapsible content -->
        <div class="collapse navbar-collapse justify-content-center" id="navbarSupportedContent">
          <ul class="nav justify-content-center mb-3 mb-lg-0">
            <li class="nav-item">
              <a class="nav-link active" aria-current="page" href="GoAddShowroom">Register Showroom</a>
            </li>
            <li class="nav-item">
              <a class="nav-link active" aria-current="page" href="GoAddBike">Register Bike</a>
            </li>
            <li class="nav-item">
              <a class="nav-link active" aria-current="page" href="bikeToShowroom">Assign Bike to Showroom</a>
            </li>
            <li class="nav-item">
              <a class="nav-link active" aria-current="page" href="user">New Customer Registration</a>
            </li>
            <li class="nav-item">
              <a class="nav-link active" aria-current="page" href="userForm">Customer Details Form</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" aria-current="page" href="explore">Showroom</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" aria-current="page" href="exploreBike">Bikes</a>
            </li>
          </ul>
        </div>
      </div>
    </nav>

    <div class="d-flex justify-content-center align-items-center vh-50 mt-5">
        <div class="form-container">
            <h2 class="text-center mb-4" style="color: black; font-weight: bold;">Customer Registration</h2>
            <form action="addCustomer" method="post">
            <c:if test="${not empty error}">
                <div class="alert alert-danger text-center">${error}</div>
            </c:if>

            <c:if test="${not empty success}">
                <div class="alert alert-success text-center">${success}</div>
            </c:if>
                <div class="row">
                    <div class="mb-3 col-md-6">
                        <label class="form-label">Full Name</label>
                        <input type="text" class="form-control" name="fullName" id="fullName" onChange="onName()" required>
                        <small id="nameError" style="color: white;"></small>
                        <small id="displayName"  style="color: white;"></small>
                    </div>
                    <div class="mb-3 col-md-6">
                        <label class="form-label">Age</label>
                        <input type="text" class="form-control" name="age" id="age" onChange="validateAge()" required>
                        <small id="ageError" style="color: white;"></small>
                    </div>
                    <div class="mb-3 col-md-6">
                        <label class="form-label">Phone Number</label>
                        <input type="text" class="form-control" name="phoneNumber" id="phoneNumber" onChange="onPhone()" required>
                        <small id="phoneError" style="color: white;"></small>
                        <small id="displayPhone"  style="color: white;"></small>
                    </div>
                    <div class="mb-3 col-md-6">
                        <label class="form-label">Email Id</label>
                        <input type="text" class="form-control" name="emailId" id="emailId" onChange="onEmail()" required>
                        <small id="emailError" style="color: white;"></small>
                        <small id="displayEmail"  style="color: white;"></small>
                    </div>
                    <div class="mb-3 col-md-6">
                        <label class="form-label">Address</label>
                        <input type="text" class="form-control" name="Address" required>
                    </div>
                    <div class="mb-3 col-md-6">
                        <label class="form-label">Driving License</label>
                        <input type="text" class="form-control" name="dlNumber" required>
                    </div>

                    <div class="mb-3 col-md-6">
                        <label class="form-label">Showroom Name</label>
                        <select name="showroomName" class="form-control" required id="showroomSelect">
                            <option value="" selected disabled>Select Showroom </option>
                            <c:forEach var="showroom" items="${showroomList}">
                                <option value="${showroom}">${showroom}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-3 col-md-6">
                        <label class="form-label">Bike Model</label>
                        <select class="form-control" name="modelName" required id="bikeModelSelect">
                            <option value="">Select Model</option>
                        </select>
                    </div>
                    <div class="mb-3 col-md-6">
                    <label class="form-label">DOB</label>
                        <input type="date" id="date" name="date" class="form-control">
                        <small id="dobError" class="text-danger"></small>
                    </div>
                    <div class="mb-3 col-md-6">
                        <label class="form-label">Schedule</label>
                        <select id="scheduleSelect" name="scheduleTask" class="form-control" required onchange="updateButtonText()">
                            <option value="" selected disabled>-- Choose Your Ride --</option>
                            <option value="0">Schedule Test Ride</option>
                            <option value="1">Booking</option>
                        </select>
                    </div>
                    <div class="mb-3 col-md-6" id="datetimeContainer">
                        <label class="form-label" id="dateTimeLabel">Date and Time</label>
                        <input type="datetime-local" class="form-control" name="dateTime" id="reasonInput">
                    </div>
                    <div class="mb-3 col-md-6" id="datetimeContainer">
                        <label class="form-label">Reason</label>
                        <input type="datetime-local" class="form-control" name="reason" id="reasonInput">
                    </div>
                </div>
                <button type="submit" id="actionButton" class="btn btn-danger no-rounded float-end custom-btn">Add</button>
            </form>
        </div>
    </div>

    <script>
        function onName() {
            var name = document.getElementById('fullName');
                var nameValue = name.value.trim();

                var xhttp = new XMLHttpRequest();
                if (nameValue !== "") {
                    xhttp.open("GET", "http://localhost:8080/bike-showroom/userRegistration" + encodeURIComponent(nameValue), true);
                    xhttp.send();

                xhttp.onload = function () {
                    if (this.status === 200) {
                        console.log(this.responseText);
                        document.getElementById("displayName").innerText = this.responseText;
                    } else {
                        console.error("Error fetching name validation.");
                    }
                };
            }
        }

        function updateButtonText() {
            const select = document.getElementById("scheduleSelect");
            const button = document.getElementById("actionButton");
            const reasonInput = document.getElementById("reasonInput");
            const dateTimeContainer = document.getElementById("datetimeContainer");

            const selectedValue = select.value;

            if (selectedValue === "0") { // Test Ride
                button.textContent = "Test Ride";
                dateTimeContainer.style.display = "block";
                reasonInput.required = true;
                dateTimeLabel.textContent = "Date and Time";
            } else if (selectedValue === "1") { // Booking
                button.textContent = "Book Ride";
                dateTimeContainer.style.display = "block";
                reasonInput.required = false;
                dateTimeLabel.textContent = "Delivery Date Time";
            } else {
                button.textContent = "Add";
                dateTimeContainer.style.display = "none";
                reasonInput.required = false;
            }
        }

         document.getElementById("showroomSelect").addEventListener("change", function () {
                 const showroomName = this.value;
                 fetch("getBikesByShowroomName?showroomName=" + encodeURIComponent(showroomName))
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

         function onName() {
             var name = document.getElementById('fullName');
             var nameValue = name.value.trim();

             var xhttp = new XMLHttpRequest();
             if (nameValue !== "") {
                 xhttp.open("GET", "http://localhost:8080/bike-showroom/fullName/" + encodeURIComponent(nameValue), true);
                 xhttp.send();

                 xhttp.onload = function() {
                     if (this.status === 200) {
                         document.getElementById("displayName").innerText = this.responseText;
                     } else {
                         console.error("Error fetching name validation.");
                     }
                 };
             }
         }

         function onPhone() {
             var phone = document.getElementById('phoneNumber');
                var phoneValue = phone.value.trim();

                var xhttp = new XMLHttpRequest();
                if (phoneValue !== "") {
                    xhttp.open("GET", "http://localhost:8080/bike-showroom/phoneNumber/" + encodeURIComponent(phoneValue), true);
                    xhttp.send();

                if (!/^\d{10}$/.test(phoneValue)) {
                    document.getElementById("phoneError").innerText = "Invalid phone number format";
                    return;
                }

                xhttp.onload = function() {
                    if (this.status === 200) {
                         let response = JSON.parse(this.responseText);
                        document.getElementById("displayPhone").innerText = this.responseText;
                    } else {
                        console.error("Error fetching phone validation.");
                    }
                };
            }
         }

         function onEmail() {
            var email = document.getElementById('emailId');
            var emailValue = email.value.trim();

            var xhttp = new XMLHttpRequest();
            if (emailValue !== "") {
                xhttp.open("GET", "http://localhost:8080/bike-showroom/emailId/" + encodeURIComponent(emailValue), true);
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

         function validateAge() {
             const ageInput = document.getElementById("age");
             const ageError = document.getElementById("ageError");
             const age = parseInt(ageInput.value.trim());

             if (isNaN(age) || age < 18) {
                 ageError.innerText = "Age must be 18 or above to proceed.";
                 ageInput.setCustomValidity("Invalid age");
             } else {
                 ageError.innerText = "";
                 ageInput.setCustomValidity(""); // Reset validity
             }
         }


    </script>
</body>
</html>
