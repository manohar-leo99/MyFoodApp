<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.myfoodapp.model.User" %>
<%
    User adminProfileUser = (User) session.getAttribute("user");
    String adminProfileDisplayName = "Admin";
    if (adminProfileUser != null) {
        if (adminProfileUser.getFirstName() != null && !adminProfileUser.getFirstName().trim().isEmpty()) {
            adminProfileDisplayName = adminProfileUser.getFirstName().trim();
        } else if (adminProfileUser.getUserName() != null && !adminProfileUser.getUserName().trim().isEmpty()) {
            adminProfileDisplayName = adminProfileUser.getUserName().trim();
        }
    }
%>
<div class="nav-profile-dropdown" id="adminProfileDropdown">
    <button type="button" class="nav-profile-btn" id="adminProfileBtn" aria-expanded="false" aria-haspopup="true" aria-label="User Profile and Account Menu">
        <span class="nav-profile-avatar" aria-hidden="true">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                <circle cx="12" cy="7" r="4"></circle>
            </svg>
        </span>
        <span class="nav-profile-name"><%= adminProfileDisplayName %></span>
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" class="nav-profile-chevron" aria-hidden="true">
            <polyline points="6 9 12 15 18 9"></polyline>
        </svg>
    </button>

    <!-- Dropdown Menu appearing on hover / cursor move -->
    <div class="nav-dropdown-menu" id="adminDropdownMenu" role="menu">
        <div class="nav-dropdown-header">
            <span class="nav-dropdown-greeting">Signed in as</span>
            <div class="nav-dropdown-username-row">
                <strong class="nav-dropdown-username"><%= adminProfileDisplayName %></strong>
                <span class="nav-dropdown-badge">Admin</span>
            </div>
            <% if (adminProfileUser != null && adminProfileUser.getEmail() != null && !adminProfileUser.getEmail().trim().isEmpty()) { %>
                <span class="nav-dropdown-email"><%= adminProfileUser.getEmail() %></span>
            <% } %>
        </div>

        <div class="nav-dropdown-divider"></div>

        <ul class="nav-dropdown-list">
            <li>
                <a href="adminProfile.jsp" class="nav-dropdown-item" role="menuitem">
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
                <a href="MyOrdersHistory" class="nav-dropdown-item" role="menuitem">
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
    var dropdown = document.getElementById('adminProfileDropdown');
    var btn = document.getElementById('adminProfileBtn');
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
