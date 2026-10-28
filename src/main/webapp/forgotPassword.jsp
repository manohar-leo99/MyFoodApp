<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String error = (String) request.getAttribute("error");
    if (error == null) error = request.getParameter("error");

    String message = (String) request.getAttribute("message");
    if (message == null) message = request.getParameter("message");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password | BiteRush</title>
    <meta name="description" content="Recover your BiteRush account credentials quickly and securely.">

    <!-- Google Fonts: Inter & Playfair Display -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">

    <!-- BiteRush Stylesheets -->
    <link rel="stylesheet" href="css/global.css?v=4">
    <link rel="stylesheet" href="css/common.css?v=4">
    <link rel="stylesheet" href="css/auth.css?v=4">
</head>
<body class="auth-page">

    <div class="auth-card-centered">
        <!-- BiteRush Centered Brand Logo -->
        <a href="restaurant.jsp" class="auth-brand-center" aria-label="BiteRush Home">
            <span class="brand-icon-box">
                <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon>
                </svg>
            </span>
            <span class="brand-text"><span class="highlight">Bite</span>Rush</span>
        </a>

        <!-- Header -->
        <div class="auth-header text-center">
            <h1 class="auth-title">Forgot Password?</h1>
            <p class="auth-subtitle">Recover your password by entering your registered account details below.</p>
        </div>

        <!-- Optional Error / Status Message Alert -->
        <% if (error != null && !error.trim().isEmpty()) { %>
            <div class="auth-alert auth-alert-error" role="alert">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <circle cx="12" cy="12" r="10"></circle>
                    <line x1="12" y1="8" x2="12" y2="12"></line>
                    <line x1="12" y1="16" x2="12.01" y2="16"></line>
                </svg>
                <span><%= error %></span>
            </div>
        <% } %>

        <% if (message != null && !message.trim().isEmpty()) { %>
            <div class="auth-alert auth-alert-success" role="status">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <polyline points="20 6 9 17 4 12"></polyline>
                </svg>
                <span><%= message %></span>
            </div>
        <% } %>

        <!-- Password Recovery Form: Preserving exact action, method, and input names -->
        <form action="forgotPassword" method="post" class="auth-form" id="forgotPasswordForm">
            <!-- Email Field -->
            <div class="form-group">
                <label for="emailInput" class="form-label">Registered Email</label>
                <div class="auth-input-wrapper">
                    <span class="auth-input-icon" aria-hidden="true">
                        <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path>
                            <polyline points="22,6 12,13 2,6"></polyline>
                        </svg>
                    </span>
                    <input type="email"
                           id="emailInput"
                           name="email"
                           placeholder="Enter your registered email"
                           required
                           class="auth-input">
                </div>
            </div>

            <!-- Phone Number Field (Preserving exact parameter name: phonenumber) -->
            <div class="form-group">
                <label for="phoneInput" class="form-label">Phone Number</label>
                <div class="auth-input-wrapper">
                    <span class="auth-input-icon" aria-hidden="true">
                        <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path>
                        </svg>
                    </span>
                    <input type="text"
                           id="phoneInput"
                           name="phonenumber"
                           placeholder="Enter your registered phone number"
                           required
                           class="auth-input">
                </div>
            </div>

            <!-- Submit Button -->
            <button type="submit" class="btn btn-primary btn-auth-submit" id="recoverSubmitBtn">
                <span>Submit & Recover</span>
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <line x1="5" y1="12" x2="19" y2="12"></line>
                    <polyline points="12 5 19 12 12 19"></polyline>
                </svg>
            </button>
        </form>

        <!-- Navigation Links -->
        <p class="auth-switch-text">
            Remember your password? 
            <a href="login.html" class="auth-switch-link">Login</a>
        </p>

        <p class="auth-switch-text" style="margin-top: 8px;">
            Need a new account? 
            <a href="signup.html" class="auth-switch-link">Sign Up</a>
        </p>

        <a href="restaurant.jsp" class="auth-back-link">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                <line x1="19" y1="12" x2="5" y2="12"></line>
                <polyline points="12 19 5 12 12 5"></polyline>
            </svg>
            <span>Back to Restaurants</span>
        </a>
    </div>

</body>
</html>
