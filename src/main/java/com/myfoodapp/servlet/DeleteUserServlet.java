package com.myfoodapp.servlet;

import java.io.IOException;

import com.myfoodapp.daoimp.UserDaoImp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;



@WebServlet("/deleteUser")
public class DeleteUserServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		// Check admin/user Login Here
		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("user") == null) {
			resp.sendRedirect("login.html");
			return;
		}
		
		
		System.out.println("User Id " + req.getParameter("userID"));
				
			
		int userID = Integer.parseInt(req.getParameter("userID"));
		UserDaoImp userDaoImp = new UserDaoImp();

		int i = userDaoImp.deleteUser(userID);
		System.out.println("Deleted rows = " + i);

		resp.sendRedirect("adminUsers");
	}
}
