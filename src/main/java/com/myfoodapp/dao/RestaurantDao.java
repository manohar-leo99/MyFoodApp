package com.myfoodapp.dao;

import com.myfoodapp.model.Restaurant;
import java.util.List;

public interface RestaurantDao {
	public List<Restaurant> getAllRestaurants();

	public List<Restaurant> searchRestaurant(String restaurantName);

	public int addRestaurant(Restaurant restaurant);

	public Restaurant getRestaurantById(int restaurantId);

	public int updateRestaurant(Restaurant restaurant);
	
	public int deleteRestaurant(int restaurantId);

}
