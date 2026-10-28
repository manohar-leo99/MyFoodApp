<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.myfoodapp.model.User"%>

<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);

User user = (User) session.getAttribute("user");

if (user == null) {
    response.sendRedirect("login.html");
    return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile | BiteRush</title>
    <meta name="description" content="Manage your personal details, delivery addresses, and account security on BiteRush.">

    <!-- Google Fonts: Inter & Playfair Display -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">

    <!-- BiteRush Stylesheets -->
    <link rel="stylesheet" href="css/global.css?v=5">
    <link rel="stylesheet" href="css/common.css?v=5">
    <link rel="stylesheet" href="css/navbar.css?v=5">
    <link rel="stylesheet" href="css/profile.css?v=5">
    <link rel="stylesheet" href="css/footer.css?v=5">

    <!-- Preserved Bfcache reload handler -->
    <script>
        window.onpageshow = function(event) {
            if (event.persisted) {
                window.location.href = "profile";
            }
        };
    </script>
</head>
<body>

    <!-- Reusable Navbar Component -->
    <%@ include file="components/navbar.jsp" %>

    <main class="profile-page-section">
        <div class="container">

            <!-- Profile Summary Banner -->
            <div class="profile-header-banner">
                <div class="profile-user-summary">
                    <div class="profile-avatar-circle" aria-label="User Avatar">
                        <%= (user.getFirstName() != null && !user.getFirstName().isEmpty()) 
                                ? user.getFirstName().substring(0, 1).toUpperCase() 
                                : "U" %>
                    </div>
                    <div class="profile-user-names">
                        <h1 class="profile-full-name"><%= user.getFirstName() != null ? user.getFirstName() : "" %> <%= user.getLastName() != null ? user.getLastName() : "" %></h1>
                        <p class="profile-username">@<%= user.getUserName() %></p>
                        <span class="badge-role"><%= user.getRole() != null ? user.getRole() : "Customer" %></span>
                    </div>
                </div>

                <a href="restaurant.jsp" class="btn btn-outline btn-sm">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <line x1="19" y1="12" x2="5" y2="12"></line>
                        <polyline points="12 19 5 12 12 5"></polyline>
                    </svg>
                    <span>Explore Restaurants</span>
                </a>
            </div>

            <!-- 2-Column Profile Grid -->
            <div class="profile-grid">
                <!-- Left: Personal & Contact Information -->
                <section class="profile-card" aria-label="Personal Details">
                    <div class="profile-card-header">
                        <h2 class="profile-card-title">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="card-icon" aria-hidden="true">
                                <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                                <circle cx="12" cy="7" r="4"></circle>
                            </svg>
                            <span>Personal Details</span>
                        </h2>
                        <a href="editProfile.jsp" class="btn btn-primary btn-sm">
                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <path d="M12 20h9"></path>
                                <path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"></path>
                            </svg>
                            <span>Update Profile</span>
                        </a>
                    </div>

                    <div class="profile-details-grid">
                        <div class="profile-field-item">
                            <span class="field-label">Username</span>
                            <span class="field-value highlight-field"><%= user.getUserName() %></span>
                        </div>

                        <div class="profile-field-item">
                            <span class="field-label">Role</span>
                            <span class="field-value"><%= user.getRole() %></span>
                        </div>

                        <div class="profile-field-item">
                            <span class="field-label">First Name</span>
                            <span class="field-value"><%= user.getFirstName() %></span>
                        </div>

                        <div class="profile-field-item">
                            <span class="field-label">Last Name</span>
                            <span class="field-value"><%= user.getLastName() %></span>
                        </div>

                        <div class="profile-field-item">
                            <span class="field-label">Email Address</span>
                            <span class="field-value"><%= user.getEmail() %></span>
                        </div>

                        <div class="profile-field-item">
                            <span class="field-label">Phone Number</span>
                            <span class="field-value"><%= user.getPhoneNumber() %></span>
                        </div>

                        <div class="profile-field-item full-width">
                            <span class="field-label">Default Delivery Address</span>
                            <span class="field-value address-value">
                                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="address-icon" aria-hidden="true">
                                    <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path>
                                    <circle cx="12" cy="10" r="3"></circle>
                                </svg>
                                <span><%= user.getAddress() != null && !user.getAddress().trim().isEmpty() ? user.getAddress() : "No address specified yet." %></span>
                            </span>
                        </div>
                    </div>
                </section>

                <!-- Right: Account Actions & Security Sidebar -->
                <aside class="profile-sidebar" aria-label="Account Settings">
                    <!-- Security Card -->
                    <div class="sidebar-card">
                        <h3 class="sidebar-card-title">Security & Credentials</h3>
                        <div class="sidebar-actions-list">
                            <a href="changePassword.jsp" class="btn btn-outline btn-sidebar-action">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                    <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                                    <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
                                </svg>
                                <span>Change Password</span>
                            </a>
                            <a href="logout" class="btn btn-outline btn-sidebar-action">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                    <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path>
                                    <polyline points="16 17 21 12 16 7"></polyline>
                                    <line x1="21" y1="12" x2="9" y2="12"></line>
                                </svg>
                                <span>Log Out</span>
                            </a>
                        </div>
                    </div>

                    <!-- Danger Zone Card -->
                    <div class="sidebar-card danger-box">
                        <h3 class="sidebar-card-title danger-title">Danger Zone</h3>
                        <p class="danger-desc">Once you delete your account, your order records and saved settings will be permanently removed.</p>
                        <a href="accountDelete.jsp" class="btn btn-danger-outline btn-sidebar-action">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z"></path>
                                <line x1="12" y1="9" x2="12" y2="13"></line>
                                <line x1="12" y1="17" x2="12.01" y2="17"></line>
                            </svg>
                            <span>Delete Account</span>
                        </a>
                    </div>
                </aside>
            </div>

        </div>
    </main>

    <!-- Reusable Footer Component -->
    <%@ include file="components/footer.jsp" %>

</body>
</html>
