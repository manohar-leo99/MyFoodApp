package com.myfoodapp.daoimp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.myfoodapp.dao.OrderItemDao;
import com.myfoodapp.model.OrderItem;
import com.myfoodapp.util.DBConnection;

public class OrderItemDaoImp implements OrderItemDao {

    private Connection con;

	private static final String ADD_ORDER_ITEM = "INSERT INTO orderitem (OrderID, MenuID, Quantity, ItemTotal) VALUES (?, ?, ?, ?)";

	private static final String GET_ORDER_ITEMS_QUERY = "SELECT * FROM orderitem WHERE OrderID = ?";

	public OrderItemDaoImp() {
		con = DBConnection.getConnectionObject();
	}

    @Override
    public void addOrderItem(OrderItem orderItem) {

        try {
            PreparedStatement pstmt =
                    con.prepareStatement(ADD_ORDER_ITEM);

            pstmt.setInt(1, orderItem.getOrderId());
            pstmt.setInt(2, orderItem.getMenuId());
            pstmt.setInt(3, orderItem.getQuantity());
            pstmt.setDouble(4, orderItem.getItemTotal());

            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    
    
    
    
    @Override
    public List<OrderItem> getOrderItems(int orderId) {
    	
    	List<OrderItem> orderItemList = new ArrayList<OrderItem>();
    	
    	try {
			PreparedStatement pstmt = con.prepareStatement(GET_ORDER_ITEMS_QUERY);
			pstmt.setInt(1, orderId);
			ResultSet orderItemsResultSet = pstmt.executeQuery();
			
			
			while(orderItemsResultSet.next())
			{
				OrderItem orderItem = new OrderItem
				(
						orderItemsResultSet.getInt("OrderItemID"),
						orderItemsResultSet.getInt("OrderID"),
						orderItemsResultSet.getInt("MenuID"),
						orderItemsResultSet.getInt("Quantity"),
						orderItemsResultSet.getDouble("ItemTotal")
				);
				
				
				orderItemList.add(orderItem);
			}
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
    	return orderItemList;
    }
}