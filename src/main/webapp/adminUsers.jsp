<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.myfoodapp.model.User"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users | BiteRush Admin</title>

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

    <!-- Main Content: User Management -->
    <main class="admin-main-section">
        <div class="container">

            <!-- Page Title Header -->
            <div class="admin-page-header-row">
                <div class="admin-page-title-group">
                    <h1>User Management</h1>
                    <p class="admin-page-subtitle">Inspect registered customer accounts, view administrative roles, and manage users.</p>
                </div>

                <a href="adminDashboard" class="btn btn-outline btn-sm">
                    <span>← Back to Dashboard</span>
                </a>
            </div>

            <!-- Toolbar: User Search Form -->
            <div class="admin-toolbar-card">
                <!-- Search Form: Preserving exact action, method, and input name -->
                <form action="adminUserSearch" method="get" class="admin-search-form">
                    <span class="admin-search-icon">🔍</span>
                    <input type="text"
                           name="name"
                           placeholder="Search users by name..."
                           required
                           class="admin-search-input">
                    <button type="submit" class="btn btn-primary admin-search-btn">Search</button>
                </form>

                <a href="adminUsers" class="btn btn-outline btn-sm">
                    <span>🔄 View All Users</span>
                </a>
            </div>

            <!-- Users Data Table Card -->
            <div class="admin-table-card">
                <%
                    List<User> users = (List<User>) request.getAttribute("users");
                %>
                <div class="admin-table-header">
                    <h2 class="admin-table-title">
                        <span>👥</span>
                        <span>Registered Users</span>
                    </h2>
                    <% if (users != null) { %>
                        <span class="admin-table-count"><%= users.size() %> <%= users.size() == 1 ? "User" : "Users" %></span>
                    <% } %>
                </div>

                <div class="admin-table-wrapper">
                    <% if (users != null && !users.isEmpty()) { %>
                        <table class="admin-table">
                            <thead>
                                <tr>
                                    <th>User ID</th>
                                    <th>User Profile</th>
                                    <th>Username</th>
                                    <th>Email Address</th>
                                    <th>Phone Number</th>
                                    <th>Role</th>
                                    <th style="text-align: right;">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    for (User user : users) {
                                        String role = user.getRole() != null ? user.getRole().toLowerCase() : "";
                                        String roleBadgeClass = role.contains("admin") ? "role-admin" : "role-customer";
                                        String initial = (user.getFirstName() != null && !user.getFirstName().isEmpty()) 
                                                        ? user.getFirstName().substring(0, 1).toUpperCase() 
                                                        : "U";
                                %>
                                    <tr>
                                        <!-- User ID -->
                                        <td>
                                            <span class="id-badge">#<%= user.getUserID() %></span>
                                        </td>

                                        <!-- Full Name with Avatar -->
                                        <td>
                                            <div class="user-name-cell">
                                                <div class="user-avatar-sm">
                                                    <%= initial %>
                                                </div>
                                                <div>
                                                    <div class="user-full-name">
                                                        <%= user.getFirstName() != null ? user.getFirstName() : "" %> 
                                                        <%= user.getLastName() != null ? user.getLastName() : "" %>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>

                                        <!-- Username -->
                                        <td>
                                            <span style="font-weight: 600; color: var(--text-main);">@<%= user.getUserName() %></span>
                                        </td>

                                        <!-- Email -->
                                        <td>
                                            <span style="color: var(--text-muted);"><%= user.getEmail() %></span>
                                        </td>

                                        <!-- Phone -->
                                        <td>
                                            <span style="color: var(--text-muted);"><%= user.getPhoneNumber() %></span>
                                        </td>

                                        <!-- Role Badge -->
                                        <td>
                                            <span class="role-badge <%= roleBadgeClass %>">
                                                <%= user.getRole() != null ? user.getRole() : "Customer" %>
                                            </span>
                                        </td>

                                        <!-- Actions: Edit and Delete -->
                                        <td style="text-align: right;">
                                            <div class="table-actions-cell" style="justify-content: flex-end;">
                                                <!-- Edit User Action -->
                                                <a href="editUser?userID=<%=user.getUserID()%>" class="btn-action-edit">
                                                    <span>✏️</span>
                                                    <span>Edit</span>
                                                </a>

                                                <!-- Delete User Action with preserved confirmation prompt -->
                                                <a href="deleteUser?userID=<%=user.getUserID()%>" 
                                                   onclick="return confirm('Are you sure you want to delete this user?');"
                                                   class="btn-action-delete">
                                                    <span>🗑️</span>
                                                    <span>Delete</span>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    <% } else { %>
                        <!-- Empty Users State -->
                        <div class="admin-empty-state">
                            <div class="admin-empty-icon">👥</div>
                            <h3 class="admin-empty-title">No Users Found</h3>
                            <p class="admin-empty-desc">We couldn't find any user accounts matching your criteria.</p>
                            <a href="adminUsers" class="btn btn-primary btn-sm">Reset & View All Users</a>
                        </div>
                    <% } %>
                </div>
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
