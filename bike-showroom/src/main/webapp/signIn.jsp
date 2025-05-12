<%@ page language="java" contentType="text/html; charset=US-ASCII" pageEncoding="US-ASCII"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>X-Workz | User Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
         body {
             margin: 0;
             padding: 0;
             height: 100vh;
             background: url('resources/images/image12.png') no-repeat center center fixed;
             background-size: cover;
         }

        .custom-card {
            width: 100%;
            max-width: 450px;
            padding: 30px;
            margin: auto;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            margin-top: 50px;
            background: rgba(255, 255, 255, 0.3);
            backdrop-filter: blur(10px);
            color: black;
        }

        .navbar-brand img {
            height: 50px;
        }

        .btn-custom {
            font-weight: 600;
            border-radius: 8px;
        }

        .form-label {
            font-weight: 500;
            margin-top: 10px;
        }

        .form-control {
            border-radius: 8px;
        }

        .card-title {
            font-weight: 700;
            margin-bottom: 20px;
        }

        .submit-btn {
            font-weight: 600;
            border-radius: 8px;
            padding: 10px;
        }

        .captcha-container {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-top: 10px;
        }

        .refresh-btn {
            padding: 6px 12px;
            font-size: 14px;
            border-radius: 6px;
            background-color: green;
            color: #fff;
            border: none;
            transition: background-color 0.3s;
        }

        .refresh-btn:hover {
            background-color: green;
        }

        .forgot-link {
            display: block;
            text-align: right;
            margin-top: 10px;
            font-size: 14px;
            color: black;
            text-decoration: none;
        }

        .forgot-link:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>

<nav class="navbar navbar-dark bg-dark">
    <div class="container d-flex justify-content-between align-items-center">
        <a class="navbar-brand" href="#">
            <img src="https://www.royalenfield.com/content/dam/royal-enfield/india/logos/logo.svg" alt="Royal Enfield Logo">
        </a>
        <div class="d-flex">
            <a class="btn btn-outline-primary btn-lg btn-custom" href="signup">Sign Up</a>
        </div>
    </div>
</nav>

<div class="custom-card">
    <div class="card-body">
        <h4 class="card-title text-center">User Login</h4>

        <form action="login" method="post">
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger" role="alert">
                    ${errorMessage}
                </div>
            </c:if>

            <div class="mb-3">
                <label for="emailId" class="form-label">Email ID</label>
                <input type="email" id="emailId" name="emailId" class="form-control" required placeholder="Enter your email" onblur="onEmail()">
                <small id="emailError" style="color: white;"></small>
               <small id="displayEmail"  style="color: red;"></small>
            </div>

            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" id="password" name="password" class="form-control" required placeholder="Enter your password">
            </div>

            <div class="mb-3">
                <label class="form-label">CAPTCHA</label>
                <div class="captcha-container">
                    <img id="captchaImage" src="generateCaptcha" alt="CAPTCHA" style="height: 45px;">
                    <button type="button" class="refresh-btn" onclick="refreshCaptcha()">Refresh</button>
                </div>
                <input type="text" name="captchaInput" class="form-control mt-2" required placeholder="Enter CAPTCHA text">
            </div>

            <div class="d-grid mt-4">
                <button type="submit" style="background-color: green;" class="btn btn-success submit-btn">Sign In</button>
            </div>

            <a href="forgotPassword"  class="forgot-link">Forgot Password?</a>
        </form>
    </div>
</div>

<script>
    function refreshCaptcha() {
        document.getElementById("captchaImage").src = "generateCaptcha?" + new Date().getTime();
    }

    function onEmail() {
            var email = document.getElementById('emailId').value.trim();
            if (email !== "") {
                var xhttp = new XMLHttpRequest();
                xhttp.open("GET", "http://localhost:8080/bike-showroom/signin/" + encodeURIComponent(email), true);
                xhttp.send();

                xhttp.onload = function () {
                    if (this.status === 200) {
                        document.getElementById("displayEmail").innerText = this.responseText;
                    } else {
                        console.error("Error while checking email.");
                    }
                };
            }
        }

</script>

</body>
</html>
