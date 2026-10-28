package com.myfoodapp.servlet;

import java.io.IOException;

import com.myfoodapp.model.User;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/adminDashboard")
public class AdminDashboardServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// Check admin/user Login Here 
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
		
		RequestDispatcher rd = req.getRequestDispatcher("adminDashboard.jsp");

		rd.forward(req, resp);
	}
	
	
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}