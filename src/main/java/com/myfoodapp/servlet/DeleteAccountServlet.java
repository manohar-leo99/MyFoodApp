package com.myfoodapp.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import com.myfoodapp.daoimp.UserDaoImp;
import com.myfoodapp.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;



@WebServlet("/deleteAccount")
public class DeleteAccountServlet extends HttpServlet
{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// Prevent browser from showing cached page
	    resp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	    resp.setHeader("Pragma", "no-cache");
	    resp.setDateHeader("Expires", 0);
	    
	    
	    // Check user login
		HttpSession session = req.getSession(false);
		
		
		if (session == null || session.getAttribute("user") == null) {

		    resp.sendRedirect("login.html");
		    return;
		}
		
		
		
		User user = (User) session.getAttribute("user");
		
		
		String username_uen = req.getParameter("username");
		String password_uep = req.getParameter("password");
		
		
		if ((user.getUserName().equals(username_uen)) && user.getPassword().equals(password_uep))
		{
			
			 UserDaoImp userDaoImp = new UserDaoImp();

	            userDaoImp.deleteUser(user.getUserID());

	            // Delete login session
	            session.invalidate();

	            // Go to login page
	            resp.sendRedirect("login.html");
			
		}
		else
		{
			 resp.sendRedirect("accountDelete.jsp");
		}
		
	}
}
