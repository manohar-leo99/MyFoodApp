package com.myfoodapp.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import com.myfoodapp.daoimp.UserDaoImp;
import com.myfoodapp.model.User;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

	
	
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String username_login = req.getParameter("username");
		String password_login = req.getParameter("password");

		UserDaoImp user_dao_imp = new UserDaoImp();
		User user = user_dao_imp.getUser(username_login, password_login);

		if (user != null) {
			if (username_login.equals(user.getUserName()) && password_login.equals(user.getPassword())) {

				HttpSession session = req.getSession();
				session.setAttribute("user", user);

				if(user.getRole().equalsIgnoreCase("admin"))
				{
					RequestDispatcher rd = req.getRequestDispatcher("/adminDashboard");
					rd.forward(req, resp);
				}
				else
				{
					RequestDispatcher rd = req.getRequestDispatcher("/restaurants");
					rd.forward(req, resp);
				}

			} else {

				resp.sendRedirect("login.html");
			}
		} else {

			resp.sendRedirect("login.html");
		}

	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		resp.sendRedirect("login.html");
	}
}
