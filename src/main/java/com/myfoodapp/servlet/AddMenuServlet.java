package com.myfoodapp.servlet;

import java.io.IOException;

import com.myfoodapp.daoimp.MenuDaoImp;
import com.myfoodapp.model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/addMenu")
public class AddMenuServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		// Check admin/user Login Here
		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("user") == null) {
			resp.sendRedirect("login.html");
			return;
		}
		
		
		
		
		int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));
		String itemName = req.getParameter("itemName");
		String description = req.getParameter("description");
		double price = Double.parseDouble(req.getParameter("price"));
		boolean isAvailable = Boolean.parseBoolean(req.getParameter("isAvailable"));
		String category = req.getParameter("category");
		String menuImageURL = req.getParameter("menuImageURL");

		Menu menu = new Menu(restaurantId, itemName, description, price, isAvailable, category, menuImageURL);
		
		MenuDaoImp menuDaoImp = new MenuDaoImp();

		menuDaoImp.addMenu(menu);

		resp.sendRedirect("adminMenus");
	}
}