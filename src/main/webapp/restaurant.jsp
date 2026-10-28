<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.myfoodapp.model.Restaurant" %>
<%@ page import="com.myfoodapp.daoimp.RestaurantDaoImp" %>

<%
    String searchTerm = request.getParameter("restaurantName");
    List<Restaurant> restaurants = (List<Restaurant>) request.getAttribute("restaurants");

    // Fallback: If accessed directly without servlet forward, load all restaurants
    if (restaurants == null && (searchTerm == null || searchTerm.trim().isEmpty())) {
        RestaurantDaoImp dao = new RestaurantDaoImp();
        restaurants = dao.getAllRestaurants();
    } else if (restaurants == null && searchTerm != null && !searchTerm.trim().isEmpty()) {
        RestaurantDaoImp dao = new RestaurantDaoImp();
        restaurants = dao.searchRestaurant(searchTerm.trim());
    }

    boolean isSearchActive = (searchTerm != null && !searchTerm.trim().isEmpty());
    int resultCount = (restaurants != null) ? restaurants.size() : 0;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= isSearchActive ? "Search: \"" + searchTerm + "\" | BiteRush" : "All Restaurants | BiteRush" %></title>
    <meta name="description" content="Discover top restaurants and order delicious food with lightning-fast delivery on BiteRush.">

    <!-- Google Fonts: Inter & Playfair Display -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">

    <!-- BiteRush Stylesheets -->
    <link rel="stylesheet" href="css/global.css?v=5">
    <link rel="stylesheet" href="css/common.css?v=5">
    <link rel="stylesheet" href="css/navbar.css?v=5">
    <link rel="stylesheet" href="css/restaurants.css?v=5">
    <link rel="stylesheet" href="css/footer.css?v=5">
