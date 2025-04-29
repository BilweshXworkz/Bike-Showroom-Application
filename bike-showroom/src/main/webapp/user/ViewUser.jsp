<%@ page language="java" contentType="text/html; charset=US-ASCII"
        pageEncoding="US-ASCII"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Form Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            margin: 0;
            padding: 0;
            height: 100vh;
            background: url('resources/images/image8.jpg') no-repeat center center fixed;
            background-size: cover;
        }
        .scrollable-table {
            max-height: 400px;
            overflow-y: auto;
            margin-top: 120px; /* Push content below navbar */
            background-color: rgba(255, 255, 255, 0.8); /* Optional: better contrast */
            border-radius: 10px;
            padding: 10px;
        }
        table thead th {
            position: sticky;
            top: 0;
            background-color: #343a40; /* Bootstrap dark */
            color: white;
            z-index: 2;
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
                <a class="nav-link btn btn-outline-light me-2 px-3 text-info" onclick="history.back()">Back</a>
            </form>
        </div>
    </nav>

    <div class="container">
        <div class="row justify-content-center">
            <h3 class="text-center text-white" style="margin-top: 100px;">Customer Details Form</h3>
            <div class="col-md-12 scrollable-table">
                <table class="table table-bordered text-center bg-white shadow-lg">
                    <thead class="table-dark">
                        <tr>
                            <th>Full Name</th>
                            <th>Age</th>
                            <th>Phone Number</th>
                            <th>Email ID</th>
                            <th>Address</th>
                            <th>Driving License</th>
                            <th>Showroom Name</th>
                            <th>Bike Model</th>
                            <th>Schedule</th>
                           <th>Reason</th>
                           <th>DateTime</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="entry" items="${reasonDateList}">
                            <tr>
                                <td>${user.getFullName()}</td>
                                <td>${user.getAge()}</td>
                                <td>${user.getPhoneNumber()}</td>
                                <td>${user.getEmailId()}</td>
                                <td>${user.getAddress()}</td>
                                <td>${user.getDlNumber()}</td>
                                <td>${user.getShowroomName()}</td>
                                <td>${user.getModelName()}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${user.getScheduleTask() == 0}">Schedule Test Ride</c:when>
                                        <c:when test="${user.getScheduleTask() == 1}">Booking</c:when>
                                        <c:otherwise>Unknown</c:otherwise>
                                    </c:choose>
                                </td>
                                <td><b>→</b> ${entry.reason}</td>
                                <td>${entry.date}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
