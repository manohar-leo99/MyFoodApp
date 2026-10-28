<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.myfoodapp.model.Menu" %>

<%
    Menu menu = (Menu) request.getAttribute("menu");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Menu Item | BiteRush Admin</title>

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

    <!-- Main Content: Edit Menu Item Form -->
    <main class="admin-main-section">
        <div class="container">

            <% if (menu != null) { %>
                <div class="admin-form-container">
                    <div class="admin-form-card">
                        <!-- Form Header -->
                        <div class="admin-form-header">
                            <h1 class="admin-form-title">
                                <span>✏️</span>
                                <span>Edit Menu Item</span>
                            </h1>
                            <p class="admin-form-subtitle">Modify culinary item details, price, category, and real-time inventory availability.</p>
                        </div>

                        <!-- Current Dish Preview Banner -->
                        <div class="edit-preview-badge">
                            <img src="<%= menu.getMenuImageURL() %>" 
                                 alt="<%= menu.getItemName() %>" 
                                 class="preview-thumb">
                            <div class="preview-info">
                                <div class="preview-title"><%= menu.getItemName() %></div>
                                <div class="preview-meta">
                                    <span>Menu ID: #<%= menu.getMenuId() %></span>
                                    <span> • </span>
                                    <span>Partner Restaurant ID: #<%= menu.getRestaurantId() %></span>
                                </div>
                            </div>
                        </div>

                        <!-- Edit Menu Form: Preserving exact action, method, and input names -->
                        <form action="editMenu" method="post">
                            <!-- Menu ID is not editable (Preserved hidden field) -->
                            <input type="hidden"
                                   name="menuId"
                                   value="<%= menu.getMenuId() %>">

                            <div class="admin-form-grid">
                                <!-- Field: Item Name -->
                                <div class="admin-form-group">
                                    <label for="itemNameInput" class="admin-label">Item Name</label>
                                    <input type="text"
                                           id="itemNameInput"
                                           name="itemName"
                                           value="<%= menu.getItemName() %>"
                                           required
                                           class="admin-input">
                                </div>

                                <!-- Field: Category -->
                                <div class="admin-form-group">
                                    <label for="categoryInput" class="admin-label">Culinary Category</label>
                                    <input type="text"
                                           id="categoryInput"
                                           name="category"
                                           value="<%= menu.getCategory() %>"
                                           required
                                           class="admin-input">
                                </div>

                                <!-- Field: Restaurant ID -->
                                <div class="admin-form-group">
                                    <label for="restaurantIdInput" class="admin-label">Restaurant ID</label>
                                    <input type="number"
                                           id="restaurantIdInput"
                                           name="restaurantId"
                                           value="<%= menu.getRestaurantId() %>"
                                           required
                                           class="admin-input">
                                </div>

                                <!-- Field: Price -->
                                <div class="admin-form-group">
                                    <label for="priceInput" class="admin-label">Price (₹)</label>
                                    <input type="number"
                                           id="priceInput"
                                           name="price"
                                           step="0.01"
                                           value="<%= menu.getPrice() %>"
                                           required
                                           class="admin-input">
                                </div>

                                <!-- Field: Availability Status -->
                                <div class="admin-form-group">
                                    <label for="isAvailableSelect" class="admin-label">Item Availability</label>
                                    <select id="isAvailableSelect" name="isAvailable" class="admin-select">
                                        <option value="true" <%= menu.isAvailable() ? "selected" : "" %>>
                                            Yes (Available / Active)
                                        </option>
                                        <option value="false" <%= !menu.isAvailable() ? "selected" : "" %>>
                                            No (Unavailable / Inactive)
                                        </option>
                                    </select>
                                </div>

                                <!-- Field: Menu Image URL -->
                                <div class="admin-form-group">
                                    <label for="menuImageURLInput" class="admin-label">Menu Image URL</label>
                                    <input type="text"
                                           id="menuImageURLInput"
                                           name="menuImageURL"
                                           value="<%= menu.getMenuImageURL() %>"
                                           required
                                           class="admin-input">
                                </div>

                                <!-- Field: Description (Full Span) -->
                                <div class="admin-form-group full-span">
                                    <label for="descriptionInput" class="admin-label">Description</label>
                                    <input type="text"
                                           id="descriptionInput"
                                           name="description"
                                           value="<%= menu.getDescription() %>"
                                           required
                                           class="admin-input">
                                </div>
                            </div>

                            <!-- Form Actions Bar -->
                            <div class="admin-form-actions">
                                <a href="adminMenus" class="btn btn-outline">
                                    <span>Cancel</span>
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <span>Update Menu</span>
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            <% } else { %>
                <!-- Fallback in case of null menu attribute -->
                <div class="admin-empty-state">
                    <div class="admin-empty-icon">⚠️</div>
                    <h2 class="admin-empty-title">Menu Item Not Found</h2>
                    <p class="admin-empty-desc">The requested menu item could not be loaded or session expired.</p>
                    <a href="adminMenus" class="btn btn-primary">Return to Menus</a>
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
