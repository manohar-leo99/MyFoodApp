package com.myfoodapp.model;

public class Restaurant 
{
	private int restaurantID;
	private String restaurantName;
	private String cuisineType;
	private int deliveryTime;
	private String address;
	private int adminUserID;
	private boolean isActive;
	private float rating;
	private String restaurantImageURL;
	
	
	public Restaurant() {
		super();
	}
	
	
	


	public Restaurant(int restaurantID, String restaurantName, String cuisineType, int deliveryTime, String address,
			int adminUserID, boolean isActive, float rating, String restaurantImageURL) {
		super();
		this.restaurantID = restaurantID;
		this.restaurantName = restaurantName;
		this.cuisineType = cuisineType;
		this.deliveryTime = deliveryTime;
		this.address = address;
		this.adminUserID = adminUserID;
		this.isActive = isActive;
		this.rating = rating;
		this.restaurantImageURL = restaurantImageURL;
	}



	public Restaurant(int restaurantID, String restaurantName, String cuisineType, int deliveryTime, String address,
			int adminUserID, boolean isActive, float rating) {
		super();
		this.restaurantID = restaurantID;
		this.restaurantName = restaurantName;
		this.cuisineType = cuisineType;
		this.deliveryTime = deliveryTime;
		this.address = address;
		this.adminUserID = adminUserID;
		this.isActive = isActive;
		this.rating = rating;
	}


	public Restaurant(String restaurantName, String cuisineType, int deliveryTime, String address, int adminUserID,
			boolean isActive, float rating) {
		super();
		this.restaurantName = restaurantName;
		this.cuisineType = cuisineType;
		this.deliveryTime = deliveryTime;
		this.address = address;
		this.adminUserID = adminUserID;
		this.isActive = isActive;
		this.rating = rating;
	}


	public int getRestaurantID() {
		return restaurantID;
	}


	public void setRestaurantID(int restaurantID) {
		this.restaurantID = restaurantID;
	}


	public String getRestaurantName() {
		return restaurantName;
	}


	public void setRestaurantName(String restaurantName) {
		this.restaurantName = restaurantName;
	}


	public String getCuisineType() {
		return cuisineType;
	}


	public void setCuisineType(String cuisineType) {
		this.cuisineType = cuisineType;
	}


	public int getDeliveryTime() {
		return deliveryTime;
	}


	public void setDeliveryTime(int deliveryTime) {
		this.deliveryTime = deliveryTime;
	}


	public String getAddress() {
		return address;
	}


	public void setAddress(String address) {
		this.address = address;
	}


	public int getAdminUserID() {
		return adminUserID;
	}


	public void setAdminUserID(int adminUserID) {
		this.adminUserID = adminUserID;
	}


	public boolean isActive() {
		return isActive;
	}


	public void setActive(boolean isActive) {
		this.isActive = isActive;
	}


	public float getRating() {
		return rating;
	}


	public void setRating(float rating) {
		this.rating = rating;
	}
	

	public String getRestaurantImageURL() {
		return restaurantImageURL;
	}


	public void setRestaurantImageURL(String restaurantImageURL) {
		this.restaurantImageURL = restaurantImageURL;
	}

	
	@Override
	public String toString() {
		return "Restaurant [restaurantID=" + restaurantID + ", restaurantName=" + restaurantName + ", cuisineType="
				+ cuisineType + ", deliveryTime=" + deliveryTime + ", address=" + address + ", adminUserID="
				+ adminUserID + ", isActive=" + isActive + ", rating=" + rating + ", restaurantImageURL="
				+ restaurantImageURL + "]";
	}
	
	
}
