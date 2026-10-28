<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Restaurant | BiteRush Admin</title>

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
                <a href="adminRestaurants" class="admin-nav-link active">
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

    <!-- Main Content: Add Restaurant Form -->
    <main class="admin-main-section">
        <div class="container">

            <div class="admin-form-container">
                <div class="admin-form-card">
                    <!-- Form Header with Back Action -->
                    <div class="admin-form-header">
                        <div style="display: flex; justify-content: space-between; align-items: flex-start; gap: 16px;">
                            <div>
                                <h1 class="admin-form-title">
                                    <span>🏬</span>
                                    <span>Add New Restaurant</span>
                                </h1>
                                <p class="admin-form-subtitle">Register a partner dining establishment with its cuisine, delivery estimates, location, and operational status.</p>
                            </div>
                            <a href="adminRestaurants" class="btn btn-outline btn-sm">
                                <span>← Back to Restaurants</span>
                            </a>
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

                    <!-- Add Restaurant Form: Preserving exact action, method, and input names -->
                    <form action="addRestaurant" method="post">
                        <div class="admin-form-grid">
                            <!-- Field: Restaurant Name -->
                            <div class="admin-form-group">
                                <label for="nameInput" class="admin-label">Restaurant Name</label>
                                <input type="text"
                                       id="nameInput"
                                       name="name"
                                       placeholder="e.g. Royal Biryani House"
                                       required
                                       class="admin-input">
                            </div>

                            <!-- Field: Cuisine Type -->
                            <div class="admin-form-group">
                                <label for="cuisineTypeInput" class="admin-label">Cuisine Type</label>
                                <input type="text"
                                       id="cuisineTypeInput"
                                       name="cuisineType"
                                       placeholder="e.g. Hyderabadi, North Indian, Mughlai"
                                       required
                                       class="admin-input">
                            </div>

                            <!-- Field: Delivery Time -->
                            <div class="admin-form-group">
                                <label for="deliveryTimeInput" class="admin-label">Estimated Delivery Time (mins)</label>
                                <input type="number"
                                       id="deliveryTimeInput"
                                       name="deliveryTime"
                                       placeholder="e.g. 30"
                                       required
                                       class="admin-input">
                                <span class="admin-input-hint">Average kitchen preparation + delivery window.</span>
                            </div>

                            <!-- Field: Admin User ID -->
                            <div class="admin-form-group">
                                <label for="adminUserIDInput" class="admin-label">Admin User ID</label>
                                <input type="number"
                                       id="adminUserIDInput"
                                       name="adminUserID"
                                       placeholder="e.g. 1"
                                       required
                                       class="admin-input">
                                <span class="admin-input-hint">User ID responsible for managing this branch.</span>
                            </div>

                            <!-- Field: Active Status -->
                            <div class="admin-form-group">
                                <label for="isActiveSelect" class="admin-label">Operational Status</label>
                                <select id="isActiveSelect" name="isActive" class="admin-select">
                                    <option value="true">Yes</option>
                                    <option value="false">No</option>
                                </select>
                            </div>

                            <!-- Field: Initial Rating -->
                            <div class="admin-form-group">
                                <label for="ratingInput" class="admin-label">Rating (0.0 to 5.0)</label>
                                <input type="number"
                                       id="ratingInput"
                                       name="rating"
                                       min="0"
                                       max="5"
                                       step="0.1"
                                       value="0"
                                       placeholder="e.g. 4.5"
                                       class="admin-input">
                                <span class="admin-input-hint">Default initial score is 0.</span>
                            </div>

                            <!-- Field: Restaurant Image URL (Full Span) -->
                            <div class="admin-form-group full-span">
                                <label for="restaurantImageURLInput" class="admin-label">Restaurant Image URL</label>
                                <input type="text"
                                       id="restaurantImageURLInput"
                                       name="restaurantImageURL"
                                       placeholder="https://images.unsplash.com/photo-... or database image URL"
                                       class="admin-input">
                                <span class="admin-input-hint">Direct image URL stored in MySQL database (compatible with backend).</span>
                            </div>

                            <!-- Field: Physical Address (Full Span) -->
                            <div class="admin-form-group full-span">
                                <label for="addressInput" class="admin-label">Physical Address</label>
                                <input type="text"
                                       id="addressInput"
                                       name="address"
                                       placeholder="e.g. 124 Food Street, Banjara Hills, Hyderabad"
                                       required
                                       class="admin-input">
                            </div>
                        </div>

                        <!-- Form Actions Bar -->
                        <div class="admin-form-actions">
                            <a href="adminRestaurants" class="btn btn-outline">
                                <span>Cancel</span>
                            </a>
                            <button type="submit" class="btn btn-primary">
                                <span>+ Add Restaurant</span>
                            </button>
                        </div>
                    </form>
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
