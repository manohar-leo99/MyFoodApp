<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    Object email = request.getAttribute("email");
    Object username = request.getAttribute("username");
    Object phonenumber = request.getAttribute("phonenumber");

    String error = (String) request.getAttribute("error");
    String message = (String) request.getAttribute("message");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Account Details | BiteRush</title>

    <!-- Google Fonts: Inter & Playfair Display -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">

    <!-- BiteRush Design System Stylesheets (No JavaScript) -->
    <link rel="stylesheet" href="css/common.css">
    <link rel="stylesheet" href="css/auth.css">
</head>
<body class="auth-page">

    <div class="auth-card-centered" style="max-width: 500px;">
        <!-- BiteRush Centered Brand Logo -->
        <a href="restaurant.jsp" class="auth-brand-center">
            <span class="brand-icon">⚡</span>
            <span>Bite<span class="highlight" style="color: var(--primary);">Rush</span></span>
        </a>

        <!-- Success Check Icon -->
        <div class="recovery-success-icon">✓</div>

        <!-- Header -->
        <div class="auth-header text-center">
            <h1 class="auth-title">Account Details</h1>
            <p class="auth-subtitle">Your account details were retrieved successfully.</p>
        </div>

        <!-- Status / Error Messages if present -->
        <% if (error != null && !error.trim().isEmpty()) { %>
            <div class="auth-alert auth-alert-error">
                <span>⚠️</span>
                <span><%= error %></span>
            </div>
        <% } %>

        <% if (message != null && !message.trim().isEmpty()) { %>
            <div class="auth-alert auth-alert-success">
                <span>✓</span>
                <span><%= message %></span>
            </div>
        <% } %>

        <!-- Retrieved Account Information Box (Password securely omitted) -->
        <div class="recovery-details-box">
            <!-- Username -->
            <div class="recovery-item">
                <span class="recovery-label">
                    <span>👤</span>
                    <span>Username</span>
                </span>
                <span class="recovery-value">
                    <%= username != null ? username : "Not available" %>
                </span>
            </div>

            <!-- Email Address -->
            <div class="recovery-item">
                <span class="recovery-label">
                    <span>✉️</span>
                    <span>Registered Email</span>
                </span>
                <span class="recovery-value">
                    <%= email != null ? email : "Not available" %>
                </span>
            </div>

            <!-- Phone Number -->
            <div class="recovery-item">
                <span class="recovery-label">
                    <span>📞</span>
                    <span>Phone Number</span>
                </span>
                <span class="recovery-value">
                    <%= phonenumber != null ? phonenumber : "Not available" %>
                </span>
            </div>
        </div>

        <!-- Safe Security Information Note -->
        <div class="recovery-security-note">
            <span>🔒</span>
            <span>For your security, passwords are encrypted and never shown in plain text. Please use your credentials to log in below.</span>
        </div>

        <!-- Login Call to Action -->
        <a href="login.html" class="btn btn-primary btn-auth-submit" style="text-decoration: none; width: 100%;">
            <span>Proceed to Login</span>
            <span>→</span>
        </a>

        <!-- Navigation Links -->
        <p class="auth-switch-text" style="margin-top: 20px;">
            Need help with another account? 
            <a href="forgotPassword.jsp" class="auth-switch-link">Find Account</a>
        </p>

        <a href="restaurant.jsp" class="auth-back-link">
            <span>← Back to Restaurants</span>
        </a>
    </div>

</body>
</html>
