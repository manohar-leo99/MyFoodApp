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



@WebServlet("/changePassword")
public class ChangePasswordServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// Check user login
		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("user") == null) {
			resp.sendRedirect("login.html");
			return;
		}

		String currentPassword = req.getParameter("currentPassword");
		String newPassword = req.getParameter("newPassword");
		String confirmPassword = req.getParameter("confirmPassword");

		User user = (User) session.getAttribute("user");

		String currentPasswordFromDB = user.getPassword();

		// Check current password
		if (!currentPasswordFromDB.equals(currentPassword)) {

			resp.getWriter().println("Current Password Is Wrong");
			return;
		}

		// Check new password and confirm password
		if (!newPassword.equals(confirmPassword)) {

			resp.getWriter().println("New Password and Confirm Password do not match");
			return;
		}

		// Update password
		UserDaoImp userDaoImp = new UserDaoImp();

		user.setPassword(newPassword);

		int i = userDaoImp.updatePassword(user);

		if (i > 0) {

			session.setAttribute("user", user);
			resp.sendRedirect("profile.jsp");

		} else {

			resp.getWriter().println("Password Update Failed");
		}
	}
}
