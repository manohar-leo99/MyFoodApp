package com.myfoodapp.servlet;

import java.io.IOException;

import com.myfoodapp.daoimp.UserDaoImp;
import com.myfoodapp.model.User;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/forgotPassword")
public class ForgotPasswordServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// Prevent browser from showing cached page
	    resp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	    resp.setHeader("Pragma", "no-cache");
	    resp.setDateHeader("Expires", 0);
	    
	    
	    
		String email = req.getParameter("email");
		String phoneNumber = req.getParameter("phonenumber");
		
	    

		UserDaoImp userDaoImp = new UserDaoImp();

		User user = userDaoImp.getUserByEmailAndPhoneNumber(email, phoneNumber);

		if (user != null) {
			req.setAttribute("username", user.getUserName());
			req.setAttribute("email", user.getEmail());
			req.setAttribute("phonenumber", user.getPhoneNumber());
			req.setAttribute("password", user.getPassword());

			RequestDispatcher rd = req.getRequestDispatcher("userDetailsDisplay.jsp");
			rd.forward(req, resp);
			
		} else {
			resp.getWriter().println("Invalid Email or Phone Number");
		}
		
	}
}