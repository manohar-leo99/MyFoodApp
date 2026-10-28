package com.myfoodapp.servlet;

import java.io.IOException;
import java.util.List;

import com.myfoodapp.daoimp.OrderDaoImp;
import com.myfoodapp.model.Order;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/adminOrders")
public class AdminOrdersServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		// Check admin/user Login Here
		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("user") == null) {
			resp.sendRedirect("login.html");
			return;
		}
		
		
		
		
		OrderDaoImp orderDaoImp = new OrderDaoImp();

		List<Order> orders = orderDaoImp.getAllOrders();

		req.setAttribute("orders", orders);

		RequestDispatcher rd = req.getRequestDispatcher("adminOrders.jsp");

		rd.forward(req, resp);
	}
}