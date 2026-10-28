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




@WebServlet("/adminUsers")
public class AdminUsersServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession(false);
		if (session == null || session.getAttribute("user") == null) {
			resp.sendRedirect("login.html");
			return;
		}

		
		
		User user = (User) session.getAttribute("user");

		if (!user.getRole().equalsIgnoreCase("admin")) {
			resp.sendRedirect("restaurants");
			return;
		}
		
		
		UserDaoImp userDaoImp = new UserDaoImp();
		List<User> users = userDaoImp.getAllUsers();

		req.setAttribute("users", users);
		RequestDispatcher rd = req.getRequestDispatcher("adminUsers.jsp");

		rd.forward(req, resp);
	}
}