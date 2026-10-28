package com.myfoodapp.daoimp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.myfoodapp.dao.MenuDao;
import com.myfoodapp.model.Menu;
import com.myfoodapp.util.DBConnection;

public class MenuDaoImp implements MenuDao
{
	
	private static final String GET_MENUS_QUERY = "SELECT * FROM menu WHERE RestaurantID = ?";
	
	private static final String GET_MENU_QUERY = "SELECT * FROM menu WHERE MenuID = ?";
	
	private static final String GET_MENUS_BY_ITS_NAME_QUERY = "SELECT * FROM menu WHERE ItemName LIKE ? and RestaurantID = ?";
	
	private static final String GET_MENUS_ITEMS_BY_CATEGORY_QUERY = "SELECT * FROM menu WHERE Category = ? AND RestaurantID = ?";
	
	private static final String GET_ALL_MENUS_QUERY = "SELECT * FROM menu";
	
	private static final String ADD_MENU_QUERY = "INSERT INTO menu (RestaurantID, ItemName, Description, Price, IsAvailable, Category) VALUES (?, ?, ?, ?, ?, ?)";

	private static final String UPDATE_MENU_QUERY = "UPDATE menu SET RestaurantID=?, ItemName=?, Description=?, Price=?, IsAvailable=?, Category=?, MenuImageURL = ? WHERE MenuID=?";

	private static final String DELETE_MENU_QUERY = "DELETE FROM menu WHERE MenuID=?";

	private static final String GET_MENUS_BY_MENU_NAME_QUERY = "SELECT * FROM menu WHERE ItemName LIKE ?";
	
	private Connection con = null;

	public MenuDaoImp()
	{
		con  = DBConnection.getConnectionObject();
	}
	
	

