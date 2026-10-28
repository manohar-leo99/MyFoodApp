<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.myfoodapp.model.Cart" %>
<%@ page import="com.myfoodapp.model.User" %>
<%
    User navCurrentUser = (User) session.getAttribute("user");
    Cart navCartSession = (Cart) session.getAttribute("cart");
    int navCartCount = 0;
    if (navCartSession != null && navCartSession.getItems() != null) {
        navCartCount = navCartSession.getItems().size();
    }

    String navCurrentUri = request.getRequestURI() != null ? request.getRequestURI().toLowerCase() : "";
    boolean navOnOrders  = navCurrentUri.contains("order");
    boolean navOnProfile = navCurrentUri.contains("profile");
    boolean navOnCart    = navCurrentUri.contains("cart") || navCurrentUri.contains("checkout");

    String navDisplayName = "Account";
    boolean navIsAdmin = false;
    if (navCurrentUser != null) {
        if (navCurrentUser.getFirstName() != null && !navCurrentUser.getFirstName().trim().isEmpty()) {
            navDisplayName = navCurrentUser.getFirstName().trim();
        } else if (navCurrentUser.getUserName() != null && !navCurrentUser.getUserName().trim().isEmpty()) {
            navDisplayName = navCurrentUser.getUserName().trim();
        }
        navIsAdmin = navCurrentUser.getRole() != null && navCurrentUser.getRole().toLowerCase().contains("admin");
    }
