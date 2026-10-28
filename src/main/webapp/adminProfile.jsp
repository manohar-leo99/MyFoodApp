<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.myfoodapp.model.User"%>

<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);

User user = (User) session.getAttribute("user");

if (user == null) {
    response.sendRedirect("login.html");
    return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Profile | BiteRush Admin</title>

    <!-- BiteRush Design System Stylesheets -->
    <link rel="stylesheet" href="css/global.css">
    <link rel="stylesheet" href="css/common.css">
    <link rel="stylesheet" href="css/navbar.css">
    <link rel="stylesheet" href="css/admin.css">

    <!-- Preserved Bfcache reload handler from existing application -->
    <script>
        window.onpageshow = function(event) {
            if (event.persisted) {
                window.location.href = "adminProfile";
            }
        };
    </script>
</head>
<body class="admin-body">

    <!-- Admin Navigation Topbar -->
    <header class="admin-navbar">
        <div class="container admin-nav-container">
            <div class="admin-brand-group">
                <a href="adminDashboard" class="admin-brand">
                    <span class="brand-icon">⚡</span>
                    <span>Bite<span style="color: var(--primary);">Rush</span></span>
                </a>
                <span class="admin-brand-tag">Admin Portal</span>
            </div>

            <div class="admin-nav-actions">
                <a href="adminDashboard" class="admin-nav-link">
                    <span>📊</span>
                    <span>Dashboard</span>
                </a>
                <a href="adminRestaurants" class="admin-nav-link">
                    <span>🏬</span>
                    <span>Restaurants</span>
                </a>
                <a href="adminMenus" class="admin-nav-link">
                    <span>🍲</span>
                    <span>Menus</span>
                </a>
                <a href="adminOrders" class="admin-nav-link">
                    <span>📦</span>
                    <span>Orders</span>
                </a>
                <a href="adminUsers" class="admin-nav-link">
                    <span>👥</span>
                    <span>Users</span>
                </a>
                <%@ include file="components/adminProfileDropdown.jsp" %>
            </div>
        </div>
    </header>

    <!-- Main Content: Admin Profile Section -->
    <main class="admin-main-section">
        <div class="container">

            <!-- Page Title Header -->
            <div class="admin-page-header-row">
                <div class="admin-page-title-group">
                    <h1>Admin Profile</h1>
                    <p class="admin-page-subtitle">Manage your administrator account credentials, personal contact information, and security preferences.</p>
                </div>

                <a href="adminDashboard" class="btn btn-outline btn-sm">
                    <span>← Back to Dashboard</span>
                </a>
            </div>

            <%
                String error = (String) request.getAttribute("error");
                String message = (String) request.getAttribute("message");
            %>

            <% if (error != null && !error.trim().isEmpty()) { %>
                <div class="admin-alert admin-alert-error">
                    <span>⚠️</span>
                    <span><%= error %></span>
                </div>
            <% } %>

            <% if (message != null && !message.trim().isEmpty()) { %>
                <div class="admin-alert admin-alert-success">
                    <span>✅</span>
                    <span><%= message %></span>
                </div>
            <% } %>

            <!-- Admin Profile Header Banner -->
            <div class="admin-profile-header-banner">
                <div class="admin-profile-user-summary">
                    <div class="admin-profile-avatar">
                        <%= (user.getFirstName() != null && !user.getFirstName().isEmpty()) 
                                ? user.getFirstName().substring(0, 1).toUpperCase() 
                                : "A" %>
                    </div>
                    <div class="admin-profile-user-names">
                        <h2>
                            <%= user.getFirstName() != null ? user.getFirstName() : "" %> 
                            <%= user.getLastName() != null ? user.getLastName() : "" %>
                        </h2>
                        <p class="admin-profile-username">@<%= user.getUserName() %></p>
                        <div style="display: flex; gap: 8px; align-items: center; margin-top: 6px;">
                            <span class="role-badge role-admin"><%= user.getRole() != null ? user.getRole() : "Admin" %></span>
                            <span class="id-badge">User ID #<%= user.getUserID() %></span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 2-Column Profile Grid -->
            <div class="admin-profile-grid">
                <!-- Left: Personal & Contact Information -->
                <div class="admin-profile-card">
                    <div class="admin-profile-card-header">
                        <h2 class="admin-profile-card-title">
                            <span>👤</span>
                            <span>Administrator Details</span>
                        </h2>
                    </div>

                    <div class="admin-profile-details-grid">
                        <div class="admin-profile-field-item">
                            <span class="admin-field-label">Username</span>
                            <span class="admin-field-value" style="font-weight: 700; color: var(--text-main);">
                                @<%= user.getUserName() %>
                            </span>
                        </div>

                        <div class="admin-profile-field-item">
                            <span class="admin-field-label">Account Role</span>
                            <span class="admin-field-value">
                                <span class="role-badge role-admin"><%= user.getRole() %></span>
                            </span>
                        </div>

                        <div class="admin-profile-field-item">
                            <span class="admin-field-label">First Name</span>
                            <span class="admin-field-value"><%= user.getFirstName() != null ? user.getFirstName() : "—" %></span>
                        </div>

                        <div class="admin-profile-field-item">
                            <span class="admin-field-label">Last Name</span>
                            <span class="admin-field-value"><%= user.getLastName() != null ? user.getLastName() : "—" %></span>
                        </div>

                        <div class="admin-profile-field-item">
                            <span class="admin-field-label">Email Address</span>
                            <span class="admin-field-value"><%= user.getEmail() != null ? user.getEmail() : "—" %></span>
                        </div>

                        <div class="admin-profile-field-item">
                            <span class="admin-field-label">Phone Number</span>
                            <span class="admin-field-value"><%= user.getPhoneNumber() != null ? user.getPhoneNumber() : "—" %></span>
                        </div>

                        <div class="admin-profile-field-item full-span">
                            <span class="admin-field-label">Physical / Registered Address</span>
                            <span class="admin-field-value">📍 <%= user.getAddress() != null ? user.getAddress() : "—" %></span>
                        </div>
                    </div>
                </div>

                <!-- Right: Account Actions & Security Sidebar -->
                <aside class="admin-profile-sidebar">
                    <!-- Security & Credentials Card -->
                    <div class="admin-sidebar-card">
                        <h3 class="admin-sidebar-card-title">
                            <span>🔐</span>
                            <span>Security & Actions</span>
                        </h3>
                        <div class="admin-sidebar-actions-list">
                            <a href="editProfile.jsp" class="btn btn-primary btn-block">
                                <span>✏️</span>
                                <span>Update Profile</span>
                            </a>
                            <a href="changePassword.jsp" class="btn btn-outline btn-block">
                                <span>🔑</span>
                                <span>Change Password</span>
                            </a>
                            <a href="logout" class="btn btn-outline btn-block" style="color: #DC2626; border-color: #FECACA;">
                                <span>🚪</span>
                                <span>Logout</span>
                            </a>
                        </div>
                    </div>

                    <!-- Danger Zone Card -->
                    <div class="admin-sidebar-card admin-danger-box">
                        <h3 class="admin-sidebar-card-title" style="color: #DC2626;">
                            <span>⚠️</span>
                            <span>Danger Zone</span>
                        </h3>
                        <p class="admin-danger-desc">Deleting this administrative account removes permissions permanently.</p>
                        <a href="accountDelete.jsp" class="btn btn-danger-outline btn-block">
                            <span>🗑️ Delete Account</span>
                        </a>
                    </div>
                </aside>
            </div>

        </div>
    </main>

    <!-- Admin Compact Footer -->
    <footer class="admin-footer">
        <div class="container">
            <p>&copy; 2026 BiteRush Admin Portal. All rights reserved.</p>
        </div>
    </footer>

</body>
</html>
