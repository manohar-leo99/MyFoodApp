package com.myfoodapp.servlet;

import java.io.IOException;
import java.util.List;

import com.myfoodapp.daoimp.OrderItemDaoImp;
import com.myfoodapp.model.OrderItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/adminOrderItems")
public class AdminOrderItemsServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// Check admin/user Login Here
		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("user") == null) {
			resp.sendRedirect("login.html");
			return;
		}
				
				
		// Get Order ID from the View Items button
		int orderId = Integer.parseInt(req.getParameter("orderId"));

		// Get OrderItems for this order
		OrderItemDaoImp orderItemDaoImp = new OrderItemDaoImp();

		List<OrderItem> orderItems = orderItemDaoImp.getOrderItems(orderId);

		// Send OrderItems to JSP
		req.setAttribute("orderItems", orderItems);

		// Send Order ID also to JSP
		req.setAttribute("orderId", orderId);

		// Open adminOrderItems.jsp
		req.getRequestDispatcher("adminOrderItems.jsp").forward(req, resp);
	}
}