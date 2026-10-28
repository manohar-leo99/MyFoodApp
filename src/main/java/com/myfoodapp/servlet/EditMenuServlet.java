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

@WebServlet("/editMenu")
public class EditMenuServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// Check admin/user Login Here
		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("user") == null) {
			resp.sendRedirect("login.html");
			return;
		}
		
		
		
		int menuId = Integer.parseInt(req.getParameter("menuId"));

		MenuDaoImp menuDaoImp = new MenuDaoImp();

		Menu menu = menuDaoImp.getMenu(menuId);

		req.setAttribute("menu", menu);

		req.getRequestDispatcher("editMenu.jsp").forward(req, resp);
	}
	
	
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		int menuId = Integer.parseInt(req.getParameter("menuId"));
		int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));
		String itemName = req.getParameter("itemName");
		String description = req.getParameter("description");
		double price = Double.parseDouble(req.getParameter("price"));
		boolean isAvailable = Boolean.parseBoolean(req.getParameter("isAvailable"));
		String category = req.getParameter("category");
		String menuImageURL = req.getParameter("menuImageURL");

		Menu menu = new Menu(menuId, restaurantId, itemName, description, price, isAvailable, category, menuImageURL);

		MenuDaoImp menuDaoImp = new MenuDaoImp();

		menuDaoImp.updateMenu(menu);

		resp.sendRedirect("adminMenus");
	}
}