<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.myfoodapp.model.User" %>

<%
    User user = (User) session.getAttribute("user");
    boolean isAdmin = user != null && user.getRole() != null && user.getRole().toLowerCase().contains("admin");
    String cancelUrl = isAdmin ? "adminProfile.jsp" : "profile.jsp";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Account | BiteRush</title>
    <meta name="description" content="Confirm account termination on BiteRush.">

    <!-- Google Fonts: Inter & Playfair Display -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">

    <!-- BiteRush Stylesheets -->
    <link rel="stylesheet" href="css/global.css?v=4">
    <link rel="stylesheet" href="css/common.css?v=4">
    <link rel="stylesheet" href="css/admin.css?v=4">
    <link rel="stylesheet" href="css/auth.css?v=4">
</head>
<body class="auth-page">

    <div class="auth-card-centered" style="max-width: 500px; border-color: rgba(200, 69, 43, 0.4);">
        <!-- BiteRush Centered Brand Logo -->
        <a href="restaurant.jsp" class="auth-brand-center" aria-label="BiteRush Home">
            <span class="brand-icon-box">
                <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon>
                </svg>
            </span>
            <span class="brand-text"><span class="highlight">Bite</span>Rush</span>
        </a>

        <!-- Form Header -->
        <div class="auth-header text-center">
            <h1 class="auth-title" style="color: #FFA594;">Delete Account</h1>
            <p class="auth-subtitle">Verify your identity with username and password to confirm permanent account termination.</p>
        </div>

        <!-- Permanent Action Warning Box -->
        <div class="auth-alert auth-alert-error" style="margin-bottom: 24px; text-align: left;">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="flex-shrink: 0;" aria-hidden="true">
                <path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z"></path>
                <line x1="12" y1="9" x2="12" y2="13"></line>
                <line x1="12" y1="17" x2="12.01" y2="17"></line>
            </svg>
            <div style="font-size: 0.84rem; line-height: 1.45;">
                <strong>This action cannot be undone.</strong> Deleting your account will permanently clear your access and order records.
            </div>
        </div>

        <%
            String error = (String) request.getAttribute("error");
            String message = (String) request.getAttribute("message");
        %>

        <% if (error != null && !error.trim().isEmpty()) { %>
            <div class="auth-alert auth-alert-error">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <circle cx="12" cy="12" r="10"></circle>
                    <line x1="12" y1="8" x2="12" y2="12"></line>
                    <line x1="12" y1="16" x2="12.01" y2="16"></line>
                </svg>
                <span><%= error %></span>
            </div>
        <% } %>

        <% if (message != null && !message.trim().isEmpty()) { %>
            <div class="auth-alert auth-alert-success">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <polyline points="20 6 9 17 4 12"></polyline>
                </svg>
                <span><%= message %></span>
            </div>
        <% } %>

        <!-- Account Deletion Form: Preserving exact action, method, and input names -->
        <form action="deleteAccount" method="post" class="auth-form" id="deleteAccountForm">
            <!-- Field: Username -->
            <div class="form-group">
                <label for="usernameInput" class="form-label">Username</label>
                <div class="auth-input-wrapper">
                    <span class="auth-input-icon" aria-hidden="true">
                        <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                            <circle cx="12" cy="7" r="4"></circle>
                        </svg>
                    </span>
                    <input type="text"
                           id="usernameInput"
                           name="username"
                           value="<%= user != null && user.getUserName() != null ? user.getUserName() : "" %>"
                           placeholder="Enter your username"
                           required
                           class="auth-input">
                </div>
            </div>

            <!-- Field: Password -->
            <div class="form-group">
                <label for="passwordInput" class="form-label">Password</label>
                <div class="auth-input-wrapper">
                    <span class="auth-input-icon" aria-hidden="true">
                        <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                            <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
                        </svg>
                    </span>
                    <input type="password"
                           id="passwordInput"
                           name="password"
                           placeholder="Enter your account password"
                           required
                           class="auth-input">
                </div>
            </div>

            <!-- Form Actions Bar -->
            <button type="submit" class="btn btn-danger" style="width: 100%; padding: 13px; font-weight: 700; border-radius: var(--radius-pill); margin-top: 10px; margin-bottom: 20px;">
                <span>Permanently Delete Account</span>
            </button>
        </form>

        <a href="<%= cancelUrl %>" class="auth-back-link">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                <line x1="19" y1="12" x2="5" y2="12"></line>
                <polyline points="12 19 5 12 12 5"></polyline>
            </svg>
            <span>Cancel & Return to Profile</span>
        </a>

    </div>

</body>
</html>
