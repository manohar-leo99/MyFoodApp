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


@WebServlet("/searchMenu")
public class SearchMenuServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession(false);
		
//		if (session == null || session.getAttribute("user") == null) {
//
//			resp.sendRedirect("login.html");
//			return;
//		}
		
		

		String itemName = req.getParameter("itemName");
		int restaurantId = (int) session.getAttribute("restaurantId");

		MenuDaoImp menuDaoImp = new MenuDaoImp();
		List<Menu> menuList = menuDaoImp.searchMenus(itemName, restaurantId);

		req.setAttribute("menus", menuList);
		RequestDispatcher mrd = req.getRequestDispatcher("menu.jsp");
		mrd.forward(req, resp);

	}
}
