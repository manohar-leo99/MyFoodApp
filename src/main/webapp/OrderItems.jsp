<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.myfoodapp.model.CartItem" %>

<%
    List<CartItem> oItems = (List<CartItem>) request.getAttribute("OrderItemsList");
    String itemsTotalAmount = request.getParameter("itemsTotalAmount");
    String orderId = request.getParameter("orderId");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Details <%= orderId != null ? "#" + orderId : "" %> | BiteRush</title>
    <meta name="description" content="Itemized dishes, quantities, and pricing breakdown for your BiteRush order.">

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

    <!-- Main Content: Order Items Section -->
    <main class="orders-page-section">
        <div class="container">

            <!-- Page Title Header Row -->
            <div class="orders-header-row">
                <div>
                    <div class="orders-title-group">
                        <h1 class="orders-page-title">Order Details</h1>
                        <% if (orderId != null && !orderId.trim().isEmpty()) { %>
                            <span class="orders-count-badge">#Order <%= orderId %></span>
                        <% } %>
                    </div>
                    <p class="orders-subtitle">Itemized dish breakdown, quantities, and pricing for this order.</p>
                </div>

                <div>
                    <a href="MyOrdersHistory" class="btn btn-outline btn-sm">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                            <line x1="19" y1="12" x2="5" y2="12"></line>
                            <polyline points="12 19 5 12 12 5"></polyline>
                        </svg>
                        <span>Back to My Orders</span>
                    </a>
                </div>
            </div>

            <% if (oItems != null && !oItems.isEmpty()) { 
                double calculatedSum = 0;
            %>
                <!-- Order Items Card Container -->
                <div class="order-details-card">
                    <!-- Card Header -->
                    <div class="order-details-header">
                        <div class="order-details-title">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <path d="M18 8h1a4 4 0 0 1 0 8h-1"></path>
                                <path d="M2 8h16v9a4 4 0 0 1-4 4H6a4 4 0 0 1-4-4V8z"></path>
                                <line x1="6" y1="1" x2="6" y2="4"></line>
                                <line x1="10" y1="1" x2="10" y2="4"></line>
                                <line x1="14" y1="1" x2="14" y2="4"></line>
                            </svg>
                            <span>Ordered Dishes</span>
                        </div>
                        <span class="badge-role">
                            <%= oItems.size() %> <%= oItems.size() == 1 ? "Item" : "Items" %>
                        </span>
                    </div>

                    <!-- Items Table -->
                    <div class="order-table-responsive">
                        <table class="order-items-table">
                            <thead>
                                <tr>
                                    <th>Dish</th>
                                    <th>Menu ID</th>
                                    <th>Price</th>
                                    <th>Quantity</th>
                                    <th style="text-align: right;">Subtotal</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    for (CartItem item : oItems) {
                                        double lineTotal = item.getPrice() * item.getQuantity();
                                        calculatedSum += lineTotal;
                                %>
                                    <tr>
                                        <!-- Dish Details with Image -->
                                        <td>
                                            <div class="order-item-cell">
                                                <% if (item.getItemImageURL() != null && !item.getItemImageURL().trim().isEmpty()) { %>
                                                    <img src="<%= item.getItemImageURL() %>" 
                                                         alt="<%= item.getItemName() %>" 
                                                         class="order-item-thumb"
                                                         loading="lazy">
                                                <% } else { %>
                                                    <div class="order-item-thumb fallback-thumb">
                                                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                            <circle cx="12" cy="12" r="10"></circle>
                                                            <path d="M8 14s1.5 2 4 2 4-2 4-2"></path>
                                                        </svg>
                                                    </div>
                                                <% } %>
                                                <div class="order-item-info">
                                                    <span class="order-item-name"><%= item.getItemName() %></span>
                                                </div>
                                            </div>
                                        </td>

                                        <!-- Menu ID -->
                                        <td>
                                            <span class="id-badge">#<%= item.getMenuId() %></span>
                                        </td>

                                        <!-- Unit Price -->
                                        <td>
                                            <span class="price-dim">₹ <%= String.format("%.2f", item.getPrice()) %></span>
                                        </td>

                                        <!-- Quantity -->
                                        <td>
                                            <span class="qty-pill">
                                                <%= item.getQuantity() %>×
                                            </span>
                                        </td>

                                        <!-- Subtotal in saffron -->
                                        <td style="text-align: right;">
                                            <strong class="line-total-amount">
                                                ₹ <%= String.format("%.2f", lineTotal) %>
                                            </strong>
                                        </td>
                                    </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>

                    <!-- Card Footer with Total Amount -->
                    <div class="order-details-footer">
                        <a href="restaurant.jsp" class="btn btn-outline btn-sm">
                            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <line x1="12" y1="5" x2="12" y2="19"></line>
                                <line x1="5" y1="12" x2="19" y2="12"></line>
                            </svg>
                            <span>Order More Food</span>
                        </a>

                        <div class="order-total-group">
                            <span class="order-total-label">Order Total Amount:</span>
                            <span class="order-total-val">
                                ₹ <%= itemsTotalAmount != null ? itemsTotalAmount : String.format("%.2f", calculatedSum) %>
                            </span>
                        </div>
                    </div>
                </div>

            <% } else { %>
                <!-- Empty State -->
                <div class="orders-empty-card">
                    <div class="orders-empty-icon" aria-hidden="true">
                        <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
                            <polyline points="14 2 14 8 20 8"></polyline>
                        </svg>
                    </div>
                    <h2 class="orders-empty-title">No Ordered Items Found</h2>
                    <p class="orders-empty-desc">We couldn't retrieve the itemized breakdown for this order, or the order may have expired.</p>
                    <a href="MyOrdersHistory" class="btn btn-primary">
                        <span>← Back to My Orders</span>
                    </a>
                </div>
            <% } %>

        </div>
    </main>

    <!-- Reusable Footer Component -->
    <%@ include file="components/footer.jsp" %>

</body>
</html>
