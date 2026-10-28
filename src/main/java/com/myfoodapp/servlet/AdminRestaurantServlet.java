package com.myfoodapp.servlet;

import java.io.IOException;
import java.util.List;

import com.myfoodapp.daoimp.RestaurantDaoImp;
import com.myfoodapp.model.Restaurant;
import com.myfoodapp.model.User;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/adminRestaurants")
public class AdminRestaurantServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession(false);
		if (session == null || session.getAttribute("user") == null) {
			resp.sendRedirect("login.html");
			return;
		}

		
		User user = (User) session.getAttribute("user");

		if (!user.getRole().equalsIgnoreCase("admin")) {
			resp.sendRedirect("restaurants");
			return;
		}

		RestaurantDaoImp restaurantDaoImp = new RestaurantDaoImp();
		List<Restaurant> restaurants = restaurantDaoImp.getAllRestaurants();

		
		req.setAttribute("restaurants", restaurants);
		RequestDispatcher rd = req.getRequestDispatcher("adminRestaurants.jsp");
		rd.forward(req, resp);
	}
}