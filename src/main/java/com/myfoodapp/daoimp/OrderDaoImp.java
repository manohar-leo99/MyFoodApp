package com.myfoodapp.daoimp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.myfoodapp.dao.OrderDao;
import com.myfoodapp.model.Order;
import com.myfoodapp.util.DBConnection;

public class OrderDaoImp implements OrderDao {

	private Connection con;

	private static final String ADD_ORDER = "INSERT INTO orderTable (UserID, RestaurantID, TotalAmount, PaymentMethod) VALUES (?, ?, ?, ?)";

	private static final String GET_ORDER_QUERY = "SELECT * FROM ordertable WHERE UserID = ?";

	private static final String CANCEL_ORDER_QUERY = "UPDATE orderTable SET Status = 'Cancelled' WHERE orderID = ?";

	private static final String GET_ALL_ORDERS_QUERY = "SELECT * FROM orderTable";
	
	private static final String UPDATE_ORDER_STATUS_QUERY = "UPDATE orderTable SET Status = ? WHERE OrderID = ?";

	private static final String SEARCH_ORDERS_BY_USER_ID_QUERY = "SELECT * FROM ordertable WHERE UserID = ?";
	
	public OrderDaoImp() {
		con = DBConnection.getConnectionObject();
	}

	
	
	
	@Override
	public int addOrder(Order order) {

		try {
			PreparedStatement pstmt = con.prepareStatement(ADD_ORDER, Statement.RETURN_GENERATED_KEYS);

			pstmt.setInt(1, order.getUserId());
			pstmt.setInt(2, order.getRestaurantId());
			pstmt.setDouble(3, order.getTotalAmount());
			pstmt.setString(4, order.getPaymentMethod());

			pstmt.executeUpdate();

			ResultSet rs = pstmt.getGeneratedKeys();

			if (rs.next()) {
				return rs.getInt(1);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return 0;
	}
	
	
	
	
	public List<Order> getAllOrdersByUserID(int userID) {

	    ArrayList<Order> ordersList = new ArrayList<Order>();

	    try {

	        System.out.println("User ID received by DAO: " + userID);

	        PreparedStatement pstmt =
	                con.prepareStatement(GET_ORDER_QUERY);

	        pstmt.setInt(1, userID);

	        ResultSet ordersResultSet =
	                pstmt.executeQuery();

	        while (ordersResultSet.next()) {

	            Order order = new Order
	            (
	                    ordersResultSet.getInt("OrderID"),
	                    ordersResultSet.getInt("UserID"),
	                    ordersResultSet.getInt("RestaurantID"),
	                    ordersResultSet.getTimestamp("OrderDate"),
	                    ordersResultSet.getDouble("TotalAmount"),
	                    ordersResultSet.getString("Status"),
	                    ordersResultSet.getString("PaymentMethod")
	            );

	            ordersList.add(order);
	        }

	        System.out.println("Orders found: " + ordersList.size());

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return ordersList;
	}
	
	
	
	
	@Override
	public int cancelOrder(int orderId) {

		int i = 0;

		try {
			PreparedStatement pstmt = con.prepareStatement(CANCEL_ORDER_QUERY);
			pstmt.setInt(1, orderId);
			i = pstmt.executeUpdate();
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return i;
	}
	
	
	
	@Override
	public List<Order> getAllOrders() {

	    List<Order> ordersList = new ArrayList<Order>();

	    try {

	        PreparedStatement pstmt =
	                con.prepareStatement(GET_ALL_ORDERS_QUERY);

	        ResultSet rs = pstmt.executeQuery();

	        while (rs.next()) {

	            Order order = new Order(
	                    rs.getInt("OrderID"),
	                    rs.getInt("UserID"),
	                    rs.getInt("RestaurantID"),
	                    rs.getTimestamp("OrderDate"),
	                    rs.getDouble("TotalAmount"),
	                    rs.getString("Status"),
	                    rs.getString("PaymentMethod")
	            );

	            ordersList.add(order);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return ordersList;
	}
	
	
	
	
	@Override
	public int updateOrderStatus(int orderId, String status) {

		int result = 0;

		try {

			PreparedStatement pstmt = con.prepareStatement(UPDATE_ORDER_STATUS_QUERY);

			pstmt.setString(1, status);
			pstmt.setInt(2, orderId);

			result = pstmt.executeUpdate();

		} catch (SQLException e) {

			e.printStackTrace();
		}
		
		return result;
	}
	
	
	@Override
	public List<Order> searchOrdersByUserID(int userID) {
		ArrayList<Order> ordersList = new ArrayList<Order>();
	    try {
	        PreparedStatement pstmt = con.prepareStatement(SEARCH_ORDERS_BY_USER_ID_QUERY);
	        pstmt.setInt(1, userID);
	        ResultSet ordersResultSet = pstmt.executeQuery();

	        while (ordersResultSet.next()) {

	            Order order = new Order
	            (
	                    ordersResultSet.getInt("OrderID"),
	                    ordersResultSet.getInt("UserID"),
	                    ordersResultSet.getInt("RestaurantID"),
	                    ordersResultSet.getTimestamp("OrderDate"),
	                    ordersResultSet.getDouble("TotalAmount"),
	                    ordersResultSet.getString("Status"),
	                    ordersResultSet.getString("PaymentMethod")
	            );

	            ordersList.add(order);
	        }

	        System.out.println("Orders found: " + ordersList.size());

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return ordersList;
	
	}
}