<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.myfoodapp.model.Cart" %>
<%@ page import="com.myfoodapp.model.CartItem" %>
<%@ page import="java.util.Map" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Cart | BiteRush</title>
    <meta name="description" content="Review your selected dishes, customize quantities, and proceed to secure checkout on BiteRush.">

    <!-- Google Fonts: Inter & Playfair Display -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">

    <!-- BiteRush Stylesheets -->
    <link rel="stylesheet" href="css/global.css?v=5">
    <link rel="stylesheet" href="css/common.css?v=5">
    <link rel="stylesheet" href="css/navbar.css?v=5">
    <link rel="stylesheet" href="css/cart.css?v=5">
    <link rel="stylesheet" href="css/footer.css?v=5">
</head>
<body>

    <!-- Reusable Navbar Component -->
    <%@ include file="components/navbar.jsp" %>

    <main class="cart-page-section">
        <div class="container">

            <%
                String error = request.getParameter("error");
                if ("differentRestaurant".equals(error)) {
            %>
                <!-- Different Restaurant Warning Banner -->
                <div class="cart-alert-warning" role="alert">
                    <div class="cart-alert-icon-box" aria-hidden="true">
                        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z"></path>
                            <line x1="12" y1="9" x2="12" y2="13"></line>
                            <line x1="12" y1="17" x2="12.01" y2="17"></line>
                        </svg>
                    </div>
                    <div class="cart-alert-content">
                        <h4>Items from Another Restaurant in Cart</h4>
                        <p>Your cart already contains items from a different restaurant. Would you like to discard them and start a new order from this restaurant?</p>
                        <div class="cart-alert-actions">
                            <a href="cart?menuId=<%= request.getParameter("menuId") %>&action=changeRestaurant" class="btn btn-danger btn-sm">
                                Discard & Switch Restaurant
                            </a>
                            <a href="cart.jsp" class="btn btn-outline btn-sm">
                                Keep Existing Cart
                            </a>
                        </div>
                    </div>
                </div>
            <%
                }
            %>

            <%
                Cart cart = (Cart) session.getAttribute("cart");
                if (cart != null && !cart.getItems().isEmpty()) {
                    int totalItemsCount = 0;
                    for (CartItem ci : cart.getItems().values()) {
                        totalItemsCount += ci.getQuantity();
                    }
            %>
                <!-- Cart Top Header -->
                <div class="cart-header-row">
                    <div class="cart-title-group">
                        <h1 class="cart-page-title">My Cart</h1>
                        <span class="cart-count-badge"><%= totalItemsCount %> <%= totalItemsCount == 1 ? "Item" : "Items" %></span>
                    </div>
                    <a href="restaurant.jsp" class="continue-shopping-link">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                            <line x1="19" y1="12" x2="5" y2="12"></line>
                            <polyline points="12 19 5 12 12 5"></polyline>
                        </svg>
                        <span>Continue Shopping</span>
                    </a>
                </div>

                <!-- 2-Column Cart Layout -->
                <div class="cart-grid">
                    <!-- Left: Cart Items List -->
                    <section class="cart-items-container" aria-label="Shopping Cart Items">
                        <div class="cart-items-header">
                            <div>Item</div>
                            <div>Price</div>
                            <div>Quantity</div>
                            <div>Total</div>
                            <div></div>
                        </div>

                        <div class="cart-items-body">
                            <%
                                for (CartItem item : cart.getItems().values()) {
                            %>
                                <article class="cart-item-row" id="cart-item-<%= item.getMenuId() %>">
                                    <!-- Food Info -->
                                    <div class="item-info-col">
                                        <div class="item-img-wrapper">
                                            <img src="<%= item.getItemImageURL() %>" 
                                                 alt="<%= item.getItemName() %>" 
                                                 class="item-img"
                                                 loading="lazy">
                                        </div>
                                        <div class="item-title-group">
                                            <h3 class="item-name"><%= item.getItemName() %></h3>
                                            <span class="item-unit-price-mobile">₹ <%= String.format("%.2f", item.getPrice()) %> each</span>
                                        </div>
                                    </div>

                                    <!-- Unit Price -->
                                    <div class="item-unit-price">
                                        ₹ <%= String.format("%.2f", item.getPrice()) %>
                                    </div>

                                    <!-- Quantity Controls (Preserving exact servlet action contract) -->
                                    <div class="item-stepper-col">
                                        <div class="cart-qty-stepper" aria-label="Quantity for <%= item.getItemName() %>">
                                            <a href="cart?menuId=<%= item.getMenuId() %>&action=decrease" 
                                               class="cart-stepper-btn" 
                                               title="Decrease quantity"
                                               aria-label="Decrease quantity">−</a>
                                            <span class="cart-stepper-value"><%= item.getQuantity() %></span>
                                            <a href="cart?menuId=<%= item.getMenuId() %>&action=increase" 
                                               class="cart-stepper-btn" 
                                               title="Increase quantity"
                                               aria-label="Increase quantity">+</a>
                                        </div>
                                    </div>

                                    <!-- Line Total (Saffron) -->
                                    <div class="item-line-total">
                                        ₹ <%= String.format("%.2f", item.getPrice() * item.getQuantity()) %>
                                    </div>

                                    <!-- Remove Action -->
                                    <div class="item-remove-col">
                                        <a href="cart?menuId=<%= item.getMenuId() %>&action=remove" 
                                           class="btn-remove-item" 
                                           title="Remove item from cart"
                                           aria-label="Remove <%= item.getItemName() %>">
                                            <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                                <polyline points="3 6 5 6 21 6"></polyline>
                                                <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                                            </svg>
                                        </a>
                                    </div>
                                </article>
                            <%
                                }
                            %>
                        </div>

                        <!-- Cart Actions Bar -->
                        <div class="cart-table-footer">
                            <a href="restaurant.jsp" class="continue-shopping-link">
                                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                    <line x1="12" y1="5" x2="12" y2="19"></line>
                                    <line x1="5" y1="12" x2="19" y2="12"></line>
                                </svg>
                                <span>Add more dishes</span>
                            </a>
                            <a href="cart?action=clear" class="btn-clear-cart" id="clearCartBtn">
                                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                    <polyline points="3 6 5 6 21 6"></polyline>
                                    <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                                </svg>
                                <span>Clear Cart</span>
                            </a>
                        </div>
                    </section>

                    <!-- Right: Order Summary Sidebar ("Bill Details") -->
                    <aside class="order-summary-card" aria-label="Bill Details">
                        <h2 class="summary-title">Bill Details</h2>

                        <div class="summary-row">
                            <span>Item Subtotal</span>
                            <span class="value">₹ <%= String.format("%.2f", cart.getTotalPrice()) %></span>
                        </div>

                        <div class="summary-row free-badge">
                            <span class="fee-label">
                                <span>Delivery Partner Fee</span>
                                <span class="tag-free">FREE</span>
                            </span>
                            <span class="value free-text">₹ 0.00</span>
                        </div>

                        <div class="summary-row">
                            <span>Platform Charges</span>
                            <span class="value">Included</span>
                        </div>

                        <div class="summary-row">
                            <span>Govt Taxes & Levies</span>
                            <span class="value">Included</span>
                        </div>

                        <div class="summary-divider"></div>

                        <div class="summary-total-row">
                            <span class="summary-total-label">Grand Total</span>
                            <span class="summary-total-amount">₹ <%= String.format("%.2f", cart.getTotalPrice()) %></span>
                        </div>

                        <!-- Proceed to Checkout Link -->
                        <a href="checkout" class="btn btn-primary btn-block btn-checkout" id="proceedToCheckoutBtn">
                            <span>Proceed to Checkout</span>
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <line x1="5" y1="12" x2="19" y2="12"></line>
                                <polyline points="12 5 19 12 12 19"></polyline>
                            </svg>
                        </a>

                        <div class="summary-trust-points">
                            <div class="trust-item">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="trust-icon" aria-hidden="true">
                                    <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
                                </svg>
                                <span>100% Safe & Secure Checkout</span>
                            </div>
                            <div class="trust-item">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="trust-icon" aria-hidden="true">
                                    <polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon>
                                </svg>
                                <span>Live Order Tracking Enabled</span>
                            </div>
                        </div>
                    </aside>
                </div>

            <%
                } else {
            %>
                <!-- Elegant Empty Cart State -->
                <div class="empty-cart-card">
                    <div class="empty-cart-icon-circle" aria-hidden="true">
                        <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M6 2L3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"></path>
                            <line x1="3" y1="6" x2="21" y2="6"></line>
                            <path d="M16 10a4 4 0 0 1-8 0"></path>
                        </svg>
                    </div>
                    <h2 class="empty-cart-title">Your Cart is Empty</h2>
                    <p class="empty-cart-desc">Good food is always just a few clicks away. Explore your favorite restaurants and treat yourself!</p>
                    <a href="restaurant.jsp" class="btn btn-primary" id="browseRestaurantsBtn">
                        <span>Browse Restaurants</span>
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