</head>
<body>

    <!-- Sticky Navbar Component -->
    <%@ include file="components/navbar.jsp" %>

    <!-- Hero Section with Background Video -->
    <section class="hero-section<%= isSearchActive ? " hero-compact-search" : "" %>">
        <div class="hero-video-wrapper">
            <video autoplay loop muted playsinline class="hero-video" preload="auto">
                <source src="videos/foodvideo.mp4" type="video/mp4">
            </video>
            <div class="hero-video-overlay"></div>
        </div>

        <div class="container hero-container">
            <div class="hero-content">
                <!-- Delivery Badge -->
                <div class="hero-badge">
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" class="hero-badge-icon" aria-hidden="true">
                        <polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon>
                    </svg>
                    <span>Superfast Food Delivery</span>
                </div>

                <!-- Hero Heading -->
                <h1 class="hero-title">Delicious Food From Top <span class="highlight">Restaurants</span></h1>
                <p class="hero-subtitle">Discover popular spots, savor mouthwatering dishes, and get them delivered hot & fresh to your door.</p>

                <!-- Search Bar Container -->
                <div class="hero-search-wrapper">
                    <form action="searchRestaurant#searchResults" method="get" class="hero-search-form" role="search" id="restaurantSearchForm">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="search-input-icon" aria-hidden="true">
                            <circle cx="11" cy="11" r="8"></circle>
                            <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                        </svg>
                        <input type="text"
                               name="restaurantName"
                               value="<%= isSearchActive ? searchTerm : "" %>"
                               placeholder="Search for restaurants, cuisines or dishes..."
                               required
                               class="hero-search-input"
                               aria-label="Search restaurants">
                        <button type="submit" class="btn btn-primary search-submit-btn" id="searchSubmitBtn">Search</button>
                    </form>
                </div>
            </div>
        </div>
    </section>

    <!-- Main Content: Restaurants Section -->
    <main class="restaurants-main" id="searchResults">
        <div class="container">

            <% if (isSearchActive) { %>
                <!-- Active Search Results Header -->
                <div class="search-results-banner">
                    <div class="search-results-left">
                        <div class="search-badge-pill">
                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <circle cx="11" cy="11" r="8"></circle>
                                <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                            </svg>
                            <span>Search Query</span>
                        </div>
                        <h2 class="search-results-heading">
                            Results for "<span class="search-term-highlight"><%= searchTerm %></span>"
                        </h2>
                        <p class="search-results-count">
                            Found <%= resultCount %> <%= resultCount == 1 ? "restaurant" : "restaurants" %> matching your search
                        </p>
                    </div>

                    <a href="restaurant.jsp" class="btn btn-outline btn-sm clear-search-action" id="clearSearchBtn">
                        <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                            <line x1="18" y1="6" x2="6" y2="18"></line>
                            <line x1="6" y1="6" x2="18" y2="18"></line>
                        </svg>
                        <span>Clear Search & View All</span>
                    </a>
                </div>
            <% } else { %>
                <!-- Standard Filter Chips Row & Header -->
                <div class="filter-chips-row">
                    <div class="filter-chips-group">
                        <a href="restaurant.jsp" class="filter-chip is-active">All</a>
                        <span class="filter-chip is-disabled">Biryani</span>
                        <span class="filter-chip is-disabled">Pizza</span>
                        <span class="filter-chip is-disabled">Starters</span>
                        <span class="filter-chip is-disabled">Desserts</span>
                        <span class="filter-chip is-disabled">Top Rated (4.0+)</span>
                    </div>
                </div>

                <div class="section-header">
                    <div>
                        <p class="section-tagline">EXPLORE DINING</p>
                        <h2 class="section-title">All Restaurants</h2>
                        <p class="section-subtitle">Handpicked culinary favorites with real-time ratings & quick delivery</p>
                    </div>
                </div>
            <% } %>

            <!-- 4-Column Restaurant Cards Grid -->
            <div class="restaurant-grid">
                <%
                if (restaurants != null && !restaurants.isEmpty()) {
                    for (Restaurant restaurant : restaurants) {
                %>
                    <!-- Restaurant Card (Entire Card Clickable) -->
                    <a href="menu?restaurantId=<%= restaurant.getRestaurantID() %>" class="restaurant-card" id="restaurant-<%= restaurant.getRestaurantID() %>" aria-label="<%= restaurant.getRestaurantName() %>">
                        <!-- 16:10 Image Container -->
                        <div class="card-media">
                            <img src="<%= restaurant.getRestaurantImageURL() %>"
                                 alt="<%= restaurant.getRestaurantName() %>"
                                 loading="lazy"
                                 class="card-img">
                            
                            <!-- Rating Pill on Corner -->
                            <div class="card-rating-pill">
                                <svg width="12" height="12" viewBox="0 0 24 24" fill="currentColor" stroke="currentColor" stroke-width="1" class="star-icon" aria-hidden="true">
                                    <polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon>
                                </svg>
                                <span><%= restaurant.getRating() %></span>
                            </div>
                        </div>

                        <!-- Card Body -->
                        <div class="card-body">
                            <h3 class="card-title"><%= restaurant.getRestaurantName() %></h3>

                            <!-- Cuisine & Delivery Time Line -->
                            <div class="card-meta-line">
                                <span class="card-cuisine"><%= restaurant.getCuisineType() %></span>
                                <span class="card-separator">•</span>
                                <span class="card-time">
                                    <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="meta-icon" aria-hidden="true">
                                        <circle cx="12" cy="12" r="10"></circle>
                                        <polyline points="12 6 12 12 16 14"></polyline>
                                    </svg>
                                    <span><%= restaurant.getDeliveryTime() %> mins</span>
                                </span>
                            </div>

                            <!-- Location Line -->
                            <div class="card-location-line">
                                <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="location-icon" aria-hidden="true">
                                    <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path>
                                    <circle cx="12" cy="10" r="3"></circle>
                                </svg>
                                <span class="card-address-text"><%= restaurant.getAddress() %></span>
                            </div>
                        </div>
                    </a>
                <%
                    }
                } else {
                %>
                    <!-- Search / Empty State Box -->
                    <div class="empty-state-box">
                        <div class="empty-state-icon">
                            <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" class="plate-svg" aria-hidden="true">
                                <circle cx="11" cy="11" r="8"></circle>
                                <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                                <line x1="8" y1="11" x2="14" y2="11"></line>
                            </svg>
                        </div>
                        <h3 class="empty-state-title">
                            <%= isSearchActive ? "No Restaurants Match \"" + searchTerm + "\"" : "No Restaurants Available" %>
                        </h3>
                        <p class="empty-state-desc">
                            <%= isSearchActive 
                                ? "We couldn't find any restaurants or cuisines matching your search. Try searching for popular dishes like Biryani, Burger, or Pizza." 
                                : "We couldn't find any restaurants at the moment. Try refreshing the listings." %>
                        </p>
                        <div class="empty-state-actions">
                            <a href="restaurant.jsp" class="btn btn-primary empty-state-btn">
                                <span>Browse All Restaurants</span>
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                    <line x1="5" y1="12" x2="19" y2="12"></line>
                                    <polyline points="12 5 19 12 12 19"></polyline>
                                </svg>
                            </a>
                        </div>
                    </div>
                <%
                }
                %>
            </div>
        </div>
    </main>

    <!-- Auto scroll script when search is submitted -->
    <% if (isSearchActive) { %>
    <script>
        (function() {
            var target = document.getElementById('searchResults');
            if (target) {
                setTimeout(function() {
                    target.scrollIntoView({ behavior: 'smooth', block: 'start' });
                }, 100);
            }
        })();
    </script>
    <% } %>

    <!-- Reusable Footer Component -->
    <%@ include file="components/footer.jsp" %>

</body>
</html>
