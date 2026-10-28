package com.myfoodapp.servlet;

import java.io.IOException;

import com.myfoodapp.daoimp.OrderDaoImp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cancelOrder")
public class CancelOrderServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// Check user login
		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("user") == null) {

			resp.sendRedirect("login.html");
			return;
		}
		
		

		int orderId = Integer.parseInt(req.getParameter("orderId"));
		String status = req.getParameter("status");
		if ("Pending".equalsIgnoreCase(status)) {
			OrderDaoImp orderDaoImp = new OrderDaoImp();
			int i = orderDaoImp.cancelOrder(orderId);

			if (i > 0) {

				resp.sendRedirect("MyOrdersHistory?message=cancelled");

			} else {

				resp.sendRedirect("MyOrdersHistory?message=notFound");
			}

		} else {

			resp.sendRedirect("MyOrdersHistory?message=cannotCancel&status=" + status);
		}
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		doPost(req, resp);
	}
}
