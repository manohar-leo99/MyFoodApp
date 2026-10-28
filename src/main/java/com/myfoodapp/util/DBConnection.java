package com.myfoodapp.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	private static final String PASSWORD = "root@123 (Your password)";
	private static final String USER_NAME = "root";
	private static final String URL = "jdbc:mysql://localhost:3306/FoodApp";

	public static Connection getConnectionObject() {

		Connection con = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(URL, USER_NAME, PASSWORD);
			System.out.println("Connection Established.");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {

			e.printStackTrace();
		}

		return con;
	}
}
