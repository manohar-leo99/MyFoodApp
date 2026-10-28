package com.myfoodapp.servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

	    // Check user login
		HttpSession session = req.getSession(false);
		
		
		if (session == null || session.getAttribute("user") == null) {

		    resp.sendRedirect("login.html");
		    return;
		}

		
		// Go to checkout page
		resp.sendRedirect("checkout.jsp");
	}
}