package com.myfoodapp.servlet;

import java.io.IOException;
import java.util.List;

import com.myfoodapp.daoimp.UserDaoImp;
import com.myfoodapp.model.User;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/adminUserSearch")
public class AdminUserSearchServlet extends HttpServlet
{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// Check admin/user Login Here
		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("user") == null) {
			resp.sendRedirect("login.html");
			return;
		}
		
		
		
		String name = req.getParameter("name");
		UserDaoImp userDaoImp = new UserDaoImp();
		List<User> users = userDaoImp.searchUsersByName(name);
		req.setAttribute("users", users);
		RequestDispatcher urd = req.getRequestDispatcher("adminUsers.jsp");
		urd.forward(req, resp);
	}
}
