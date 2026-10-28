package com.myfoodapp.servlet;

import java.io.IOException;

import com.myfoodapp.daoimp.RestaurantDaoImp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/deleteRestaurant")
public class DeleteRestaurantServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		
		// Check admin/user Login Here
		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("user") == null) {
			resp.sendRedirect("login.html");
			return;
		}
		
		
		
		int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));

		RestaurantDaoImp restaurantDaoImp = new RestaurantDaoImp();

		int i = restaurantDaoImp.deleteRestaurant(restaurantId);

		System.out.println("Restaurant Delete Result = " + i);

		if (i > 0) {

			resp.sendRedirect("adminRestaurants");
		} else {

			resp.sendRedirect("adminRestaurants");
		}
	}
}