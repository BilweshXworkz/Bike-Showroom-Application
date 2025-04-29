<%@ page language="java" contentType="text/html; charset=US-ASCII"
        pageEncoding="US-ASCII"%>
 <%@ page isELIgnored="false" %>
<html>
<head>
     <meta http-equiv="Cache-Control" content="no-store, no-cache, must-revalidate, post-check=0, pre-check=0">
     <meta http-equiv="Pragma" content="no-cache">
     <meta http-equiv="Expires" content="0">
    <title>Royal Enfield</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body {
             margin: 0;
             padding: 0;
             height: 100vh;
             background-size: cover;
         }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="#">
                <img src="https://www.royalenfield.com/content/dam/royal-enfield/india/logos/logo.svg" alt="" width="200" height="40">
            </a>
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                <li class="nav-item dropdown">
                     <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                       <img src = "https://img.icons8.com/?size=50&id=65342&format=png&color=000000" alt = "">
                     </a>
                     <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                       <li><a class="dropdown-item" href="fetchByEmail?emailId=${user.emailId}">Edit Profile</a></li>
                       <li><a class="dropdown-item" href="logout">Logout</a></li>
                     </ul>
                </li>
            </ul>
        </div>
    </nav>

    <div class="d-flex flex-column justify-content-center align-items-center text-center text-black" style="height: 80vh;">
        <h1 class="display-4 fw-bold">Welcome to Royal Enfield Showroom</h1>
        <p class="lead">Experience Power. Style. Adventure.</p>
        <h2 class="me-2 mt-5"><center> Welcome TO The Main Page ${user.getFullName()}</center></h2>
        <a href="showroomUser" class="btn btn-danger btn-lg btn-custom no-rounded">Explore Showroom</a>
    </div>
</body>
</html>
