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




@WebServlet("/adminOrdersSearchByUserId")
public class AdminOrdersSearchServlet extends HttpServlet
{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// Check admin/user Login Here
		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("user") == null) {
			resp.sendRedirect("login.html");
			return;
		}
		
		
		int userId = Integer.parseInt(req.getParameter("userId"));
		OrderDaoImp orderDaoImp = new OrderDaoImp();
		List<Order> orders = orderDaoImp.searchOrdersByUserID(userId);
		req.setAttribute("orders", orders);
		RequestDispatcher ord = req.getRequestDispatcher("adminOrders.jsp");
		ord.forward(req, resp);
	}
}
