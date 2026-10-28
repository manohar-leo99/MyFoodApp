<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.myfoodapp.model.Restaurant"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Restaurants | BiteRush Admin</title>

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

    <!-- Main Content: Restaurant Management -->
    <main class="admin-main-section">
        <div class="container">

            <!-- Page Title Header Row -->
            <div class="admin-page-header-row">
                <div class="admin-page-title-group">
                    <h1>Restaurant Management</h1>
                    <p class="admin-page-subtitle">Oversee registered eateries, update dining details, inspect delivery times, and onboard new partners.</p>
                </div>

                <div style="display: flex; gap: 12px; align-items: center;">
                    <a href="adminDashboard" class="btn btn-outline btn-sm">
                        <span>← Back to Dashboard</span>
                    </a>
                    <a href="addRestaurant.jsp" class="btn btn-primary btn-sm">
                        <span>+ Add Restaurant</span>
                    </a>
                </div>
            </div>

            <!-- Toolbar: Restaurant Search Form -->
            <div class="admin-toolbar-card">
                <!-- Search Form: Preserving exact action, method, and input name -->
                <form action="adminRestaurantSearch" method="get" class="admin-search-form">
                    <span class="admin-search-icon">🔍</span>
                    <input type="text"
                           name="restaurantName"
                           placeholder="Search restaurants by name..."
                           required
                           class="admin-search-input">
                    <button type="submit" class="btn btn-primary admin-search-btn">Search</button>
                </form>

                <div style="display: flex; gap: 10px;">
                    <a href="adminRestaurants" class="btn btn-outline btn-sm">
                        <span>🔄 View All</span>
                    </a>
                </div>
            </div>

            <!-- Restaurants Data Table Card -->
            <div class="admin-table-card">
                <%
                    List<Restaurant> restaurants = (List<Restaurant>) request.getAttribute("restaurants");
                %>
                <div class="admin-table-header">
                    <h2 class="admin-table-title">
                        <span>🏬</span>
                        <span>Partner Restaurants</span>
                    </h2>
                    <% if (restaurants != null) { %>
                        <span class="admin-table-count"><%= restaurants.size() %> <%= restaurants.size() == 1 ? "Restaurant" : "Restaurants" %></span>
                    <% } %>
                </div>

                <div class="admin-table-wrapper">
                    <% if (restaurants != null && !restaurants.isEmpty()) { %>
                        <table class="admin-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Restaurant</th>
                                    <th>Cuisine</th>
                                    <th>Delivery Time</th>
                                    <th>Rating</th>
                                    <th>Address</th>
                                    <th style="text-align: right;">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    for (Restaurant restaurant : restaurants) {
                                %>
                                    <tr>
                                        <!-- Restaurant ID -->
                                        <td>
                                            <span class="id-badge">#<%= restaurant.getRestaurantID() %></span>
                                        </td>

                                        <!-- Restaurant Info with Database Image URL -->
                                        <td>
                                            <div class="admin-resto-cell">
                                                <img src="<%= restaurant.getRestaurantImageURL() %>" 
                                                     alt="<%= restaurant.getRestaurantName() %>" 
                                                     class="admin-resto-thumb">
                                                <div>
                                                    <div class="resto-name-bold"><%= restaurant.getRestaurantName() %></div>
                                                </div>
                                            </div>
                                        </td>

                                        <!-- Cuisine -->
                                        <td>
                                            <span class="badge badge-cuisine"><%= restaurant.getCuisineType() %></span>
                                        </td>

                                        <!-- Delivery Time -->
                                        <td>
                                            <span class="badge badge-time">
                                                <span>⏱️</span>
                                                <span><%= restaurant.getDeliveryTime() %> mins</span>
                                            </span>
                                        </td>

                                        <!-- Rating -->
                                        <td>
                                            <span class="badge badge-rating high">
                                                <span>★</span>
                                                <span><%= restaurant.getRating() %></span>
                                            </span>
                                        </td>

                                        <!-- Address -->
                                        <td>
                                            <span style="font-size: 0.88rem; color: var(--text-muted); display: flex; align-items: center; gap: 4px;">
                                                <span>📍</span>
                                                <span><%= restaurant.getAddress() %></span>
                                            </span>
                                        </td>

                                        <!-- Actions: Edit and Delete -->
                                        <td style="text-align: right;">
                                            <div class="table-actions-cell" style="justify-content: flex-end;">
                                                <!-- Edit Restaurant Action -->
                                                <a href="editRestaurant?restaurantId=<%= restaurant.getRestaurantID() %>" 
                                                   class="btn-action-edit">
                                                    <span>✏️</span>
                                                    <span>Edit</span>
                                                </a>

                                                <!-- Delete Restaurant Action with preserved confirmation prompt -->
                                                <a href="deleteRestaurant?restaurantId=<%= restaurant.getRestaurantID() %>" 
                                                   onclick="return confirm('Are you sure you want to delete this restaurant?');"
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
                        <!-- Empty State -->
                        <div class="admin-empty-state">
                            <div class="admin-empty-icon">🏬</div>
                            <h3 class="admin-empty-title">No Restaurants Found</h3>
                            <p class="admin-empty-desc">We couldn't find any partner restaurants matching your criteria.</p>
                            <a href="adminRestaurants" class="btn btn-outline btn-sm">Reset & View All</a>
                            <a href="addRestaurant.jsp" class="btn btn-primary btn-sm" style="margin-left: 8px;">+ Add New Restaurant</a>
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
