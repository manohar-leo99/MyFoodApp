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


//<a href="profile">Profile</a>
//<br>
//<a href="MyOrdersHistory">My Orders</a>

@WebServlet("/restaurants")
public class RestaurantServlet extends HttpServlet
{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException 
	{
		
		RestaurantDaoImp restaDaoImp = new RestaurantDaoImp();
		List<Restaurant> restaurantsList = restaDaoImp.getAllRestaurants();
		
		
		req.setAttribute("restaurants", restaurantsList);
		
		RequestDispatcher rd = req.getRequestDispatcher("restaurant.jsp");
		rd.forward(req, resp);
	}
	
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
