package com.myfoodapp.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.myfoodapp.daoimp.MenuDaoImp;
import com.myfoodapp.daoimp.OrderItemDaoImp;
import com.myfoodapp.model.CartItem;
import com.myfoodapp.model.Menu;
import com.myfoodapp.model.OrderItem;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;



@WebServlet("/OrderItems")
public class OrderItemsServlet extends HttpServlet
{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		// Check user login
		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("user") == null) {

			resp.sendRedirect("login.html");
			return;
		}
		
		
		int orderId = Integer.parseInt(req.getParameter("orderId"));
		
		
		OrderItemDaoImp orderItemDaoImp = new OrderItemDaoImp();
		List<OrderItem> orderItemsList = orderItemDaoImp.getOrderItems(orderId);
		
		System.out.println("Order Items Count : " + orderItemsList.size());
		
		MenuDaoImp MenuDaoImple = new MenuDaoImp();
		
		
		ArrayList<CartItem> oitemsList = new ArrayList<CartItem>();
		
		for (OrderItem item : orderItemsList)
		{
			Menu menu = MenuDaoImple.getMenu(item.getMenuId());
			String itemName = menu.getItemName();
	
			CartItem oitem = new CartItem(item.getMenuId(), itemName, item.getItemTotal(), item.getQuantity(), menu.getMenuImageURL());
			
			
			oitemsList.add(oitem);
			
		}
		
		
		
		req.setAttribute("OrderItemsList", oitemsList);
		
		RequestDispatcher oird = req.getRequestDispatcher("OrderItems.jsp");
		oird.forward(req, resp);
		
	}
}
