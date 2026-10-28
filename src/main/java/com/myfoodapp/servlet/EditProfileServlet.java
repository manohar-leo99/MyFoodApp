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



@WebServlet("/editProfileServlet")
public class EditProfileServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// Check user login
		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("user") == null) {

			resp.sendRedirect("login.html");
			return;
		}

		String firstname = req.getParameter("firstname");
		String lastname = req.getParameter("lastname");
		String email = req.getParameter("email");
		String phone = req.getParameter("phone");
		String address = req.getParameter("address");

		User user = (User) session.getAttribute("user");

		user.setFirstName(firstname);
		user.setLastName(lastname);
		user.setEmail(email);
		user.setPhoneNumber(phone);
		user.setAddress(address);

		UserDaoImp userDaoImp = new UserDaoImp();
		int i = userDaoImp.updateUserDetails(user);

		if (i > 0) {
			resp.sendRedirect("profile.jsp");
			System.out.println("User Details Are Updated!!!!!!!");
		}

	}
}
