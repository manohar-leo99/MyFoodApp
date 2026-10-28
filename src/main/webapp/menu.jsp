<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.myfoodapp.model.Menu" %>
<%@ page import="com.myfoodapp.model.Restaurant" %>
<%@ page import="com.myfoodapp.model.Cart" %>
<%@ page import="com.myfoodapp.model.CartItem" %>
<%@ page import="com.myfoodapp.daoimp.RestaurantDaoImp" %>

<%
    List<Menu> menus = (List<Menu>) request.getAttribute("menus");
    Restaurant restaurant = null;
    Integer restIdSession = (Integer) session.getAttribute("restaurantId");
    RestaurantDaoImp restaurantDaoImp = new RestaurantDaoImp();

    if (menus != null && !menus.isEmpty()) {
        int restaurantID = menus.get(0).getRestaurantId();
        restaurant = restaurantDaoImp.getRestaurantById(restaurantID);
    } else if (restIdSession != null) {
        restaurant = restaurantDaoImp.getRestaurantById(restIdSession);
    } else if (request.getParameter("restaurantId") != null) {
        try {
            int pId = Integer.parseInt(request.getParameter("restaurantId"));
            restaurant = restaurantDaoImp.getRestaurantById(pId);
        } catch (Exception ignored) {}
    }

    Cart sessionCart = (Cart) session.getAttribute("cart");
    int totalCartItems = 0;
    double totalCartPrice = 0.0;
    if (sessionCart != null && sessionCart.getItems() != null && !sessionCart.getItems().isEmpty()) {
        for (CartItem cItem : sessionCart.getItems().values()) {
            totalCartItems += cItem.getQuantity();
        }
        totalCartPrice = sessionCart.getTotalPrice();
    }

    int activeRestId = restaurant != null ? restaurant.getRestaurantID() : (restIdSession != null ? restIdSession : 1);
    String currentCategory = request.getParameter("category");
    String currentSearch = request.getParameter("itemName");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= restaurant != null ? restaurant.getRestaurantName() + " — Menu" : "Restaurant Menu" %> | BiteRush</title>
    <meta name="description" content="Explore artisanal dishes, authentic cuisines, and chef specials at BiteRush.">

    <!-- Google Fonts: Inter & Playfair Display -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">

    <!-- BiteRush Stylesheets -->
    <link rel="stylesheet" href="css/global.css?v=5">
    <link rel="stylesheet" href="css/common.css?v=5">
    <link rel="stylesheet" href="css/navbar.css?v=5">
    <link rel="stylesheet" href="css/menu.css?v=5">
    <link rel="stylesheet" href="css/footer.css?v=5">
