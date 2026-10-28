package com.myfoodapp.servlet;

import java.io.IOException;
import java.util.List;

import com.myfoodapp.daoimp.OrderDaoImp;
import com.myfoodapp.model.Order;
import com.myfoodapp.model.User;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;





@WebServlet("/MyOrdersHistory")
public class OrderHistoryServlet extends HttpServlet
{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	    // Check user login
		HttpSession session = req.getSession(false);
		
		
		if (session == null || session.getAttribute("user") == null) {

		    resp.sendRedirect("login.html");
		    return;
		}
		
		
		
		
		User user = (User) session.getAttribute("user");

		OrderDaoImp orderDaoImp = new OrderDaoImp();
		System.out.println("Logged User ID: " + user.getUserID());

		List<Order> orders = orderDaoImp.getAllOrdersByUserID(user.getUserID());

		System.out.println("Orders found: " + orders.size());

		if (orders != null) {
			req.setAttribute("orders", orders);
			RequestDispatcher ord = req.getRequestDispatcher("myorders.jsp");
			ord.forward(req, resp);
		}
		
		
	}
}