	@Override
	public List<Menu> getMenuByRestaurantId(int restaurantId) {
		
		List<Menu> restaurantMenuList = new ArrayList<Menu>();
		
		Menu menu = null;
		
		try {
			
			
			PreparedStatement pstmt = con.prepareStatement(GET_MENUS_QUERY);
			pstmt.setInt(1, restaurantId);
			ResultSet menuResultSet = pstmt.executeQuery();
			
			
			while (menuResultSet.next())
			{
				menu = new Menu
				(
						menuResultSet.getInt("MenuID"),
						menuResultSet.getInt("RestaurantID"),
						menuResultSet.getString("ItemName"),
						menuResultSet.getString("Description"),
						menuResultSet.getDouble("Price"),
						menuResultSet.getBoolean("IsAvailable"),
						menuResultSet.getString("Category"),
						menuResultSet.getTimestamp("UpdatedAt"),
						menuResultSet.getTimestamp("CreatedAt"),
						menuResultSet.getTimestamp("DeletedAt"),
						menuResultSet.getString("MenuImageURL")
						
				);
				
				restaurantMenuList.add(menu);
			}
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		
		return restaurantMenuList;
	}
	

	
	
	
	@Override
	public Menu getMenu(int menuID) {
		
		Menu menu = null;
		
		try {
			PreparedStatement pstmt = con.prepareStatement(GET_MENU_QUERY);
			pstmt.setInt(1, menuID);
			ResultSet menuRow  = pstmt.executeQuery();
			
			while (menuRow.next())
			{
				menu = new Menu
				(
						menuRow.getInt("MenuID"),
						menuRow.getInt("RestaurantID"),
						menuRow.getString("ItemName"),
						menuRow.getString("Description"),
						menuRow.getDouble("Price"),
						menuRow.getBoolean("IsAvailable"),
						menuRow.getString("Category"),
						menuRow.getTimestamp("UpdatedAt"),
						menuRow.getTimestamp("CreatedAt"),
						menuRow.getTimestamp("DeletedAt"),
						menuRow.getString("MenuImageURL")
						
				);
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return menu;
	}
	
	
	
	
	
	
	@Override
	public List<Menu> searchMenus(String itemName, int restaurantId) {
		
		List<Menu> restaurantMenuList = new ArrayList<Menu>();
		
		Menu menu = null;
		
		try {
			
			
			PreparedStatement pstmt = con.prepareStatement(GET_MENUS_BY_ITS_NAME_QUERY);
			pstmt.setString(1, "%" + itemName + "%");
			pstmt.setInt(2, restaurantId);
			ResultSet menuResultSet = pstmt.executeQuery();
			
			
			
			while (menuResultSet.next())
			{
				menu = new Menu
				(
						menuResultSet.getInt("MenuID"),
						menuResultSet.getInt("RestaurantID"),
						menuResultSet.getString("ItemName"),
						menuResultSet.getString("Description"),
						menuResultSet.getDouble("Price"),
						menuResultSet.getBoolean("IsAvailable"),
						menuResultSet.getString("Category"),
						menuResultSet.getTimestamp("UpdatedAt"),
						menuResultSet.getTimestamp("CreatedAt"),
						menuResultSet.getTimestamp("DeletedAt"),
						menuResultSet.getString("MenuImageURL")
						
				);
				
				restaurantMenuList.add(menu);
			}
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		
		return restaurantMenuList;
	}
	
	
	
	@Override
	public List<Menu> filterMenus(String category, int restaurantId) {

		List<Menu> menuList = new ArrayList<Menu>();

		try {

			PreparedStatement pstmt = con.prepareStatement(GET_MENUS_ITEMS_BY_CATEGORY_QUERY);

			pstmt.setString(1, category);
			pstmt.setInt(2, restaurantId);

			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {

				Menu menu = new Menu
						(
						rs.getInt("MenuID"), 
						rs.getInt("RestaurantID"), 
						rs.getString("ItemName"),
						rs.getString("Description"),
						rs.getDouble("Price"), 
						rs.getBoolean("IsAvailable"),
						rs.getString("Category"),
						rs.getString("MenuImageURL")
						);

				menuList.add(menu);
			}

		} catch (SQLException e) {

			e.printStackTrace();
		}

		return menuList;
	}
	
	
	
	
	@Override
	public List<Menu> getAllMenus() {

	    List<Menu> menuList = new ArrayList<Menu>();

	    try {

	        PreparedStatement pstmt = con.prepareStatement(GET_ALL_MENUS_QUERY);

	        ResultSet rs = pstmt.executeQuery();

	        while (rs.next()) {

	            Menu menu = new Menu(
	                    rs.getInt("MenuID"),
	                    rs.getInt("RestaurantID"),
	                    rs.getString("ItemName"),
	                    rs.getString("Description"),
	                    rs.getDouble("Price"),
	                    rs.getBoolean("IsAvailable"),
	                    rs.getString("Category"),
	                    rs.getTimestamp("UpdatedAt"),
	                    rs.getTimestamp("CreatedAt"),
	                    rs.getTimestamp("DeletedAt"),
	                    rs.getString("MenuImageURL")
	            );

	            menuList.add(menu);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return menuList;
	}
	
	
	
	@Override
	public void addMenu(Menu menu) {

	    try {

	        PreparedStatement pstmt = con.prepareStatement(ADD_MENU_QUERY);

	        pstmt.setInt(1, menu.getRestaurantId());
	        pstmt.setString(2, menu.getItemName());
	        pstmt.setString(3, menu.getDescription());
	        pstmt.setDouble(4, menu.getPrice());
	        pstmt.setBoolean(5, menu.isAvailable());
	        pstmt.setString(6, menu.getCategory());
	        pstmt.setString(7, menu.getMenuImageURL());

	        pstmt.executeUpdate();

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}
	
	
	
	@Override
	public void updateMenu(Menu menu) {

	    try {

	        PreparedStatement pstmt = con.prepareStatement(UPDATE_MENU_QUERY);

	        pstmt.setInt(1, menu.getRestaurantId());
	        pstmt.setString(2, menu.getItemName());
	        pstmt.setString(3, menu.getDescription());
	        pstmt.setDouble(4, menu.getPrice());
	        pstmt.setBoolean(5, menu.isAvailable());
	        pstmt.setString(6, menu.getCategory());
	        pstmt.setString(7, menu.getMenuImageURL());
	        pstmt.setInt(8, menu.getMenuId());

	        pstmt.executeUpdate();

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}
	
	
	
	
	@Override
	public void deleteMenu(int menuId) {

	    try {

	        PreparedStatement pstmt = con.prepareStatement(DELETE_MENU_QUERY);

	        pstmt.setInt(1, menuId);

	        pstmt.executeUpdate();

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}
	
	
	@Override
	public List<Menu> searchMenusByadminByMenuName(String menuName) {
		
		List<Menu> menuList = new ArrayList<Menu>();
		Menu menu = null;
		try {
			PreparedStatement pstmt = con.prepareStatement(GET_MENUS_BY_MENU_NAME_QUERY);
			pstmt.setString(1, "%"+ menuName +"%");
			ResultSet menuResultSet = pstmt.executeQuery();
			
			while (menuResultSet.next())
			{
				menu = new Menu
				(
						menuResultSet.getInt("MenuID"),
						menuResultSet.getInt("RestaurantID"),
						menuResultSet.getString("ItemName"),
						menuResultSet.getString("Description"),
						menuResultSet.getDouble("Price"),
						menuResultSet.getBoolean("IsAvailable"),
						menuResultSet.getString("Category"),
						menuResultSet.getTimestamp("UpdatedAt"),
						menuResultSet.getTimestamp("CreatedAt"),
						menuResultSet.getTimestamp("DeletedAt"),
						menuResultSet.getString("MenuImageURL")
						
				);
				
				menuList.add(menu);
			}
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		return menuList;
	}
	
}
