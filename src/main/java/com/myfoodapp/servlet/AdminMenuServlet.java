package com.myfoodapp.servlet;

import java.io.IOException;
import java.util.List;

import com.myfoodapp.daoimp.MenuDaoImp;
import com.myfoodapp.model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/adminMenus")
public class AdminMenuServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// Check admin/user Login Here
		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("user") == null) {
			resp.sendRedirect("login.html");
			return;
		}
		
		// Create Menu DAO
		MenuDaoImp menuDaoImp = new MenuDaoImp();

		// Get all menus from database
		List<Menu> menuList = menuDaoImp.getAllMenus();

		// Send menu list to JSP
		req.setAttribute("menuList", menuList);

		// Open Admin Menu page
		req.getRequestDispatcher("adminMenus.jsp").forward(req, resp);
	}
}