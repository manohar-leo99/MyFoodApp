<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.myfoodapp.model.Order" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders | BiteRush</title>
    <meta name="description" content="Review your past BiteRush orders, track active deliveries, and inspect itemized dish receipts.">

    <!-- Google Fonts: Inter & Playfair Display -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">

    <!-- BiteRush Stylesheets -->
    <link rel="stylesheet" href="css/global.css?v=5">
    <link rel="stylesheet" href="css/common.css?v=5">
    <link rel="stylesheet" href="css/navbar.css?v=5">
    <link rel="stylesheet" href="css/orders.css?v=5">
    <link rel="stylesheet" href="css/footer.css?v=5">
</head>
<body>

    <!-- Reusable Navbar Component -->
    <%@ include file="components/navbar.jsp" %>

    <main class="orders-page-section">
        <div class="container">

            <%
                List<Order> orders = (List<Order>) request.getAttribute("orders");
                if (orders != null && !orders.isEmpty()) {
            %>
                <!-- Orders Page Header -->
                <div class="orders-header-row">
                    <div>
                        <div class="orders-title-group">
                            <h1 class="orders-page-title">My Orders</h1>
                            <span class="orders-count-badge"><%= orders.size() %> <%= orders.size() == 1 ? "Order" : "Orders" %></span>
                        </div>
                        <p class="orders-subtitle">Review your past deliveries, check itemized dish breakdowns, and track order progress.</p>
                    </div>

                    <a href="restaurant.jsp" class="btn btn-outline btn-sm">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                            <line x1="19" y1="12" x2="5" y2="12"></line>
                            <polyline points="12 19 5 12 12 5"></polyline>
                        </svg>
                        <span>Back to Restaurants</span>
                    </a>
                </div>

                <!-- Orders Stack -->
                <div class="orders-list">
                    <%
                        for (Order order : orders) {
                            String rawStatus = order.getStatus() != null ? order.getStatus().trim() : "Pending";
                            String statusLower = rawStatus.toLowerCase();
                            String statusBadgeClass = "status-placed";
                            if (statusLower.contains("deliver") || statusLower.contains("complete")) {
                                statusBadgeClass = "status-delivered";
                            } else if (statusLower.contains("cancel")) {
                                statusBadgeClass = "status-cancelled";
                            }
                    %>
                        <!-- Single Order Card -->
                        <article class="order-card" id="order-card-<%= order.getOrderId() %>">
                            <div class="order-card-header">
                                <div class="order-id-group">
                                    <span class="order-id-pill">
                                        <span class="hash">#</span>Order <%= order.getOrderId() %>
                                    </span>
                                </div>

                                <div class="order-status-badge <%= statusBadgeClass %>">
                                    <span class="status-dot-indicator"></span>
                                    <span><%= rawStatus %></span>
                                </div>
                            </div>

                            <div class="order-card-body">
                                <div class="order-metric">
                                    <span class="metric-label">Order Date</span>
                                    <span class="metric-value">
                                        <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="metric-icon" aria-hidden="true">
                                            <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
                                            <line x1="16" y1="2" x2="16" y2="6"></line>
                                            <line x1="8" y1="2" x2="8" y2="6"></line>
                                            <line x1="3" y1="10" x2="21" y2="10"></line>
                                        </svg>
                                        <span><%= order.getOrderDate() %></span>
                                    </span>
                                </div>

                                <div class="order-metric">
                                    <span class="metric-label">Payment Method</span>
                                    <span class="metric-value">
                                        <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="metric-icon" aria-hidden="true">
                                            <rect x="1" y="4" width="22" height="16" rx="2" ry="2"></rect>
                                            <line x1="1" y1="10" x2="23" y2="10"></line>
                                        </svg>
                                        <span><%= order.getPaymentMethod() != null ? order.getPaymentMethod() : "Cash on Delivery" %></span>
                                    </span>
                                </div>

                                <div class="order-metric">
                                    <span class="metric-label">Total Amount</span>
                                    <span class="metric-value total-highlight">
                                        <span>₹</span><%= String.format("%.2f", order.getTotalAmount()) %>
                                    </span>
                                </div>
                            </div>

                            <div class="order-card-footer">
                                <div class="order-actions-wrap">
                                    <!-- View Order Details Link -->
                                    <a href="OrderItems?orderId=<%= order.getOrderId()%>&itemsTotalAmount=<%= order.getTotalAmount()%>" 
                                       class="btn btn-primary btn-view-order">
                                        <span>View Details</span>
                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                            <line x1="5" y1="12" x2="19" y2="12"></line>
                                            <polyline points="12 5 19 12 12 19"></polyline>
                                        </svg>
                                    </a>

                                    <!-- Cancel Order Link (12px gap, outlined danger #C8452B, exact Servlet params) -->
                                    <% if (!statusLower.contains("cancel") && !statusLower.contains("deliver")) { %>
                                        <a href="cancelOrder?orderId=<%=order.getOrderId()%>&status=<%=order.getStatus()%>" 
                                           class="btn btn-danger-outline btn-cancel-order">
                                            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                                <line x1="18" y1="6" x2="6" y2="18"></line>
                                                <line x1="6" y1="6" x2="18" y2="18"></line>
                                            </svg>
                                            <span>Cancel Order</span>
                                        </a>
                                    <% } %>
                                </div>
                            </div>
                        </article>
                    <%
                        }
                    %>
                </div>

            <%
                } else {
            %>
                <!-- Empty Orders State -->
                <div class="orders-empty-card">
                    <div class="orders-empty-icon" aria-hidden="true">
                        <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
                            <polyline points="14 2 14 8 20 8"></polyline>
                            <line x1="16" y1="13" x2="8" y2="13"></line>
                            <line x1="16" y1="17" x2="8" y2="17"></line>
                            <polyline points="10 9 9 9 8 9"></polyline>
                        </svg>
                    </div>
                    <h2 class="orders-empty-title">No Orders Placed Yet</h2>
                    <p class="orders-empty-desc">You haven't placed any food orders yet. Browse our selection of popular restaurants and treat yourself to something delicious!</p>
                    <a href="restaurant.jsp" class="btn btn-primary">
                        <span>Explore Restaurants</span>
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                            <line x1="5" y1="12" x2="19" y2="12"></line>
                            <polyline points="12 5 19 12 12 19"></polyline>
                        </svg>
                    </a>
                </div>
            <%
                }
            %>

        </div>
    </main>

    <!-- Reusable Footer Component -->
    <%@ include file="components/footer.jsp" %>

</body>
</html>