</head>
<body class="<%= totalCartItems > 0 ? "has-floating-cart" : "" %>">

    <!-- Sticky Navbar Component -->
    <%@ include file="components/navbar.jsp" %>

    <!-- Back Navigation Link -->
    <div class="menu-back-wrapper">
        <div class="container">
            <a href="restaurant.jsp" class="back-link" id="backToRestaurantsBtn">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <line x1="19" y1="12" x2="5" y2="12"></line>
                    <polyline points="12 19 5 12 12 5"></polyline>
                </svg>
                <span>Back to restaurants</span>
            </a>
        </div>
    </div>

    <!-- Restaurant Header Card Banner -->
    <% if (restaurant != null) { %>
    <section class="restaurant-header-banner" aria-label="Restaurant Information">
        <div class="container">
            <div class="restaurant-header-card">
                <div class="restaurant-hero-img-wrapper">
                    <img src="<%= restaurant.getRestaurantImageURL() %>" 
                         alt="<%= restaurant.getRestaurantName() %>" 
                         class="restaurant-hero-img"
                         loading="lazy">
                </div>

                <div class="restaurant-header-info">
                    <h1 class="restaurant-title"><%= restaurant.getRestaurantName() %></h1>

                    <div class="restaurant-meta-row">
                        <span class="badge badge-cuisine"><%= restaurant.getCuisineType() %></span>
                        <span class="badge badge-rating">
                            <span class="star-icon">★</span>
                            <span><%= restaurant.getRating() %></span>
                        </span>
                        <span class="badge badge-time">
                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <circle cx="12" cy="12" r="10"></circle>
                                <polyline points="12 6 12 12 16 14"></polyline>
                            </svg>
                            <span><%= restaurant.getDeliveryTime() %> mins</span>
                        </span>
                    </div>

                    <p class="restaurant-meta-address">
                        <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                            <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path>
                            <circle cx="12" cy="10" r="3"></circle>
                        </svg>
                        <span><%= restaurant.getAddress() %></span>
                    </p>
                </div>
            </div>
        </div>
    </section>
    <% } %>

    <!-- Sticky Menu Toolbar (Search input + Sticky Category Chips) -->
    <section class="menu-toolbar-section" aria-label="Menu filters and search">
        <div class="container menu-toolbar">
            <!-- Search Menu Form -->
            <form action="searchMenu" method="get" class="menu-search-form" role="search" id="menuSearchForm">
                <div class="search-input-group">
                    <span class="search-icon" aria-hidden="true">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <circle cx="11" cy="11" r="8"></circle>
                            <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                        </svg>
                    </span>
                    <input type="text"
                           name="itemName"
                           id="menuSearchInput"
                           placeholder="Search dishes in this menu..."
                           value="<%= currentSearch != null ? currentSearch : "" %>"
                           required
                           class="menu-search-input"
                           aria-label="Search dishes in this menu">
                    <button type="submit" class="btn btn-primary menu-search-btn" id="menuSearchSubmit">Search</button>
                </div>
            </form>

            <!-- Sticky Category Chips Nav -->
            <%
                String[] categories = {"All", "Biryani", "Starters", "Pizza", "Desserts", "Drinks", "Main Course", "Meals"};
            %>
            <nav class="category-chips-nav" aria-label="Dishes by category">
                <div class="category-chips-scroll">
                    <% for (String cat : categories) { 
                        boolean isAll = "All".equalsIgnoreCase(cat);
                        boolean isActive = (isAll && currentCategory == null && currentSearch == null) || 
                                           (cat.equalsIgnoreCase(currentCategory));
                        String targetUrl = isAll ? ("menu?restaurantId=" + activeRestId) : ("filterMenu?category=" + cat);
                    %>
                        <a href="<%= targetUrl %>" class="category-chip<%= isActive ? " is-active" : "" %>">
                            <%= cat %>
                        </a>
                    <% } %>
                </div>
            </nav>
        </div>
    </section>

    <!-- Menu Items 3-Column Grid Section -->
    <main class="menu-content-section" id="menuContentSection">
        <div class="container">
            <div class="menu-section-header">
                <div class="menu-title-wrap">
                    <h2 class="menu-section-title">
                        <%= currentCategory != null ? currentCategory : (currentSearch != null ? "Search: \"" + currentSearch + "\"" : "Menu Dishes") %>
                    </h2>
                    <p class="menu-section-subtitle">Freshly prepared and made to order with authentic hand-selected ingredients</p>
                </div>
                <% if (currentCategory != null || currentSearch != null) { %>
                    <a href="menu?restaurantId=<%= activeRestId %>" class="clear-filter-link">View all dishes</a>
                <% } %>
            </div>

            <div class="menu-container">
                <%
                if (menus != null && !menus.isEmpty()) {
                    for (Menu menu : menus) {
                        boolean isAvailable = menu.isAvailable();
                        int qty = 0;
                        if (sessionCart != null && sessionCart.getItems() != null && sessionCart.getItems().containsKey(menu.getMenuId())) {
                            qty = sessionCart.getItems().get(menu.getMenuId()).getQuantity();
                        }
                %>
                    <!-- Dish Card (3-Column Grid) -->
                    <article class="food-card<%= !isAvailable ? " is-unavailable" : "" %>" id="dish-<%= menu.getMenuId() %>">
                        <div class="food-media">
                            <img src="<%= menu.getMenuImageURL() %>" 
                                 alt="<%= menu.getItemName() %>" 
                                 class="food-img"
                                 loading="lazy">
                            <span class="category-pill"><%= menu.getCategory() %></span>
                        </div>

                        <div class="food-card-body">
                            <!-- Dish Name & Inline Availability -->
                            <div class="food-name-row">
                                <h3 class="food-name"><%= menu.getItemName() %></h3>
                                <% if (isAvailable) { %>
                                    <span class="availability-badge available">
                                        <span class="status-dot green" aria-hidden="true"></span>
                                        Available
                                    </span>
                                <% } else { %>
                                    <span class="availability-badge unavailable">
                                        <span class="status-dot red" aria-hidden="true"></span>
                                        Unavailable
                                    </span>
                                <% } %>
                            </div>

                            <p class="food-desc"><%= menu.getDescription() != null ? menu.getDescription() : "Artisanal preparation curated freshly by master chefs." %></p>

                            <div class="food-card-bottom">
                                <div class="food-price">
                                    <span class="currency">₹</span><span class="amount"><%= menu.getPrice() %></span>
                                </div>

                                <div class="food-action-slot">
                                    <% if (!isAvailable) { %>
                                        <button type="button" class="btn btn-disabled add-cart-btn" disabled aria-disabled="true">Unavailable</button>
                                    <% } else if (qty == 0) { %>
                                        <a href="cart?menuId=<%= menu.getMenuId() %>" class="btn btn-primary add-cart-btn" aria-label="Add <%= menu.getItemName() %> to cart">
                                            <span>+ Add</span>
                                        </a>
                                    <% } else { %>
                                        <div class="quantity-control" aria-label="Quantity selector for <%= menu.getItemName() %>">
                                            <a href="cart?menuId=<%= menu.getMenuId() %>&action=decrease" class="qty-btn" title="Decrease quantity" aria-label="Decrease quantity">−</a>
                                            <span class="qty-value"><%= qty %></span>
                                            <a href="cart?menuId=<%= menu.getMenuId() %>&action=increase" class="qty-btn" title="Increase quantity" aria-label="Increase quantity">+</a>
                                        </div>
                                    <% } %>
                                </div>
                            </div>
                        </div>
                    </article>
                <%
                    }
                } else {
                %>
                    <!-- Elegant Empty State -->
                    <div class="menu-empty-state">
                        <div class="empty-icon-circle">
                            <svg width="44" height="44" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <path d="M18 8h1a4 4 0 0 1 0 8h-1"></path>
                                <path d="M2 8h16v9a4 4 0 0 1-4 4H6a4 4 0 0 1-4-4V8z"></path>
                                <line x1="6" y1="1" x2="6" y2="4"></line>
                                <line x1="10" y1="1" x2="10" y2="4"></line>
                                <line x1="14" y1="1" x2="14" y2="4"></line>
                            </svg>
                        </div>
                        <h3 class="empty-title">No Dishes Found</h3>
                        <p class="empty-subtitle">We couldn't find any items matching your selection in this restaurant menu.</p>
                        <div class="empty-actions">
                            <a href="menu?restaurantId=<%= activeRestId %>" class="btn btn-primary">View Full Menu</a>
                            <a href="restaurant.jsp" class="btn btn-outline">Explore Other Restaurants</a>
                        </div>
                    </div>
                <%
                }
                %>
            </div>
        </div>
    </main>

    <!-- Floating Bottom Cart Bar (Appears when cart has items) -->
    <% if (totalCartItems > 0) { %>
    <aside class="floating-cart-bar" aria-label="Shopping Cart Bar">
        <div class="container floating-cart-inner">
            <div class="floating-cart-info">
                <span class="floating-cart-count"><%= totalCartItems %> <%= totalCartItems == 1 ? "item" : "items" %></span>
                <span class="floating-cart-sep">•</span>
                <span class="floating-cart-price">₹<%= String.format("%.2f", totalCartPrice) %></span>
            </div>
            <a href="cart.jsp" class="btn btn-primary floating-cart-btn" id="floatingCartBtn">
                <span>View cart</span>
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <line x1="5" y1="12" x2="19" y2="12"></line>
                    <polyline points="12 5 19 12 12 19"></polyline>
                </svg>
            </a>
        </div>
    </aside>
    <% } %>

    <!-- Reusable Footer Component -->
    <%@ include file="components/footer.jsp" %>

</body>
</html>