%>
<header class="site-header">
    <nav class="navbar container" aria-label="Main Navigation">
        <!-- Logo (Left) -->
        <a href="restaurant.jsp" class="brand" aria-label="BiteRush Home">
            <span class="brand-icon-box">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round" class="brand-icon-svg" aria-hidden="true">
                    <polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon>
                </svg>
            </span>
            <span class="brand-text"><span class="brand-highlight">Bite</span>Rush</span>
        </a>

        <!-- Mobile Hamburger Toggle Checkbox (No JS required) -->
        <input type="checkbox" id="nav-toggle" class="nav-toggle-input" aria-label="Toggle navigation menu">

        <!-- Navigation Links (Center / Left - kept clean without raw text links) -->
        <div class="nav-menu">
            <ul class="nav-links">
                <!-- Navigation is unified in the modern profile avatar dropdown -->
            </ul>
        </div>

        <!-- Actions (Right: Cart + Modern Profile Icon Dropdown) -->
        <div class="nav-actions">
            <!-- Cart Button with Live Saffron Count Badge (Kept identical as requested) -->
            <a href="cart.jsp" class="nav-cart-btn<%= navOnCart ? " is-active" : "" %>" aria-label="View Shopping Cart" id="navCartBtn">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="nav-cart-svg" aria-hidden="true">
                    <circle cx="8" cy="21" r="1"></circle>
                    <circle cx="19" cy="21" r="1"></circle>
                    <path d="M2.05 2.05h2l2.66 12.42a2 2 0 0 0 2 1.58h9.78a2 2 0 0 0 1.95-1.57l1.65-7.43H5.12"></path>
                </svg>
                <span class="nav-cart-label">Cart</span>
                <span class="nav-cart-badge"><%= navCartCount %></span>
            </a>

            <!-- Modern Profile Menu / Guest Login -->
            <% if (navCurrentUser != null) { %>
                <div class="nav-profile-dropdown" id="navProfileDropdown">
                    <button type="button" class="nav-profile-btn" id="navProfileBtn" aria-expanded="false" aria-haspopup="true" aria-label="User Profile and Account Menu">
                        <span class="nav-profile-avatar" aria-hidden="true">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                                <circle cx="12" cy="7" r="4"></circle>
                            </svg>
                        </span>
                        <span class="nav-profile-name"><%= navDisplayName %></span>
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" class="nav-profile-chevron" aria-hidden="true">
                            <polyline points="6 9 12 15 18 9"></polyline>
                        </svg>
                    </button>

                    <!-- Dropdown Menu appearing on hover / cursor move -->
                    <div class="nav-dropdown-menu" id="navDropdownMenu" role="menu">
                        <div class="nav-dropdown-header">
                            <span class="nav-dropdown-greeting">Signed in as</span>
                            <div class="nav-dropdown-username-row">
                                <strong class="nav-dropdown-username"><%= navDisplayName %></strong>
                                <% if (navIsAdmin) { %>
                                    <span class="nav-dropdown-badge">Admin</span>
                                <% } %>
                            </div>
                            <% if (navCurrentUser.getEmail() != null && !navCurrentUser.getEmail().trim().isEmpty()) { %>
                                <span class="nav-dropdown-email"><%= navCurrentUser.getEmail() %></span>
                            <% } %>
                        </div>

                        <div class="nav-dropdown-divider"></div>

                        <ul class="nav-dropdown-list">
                            <li>
                                <a href="<%= navIsAdmin ? "adminProfile.jsp" : "profile" %>" class="nav-dropdown-item<%= navOnProfile ? " is-active" : "" %>" role="menuitem">
                                    <span class="nav-dropdown-icon">
                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                            <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                                            <circle cx="12" cy="7" r="4"></circle>
                                        </svg>
                                    </span>
                                    <span>Profile</span>
                                </a>
                            </li>
                            <li>
                                <a href="MyOrdersHistory" class="nav-dropdown-item<%= navOnOrders ? " is-active" : "" %>" role="menuitem">
                                    <span class="nav-dropdown-icon">
                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                            <path d="M6 2L3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"></path>
                                            <line x1="3" y1="6" x2="21" y2="6"></line>
                                            <path d="M16 10a4 4 0 0 1-8 0"></path>
                                        </svg>
                                    </span>
                                    <span>My Orders</span>
                                </a>
                            </li>
                            <% if (navIsAdmin) { %>
                                <li>
                                    <a href="adminDashboard.jsp" class="nav-dropdown-item" role="menuitem">
                                        <span class="nav-dropdown-icon">
                                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                <rect x="3" y="3" width="7" height="7"></rect>
                                                <rect x="14" y="3" width="7" height="7"></rect>
                                                <rect x="14" y="14" width="7" height="7"></rect>
                                                <rect x="3" y="14" width="7" height="7"></rect>
                                            </svg>
                                        </span>
                                        <span>Admin Dashboard</span>
                                    </a>
                                </li>
                            <% } %>
                        </ul>

                        <div class="nav-dropdown-divider"></div>

                        <a href="logout" class="nav-dropdown-item nav-dropdown-logout" role="menuitem">
                            <span class="nav-dropdown-icon">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path>
                                    <polyline points="16 17 21 12 16 7"></polyline>
                                    <line x1="21" y1="12" x2="9" y2="12"></line>
                                </svg>
                            </span>
                            <span>Log Out</span>
                        </a>
                    </div>
                </div>

                <script>
                (function() {
                    var dropdown = document.getElementById('navProfileDropdown');
                    var btn = document.getElementById('navProfileBtn');
                    if (!dropdown || !btn) return;
                    btn.addEventListener('click', function(e) {
                        e.stopPropagation();
                        var isOpen = dropdown.classList.toggle('is-open');
                        btn.setAttribute('aria-expanded', isOpen ? 'true' : 'false');
                    });
                    document.addEventListener('click', function(e) {
                        if (!dropdown.contains(e.target)) {
                            dropdown.classList.remove('is-open');
                            btn.setAttribute('aria-expanded', 'false');
                        }
                    });
                })();
                </script>
            <% } else { %>
                <a href="login.html" class="nav-link nav-login-link">Log in</a>
            <% } %>

            <!-- Mobile Hamburger Icon -->
            <label for="nav-toggle" class="nav-burger-label" aria-label="Open menu">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <line x1="4" y1="6" x2="20" y2="6"></line>
                    <line x1="4" y1="12" x2="20" y2="12"></line>
                    <line x1="4" y1="18" x2="20" y2="18"></line>
                </svg>
            </label>
        </div>
    </nav>
</header>
