package com.myfoodapp.dao;

import java.util.List;

import com.myfoodapp.model.User;

public interface UserDao 
{
	public int addUser(User user);
	public User getUser(String username, String password);
	public int deleteUser(int userID);
	public User getUserByEmailAndPhoneNumber(String email, String phoneNumber);
	public int updateUserDetails(User user);
	public int updatePassword(User user);
	public List<User> getAllUsers();
	User getUserById(int userID);
	public List<User> searchUsersByName(String name);
}
