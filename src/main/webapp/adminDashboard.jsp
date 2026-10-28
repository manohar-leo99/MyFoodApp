<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | BiteRush</title>

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
                <a href="adminDashboard.jsp" class="admin-brand">
                    <span class="brand-icon">⚡</span>
                    <span>Bite<span style="color: var(--primary);">Rush</span></span>
                </a>
                <span class="admin-brand-tag">Admin Portal</span>
            </div>

            <div class="admin-nav-actions">
                <a href="restaurant.jsp" class="admin-nav-link">
                    <span>🏪</span>
                    <span>Storefront</span>
                </a>
                <%@ include file="components/adminProfileDropdown.jsp" %>
            </div>
        </div>
    </header>

    <!-- Main Admin Dashboard Content -->
    <main class="admin-main-section">
        <div class="container">

            <!-- Welcome Header Banner -->
            <div class="admin-welcome-banner">
                <div class="admin-banner-text">
                    <div class="admin-badge-pill">
                        <span>🛡️</span>
                        <span>Administrative Control Center</span>
                    </div>
                    <h1 class="admin-dashboard-title">Admin Dashboard</h1>
                    <p class="admin-dashboard-subtitle">Manage partner restaurants, update culinary menu catalogs, review registered accounts, and oversee customer orders in real-time.</p>
                </div>

                <div class="admin-greeting-pill">
                    <span>👋</span>
                    <span>Welcome Admin</span>
                </div>
            </div>

            <!-- Management Modules Section -->
            <div class="admin-section-header">
                <h2 class="admin-section-title">Core Management Modules</h2>
                <p class="admin-section-desc">Select an operational module below to access management tables and administrative tools.</p>
            </div>

            <div class="admin-modules-grid">
                <!-- Module 1: Manage Restaurants -->
                <div class="admin-module-card">
                    <div class="module-icon-wrapper">🏬</div>
                    <h3 class="module-card-title">Manage Restaurants</h3>
                    <p class="module-card-desc">Review existing dining partners, edit operational locations, manage culinary profiles, and onboard new restaurants.</p>
                    <div class="module-card-action">
                        <a href="adminRestaurants" class="btn btn-primary btn-block">
                            <span>Manage Restaurants</span>
                            <span>→</span>
                        </a>
                    </div>
                </div>

                <!-- Module 2: Manage Menus -->
                <div class="admin-module-card">
                    <div class="module-icon-wrapper">🍲</div>
                    <h3 class="module-card-title">Manage Menu</h3>
                    <p class="module-card-desc">Update dish offerings, modify pricing, control item availability, assign culinary categories, and configure food descriptions.</p>
                    <div class="module-card-action">
                        <a href="adminMenus" class="btn btn-primary btn-block">
                            <span>Manage Menu</span>
                            <span>→</span>
                        </a>
                    </div>
                </div>

                <!-- Module 3: Manage Orders -->
                <div class="admin-module-card">
                    <div class="module-icon-wrapper">📦</div>
                    <h3 class="module-card-title">Manage Orders</h3>
                    <p class="module-card-desc">Monitor live customer orders, review detailed item breakdowns, inspect customer totals, and update fulfillment statuses.</p>
                    <div class="module-card-action">
                        <a href="adminOrders" class="btn btn-primary btn-block">
                            <span>Manage Orders</span>
                            <span>→</span>
                        </a>
                    </div>
                </div>

                <!-- Module 4: Manage Users -->
                <div class="admin-module-card">
                    <div class="module-icon-wrapper">👥</div>
                    <h3 class="module-card-title">Manage Users</h3>
                    <p class="module-card-desc">Inspect registered customer accounts, review user permissions, verify contact emails, and manage user records.</p>
                    <div class="module-card-action">
                        <a href="adminUsers" class="btn btn-primary btn-block">
                            <span>Manage Users</span>
                            <span>→</span>
                        </a>
                    </div>
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
