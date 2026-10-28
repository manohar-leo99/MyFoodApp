<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.myfoodapp.model.Order" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Management | BiteRush Admin</title>

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

    <!-- Main Content: Order Management -->
    <main class="admin-main-section">
        <div class="container">

            <!-- Page Title Header -->
            <div class="admin-page-header-row">
                <div class="admin-page-title-group">
                    <h1>Order Management</h1>
                    <p class="admin-page-subtitle">Track customer orders in real-time, inspect item breakdowns, and update fulfillment stages.</p>
                </div>

                <a href="adminDashboard" class="btn btn-outline btn-sm">
                    <span>← Back to Dashboard</span>
                </a>
            </div>

            <!-- Toolbar: Search Orders by User ID -->
            <div class="admin-toolbar-card">
                <!-- Search Form: Preserving exact action, method, and input name -->
                <form action="adminOrdersSearchByUserId" method="get" class="admin-search-form">
                    <span class="admin-search-icon">🔍</span>
                    <input type="text"
                           name="userId"
                           placeholder="Search orders by User ID..."
                           required
                           class="admin-search-input">
                    <button type="submit" class="btn btn-primary admin-search-btn">Search</button>
                </form>

                <div style="display: flex; gap: 10px;">
                    <a href="adminOrders" class="btn btn-outline btn-sm">
                        <span>🔄 View All Orders</span>
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

            <!-- Orders Data Table Card -->
            <div class="admin-table-card">
                <%
                    List<Order> orders = (List<Order>) request.getAttribute("orders");
                %>
                <div class="admin-table-header">
                    <h2 class="admin-table-title">
                        <span>📦</span>
                        <span>Placed Orders</span>
                    </h2>
                    <% if (orders != null) { %>
                        <span class="admin-table-count"><%= orders.size() %> <%= orders.size() == 1 ? "Order" : "Orders" %></span>
                    <% } %>
                </div>

                <div class="admin-table-wrapper">
                    <% if (orders != null && !orders.isEmpty()) { %>
                        <table class="admin-table">
                            <thead>
                                <tr>
                                    <th>Order ID</th>
                                    <th>Customer</th>
                                    <th>Restaurant</th>
                                    <th>Order Date</th>
                                    <th>Total Amount</th>
                                    <th>Status</th>
                                    <th>Payment Method</th>
                                    <th>Order Items</th>
                                    <th>Update Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    for (Order order : orders) {
                                        String statusClass = "status-pending";
                                        String statusIcon = "⏳";
                                        String currentStatus = order.getStatus() != null ? order.getStatus().trim() : "";

                                        if ("Confirmed".equalsIgnoreCase(currentStatus)) {
                                            statusClass = "status-confirmed";
                                            statusIcon = "📋";
                                        } else if ("Preparing".equalsIgnoreCase(currentStatus)) {
                                            statusClass = "status-preparing";
                                            statusIcon = "🍳";
                                        } else if ("Out for Delivery".equalsIgnoreCase(currentStatus)) {
                                            statusClass = "status-out-for-delivery";
                                            statusIcon = "🛵";
                                        } else if ("Delivered".equalsIgnoreCase(currentStatus)) {
                                            statusClass = "status-delivered";
                                            statusIcon = "✅";
                                        } else if ("Cancelled".equalsIgnoreCase(currentStatus)) {
                                            statusClass = "status-cancelled";
                                            statusIcon = "❌";
                                        }
                                %>
                                    <tr>
                                        <!-- Order ID -->
                                        <td>
                                            <span class="id-badge">#<%= order.getOrderId() %></span>
                                        </td>

                                        <!-- User ID -->
                                        <td>
                                            <span class="id-badge">User #<%= order.getUserId() %></span>
                                        </td>

                                        <!-- Restaurant ID -->
                                        <td>
                                            <span class="badge badge-cuisine">Resto #<%= order.getRestaurantId() %></span>
                                        </td>

                                        <!-- Order Date -->
                                        <td>
                                            <span class="order-date-text"><%= order.getOrderDate() %></span>
                                        </td>

                                        <!-- Total Amount -->
                                        <td>
                                            <strong class="order-amount-text">₹ <%= order.getTotalAmount() %></strong>
                                        </td>

                                        <!-- Status Badge -->
                                        <td>
                                            <span class="order-status-badge <%= statusClass %>">
                                                <span><%= statusIcon %></span>
                                                <span><%= order.getStatus() %></span>
                                            </span>
                                        </td>

                                        <!-- Payment Method -->
                                        <td>
                                            <span class="badge badge-payment">
                                                <span>💳</span>
                                                <span><%= order.getPaymentMethod() %></span>
                                            </span>
                                        </td>

                                        <!-- View Items Link -->
                                        <td>
                                            <a href="adminOrderItems?orderId=<%= order.getOrderId() %>" 
                                               class="btn btn-outline btn-sm"
                                               style="white-space: nowrap;">
                                                <span>📦 View Items</span>
                                            </a>
                                        </td>

                                        <!-- Update Status Form -->
                                        <td>
                                            <form action="updateOrderStatus" method="post" class="admin-status-form">
                                                <input type="hidden"
                                                       name="orderId"
                                                       value="<%= order.getOrderId() %>">

                                                <select name="status" class="admin-select-sm">
                                                    <option value="Pending"
                                                        <%= "Pending".equals(order.getStatus()) ? "selected" : "" %>>
                                                        Pending
                                                    </option>
                                                    <option value="Confirmed"
                                                        <%= "Confirmed".equals(order.getStatus()) ? "selected" : "" %>>
                                                        Confirmed
                                                    </option>
                                                    <option value="Preparing"
                                                        <%= "Preparing".equals(order.getStatus()) ? "selected" : "" %>>
                                                        Preparing
                                                    </option>
                                                    <option value="Out for Delivery"
                                                        <%= "Out for Delivery".equals(order.getStatus()) ? "selected" : "" %>>
                                                        Out for Delivery
                                                    </option>
                                                    <option value="Delivered"
                                                        <%= "Delivered".equals(order.getStatus()) ? "selected" : "" %>>
                                                        Delivered
                                                    </option>
                                                    <option value="Cancelled"
                                                        <%= "Cancelled".equals(order.getStatus()) ? "selected" : "" %>>
                                                        Cancelled
                                                    </option>
                                                </select>

                                                <button type="submit" class="btn btn-primary btn-sm">Update</button>
                                            </form>
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
                            <div class="admin-empty-icon">📦</div>
                            <h3 class="admin-empty-title">No Orders Found</h3>
                            <p class="admin-empty-desc">There are no orders matching your current criteria or query.</p>
                            <a href="adminOrders" class="btn btn-primary btn-sm">View All Orders</a>
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
