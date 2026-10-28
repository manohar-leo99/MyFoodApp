<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.myfoodapp.model.User" %>

<%
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect("login.html");
        return;
    }

    boolean isAdmin = user.getRole() != null && user.getRole().toLowerCase().contains("admin");
    String backUrl = isAdmin ? "adminProfile.jsp" : "profile.jsp";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile | BiteRush</title>
    <meta name="description" content="Update your personal details and address on BiteRush.">

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
</head>
<body>

    <!-- Sticky Navbar -->
    <%@ include file="components/navbar.jsp" %>

    <main class="profile-page-section">
        <div class="container" style="max-width: 800px;">

            <!-- Header -->
            <div class="orders-header-row">
                <div>
                    <h1 class="orders-page-title">Edit Profile</h1>
                    <p class="orders-subtitle">Update your personal contact details, full name, and delivery address.</p>
                </div>
                <a href="<%= backUrl %>" class="btn btn-outline btn-sm">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <line x1="19" y1="12" x2="5" y2="12"></line>
                        <polyline points="12 19 5 12 12 5"></polyline>
                    </svg>
                    <span>Back to Profile</span>
                </a>
            </div>

            <!-- Edit Form Card -->
            <div class="profile-card" style="margin-top: 10px;">
                <%
                    String error = (String) request.getAttribute("error");
                    String message = (String) request.getAttribute("message");
                %>

                <% if (error != null && !error.trim().isEmpty()) { %>
                    <div class="auth-alert auth-alert-error">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                            <circle cx="12" cy="12" r="10"></circle>
                            <line x1="12" y1="8" x2="12" y2="12"></line>
                            <line x1="12" y1="16" x2="12.01" y2="16"></line>
                        </svg>
                        <span><%= error %></span>
                    </div>
                <% } %>

                <% if (message != null && !message.trim().isEmpty()) { %>
                    <div class="auth-alert auth-alert-success">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                            <polyline points="20 6 9 17 4 12"></polyline>
                        </svg>
                        <span><%= message %></span>
                    </div>
                <% } %>

                <!-- Edit Profile Form: Preserving exact action, method, and input names -->
                <form action="editProfileServlet" method="post" id="editProfileForm">
                    <div class="profile-details-grid" style="margin-bottom: 24px;">
                        <!-- Field: First Name -->
                        <div class="form-group">
                            <label for="firstnameInput" class="form-label">First Name</label>
                            <input type="text"
                                   id="firstnameInput"
                                   name="firstname"
                                   value="<%= user.getFirstName() != null ? user.getFirstName() : "" %>"
                                   placeholder="e.g. John"
                                   required
                                   class="auth-input"
                                   style="padding-left: 16px !important;">
                        </div>

                        <!-- Field: Last Name -->
                        <div class="form-group">
                            <label for="lastnameInput" class="form-label">Last Name</label>
                            <input type="text"
                                   id="lastnameInput"
                                   name="lastname"
                                   value="<%= user.getLastName() != null ? user.getLastName() : "" %>"
                                   placeholder="e.g. Doe"
                                   required
                                   class="auth-input"
                                   style="padding-left: 16px !important;">
                        </div>

                        <!-- Field: Email Address -->
                        <div class="form-group">
                            <label for="emailInput" class="form-label">Email Address</label>
                            <input type="email"
                                   id="emailInput"
                                   name="email"
                                   value="<%= user.getEmail() != null ? user.getEmail() : "" %>"
                                   placeholder="e.g. john@example.com"
                                   required
                                   class="auth-input"
                                   style="padding-left: 16px !important;">
                        </div>

                        <!-- Field: Phone Number -->
                        <div class="form-group">
                            <label for="phoneInput" class="form-label">Phone Number</label>
                            <input type="text"
                                   id="phoneInput"
                                   name="phone"
                                   value="<%= user.getPhoneNumber() != null ? user.getPhoneNumber() : "" %>"
                                   placeholder="e.g. 9876543210"
                                   required
                                   class="auth-input"
                                   style="padding-left: 16px !important;">
                        </div>

                        <!-- Field: Address (Full Span) -->
                        <div class="form-group" style="grid-column: 1 / -1;">
                            <label for="addressInput" class="form-label">Delivery Address</label>
                            <textarea id="addressInput"
                                      name="address"
                                      rows="3"
                                      placeholder="e.g. 124 Food Street, Banjara Hills, Hyderabad"
                                      required
                                      class="checkout-textarea"><%= user.getAddress() != null ? user.getAddress() : "" %></textarea>
                        </div>
                    </div>

                    <!-- Form Actions Bar -->
                    <div style="display: flex; align-items: center; justify-content: flex-end; gap: 14px; border-top: 1px solid var(--border); padding-top: 20px;">
                        <a href="<%= backUrl %>" class="btn btn-outline">
                            <span>Cancel</span>
                        </a>
                        <button type="submit" class="btn btn-primary" id="updateProfileBtn">
                            <span>Update Profile</span>
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <line x1="5" y1="12" x2="19" y2="12"></line>
                                <polyline points="12 5 19 12 12 19"></polyline>
                            </svg>
                        </button>
                    </div>
                </form>
            </div>

        </div>
    </main>

    <!-- Reusable Footer Component -->
    <%@ include file="components/footer.jsp" %>

</body>
</html>
