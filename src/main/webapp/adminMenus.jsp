<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.myfoodapp.model.Menu" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Menus | BiteRush Admin</title>

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
                <a href="adminMenus" class="admin-nav-link active">
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

    <!-- Main Content: Menu Management -->
    <main class="admin-main-section">
        <div class="container">

            <!-- Page Title Header Row -->
            <div class="admin-page-header-row">
                <div class="admin-page-title-group">
                    <h1>Menu Management</h1>
                    <p class="admin-page-subtitle">Configure culinary dishes, adjust pricing, manage item availability, and assign food categories.</p>
                </div>

                <div style="display: flex; gap: 12px; align-items: center;">
                    <a href="adminDashboard" class="btn btn-outline btn-sm">
                        <span>← Back to Dashboard</span>
                    </a>
                    <a href="addMenu.jsp" class="btn btn-primary btn-sm">
                        <span>+ Add New Menu</span>
                    </a>
                </div>
            </div>

            <!-- Toolbar: Menu Search Form -->
            <div class="admin-toolbar-card">
                <!-- Search Form: Preserving exact action and input name -->
                <form action="adminMenuSearch" method="get" class="admin-search-form">
                    <span class="admin-search-icon">🔍</span>
                    <input type="text"
                           name="menuName"
                           placeholder="Search dishes by name..."
                           required
                           class="admin-search-input">
                    <button type="submit" class="btn btn-primary admin-search-btn">Search</button>
                </form>

                <div style="display: flex; gap: 10px;">
                    <a href="adminMenus" class="btn btn-outline btn-sm">
                        <span>🔄 View All Menus</span>
                    </a>
                </div>
            </div>

            <!-- Menus Data Table Card -->
            <div class="admin-table-card">
                <%
                    List<Menu> menuList = (List<Menu>) request.getAttribute("menuList");
                %>
                <div class="admin-table-header">
                    <h2 class="admin-table-title">
                        <span>🍲</span>
                        <span>Culinary Dishes</span>
                    </h2>
                    <% if (menuList != null) { %>
                        <span class="admin-table-count"><%= menuList.size() %> <%= menuList.size() == 1 ? "Item" : "Items" %></span>
                    <% } %>
                </div>

                <div class="admin-table-wrapper">
                    <% if (menuList != null && !menuList.isEmpty()) { %>
                        <table class="admin-table">
                            <thead>
                                <tr>
                                    <th>Menu ID</th>
                                    <th>Restaurant</th>
                                    <th>Dish & Image</th>
                                    <th>Description</th>
                                    <th>Category</th>
                                    <th>Price</th>
                                    <th>Availability</th>
                                    <th style="text-align: right;">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    for (Menu menu : menuList) {
                                %>
                                    <tr>
                                        <!-- Menu ID -->
                                        <td>
                                            <span class="id-badge">#<%= menu.getMenuId() %></span>
                                        </td>

                                        <!-- Restaurant ID -->
                                        <td>
                                            <span class="id-badge" style="background-color: #FEF3C7; color: #B45309;">
                                                Resto #<%= menu.getRestaurantId() %>
                                            </span>
                                        </td>

                                        <!-- Dish Name & Image -->
                                        <td>
                                            <div class="admin-resto-cell">
                                                <img src="<%= menu.getMenuImageURL() %>" 
                                                     alt="<%= menu.getItemName() %>" 
                                                     class="admin-resto-thumb">
                                                <div>
                                                    <div class="resto-name-bold"><%= menu.getItemName() %></div>
                                                </div>
                                            </div>
                                        </td>

                                        <!-- Truncated Description -->
                                        <td>
                                            <div class="desc-cell-truncate" title="<%= menu.getDescription() != null ? menu.getDescription() : "" %>">
                                                <%= menu.getDescription() != null ? menu.getDescription() : "—" %>
                                            </div>
                                        </td>

                                        <!-- Category -->
                                        <td>
                                            <span class="badge badge-cuisine"><%= menu.getCategory() %></span>
                                        </td>

                                        <!-- Price -->
                                        <td>
                                            <span style="font-weight: 800; color: var(--text-main); font-size: 0.95rem;">
                                                ₹<%= menu.getPrice() %>
                                            </span>
                                        </td>

                                        <!-- Availability Status -->
                                        <td>
                                            <% if (menu.isAvailable()) { %>
                                                <span class="stock-pill available-yes">
                                                    <span>●</span>
                                                    <span>Available</span>
                                                </span>
                                            <% } else { %>
                                                <span class="stock-pill available-no">
                                                    <span>●</span>
                                                    <span>Unavailable</span>
                                                </span>
                                            <% } %>
                                        </td>

                                        <!-- Actions: Edit and Delete -->
                                        <td style="text-align: right;">
                                            <div class="table-actions-cell" style="justify-content: flex-end;">
                                                <!-- Edit Menu Action -->
                                                <a href="editMenu?menuId=<%= menu.getMenuId() %>" class="btn-action-edit">
                                                    <span>✏️</span>
                                                    <span>Edit</span>
                                                </a>

                                                <!-- Delete Menu Action with preserved confirmation prompt -->
                                                <a href="deleteMenu?menuId=<%= menu.getMenuId() %>" 
                                                   onclick="return confirm('Are you sure you want to delete this menu?');"
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
                            <div class="admin-empty-icon">🍲</div>
                            <h3 class="admin-empty-title">No Menu Items Found</h3>
                            <p class="admin-empty-desc">We couldn't find any dishes matching your criteria.</p>
                            <a href="adminMenus" class="btn btn-outline btn-sm">Reset & View All</a>
                            <a href="addMenu.jsp" class="btn btn-primary btn-sm" style="margin-left: 8px;">+ Add New Menu</a>
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
