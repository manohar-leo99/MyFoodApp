<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    Object orderIdObj = request.getAttribute("orderId");
    Integer orderId = (orderIdObj instanceof Integer) ? (Integer) orderIdObj : null;

    Object totalObj = request.getAttribute("total");
    Double total = (totalObj instanceof Double) ? (Double) totalObj : null;

    String payment = (String) request.getAttribute("payment");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Placed Successfully | BiteRush</title>
    <meta name="description" content="Your BiteRush order has been confirmed and placed with the restaurant.">

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

    <!-- Main Content: Order Success Section -->
    <main class="order-success-section">
        <div class="container">

            <div class="order-success-card">
                <!-- Success Animated Check Icon -->
                <div class="order-success-icon-badge" aria-hidden="true">
                    <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.6" stroke-linecap="round" stroke-linejoin="round">
                        <polyline points="20 6 9 17 4 12"></polyline>
                    </svg>
                </div>

                <!-- Page Heading -->
                <h1 class="order-success-title">Order Placed Successfully!</h1>
                <p class="order-success-subtitle">
                    Thank you for ordering with BiteRush! Your order has been dispatched to the kitchen and is being freshly prepared.
                </p>

                <!-- Order Status Timeline -->
                <div class="order-timeline" aria-label="Order Tracking Progress">
                    <div class="timeline-step is-complete">
                        <div class="timeline-dot">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round">
                                <polyline points="20 6 9 17 4 12"></polyline>
                            </svg>
                        </div>
                        <span class="timeline-label">Order Placed</span>
                    </div>
                    <div class="timeline-line is-active"></div>
                    <div class="timeline-step is-active">
                        <div class="timeline-dot">
                            <span class="pulse-inner"></span>
                        </div>
                        <span class="timeline-label">Preparing</span>
                    </div>
                    <div class="timeline-line"></div>
                    <div class="timeline-step">
                        <div class="timeline-dot"></div>
                        <span class="timeline-label">On the way</span>
                    </div>
                    <div class="timeline-line"></div>
                    <div class="timeline-step">
                        <div class="timeline-dot"></div>
                        <span class="timeline-label">Delivered</span>
                    </div>
                </div>

                <!-- Order Receipt Details Box -->
                <div class="order-receipt-box">
                    <!-- Order ID -->
                    <div class="order-receipt-row">
                        <span class="order-receipt-label">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <line x1="16.5" y1="9.4" x2="7.5" y2="4.21"></line>
                                <path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"></path>
                                <polyline points="3.27 6.96 12 12.01 20.73 6.96"></polyline>
                                <line x1="12" y1="22.08" x2="12" y2="12"></line>
                            </svg>
                            <span>Order ID</span>
                        </span>
                        <span class="order-receipt-value">
                            <span class="id-badge">#<%= orderId != null ? orderId : "—" %></span>
                        </span>
                    </div>

                    <!-- Total Amount -->
                    <div class="order-receipt-row">
                        <span class="order-receipt-label">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <line x1="12" y1="1" x2="12" y2="23"></line>
                                <path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"></path>
                            </svg>
                            <span>Total Amount</span>
                        </span>
                        <span class="order-receipt-value receipt-amount">
                            ₹ <%= total != null ? String.format("%.2f", total) : "0.00" %>
                        </span>
                    </div>

                    <!-- Payment Method -->
                    <div class="order-receipt-row">
                        <span class="order-receipt-label">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <rect x="1" y="4" width="22" height="16" rx="2" ry="2"></rect>
                                <line x1="1" y1="10" x2="23" y2="10"></line>
                            </svg>
                            <span>Payment Method</span>
                        </span>
                        <span class="order-receipt-value">
                            <span class="badge badge-payment">
                                <%= payment != null ? payment : "Cash on Delivery" %>
                            </span>
                        </span>
                    </div>

                    <!-- Status -->
                    <div class="order-receipt-row">
                        <span class="order-receipt-label">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <circle cx="12" cy="12" r="10"></circle>
                                <polyline points="12 6 12 12 16 14"></polyline>
                            </svg>
                            <span>Order Status</span>
                        </span>
                        <span class="order-receipt-value">
                            <span class="order-status-badge status-placed">
                                <span class="dot-amber"></span>
                                <span>Confirmed</span>
                            </span>
                        </span>
                    </div>
                </div>

                <!-- Action Links -->
                <div class="order-success-actions">
                    <a href="restaurant.jsp" class="btn btn-primary">
                        <span>Order More Food</span>
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                            <line x1="5" y1="12" x2="19" y2="12"></line>
                            <polyline points="12 5 19 12 12 19"></polyline>
                        </svg>
                    </a>
                    <a href="MyOrdersHistory" class="btn btn-outline">
                        <span>View My Orders</span>
                    </a>
                </div>
            </div>

        </div>
    </main>

    <!-- Reusable Footer Component -->
    <%@ include file="components/footer.jsp" %>

</body>
</html>
