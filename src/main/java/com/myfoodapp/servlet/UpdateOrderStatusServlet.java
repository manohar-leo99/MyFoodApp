package com.myfoodapp.servlet;

import java.io.IOException;

import com.myfoodapp.daoimp.OrderDaoImp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/updateOrderStatus")
public class UpdateOrderStatusServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		int orderId = Integer.parseInt(req.getParameter("orderId"));

		String status = req.getParameter("status");

		OrderDaoImp orderDaoImp = new OrderDaoImp();

		orderDaoImp.updateOrderStatus(orderId, status);

		resp.sendRedirect("adminOrders");
	}
}