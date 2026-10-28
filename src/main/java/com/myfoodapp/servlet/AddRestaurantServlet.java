package com.myfoodapp.servlet;

import java.io.IOException;

import com.myfoodapp.daoimp.RestaurantDaoImp;
import com.myfoodapp.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;





@WebServlet("/addRestaurant")
public class AddRestaurantServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	
    	
    	
		// Check admin/user Login Here
		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("user") == null) {
			resp.sendRedirect("login.html");
			return;
		}
		
		
		
		String name = req.getParameter("name");
		String cuisineType = req.getParameter("cuisineType");
		int deliveryTime = Integer.parseInt(req.getParameter("deliveryTime"));
		String address = req.getParameter("address");
		int adminUserID = Integer.parseInt(req.getParameter("adminUserID"));
		boolean isActive = Boolean.parseBoolean(req.getParameter("isActive"));
		float rating = Float.parseFloat(req.getParameter("rating"));

		Restaurant restaurant = new Restaurant(name, cuisineType, deliveryTime, address, adminUserID, isActive, rating);
		RestaurantDaoImp restaurantDaoImp = new RestaurantDaoImp();
		int i = restaurantDaoImp.addRestaurant(restaurant);
		
		
		
		if (i > 0) {
			resp.sendRedirect("adminRestaurants");
		}
		
    }
}