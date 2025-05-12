<%@ page language="java" contentType="text/html; charset=US-ASCII" pageEncoding="US-ASCII"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Reset Password</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f0f2f5;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            margin: 0;
            padding: 0;
            height: 100vh;
            background: url('resources/images/image8.jpg') no-repeat center center fixed;
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

        .btn-custom-primary {
            background-color: #007bff;
            color: white;
            font-weight: 600;
            border-radius: 8px;
            transition: background-color 0.3s ease;

        }

        .btn-custom-primary:hover {
            background-color: #0056b3;
        }

        .btn-custom-success {
            background-color: #28a745;
            color: white;
            font-weight: 600;
            border-radius: 8px;
            transition: background-color 0.3s ease;
        }

        .btn-custom-success:hover {
            background-color: #1e7e34;
        }

        #timer {
            font-size: 1.2rem;
            font-weight: 600;
        }

        hr {
            margin: 30px 0;
            border-top: 1px solid #dee2e6;
        }
    </style>
</head>
<body>

<div class="custom-card">
    <div class="text-center mb-4">
        <h3 class="fw-bold">Reset Password</h3>
    </div>

   <form action="updatePassword" method="post">
       <div class="mb-3 text-start">
           <label for="emailId" class="form-label">Email ID</label>
           <input type="email" id="emailId" name="emailId" class="form-control" required placeholder="Enter your email" onblur="onEmail()">
           <small id="emailError" style="color: white;"></small>
           <small id="displayEmail"  style="color: red;"></small>
       </div>

       <div class="mb-3 text-start">
           <label for="newPassword" class="form-label">New Password</label>
           <input type="password" id="newPassword" name="newPassword" class="form-control" required placeholder="Enter new password">
       </div>

       <div class="mb-3 text-start">
            <label class="form-label">Confirm Password</label>
            <input type="password" name="confirmPassword" class="form-control" required placeholder="Enter new password">
       </div>

       <div class="d-grid gap-2">
           <button type="submit" class="btn btn-custom-success">Reset Password</button>
       </div>
   </form>

    <!-- Display Messages -->
    <c:if test="${not empty message}">
        <div class="alert alert-success mt-4 text-center" role="alert">
            ${message}
        </div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-danger mt-4 text-center" role="alert">
            ${error}
        </div>
    </c:if>
</div>

<script>
     function onEmail() {
        var email = document.getElementById('emailId');
        var emailValue = email.value.trim();

        var xhttp = new XMLHttpRequest();
        if (emailValue !== "") {
            xhttp.open("GET", "http://localhost:8080/bike-showroom/forgotPassword/emailId/" + encodeURIComponent(emailValue), true);
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
