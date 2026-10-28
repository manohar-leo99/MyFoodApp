package com.myfoodapp.model;

import java.sql.Timestamp;

public class User 
{
	private int userID;
	private String firstName;
	private String lastName;
	private String userName;
	private String email;
	private String phoneNumber;
	private String address;
	private String role;
	private Timestamp lastLoginDate;
	private Timestamp createdDate;
	private String password;
	
	
	public User() {
		super();
	}
	
	
	
	

	

	public User(int userID, String firstName, String lastName, String userName, String email, String phoneNumber,
			String address, String role, Timestamp lastLoginDate, Timestamp createdDate, String password) {
		super();
		this.userID = userID;
		this.firstName = firstName;
		this.lastName = lastName;
		this.userName = userName;
		this.email = email;
		this.phoneNumber = phoneNumber;
		this.address = address;
		this.role = role;
		this.lastLoginDate = lastLoginDate;
		this.createdDate = createdDate;
		this.password = password;
	}


	




	public User(String firstName, String lastName, String userName, String email, String phoneNumber, String address,
			String role, Timestamp lastLoginDate, Timestamp createdDate, String password) {
		super();
		this.firstName = firstName;
		this.lastName = lastName;
		this.userName = userName;
		this.email = email;
		this.phoneNumber = phoneNumber;
		this.address = address;
		this.role = role;
		this.lastLoginDate = lastLoginDate;
		this.createdDate = createdDate;
		this.password = password;
	}


	




	public User(String firstName, String lastName, String userName, String email, String phoneNumber, String address,
			String role, String password) {
		super();
		this.firstName = firstName;
		this.lastName = lastName;
		this.userName = userName;
		this.email = email;
		this.phoneNumber = phoneNumber;
		this.address = address;
		this.role = role;
		this.password = password;
	}

	
	
	
	



	public User(int userID, String firstName, String lastName, String email, String phoneNumber, String address) {
		super();
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.phoneNumber = phoneNumber;
		this.address = address;
	}



	public String getFirstName() {
		return firstName;
	}



	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}



	public String getLastName() {
		return lastName;
	}



	public void setLastName(String lastName) {
		this.lastName = lastName;
	}



	public String getUserName() {
		return userName;
	}


	public void setUserName(String userName) {
		this.userName = userName;
	}


	public int getUserID() {
		return userID;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public Timestamp getLastLoginDate() {
		return lastLoginDate;
	}

	public void setLastLoginDate(Timestamp lastLoginDate) {
		this.lastLoginDate = lastLoginDate;
	}

	public Timestamp getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Timestamp createdDate) {
		this.createdDate = createdDate;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}







	@Override
	public String toString() {
		return "User [userID=" + userID + ", firstName=" + firstName + ", lastName=" + lastName + ", userName="
				+ userName + ", email=" + email + ", phoneNumber=" + phoneNumber + ", address=" + address + ", role="
				+ role + ", lastLoginDate=" + lastLoginDate + ", createdDate=" + createdDate + ", password=" + password
				+ "]";
	}

	
}
