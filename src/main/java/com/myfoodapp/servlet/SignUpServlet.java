package com.myfoodapp.servlet;

import java.io.IOException;

import com.myfoodapp.daoimp.UserDaoImp;
import com.myfoodapp.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;



@WebServlet("/SignUpServlet")
public class SignUpServlet extends HttpServlet
{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException 
	{
		
		String firstname = req.getParameter("firstname");
		String lastname = req.getParameter("lastname");
		String username = req.getParameter("username");
		String email = req.getParameter("email");
		String phone_number = req.getParameter("phone_number");
		String address = req.getParameter("address");
		String role = req.getParameter("role");
		String password = req.getParameter("password");
		
		
		
		User user = new User(firstname, lastname, username, email, phone_number, address, role, password);
		UserDaoImp user_dao_imp = new UserDaoImp();
		
		
		
		int i = user_dao_imp.addUser(user);
		
		
		
		if (i > 0)
        {
            // Create session after successful signup
            HttpSession session = req.getSession();
            session.setAttribute("user", user);

            // Directly go to restaurants
            resp.sendRedirect("restaurants");
        }
		
	}
}
