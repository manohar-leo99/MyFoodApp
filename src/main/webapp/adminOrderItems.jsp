<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.myfoodapp.model.OrderItem" %>
<%@ page import="com.myfoodapp.daoimp.MenuDaoImp" %>
<%@ page import="com.myfoodapp.model.Menu" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Items | BiteRush Admin</title>

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
                <a href="adminOrders" class="admin-nav-link active">
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

    <!-- Main Content: Order Items Section -->
    <main class="admin-main-section">
        <div class="container">

            <%
                List<OrderItem> orderItems = (List<OrderItem>) request.getAttribute("orderItems");
                Integer orderId = (Integer) request.getAttribute("orderId");
            %>

            <!-- Page Title Header -->
            <div class="admin-page-header-row">
                <div class="admin-page-title-group">
                    <h1>Order Items Breakdown</h1>
                    <p class="admin-page-subtitle">Itemized culinary selections, portion quantities, and line-item totals for Order #<%= orderId != null ? orderId : "—" %>.</p>
                </div>

                <a href="adminOrders" class="btn btn-outline btn-sm">
                    <span>← Back to Orders</span>
                </a>
            </div>

            <!-- Order Reference & Meta Banner -->
            <div class="admin-toolbar-card" style="margin-bottom: 24px;">
                <div style="display: flex; align-items: center; gap: 14px;">
                    <span style="font-size: 1.5rem;">📦</span>
                    <div>
                        <div style="font-size: 0.8rem; color: var(--text-muted); font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px;">Order Reference</div>
                        <div style="font-size: 1.15rem; font-weight: 800; color: var(--text-main);">
                            Order ID: #<%= orderId != null ? orderId : "—" %>
                        </div>
                    </div>
                </div>

                <div style="display: flex; align-items: center; gap: 12px;">
                    <% if (orderItems != null) { %>
                        <span class="admin-table-count"><%= orderItems.size() %> <%= orderItems.size() == 1 ? "Line Item" : "Line Items" %></span>
                    <% } %>
                    <a href="adminOrders" class="btn btn-outline btn-sm">
                        <span>Back to All Orders</span>
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

            <!-- Order Items Table Card -->
            <div class="admin-table-card">
                <div class="admin-table-header">
                    <h2 class="admin-table-title">
                        <span>🍽️</span>
                        <span>Ordered Dishes</span>
                    </h2>
                </div>

                <div class="admin-table-wrapper">
                    <% if (orderItems != null && !orderItems.isEmpty()) { 
                        MenuDaoImp menuDaoImp = new MenuDaoImp();
                        double calculatedSubtotal = 0;
                    %>
                        <table class="admin-table">
                            <thead>
                                <tr>
                                    <th style="width: 70px;">Item Image</th>
                                    <th>Item Name</th>
                                    <th>Order Item ID</th>
                                    <th>Menu ID</th>
                                    <th>Quantity</th>
                                    <th style="text-align: right;">Item Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    for (OrderItem item : orderItems) {
                                        Menu menu = menuDaoImp.getMenu(item.getMenuId());
                                        calculatedSubtotal += item.getItemTotal();
                                %>
                                    <tr>
                                        <!-- Item Image -->
                                        <td>
                                            <% if (menu != null && menu.getMenuImageURL() != null && !menu.getMenuImageURL().trim().isEmpty()) { %>
                                                <img src="<%= menu.getMenuImageURL() %>"
                                                     alt="<%= menu.getItemName() %>"
                                                     class="admin-resto-thumb">
                                            <% } else { %>
                                                <div class="admin-resto-thumb-placeholder">🍽️</div>
                                            <% } %>
                                        </td>

                                        <!-- Item Name -->
                                        <td>
                                            <div class="resto-name-bold">
                                                <%= menu != null ? menu.getItemName() : "Item no longer available" %>
                                            </div>
                                        </td>

                                        <!-- Order Item ID -->
                                        <td>
                                            <span class="id-badge">#<%= item.getOrderItemId() %></span>
                                        </td>

                                        <!-- Menu ID -->
                                        <td>
                                            <span class="id-badge">Menu #<%= item.getMenuId() %></span>
                                        </td>

                                        <!-- Quantity -->
                                        <td>
                                            <span class="badge badge-cuisine">× <%= item.getQuantity() %></span>
                                        </td>

                                        <!-- Item Total -->
                                        <td style="text-align: right;">
                                            <strong class="order-amount-text">₹ <%= item.getItemTotal() %></strong>
                                        </td>
                                    </tr>
                                <%
                                    }
                                %>
                            </tbody>
                            <tfoot>
                                <tr style="background-color: var(--bg-surface);">
                                    <td colspan="5" style="text-align: right; padding: 18px 20px; font-weight: 800; color: var(--text-main);">
                                        Items Subtotal:
                                    </td>
                                    <td style="text-align: right; padding: 18px 20px;">
                                        <strong class="order-amount-text" style="font-size: 1.15rem; color: var(--primary);">
                                            ₹ <%= String.format("%.2f", calculatedSubtotal) %>
                                        </strong>
                                    </td>
                                </tr>
                            </tfoot>
                        </table>
                    <% } else { %>
                        <!-- Empty State -->
                        <div class="admin-empty-state">
                            <div class="admin-empty-icon">🍽️</div>
                            <h3 class="admin-empty-title">No Items Found</h3>
                            <p class="admin-empty-desc">There are no line items recorded for this order.</p>
                            <a href="adminOrders" class="btn btn-primary btn-sm">Back to Orders</a>
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
