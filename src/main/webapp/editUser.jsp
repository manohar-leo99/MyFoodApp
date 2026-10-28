<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.myfoodapp.model.User" %>

<%
    User user = (User) request.getAttribute("user");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit User | BiteRush Admin</title>

    <!-- BiteRush Design System Stylesheets -->
    <link rel="stylesheet" href="css/global.css">
    <link rel="stylesheet" href="css/common.css">
    <link rel="stylesheet" href="css/navbar.css">
    <link rel="stylesheet" href="css/admin.css">
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
                <a href="adminUsers" class="admin-nav-link active">
                    <span>👥</span>
                    <span>Users</span>
                </a>
                <%@ include file="components/adminProfileDropdown.jsp" %>
            </div>
        </div>
    </header>

    <!-- Main Content: Edit User Form -->
    <main class="admin-main-section">
        <div class="container">

            <% if (user != null) { 
                String initial = (user.getFirstName() != null && !user.getFirstName().isEmpty()) 
                                ? user.getFirstName().substring(0, 1).toUpperCase() 
                                : "U";
            %>
                <div class="admin-form-container">
                    <div class="admin-form-card">
                        <!-- Form Header with Back Link -->
                        <div class="admin-form-header">
                            <div style="display: flex; justify-content: space-between; align-items: flex-start; gap: 16px;">
                                <div>
                                    <h1 class="admin-form-title">
                                        <span>✏️</span>
                                        <span>Edit User Account</span>
                                    </h1>
                                    <p class="admin-form-subtitle">Update contact details, personal name, and physical address for this user.</p>
                                </div>
                                <a href="adminUsers" class="btn btn-outline btn-sm">
                                    <span>← Back to Users</span>
                                </a>
                            </div>
                        </div>

                        <!-- Current User Context Preview Banner -->
                        <div class="edit-preview-badge">
                            <div class="user-avatar-sm" style="width: 52px; height: 52px; font-size: 1.25rem;">
                                <%= initial %>
                            </div>
                            <div class="preview-info">
                                <div class="preview-title">
                                    <%= user.getFirstName() != null ? user.getFirstName() : "" %> 
                                    <%= user.getLastName() != null ? user.getLastName() : "" %>
                                </div>
                                <div class="preview-meta">
                                    <span>User ID: #<%= user.getUserID() %></span>
                                    <% if (user.getUserName() != null && !user.getUserName().trim().isEmpty()) { %>
                                        <span> • </span>
                                        <span>Username: @<%= user.getUserName() %></span>
                                    <% } %>
                                    <% if (user.getRole() != null && !user.getRole().trim().isEmpty()) { %>
                                        <span> • </span>
                                        <span class="role-badge <%= user.getRole().toLowerCase().contains("admin") ? "role-admin" : "role-customer" %>">
                                            <%= user.getRole() %>
                                        </span>
                                    <% } %>
                                </div>
                            </div>
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

                        <!-- Edit User Form: Preserving exact action, method, and input names -->
                        <form action="updateUser" method="post">

                            <!-- Preserved Hidden User ID -->
                            <input type="hidden"
                                   name="userID"
                                   value="<%= user.getUserID() %>">

                            <div class="admin-form-grid">
                                <!-- Field: First Name -->
                                <div class="admin-form-group">
                                    <label for="firstNameInput" class="admin-label">First Name</label>
                                    <input type="text"
                                           id="firstNameInput"
                                           name="firstName"
                                           value="<%= user.getFirstName() != null ? user.getFirstName() : "" %>"
                                           placeholder="e.g. John"
                                           class="admin-input">
                                </div>

                                <!-- Field: Last Name -->
                                <div class="admin-form-group">
                                    <label for="lastNameInput" class="admin-label">Last Name</label>
                                    <input type="text"
                                           id="lastNameInput"
                                           name="lastName"
                                           value="<%= user.getLastName() != null ? user.getLastName() : "" %>"
                                           placeholder="e.g. Doe"
                                           class="admin-input">
                                </div>

                                <!-- Field: Email Address -->
                                <div class="admin-form-group">
                                    <label for="emailInput" class="admin-label">Email Address</label>
                                    <input type="email"
                                           id="emailInput"
                                           name="email"
                                           value="<%= user.getEmail() != null ? user.getEmail() : "" %>"
                                           placeholder="e.g. john@example.com"
                                           class="admin-input">
                                </div>

                                <!-- Field: Phone Number -->
                                <div class="admin-form-group">
                                    <label for="phoneInput" class="admin-label">Phone Number</label>
                                    <input type="text"
                                           id="phoneInput"
                                           name="phone"
                                           value="<%= user.getPhoneNumber() != null ? user.getPhoneNumber() : "" %>"
                                           placeholder="e.g. 9876543210"
                                           class="admin-input">
                                </div>

                                <!-- Field: Physical Address (Full Span) -->
                                <div class="admin-form-group full-span">
                                    <label for="addressInput" class="admin-label">Delivery Address</label>
                                    <input type="text"
                                           id="addressInput"
                                           name="address"
                                           value="<%= user.getAddress() != null ? user.getAddress() : "" %>"
                                           placeholder="e.g. 124 Food Street, Banjara Hills, Hyderabad"
                                           class="admin-input">
                                </div>
                            </div>

                            <!-- Form Actions Bar -->
                            <div class="admin-form-actions">
                                <a href="adminUsers" class="btn btn-outline">
                                    <span>Cancel</span>
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <span>Update User</span>
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            <% } else { %>
                <!-- Fallback in case of null user attribute -->
                <div class="admin-empty-state">
                    <div class="admin-empty-icon">⚠️</div>
                    <h2 class="admin-empty-title">User Not Found</h2>
                    <p class="admin-empty-desc">The requested user profile could not be loaded or session expired.</p>
                    <a href="adminUsers" class="btn btn-primary">Back to Users</a>
                </div>
            <% } %>

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
