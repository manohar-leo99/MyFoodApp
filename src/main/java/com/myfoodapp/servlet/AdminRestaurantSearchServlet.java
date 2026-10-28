package com.myfoodapp.servlet;

import java.io.IOException;
import java.util.List;

import com.myfoodapp.daoimp.RestaurantDaoImp;
import com.myfoodapp.model.Restaurant;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/adminRestaurantSearch")
public class AdminRestaurantSearchServlet extends HttpServlet
{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		// Check admin/user Login Here
		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("user") == null) {
			resp.sendRedirect("login.html");
			return;
		}
		
		
		
		
		String restaurantName = req.getParameter("restaurantName");
		RestaurantDaoImp restaurantDaoImp = new RestaurantDaoImp();
		List<Restaurant> restaurantsList = restaurantDaoImp.searchRestaurant(restaurantName);
		req.setAttribute("restaurants", restaurantsList);
		RequestDispatcher rrd = req.getRequestDispatcher("adminRestaurants.jsp");
		rrd.forward(req, resp);
		
	}
}
