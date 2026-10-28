<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.myfoodapp.model.Cart"%>
<%@ page import="com.myfoodapp.model.CartItem"%>
<%@ page import="java.util.Map"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout | BiteRush</title>
    <meta name="description" content="Complete your BiteRush order with fast doorstep delivery and secure payment options.">

    <!-- Google Fonts: Inter & Playfair Display -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">

    <!-- BiteRush Stylesheets -->
    <link rel="stylesheet" href="css/global.css?v=5">
    <link rel="stylesheet" href="css/common.css?v=5">
    <link rel="stylesheet" href="css/navbar.css?v=5">
    <link rel="stylesheet" href="css/checkout.css?v=5">
    <link rel="stylesheet" href="css/footer.css?v=5">
</head>
<body>

    <!-- Reusable Navbar Component -->
    <%@ include file="components/navbar.jsp" %>

    <main class="checkout-section">
        <div class="container">

            <%
                Cart cart = (Cart) session.getAttribute("cart");
                if (cart == null || cart.getItems().isEmpty()) {
            %>
                <!-- Empty Cart State -->
                <div class="checkout-empty-card">
                    <div class="checkout-empty-icon" aria-hidden="true">
                        <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M6 2L3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"></path>
                            <line x1="3" y1="6" x2="21" y2="6"></line>
                            <path d="M16 10a4 4 0 0 1-8 0"></path>
                        </svg>
                    </div>
                    <h2 class="checkout-empty-title">Your Cart is Empty</h2>
                    <p class="checkout-empty-desc">You don't have any items ready for checkout. Choose dishes from your favorite restaurants first!</p>
                    <a href="restaurant.jsp" class="btn btn-primary">
                        <span>Browse Restaurants</span>
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                            <line x1="5" y1="12" x2="19" y2="12"></line>
                            <polyline points="12 5 19 12 12 19"></polyline>
                        </svg>
                    </a>
                </div>
            <%
                } else {
                    int totalItemsQty = 0;
                    for (CartItem ci : cart.getItems().values()) {
                        totalItemsQty += ci.getQuantity();
                    }
            %>
                <!-- Checkout Header -->
                <div class="checkout-header-row">
                    <div>
                        <h1 class="checkout-title">Complete Your Order</h1>
                        <p class="checkout-subtitle">Please enter your delivery destination and confirm your preferred payment method.</p>
                    </div>
                    <a href="cart.jsp" class="btn btn-outline btn-sm">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                            <line x1="19" y1="12" x2="5" y2="12"></line>
                            <polyline points="12 19 5 12 12 5"></polyline>
                        </svg>
                        <span>Back to Cart</span>
                    </a>
                </div>

                <!-- Checkout Form & Review Grid -->
                <form action="placeOrder" method="post" class="checkout-grid" id="checkoutForm">
                    <!-- Left Column: Delivery & Payment Details -->
                    <div class="checkout-form-col">
                        <!-- Step 1: Delivery Address -->
                        <div class="checkout-card">
                            <div class="card-title-group">
                                <span class="step-indicator">1</span>
                                <div>
                                    <h2 class="card-step-title">Delivery Address</h2>
                                    <p class="card-step-desc">Where should we deliver your freshly prepared food?</p>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="deliveryAddress" class="form-label">Full Delivery Address <span class="required-mark">*</span></label>
                                <textarea id="deliveryAddress"
                                          name="address"
                                          rows="4"
                                          placeholder="Enter house/flat no., building name, street, nearby landmark, and pincode..."
                                          required
                                          class="checkout-textarea"></textarea>
                                <span class="form-hint">
                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                        <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path>
                                        <circle cx="12" cy="10" r="3"></circle>
                                    </svg>
                                    <span>Accurate address details ensure faster, seamless doorstep delivery.</span>
                                </span>
                            </div>
                        </div>

                        <!-- Step 2: Payment Method -->
                        <div class="checkout-card">
                            <div class="card-title-group">
                                <span class="step-indicator">2</span>
                                <div>
                                    <h2 class="card-step-title">Payment Method</h2>
                                    <p class="card-step-desc">Select how you'd like to pay for your meal</p>
                                </div>
                            </div>

                            <div class="payment-options-list">
                                <!-- Cash on Delivery -->
                                <label class="payment-option-card">
                                    <input type="radio"
                                           name="payment"
                                           value="Cash on Delivery"
                                           checked
                                           class="payment-radio">
                                    <div class="payment-option-info">
                                        <div class="payment-option-head">
                                            <span class="payment-name">Cash on Delivery</span>
                                            <span class="badge-rec">Recommended</span>
                                        </div>
                                        <span class="payment-option-desc">Pay in cash or scan delivery partner's QR code on doorstep arrival.</span>
                                    </div>
                                </label>

                                <!-- UPI / Online -->
                                <label class="payment-option-card">
                                    <input type="radio"
                                           name="payment"
                                           value="UPI"
                                           class="payment-radio">
                                    <div class="payment-option-info">
                                        <div class="payment-option-head">
                                            <span class="payment-name">UPI / QR Code</span>
                                        </div>
                                        <span class="payment-option-desc">Pay instantly using Google Pay, PhonePe, Paytm, or BHIM UPI.</span>
                                    </div>
                                </label>

                                <!-- Card -->
                                <label class="payment-option-card">
                                    <input type="radio"
                                           name="payment"
                                           value="Credit / Debit Card"
                                           class="payment-radio">
                                    <div class="payment-option-info">
                                        <div class="payment-option-head">
                                            <span class="payment-name">Credit / Debit Card</span>
                                        </div>
                                        <span class="payment-option-desc">Visa, Mastercard, RuPay, and American Express accepted.</span>
                                    </div>
                                </label>
                            </div>
                        </div>

                        <!-- Navigation & Submit Controls -->
                        <div class="checkout-actions-row">
                            <a href="cart.jsp" class="btn btn-outline">
                                <span>← Back to Cart</span>
                            </a>
                            <button type="submit" class="btn btn-primary btn-place-order" id="placeOrderSubmitBtn">
                                <span>Place Order</span>
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                    <line x1="5" y1="12" x2="19" y2="12"></line>
                                    <polyline points="12 5 19 12 12 19"></polyline>
                                </svg>
                            </button>
                        </div>
                    </div>

                    <!-- Right Column: Order Summary Sidebar -->
                    <aside class="checkout-summary-card" aria-label="Order Summary">
                        <div class="summary-head">
                            <h2 class="summary-card-title">Order Summary</h2>
                            <span class="summary-count-badge"><%= totalItemsQty %> <%= totalItemsQty == 1 ? "dish" : "dishes" %></span>
                        </div>

                        <div class="summary-items-list">
                            <%
                                for (Map.Entry<Integer, CartItem> entry : cart.getItems().entrySet()) {
                                    CartItem item = entry.getValue();
                            %>
                                <div class="summary-item-row">
                                    <div class="summary-item-left">
                                        <span class="summary-item-qty"><%= item.getQuantity() %>×</span>
                                        <span class="summary-item-name"><%= item.getItemName() %></span>
                                    </div>
                                    <span class="summary-item-price">₹ <%= String.format("%.2f", item.getPrice() * item.getQuantity()) %></span>
                                </div>
                            <%
                                }
                            %>
                        </div>

                        <div class="summary-divider"></div>

                        <!-- Price Breakdown -->
                        <div class="calc-row">
                            <span>Item Subtotal</span>
                            <span class="calc-value">₹ <%= String.format("%.2f", cart.getTotalPrice()) %></span>
                        </div>

                        <div class="calc-row free-fee">
                            <span>Delivery Partner Fee</span>
                            <span class="calc-value free-pill">FREE</span>
                        </div>

                        <div class="calc-row">
                            <span>Platform Taxes & Levies</span>
                            <span class="calc-value">Included</span>
                        </div>

                        <div class="summary-divider"></div>

                        <div class="summary-total-box">
                            <span class="total-label">Amount Payable</span>
                            <span class="total-amount">₹ <%= String.format("%.2f", cart.getTotalPrice()) %></span>
                        </div>

                        <div class="checkout-guarantee">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="guarantee-icon" aria-hidden="true">
                                <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
                            </svg>
                            <span>Safe, contactless hygienic packaging & delivery guaranteed.</span>
                        </div>
                    </aside>
                </form>
            <%
                }
            %>

        </div>
    </main>

    <!-- Reusable Footer Component -->
    <%@ include file="components/footer.jsp" %>

</body>
</html>
