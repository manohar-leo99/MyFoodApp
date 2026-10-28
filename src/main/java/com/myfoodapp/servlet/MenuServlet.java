package com.myfoodapp.servlet;

import java.io.IOException;
import java.util.List;

import com.myfoodapp.daoimp.MenuDaoImp;
import com.myfoodapp.model.Menu;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/menu")
public class MenuServlet extends HttpServlet
{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    
	    
	    // Check user login
		HttpSession session = req.getSession(false);

//		if (session == null || session.getAttribute("user") == null) {
//
//		    resp.sendRedirect("login.html");
//		    return;
//		}
		
		
		
		int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));
		session.setAttribute("restaurantId", restaurantId);
		
		
		MenuDaoImp menuDaoImp = new MenuDaoImp();
		List<Menu> restaurantMenuList = menuDaoImp.getMenuByRestaurantId(restaurantId);
		
		req.setAttribute("menus", restaurantMenuList);
		
		
		RequestDispatcher rd = req.getRequestDispatcher("menu.jsp");
		rd.forward(req, resp);
	}
}
