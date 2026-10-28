package com.myfoodapp.dao;

import java.util.List;

import com.myfoodapp.model.OrderItem;

public interface OrderItemDao {

    void addOrderItem(OrderItem orderItem);
    public List<OrderItem> getOrderItems(int orderId);

}