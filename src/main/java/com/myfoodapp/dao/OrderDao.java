package com.myfoodapp.dao;

import java.util.List;

import com.myfoodapp.model.Order;

public interface OrderDao {

    int addOrder(Order order);
    List<Order> getAllOrdersByUserID(int userID);
    public int cancelOrder(int orderId);
    
    
    
    List<Order> getAllOrders();
    int updateOrderStatus(int orderId, String status);
    List<Order> searchOrdersByUserID(int userID);

}