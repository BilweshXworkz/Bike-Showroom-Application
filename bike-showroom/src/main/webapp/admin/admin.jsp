<%@ page language="java" contentType="text/html; charset=US-ASCII" pageEncoding="US-ASCII"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin OTP Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            margin: 0;
            padding: 0;
            height: 100vh;
            background: url('resources/images/image4.jpg') no-repeat center center/cover;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Segoe UI', sans-serif;
        }

        .card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            border-radius: 20px;
            padding: 40px;
            width: 400px;
            color: #fff;
        }

        .card h3 {
            font-weight: 700;
            margin-bottom: 25px;
            color: #f8f9fa;
        }

        .form-label, .form-control {
            font-weight: 500;
            color: #f8f9fa;
        }

        .form-control {
            background-color: rgba(255, 255, 255, 0.2);
            border: none;
            color: #fff;
        }

        .form-control::placeholder {
            color: #eee;
        }

        .btn-primary, .btn-success {
            font-weight: bold;
            border-radius: 10px;
            padding: 12px;
        }

        .btn-primary {
            background-color: #007bff;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        .btn-success {
            background-color: #28a745;
        }

        .btn-success:hover {
            background-color: #218838;
        }

        #otp-timer {
            font-weight: bold;
            animation: blink 1s step-start infinite;
        }

        @keyframes blink {
            50% {
                color: #ffc107;
            }
            100% {
                color: #dc3545;
            }
        }

        .text-center {
            color: #f8f9fa;
        }

        .message {
            font-weight: bold;
        }

        .alert {
            font-weight: 500;
        }
    </style>
</head>

<body>

    <div class="card text-center shadow">
        <h3 class="mb-4">Admin OTP Login</h3>

        <!-- Form to send OTP -->
        <form action="sendOtp" method="post">
            <div class="mb-3 text-start">
                <label class="form-label">Email ID</label>
                <input type="email" name="email" class="form-control" required value="${email}" placeholder="Enter your email">
            </div>
            <button type="submit" class="btn btn-primary w-100">Send OTP</button>

            <!-- Timer -->
            <div class="text-center text-warning fw-bold mt-3">
                <span id="timer">02:00</span>
            </div>
            <input type="hidden" id="otpStartTimeHidden" value="${sessionScope.otpStartTime}" />
        </form>

        <hr class="bg-light">

        <!-- Form to verify OTP -->
        <form action="verifyOtp" method="post">
            <div class="mb-3 text-start">
                <label class="form-label">Enter OTP</label>
                <input type="text" name="otp" required class="form-control" placeholder="Enter OTP">
            </div>
            <button type="submit" class="btn btn-success w-100">Verify OTP</button>
        </form>

        <!-- Display Messages -->
        <c:if test="${not empty message}">
            <p class="text-success mt-3">${message}</p>
        </c:if>

        <c:if test="${not empty error}">
            <p class="text-danger mt-3">${error}</p>
        </c:if>
    </div>

    <!-- Timer Script -->
    <c:if test="${sessionScope.otpSent eq true}">
    <script>
        let timerOn = true;

        function timer(remaining) {
            var m = Math.floor(remaining / 60);
            var s = remaining % 60;

            m = m < 10 ? '0' + m : m;
            s = s < 10 ? '0' + s : s;
            document.getElementById('timer').innerHTML = m + ':' + s;
            remaining -= 1;

            if (remaining >= 0 && timerOn) {
                setTimeout(function() {
                    timer(remaining);
                }, 1000);
                return;
            }

            if (!timerOn) {
                return;
            }

            // Do timeout stuff here
            alert('OTP expired. Please request a new one.');
            const otpForm = document.querySelector("form[action='verifyOtp']");
            if (otpForm) {
                const button = otpForm.querySelector("button[type='submit']");
                const input = otpForm.querySelector("input[name='otp']");
                if (button) button.disabled = true;
                if (input) input.disabled = true;
            }
        }

        // Start countdown from 120 seconds (2 minutes)
        timer(120);
    </script>
    </c:if>

</body>

</html>
