package com.myfoodapp.servlet;

import java.io.IOException;

import com.myfoodapp.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;




@WebServlet("/adminProfile")
public class AdminProfileServlet extends HttpServlet
{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// Prevent browser from showing cached page
		resp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		resp.setHeader("Pragma", "no-cache");
		resp.setDateHeader("Expires", 0);
		
		
		// Check admin/user Login Here
		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("user") == null) {
			resp.sendRedirect("login.html");
			return;
		}
		
		
		User user = (User) session.getAttribute("user");
		
		if (user.getRole().equalsIgnoreCase("Admin"))
		{
			resp.sendRedirect("adminProfile.jsp");
		}
		else
		{
			resp.sendRedirect("login.jsp");
		}
	}
}
