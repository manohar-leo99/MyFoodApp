package com.myfoodapp.servlet;

import java.io.IOException;

import com.myfoodapp.daoimp.OrderDaoImp;
import com.myfoodapp.daoimp.OrderItemDaoImp;
import com.myfoodapp.model.Cart;
import com.myfoodapp.model.CartItem;
import com.myfoodapp.model.Order;
import com.myfoodapp.model.OrderItem;
import com.myfoodapp.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/placeOrder")
public class PlaceOrderServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// Get existing session
		HttpSession session = req.getSession(false);

		// Check login
		if (session == null || session.getAttribute("user") == null) {

			resp.sendRedirect("login.html");
			return;
		}

		
		
		
		
		// Get User
		User user = (User) session.getAttribute("user");

		// Get Cart
		Cart cart = (Cart) session.getAttribute("cart");

		// Check Cart
		if (cart == null || cart.getItems().isEmpty()) {

			resp.sendRedirect("cart.jsp");
			return;
		}

		// Get RestaurantID from Session
		Integer restaurantId = (Integer) session.getAttribute("restaurantId");

		if (restaurantId == null) {

			resp.sendRedirect("restaurants");
			return;
		}
        
        
        

        // Get payment method
        String payment = req.getParameter("payment");

        // =============================
        // CREATE ORDER
        // =============================

        Order order = new Order();

        order.setUserId(user.getUserID());

        order.setRestaurantId(restaurantId);

        order.setTotalAmount(cart.getTotalPrice());

        order.setPaymentMethod(payment);


        // =============================
        // SAVE ORDER
        // =============================

        OrderDaoImp orderDaoImp = new OrderDaoImp();

        int orderId = orderDaoImp.addOrder(order);


        // =============================
        // SAVE ORDER ITEMS
        // =============================

		if (orderId > 0) {

			OrderItemDaoImp orderItemDaoImp = new OrderItemDaoImp();

			for (CartItem cartItem : cart.getItems().values()) {

				OrderItem orderItem = new OrderItem();

				orderItem.setOrderId(orderId);

				orderItem.setMenuId(cartItem.getMenuId());

				orderItem.setQuantity(cartItem.getQuantity());

				double itemTotal = cartItem.getPrice() * cartItem.getQuantity();

				orderItem.setItemTotal(itemTotal);

				// Save OrderItem
				orderItemDaoImp.addOrderItem(orderItem);
			}


            // =============================
            // CLEAR CART
            // =============================

            session.removeAttribute("cart");


            // =============================
            // SEND DATA TO SUCCESS PAGE
            // =============================

			req.setAttribute("orderId", orderId);

			req.setAttribute("total", order.getTotalAmount());

			req.setAttribute("payment", payment);

			req.getRequestDispatcher("orderSuccess.jsp").forward(req, resp);

		} else {

			resp.sendRedirect("checkout.jsp");
		}
    }
}