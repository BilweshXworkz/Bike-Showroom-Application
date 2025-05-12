<%@ page language="java" contentType="text/html; charset=US-ASCII"
        pageEncoding="US-ASCII"%>
 <%@ page isELIgnored="false" %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>X-Workz</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
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
        .form {
                height: 50vh;
                display: flex;
                justify-content: center;
                align-items: center;
                background-color: #f8f9fa;
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
            </style>
</head>
<body>
<nav class="navbar navbar-dark bg-dark">
  <div class="container">
    <a class="navbar-brand" href="#">
      <img src="https://x-workz.in/static/media/Logo.cf195593dc1b3f921369.png" alt="" width="125" height="70">
    </a>
    <li class="nav-item">
       </ul>
          <form class="d-flex">
              <a class="btn btn-outline-primary btn-lg btn-custom me-3" href="signin">Sign In</a>
              <a class="btn btn-outline-primary btn-lg btn-custom me-3" href="signup">Sign Up</a>
          </form>
       </li>
  </div>
</nav>
<c:if test="${not empty errorMessage}">
    <h4 style="color: black; text-align: center;">${errorMessage}</h4>
</c:if>
<div class="d-flex justify-content-center align-items-center mt-5">
<div class="card custom-card">
    <div class="card-body">
        <h4 class="card-title text-center">Forget Password</h4>
<form action="resetPassword" method="post">
    <label class="form-label">Email Id</label>
    <input type="text" name="emailId" class="form-control">
    <label class="form-label">Password</label>
    <input type="password" name="password"  class="form-control">
    <label class="form-label">Password</label>
    <input type="password" name="newPassword" class="form-control">

    <label class="form-label">Confirm Password</label>
    <input type="password" name="confirmPassword" class="form-control">

    <div class="mb-3 text-center">
        <button type="submit" class="btn btn-primary mt-3">Submit</button>
    </div>
</form>
    </div>
</div>
</div>
</body>
</html>
