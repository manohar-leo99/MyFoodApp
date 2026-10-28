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


@WebServlet("/adminMenuSearch")
public class AdminMenuSearchServlet extends HttpServlet
{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		// Check admin/user Login Here
		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("user") == null) {
			resp.sendRedirect("login.html");
			return;
		}
		
		
		
		String menuName = req.getParameter("menuName");
		MenuDaoImp menuDaoImp = new MenuDaoImp();
		
		List<Menu> menuList = menuDaoImp.searchMenusByadminByMenuName(menuName);
		
		req.setAttribute("menuList", menuList);
		RequestDispatcher mrd = req.getRequestDispatcher("adminMenus.jsp");
		mrd.forward(req, resp);
	}
}
