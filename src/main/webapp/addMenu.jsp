<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Menu Item | BiteRush Admin</title>

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

    <!-- Main Content: Add Menu Item Form -->
    <main class="admin-main-section">
        <div class="container">

            <div class="admin-form-container">
                <div class="admin-form-card">
                    <!-- Form Header -->
                    <div class="admin-form-header">
                        <h1 class="admin-form-title">
                            <span>🍲</span>
                            <span>Add New Menu Item</span>
                        </h1>
                        <p class="admin-form-subtitle">Register a new dish offering with its culinary specifications, price, and image URL.</p>
                    </div>

                    <!-- Add Menu Form: Preserving exact action, method, and input names -->
                    <form action="addMenu" method="post">
                        <div class="admin-form-grid">
                            <!-- Field: Item Name -->
                            <div class="admin-form-group">
                                <label for="itemNameInput" class="admin-label">Item Name</label>
                                <input type="text"
                                       id="itemNameInput"
                                       name="itemName"
                                       placeholder="e.g. Chicken Dum Biryani"
                                       required
                                       class="admin-input">
                            </div>

                            <!-- Field: Category -->
                            <div class="admin-form-group">
                                <label for="categoryInput" class="admin-label">Culinary Category</label>
                                <input type="text"
                                       id="categoryInput"
                                       name="category"
                                       placeholder="e.g. Biryani, Starters, Pizza"
                                       required
                                       class="admin-input">
                            </div>

                            <!-- Field: Restaurant ID -->
                            <div class="admin-form-group">
                                <label for="restaurantIdInput" class="admin-label">Restaurant ID</label>
                                <input type="number"
                                       id="restaurantIdInput"
                                       name="restaurantId"
                                       placeholder="Enter partner Restaurant ID"
                                       required
                                       class="admin-input">
                                <span class="admin-input-hint">ID of the registered partner restaurant offering this dish.</span>
                            </div>

                            <!-- Field: Price -->
                            <div class="admin-form-group">
                                <label for="priceInput" class="admin-label">Price (₹)</label>
                                <input type="number"
                                       id="priceInput"
                                       name="price"
                                       step="0.01"
                                       placeholder="e.g. 299.00"
                                       required
                                       class="admin-input">
                            </div>

                            <!-- Field: Availability Status -->
                            <div class="admin-form-group">
                                <label for="isAvailableSelect" class="admin-label">Item Availability</label>
                                <select id="isAvailableSelect" name="isAvailable" required class="admin-select">
                                    <option value="true">Yes (In Stock / Active)</option>
                                    <option value="false">No (Out of Stock / Inactive)</option>
                                </select>
                            </div>

                            <!-- Field: Menu Image URL -->
                            <div class="admin-form-group">
                                <label for="menuImageURLInput" class="admin-label">Menu Image URL</label>
                                <input type="text"
                                       id="menuImageURLInput"
                                       name="menuImageURL"
                                       placeholder="https://example.com/images/dish.jpg"
                                       required
                                       class="admin-input">
                                <span class="admin-input-hint">Direct image URL stored in MySQL database.</span>
                            </div>

                            <!-- Field: Description (Full Span) -->
                            <div class="admin-form-group full-span">
                                <label for="descriptionInput" class="admin-label">Description</label>
                                <input type="text"
                                       id="descriptionInput"
                                       name="description"
                                       placeholder="Short description highlighting flavors, ingredients, or portions"
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
                                <span>+ Add Menu</span>
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
