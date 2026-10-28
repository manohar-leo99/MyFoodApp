package com.myfoodapp.model;

import java.sql.Timestamp;

public class Menu {

	private int menuId;
	private int restaurantId;
	private String itemName;
	private String description;
	private double price;
	private boolean isAvailable;
	private String category;
	private Timestamp updatedAt;
	private Timestamp createdAt;
	private Timestamp deletedAt;
	private String MenuImageURL;

	public Menu() {
		super();
	}
	
	
	

	public Menu(int menuId, int restaurantId, String itemName, String description, double price, boolean isAvailable,
			String category, Timestamp updatedAt, Timestamp createdAt, Timestamp deletedAt, String menuImageURL) {
		super();
		this.menuId = menuId;
		this.restaurantId = restaurantId;
		this.itemName = itemName;
		this.description = description;
		this.price = price;
		this.isAvailable = isAvailable;
		this.category = category;
		this.updatedAt = updatedAt;
		this.createdAt = createdAt;
		this.deletedAt = deletedAt;
		this.MenuImageURL = menuImageURL;
	}




	public Menu(int menuId, int restaurantId, String itemName, String description, double price, boolean isAvailable,
			String category, Timestamp updatedAt, Timestamp createdAt, Timestamp deletedAt) {
		super();
		this.menuId = menuId;
		this.restaurantId = restaurantId;
		this.itemName = itemName;
		this.description = description;
		this.price = price;
		this.isAvailable = isAvailable;
		this.category = category;
		this.updatedAt = updatedAt;
		this.createdAt = createdAt;
		this.deletedAt = deletedAt;
	}

	public Menu(int menuId, int restaurantId, String itemName, String description, double price, boolean isAvailable,
			String category) {
		super();
		this.menuId = menuId;
		this.restaurantId = restaurantId;
		this.itemName = itemName;
		this.description = description;
		this.price = price;
		this.isAvailable = isAvailable;
		this.category = category;
	}
	
	
	
	
	
	
	public Menu(int restaurantId, String itemName, String description, double price, boolean isAvailable,
			String category) {
		super();
		this.restaurantId = restaurantId;
		this.itemName = itemName;
		this.description = description;
		this.price = price;
		this.isAvailable = isAvailable;
		this.category = category;
	}
	
	
	



	public Menu(int menuId, int restaurantId, String itemName, String description, double price, boolean isAvailable,
			String category, String menuImageURL) {
		super();
		this.menuId = menuId;
		this.restaurantId = restaurantId;
		this.itemName = itemName;
		this.description = description;
		this.price = price;
		this.isAvailable = isAvailable;
		this.category = category;
		MenuImageURL = menuImageURL;
	}

	
	
	

	public Menu(int restaurantId, String itemName, String description, double price, boolean isAvailable,
			String category, String menuImageURL) {
		super();
		this.restaurantId = restaurantId;
		this.itemName = itemName;
		this.description = description;
		this.price = price;
		this.isAvailable = isAvailable;
		this.category = category;
		MenuImageURL = menuImageURL;
	}




	public int getMenuId() {
		return menuId;
	}

	public void setMenuId(int menuId) {
		this.menuId = menuId;
	}

	public int getRestaurantId() {
		return restaurantId;
	}

	public void setRestaurantId(int restaurantId) {
		this.restaurantId = restaurantId;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public boolean isAvailable() {
		return isAvailable;
	}

	public void setAvailable(boolean isAvailable) {
		this.isAvailable = isAvailable;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public Timestamp getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Timestamp updatedAt) {
		this.updatedAt = updatedAt;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	public Timestamp getDeletedAt() {
		return deletedAt;
	}

	public void setDeletedAt(Timestamp deletedAt) {
		this.deletedAt = deletedAt;
	}
	
	
	

	public String getMenuImageURL() {
		return MenuImageURL;
	}

	public void setMenuImageURL(String menuImageURL) {
		MenuImageURL = menuImageURL;
	}


	

	@Override
	public String toString() {
		return "Menu [menuId=" + menuId + ", restaurantId=" + restaurantId + ", itemName=" + itemName + ", description="
				+ description + ", price=" + price + ", isAvailable=" + isAvailable + ", category=" + category
				+ ", updatedAt=" + updatedAt + ", createdAt=" + createdAt + ", deletedAt=" + deletedAt
				+ ", MenuImageURL=" + MenuImageURL + "]";
	}
	
}
