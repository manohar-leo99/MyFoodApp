package com.myfoodapp.servlet;

import java.io.IOException;

import com.myfoodapp.daoimp.RestaurantDaoImp;
import com.myfoodapp.model.Restaurant;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/editRestaurant")
public class EditRestaurantServlet extends HttpServlet {

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

		Restaurant restaurant = restaurantDaoImp.getRestaurantById(restaurantId);

		req.setAttribute("restaurant", restaurant);

		RequestDispatcher rd = req.getRequestDispatcher("editRestaurant.jsp");

		rd.forward(req, resp);
	}
	
	
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));
		String name = req.getParameter("name");
		String cuisineType = req.getParameter("cuisineType");
		int deliveryTime = Integer.parseInt(req.getParameter("deliveryTime"));
		String address = req.getParameter("address");
		int adminUserID = Integer.parseInt(req.getParameter("adminUserID"));
		boolean isActive = Boolean.parseBoolean(req.getParameter("isActive"));
		float rating = Float.parseFloat(req.getParameter("rating"));
		String restaurantImageURL = req.getParameter("restaurantImageURL");
		
		Restaurant restaurant = new Restaurant(restaurantId, name, cuisineType, deliveryTime, address, adminUserID, isActive, rating, restaurantImageURL);

		RestaurantDaoImp restaurantDaoImp = new RestaurantDaoImp();

		int i = restaurantDaoImp.updateRestaurant(restaurant);

		System.out.println("Restaurant Update Result = " + i);

		if (i > 0) {

			resp.sendRedirect("adminRestaurants");

		} else {

			resp.sendRedirect("editRestaurant?restaurantId=" + restaurantId);
		}
	}
}