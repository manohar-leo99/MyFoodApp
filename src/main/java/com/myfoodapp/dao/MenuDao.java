package com.myfoodapp.dao;

import com.myfoodapp.model.Menu;
import java.util.List;

public interface MenuDao {
	
	
	public List<Menu> getMenuByRestaurantId(int restaurantId);
	public Menu getMenu(int menuID);
	public List<Menu> searchMenus(String itemName, int restaurantId);
	public List<Menu> filterMenus(String category, int restaurantId);
	
	
	
	//admin methods 
	
	public List<Menu> getAllMenus();

	public void addMenu(Menu menu);

	public void updateMenu(Menu menu);

	public void deleteMenu(int menuId);
	
	public List<Menu> searchMenusByadminByMenuName(String menuName);

}
