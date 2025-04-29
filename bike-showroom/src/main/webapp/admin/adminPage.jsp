<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
             margin: 0;
             padding: 0;
             height: 100vh;
             background: url('resources/images/image2..jpg') no-repeat center center fixed;
             background-size: cover;
         }
       .triangle {
           display: flex;
           flex-direction: column;
           align-items: center;
           gap: 30px;
           margin-top: 40px;
       }

       .top-buttons {
           display: flex;
           gap: 40px;
       }

       .bottom-button {
           display: flex;
           gap: 40px;
       }

       .btn-custom {
           padding: 15px 30px;
           font-size: 22px;
           font-weight: 600;
           border-radius: 30px;
           transition: all 0.3s ease-in-out;
           box-shadow: 0px 4px 10px rgba(0,0,0,0.3);
       }

       .btn-custom:hover {
           background-color: #dc3545;
           color: white;
           transform: translateY(-3px);
       }

       h2 {
           font-size: 50px;
           font-weight: bold;
           color: white;
           text-shadow: 2px 2px 6px rgba(0,0,0,0.5);
       }

       @media (max-width: 768px) {
           .top-buttons,
           .bottom-button {
               flex-direction: column;
           }
       }

    </style>
</head>
<body>
<nav class="navbar navbar-dark bg-dark">
  <div class="container">
   <a class="navbar-brand" href="#">
          <img src="https://www.royalenfield.com/content/dam/royal-enfield/india/logos/logo.svg" alt="" width="200" height="40" class="me-2">
       </a>
    <form class="d-flex">
        <a class="nav-link btn btn-outline-light me-2 px-3 text-info" href="logout">Logout</a>
    </form>
  </div>
</nav>

<div class="container">
    <h2 class="mb-4 text-center text-white font-weight-bold" style="font-size: 50px; text-shadow: 2px 2px 6px rgba(0, 0, 0, 0.5);">Welcome Admin</h2>
    <div class="row justify-content-center">
        <div class="col-12 col-md-6 col-lg-4 mb-4">
            <a href="GoAddShowroom" class="btn btn-danger btn-lg btn-custom w-100">Register Showroom</a>
        </div>
        <div class="col-12 col-md-6 col-lg-4 mb-4">
            <a href="GoAddBike" class="btn btn-danger btn-lg btn-custom w-100">Register Bike</a>
        </div>
        <div class="col-12 col-md-6 col-lg-4 mb-4">
            <a href="bikeToShowroom" class="btn btn-danger btn-lg btn-custom w-100">Assign Bike to Showroom</a>
        </div>
        <div class="col-12 col-md-6 col-lg-4 mb-4">
            <a href="user" class="btn btn-danger btn-lg btn-custom w-100">New Customer Registration</a>
        </div>
    </div>

    <div class="row justify-content-center">
        <div class="col-12 col-md-6 col-lg-4 mb-4">
            <a href="userForm" class="btn btn-danger btn-lg btn-custom w-100">Customer Details Form</a>
        </div>
        <div class="col-12 col-md-6 col-lg-4 mb-4">
            <a href="explore" class="btn btn-danger btn-lg btn-custom w-100">Stores</a>
        </div>
        <div class="col-12 col-md-6 col-lg-4 mb-4">
            <a href="exploreBike" class="btn btn-danger btn-lg btn-custom w-100">Bikes</a>
        </div>
    </div>
</div>


</body>
</html>
