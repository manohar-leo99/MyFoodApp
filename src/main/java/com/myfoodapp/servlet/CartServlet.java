package com.myfoodapp.servlet;

/*
 * CART FLOW:
 *
 * 1. Check user login
 * 2. Get action
 * 3. If action is clear -> clear entire cart
 * 4. Get selected menu item
 * 5. Get its restaurant ID
 * 6. Get cart from session
 *
 * 7. If user wants to change restaurant:
 *       Clear old cart
 *       Create new cart
 *
 * 8. If action is increase/decrease/remove:
 *       Update existing cart item
 *
 * 9. If adding a new item:
 *       Compare cart restaurant with new restaurant
 *
 *       Same restaurant
 *           -> Add item
 *
 *       Different restaurant
 *           -> Ask user whether to change restaurant
 *
 * 10. Save cart in session
 * 11. Redirect to cart.jsp
 */

import java.io.IOException;

import com.myfoodapp.daoimp.MenuDaoImp;
import com.myfoodapp.model.Cart;
import com.myfoodapp.model.CartItem;
import com.myfoodapp.model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// =========================================================
		// 1. CHECK USER LOGIN
		// =========================================================

		HttpSession session = req.getSession(false);
		if (session == null || session.getAttribute("user") == null) {

			resp.sendRedirect("login.html");
			return;
		}
		
		

		// =========================================================
		// 2. GET ACTION
		// =========================================================

		String action = req.getParameter("action");

		// =========================================================
		// 3. CLEAR ENTIRE CART
		// =========================================================
		// Clear Cart does NOT have a menuId.
		// Therefore, this must be handled BEFORE parsing menuId.

		if ("clear".equals(action)) {

			Cart cart = (Cart) session.getAttribute("cart");

			if (cart != null) {

				cart.clearCart();
			}

			// Remove restaurant information because
			// the cart is now completely empty.
			session.removeAttribute("cartRestaurantId");

			// Go back to cart page.
			resp.sendRedirect("cart.jsp");
			return;
		}

		// =========================================================
		// 4. GET MENU ID
		// =========================================================

		String menuIdParameter = req.getParameter("menuId");

		int menuId = Integer.parseInt(menuIdParameter);

		// =========================================================
		// 5. GET MENU ITEM
		// =========================================================

		MenuDaoImp menuDaoImp = new MenuDaoImp();

		Menu menu = menuDaoImp.getMenu(menuId);

		// Get restaurant ID of selected menu item.
		int currentRestaurantId = menu.getRestaurantId();

		// =========================================================
		// 6. GET EXISTING CART FROM SESSION
		// =========================================================

		Cart cart = (Cart) session.getAttribute("cart");

		// =========================================================
		// 7. CHANGE RESTAURANT
		// =========================================================

		if ("changeRestaurant".equals(action)) {

			// Remove old cart.
			cart = new Cart();

			// Save new empty cart.
			session.setAttribute("cart", cart);

			// Store the new restaurant ID.
			session.setAttribute("cartRestaurantId", currentRestaurantId);

			// Do not execute increase/decrease/remove section.
			action = null;
		}

		// =========================================================
		// 8. INCREASE / DECREASE / REMOVE
		// =========================================================

		if (action != null && cart != null) {

			CartItem item = cart.getItems().get(menuId);

			if ("increase".equals(action)) {

				if (item != null) {

					item.setQuantity(item.getQuantity() + 1);
				}

			} else if ("decrease".equals(action)) {

				if (item != null) {

					if (item.getQuantity() > 1) {

						item.setQuantity(item.getQuantity() - 1);
					}
				}

			} else if ("remove".equals(action)) {

				cart.removeItem(menuId);
				resp.sendRedirect("cart.jsp");
				return;
			}

			// If cart becomes empty,
			// remove restaurant information.
			if (cart.getItems().isEmpty()) {

				session.removeAttribute("cartRestaurantId");
			}

			// Save updated cart.
			session.setAttribute("cart", cart);

			resp.sendRedirect("menu?restaurantId=" + currentRestaurantId);
			return;
		}

		// =========================================================
		// 9. CHECK DIFFERENT RESTAURANT
		// =========================================================

		Integer cartRestaurantId = (Integer) session.getAttribute("cartRestaurantId");

		if (cart != null && !cart.getItems().isEmpty()) {

			if (cartRestaurantId != null && cartRestaurantId != currentRestaurantId) {

				// Different restaurant.
				// Ask user whether they want to change restaurant.

				resp.sendRedirect("cart.jsp?error=differentRestaurant&menuId=" + menuId);

				return;
			}
		}

		// =========================================================
		// 10. CREATE CART IF CART DOES NOT EXIST
		// =========================================================

		if (cart == null) {

			cart = new Cart();
		}

		// =========================================================
		// 11. CREATE CART ITEM
		// =========================================================

		CartItem cartItem = new CartItem();
		cartItem.setItemName(menu.getItemName());
		cartItem.setMenuId(menuId);
		cartItem.setPrice(menu.getPrice());
		// New item starts with quantity 1.
		cartItem.setQuantity(1);
		cartItem.setItemImageURL(menu.getMenuImageURL());

		// =========================================================
		// 12. ADD ITEM TO CART
		// =========================================================

		cart.addItem(cartItem);

		// =========================================================
		// 13. SAVE CART IN SESSION
		// =========================================================

		session.setAttribute("cart", cart);

		// Remember restaurant of current cart.
		session.setAttribute("cartRestaurantId", currentRestaurantId);

		// =========================================================
		// 14. SHOW CART PAGE
		// =========================================================

		resp.sendRedirect("menu?restaurantId=" + currentRestaurantId);
	}
}
