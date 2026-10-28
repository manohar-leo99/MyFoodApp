package com.myfoodapp.daoimp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.myfoodapp.dao.RestaurantDao;
import com.myfoodapp.model.Restaurant;
import com.myfoodapp.util.DBConnection;

public class RestaurantDaoImp implements RestaurantDao
{
	
	private Connection con = null;
	
	private static final String GET_ALL_RESTAURANTS_QUERY = "SELECT * FROM restaurant";

	private static final String GET_RESTAURANT_BY_ITS_NAME_QUERY = "SELECT * FROM restaurant WHERE Name LIKE ?";

	private static final String ADD_RESTAURANT_QUERY = "INSERT INTO restaurant (Name, CuisineType, DeliveryTime, Address, AdminUserID, IsActive, Rating) VALUES (?, ?, ?, ?, ?, ?, ?)";
	
	
	private static final String GET_RESTAURANT_BY_ID_QUERY = "SELECT * FROM restaurant WHERE RestaurantID = ?";

	private static final String UPDATE_RESTAURANT_QUERY = "UPDATE restaurant SET Name = ?, CuisineType = ?, DeliveryTime = ?, Address = ?, AdminUserID = ?, IsActive = ?, Rating = ?, RestaurantImageURL = ? WHERE RestaurantID = ?";
	
	private static final String DELETE_RESTAURANT_QUERY = "DELETE FROM restaurant WHERE RestaurantID = ?";
	public RestaurantDaoImp()
	{
		con = DBConnection.getConnectionObject();
	}
	
	
	
	
	@Override
	public List<Restaurant> getAllRestaurants() 
	{
		
		List<Restaurant> restaurantsList = new ArrayList<Restaurant>();
		Restaurant restaurant = null;
		
		
		try 
		{
			Statement stmt = con.createStatement();
			ResultSet restaurantsResultSet = stmt.executeQuery(GET_ALL_RESTAURANTS_QUERY);
			
			while (restaurantsResultSet.next())
			{
				restaurant = new Restaurant
				(
						restaurantsResultSet.getInt("RestaurantID"),
						restaurantsResultSet.getString("Name"),
						restaurantsResultSet.getString("CuisineType"),
						restaurantsResultSet.getInt("DeliveryTime"),
						restaurantsResultSet.getString("Address"),
						restaurantsResultSet.getInt("AdminUserID"),
						restaurantsResultSet.getBoolean("IsActive"),
						restaurantsResultSet.getFloat("Rating"),
						restaurantsResultSet.getString("RestaurantImageURL")
				);
				
				
				restaurantsList.add(restaurant);
			}
		} 
		catch (SQLException e)
		{
			
			e.printStackTrace();
		}
		return restaurantsList;
	}
	
	
	
	
	
	
	
	
	@Override
	public List<Restaurant> searchRestaurant(String restaurantName) {
		
		List<Restaurant> restaurantsList = new ArrayList<Restaurant>();
		Restaurant restaurant = null;
		try {

			PreparedStatement pstmt = con.prepareStatement(GET_RESTAURANT_BY_ITS_NAME_QUERY);
			pstmt.setString(1, "%" + restaurantName + "%");
			ResultSet restaurantResultSet = pstmt.executeQuery();
			
			while (restaurantResultSet.next())
			{
				restaurant = new Restaurant
				(
						restaurantResultSet.getInt("RestaurantID"),
						restaurantResultSet.getString("Name"),
						restaurantResultSet.getString("CuisineType"),
						restaurantResultSet.getInt("DeliveryTime"),
						restaurantResultSet.getString("Address"),
						restaurantResultSet.getInt("AdminUserID"),
						restaurantResultSet.getBoolean("IsActive"),
						restaurantResultSet.getFloat("Rating"),
						restaurantResultSet.getString("restaurantImageURL")
				);
				restaurantsList.add(restaurant);
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return restaurantsList;
	}
	
	
	
	@Override
	public int addRestaurant(Restaurant restaurant) {

		int i = 0;

		try {

			PreparedStatement pstmt = con.prepareStatement(ADD_RESTAURANT_QUERY);

			pstmt.setString(1, restaurant.getRestaurantName());
			pstmt.setString(2, restaurant.getCuisineType());
			pstmt.setInt(3, restaurant.getDeliveryTime());
			pstmt.setString(4, restaurant.getAddress());
			pstmt.setInt(5, restaurant.getAdminUserID());
			pstmt.setBoolean(6, restaurant.isActive());
			pstmt.setFloat(7, restaurant.getRating());

			i = pstmt.executeUpdate();

			System.out.println("Restaurant added. Rows affected = " + i);

		} catch (SQLException e) {

			e.printStackTrace();
		}

		return i;
	}
	
	
	
	@Override
	public Restaurant getRestaurantById(int restaurantId) {

		Restaurant restaurant = null;

		try {

			PreparedStatement pstmt = con.prepareStatement(GET_RESTAURANT_BY_ID_QUERY);

			pstmt.setInt(1, restaurantId);

			ResultSet rs = pstmt.executeQuery();

	        if (rs.next()) {

	            restaurant = new Restaurant(
	                    rs.getInt("RestaurantID"),
	                    rs.getString("Name"),
	                    rs.getString("CuisineType"),
	                    rs.getInt("DeliveryTime"),
	                    rs.getString("Address"),
	                    rs.getInt("AdminUserID"),
	                    rs.getBoolean("IsActive"),
	                    rs.getFloat("Rating"),
	                    rs.getString("RestaurantImageURL")
	            );
	        }

	    } catch (SQLException e) {

	        e.printStackTrace();
	    }

	    return restaurant;
	}
	
	
	
	
	
	@Override
	public int updateRestaurant(Restaurant restaurant) {

	    int i = 0;

	    try {

			PreparedStatement pstmt = con.prepareStatement(UPDATE_RESTAURANT_QUERY);

	        pstmt.setString(1, restaurant.getRestaurantName());
	        pstmt.setString(2, restaurant.getCuisineType());
	        pstmt.setInt(3, restaurant.getDeliveryTime());
	        pstmt.setString(4, restaurant.getAddress());
	        pstmt.setInt(5, restaurant.getAdminUserID());
	        pstmt.setBoolean(6, restaurant.isActive());
	        pstmt.setFloat(7, restaurant.getRating());
	        pstmt.setString(8, restaurant.getRestaurantImageURL());
	        pstmt.setInt(9, restaurant.getRestaurantID());
	        

	        i = pstmt.executeUpdate();

	        System.out.println("Restaurant Update Result = " + i);

	    } catch (SQLException e) {

	        e.printStackTrace();
	    }

	    return i;
	}
	
	
	
	@Override
	public int deleteRestaurant(int restaurantId) {

	    int i = 0;

	    try {

	        PreparedStatement pstmt =
	                con.prepareStatement(DELETE_RESTAURANT_QUERY);

	        pstmt.setInt(1, restaurantId);

	        i = pstmt.executeUpdate();

	        System.out.println("Restaurant Delete Result = " + i);

	    } catch (SQLException e) {

	        e.printStackTrace();
	    }

	    return i;
	}
	
}
