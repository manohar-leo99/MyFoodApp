package com.myfoodapp.model;

import java.util.HashMap;
import java.util.Map;

public class Cart {

	private Map<Integer, CartItem> items;

	public Cart() {
		items = new HashMap<>();
	}

	public Map<Integer, CartItem> getItems() {
		return items;
	}

	public void setItems(Map<Integer, CartItem> items) {
		this.items = items;
	}

	// Add item to cart
	public void addItem(CartItem item) {

		int menuId = item.getMenuId();

		if (items.containsKey(menuId)) {

			CartItem existingItem = items.get(menuId);

			existingItem.setQuantity(existingItem.getQuantity() + item.getQuantity());

		} else {

			items.put(menuId, item);
		}
	}
	

	// Remove item from cart
	public void removeItem(int menuId) {

		items.remove(menuId);
	}

	
	
	// Update item quantity
	public void updateItem(int menuId, int quantity) {

		if (items.containsKey(menuId)) {

			CartItem item = items.get(menuId);

			item.setQuantity(quantity);
		}
	}
	
	
	//Get Total Of Items
	public double getTotalPrice() {

	    double totalPrice = 0;

	    for (CartItem item : items.values()) {

	        totalPrice += item.getPrice() * item.getQuantity();
	    }

	    return totalPrice;
	}
	
	
	
	
	public void clearCart()
	{
		items.clear();
	}
	
	
}