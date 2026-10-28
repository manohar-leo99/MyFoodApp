<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String error = (String) request.getAttribute("error");
    if (error == null) error = request.getParameter("error");

    String message = (String) request.getAttribute("message");
    if (message == null) message = request.getParameter("message");

    String success = (String) request.getAttribute("success");
    if (success == null) success = request.getParameter("success");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Password | BiteRush</title>
    <meta name="description" content="Update your BiteRush account security and password.">

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
            <h1 class="auth-title">Change Password</h1>
            <p class="auth-subtitle">Update your credentials to keep your account safe and secure.</p>
        </div>

        <!-- Optional Error / Status Alerts -->
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
            <div class="auth-alert auth-alert-error" role="alert">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <circle cx="12" cy="12" r="10"></circle>
                    <line x1="12" y1="8" x2="12" y2="12"></line>
                    <line x1="12" y1="16" x2="12.01" y2="16"></line>
                </svg>
                <span><%= message %></span>
            </div>
        <% } %>

        <% if (success != null && !success.trim().isEmpty()) { %>
            <div class="auth-alert auth-alert-success" role="status">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <polyline points="20 6 9 17 4 12"></polyline>
                </svg>
                <span><%= success %></span>
            </div>
        <% } %>

        <!-- Change Password Form: Preserving exact action, method, and input names -->
        <form action="changePassword" method="post" class="auth-form" id="changePasswordForm">
            <!-- Current Password Field -->
            <div class="form-group">
                <label for="currentPasswordInput" class="form-label">Current Password</label>
                <div class="auth-input-wrapper">
                    <span class="auth-input-icon" aria-hidden="true">
                        <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                            <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
                        </svg>
                    </span>
                    <input type="password"
                           id="currentPasswordInput"
                           name="currentPassword"
                           placeholder="Enter current password"
                           required
                           class="auth-input">
                </div>
            </div>

            <!-- New Password Field -->
            <div class="form-group">
                <label for="newPasswordInput" class="form-label">New Password</label>
                <div class="auth-input-wrapper">
                    <span class="auth-input-icon" aria-hidden="true">
                        <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M21 2l-2 2m-2-2l2 2m-4 4l-4 4-2-2-4 4 2 2-4 4 2 2 4-4 2 2 4-4"></path>
                            <circle cx="7.5" cy="7.5" r="3.5"></circle>
                        </svg>
                    </span>
                    <input type="password"
                           id="newPasswordInput"
                           name="newPassword"
                           placeholder="Enter new password"
                           required
                           class="auth-input">
                </div>
            </div>

            <!-- Confirm New Password Field -->
            <div class="form-group">
                <label for="confirmPasswordInput" class="form-label">Confirm New Password</label>
                <div class="auth-input-wrapper">
                    <span class="auth-input-icon" aria-hidden="true">
                        <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                            <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
                        </svg>
                    </span>
                    <input type="password"
                           id="confirmPasswordInput"
                           name="confirmPassword"
                           placeholder="Re-enter new password"
                           required
                           class="auth-input">
                </div>
            </div>

            <!-- Submit Button -->
            <button type="submit" class="btn btn-primary btn-auth-submit" id="changePasswordSubmitBtn">
                <span>Update Password</span>
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <line x1="5" y1="12" x2="19" y2="12"></line>
                    <polyline points="12 5 19 12 12 19"></polyline>
                </svg>
            </button>
        </form>

        <!-- Navigation Links -->
        <a href="profile.jsp" class="auth-back-link">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                <line x1="19" y1="12" x2="5" y2="12"></line>
                <polyline points="12 19 5 12 12 5"></polyline>
            </svg>
            <span>Back to Profile</span>
        </a>

        <a href="restaurant.jsp" class="auth-back-link" style="margin-top: 8px;">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                <line x1="19" y1="12" x2="5" y2="12"></line>
                <polyline points="12 19 5 12 12 5"></polyline>
            </svg>
            <span>Back to Restaurants</span>
        </a>
    </div>

</body>
</html>
