package com.myfoodapp.servlet;

import java.io.IOException;

import com.myfoodapp.daoimp.MenuDaoImp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;



@WebServlet("/deleteMenu")
public class DeleteMenuServlet extends HttpServlet {

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

		menuDaoImp.deleteMenu(menuId);

		resp.sendRedirect("adminMenus");
	}
}