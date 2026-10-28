package com.myfoodapp.daoimp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.myfoodapp.dao.UserDao;
import com.myfoodapp.model.User;
import com.myfoodapp.util.DBConnection;

public class UserDaoImp implements UserDao {

    private Connection con;

    private static final String ADD_USER_QUERY = "INSERT INTO user(username, firstname, lastname, email, phone, address, role, lastLoginDate, createDate, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    private static final String GET_USER_QUERY = "SELECT * FROM user WHERE username = ? AND password = ?";

	private static final String DELETE_USER_QUERY = "DELETE FROM user WHERE UserID = ?";

	private static final String GET_USER_BY_EMAIL_PHONE_QUERY = "SELECT * FROM user WHERE email = ? and phone = ?";

	private static final String UPDATE_USER_DETAILS_QUERY = "UPDATE user SET firstname = ?, lastname = ?, email = ?, phone = ?, address = ? WHERE UserID = ?";

	private static final String UPDATE_USER_PASSWORD_QUERY = "UPDATE user SET password = ? WHERE UserID = ?";

	private static final String GET_ALL_USERS_QUERY = "SELECT * FROM user";
	
	private static final String GET_USER_BY_ID_QUERY = "SELECT * FROM user WHERE UserID = ?";

	private static final String SEARCH_USERS_BY_NAME_QUERY = "SELECT * FROM user WHERE CONCAT(firstname ,' ', lastname) LIKE  ?";
	
	


    // Constructor
    public UserDaoImp() 
    {
        con = DBConnection.getConnectionObject();
    }


    @Override
    public int addUser(User user) {

        int i = 0;

        try {

            PreparedStatement pstmt = con.prepareStatement(ADD_USER_QUERY);

            pstmt.setString(1, user.getUserName());
            pstmt.setString(2, user.getFirstName());
            pstmt.setString(3, user.getLastName());
            pstmt.setString(4, user.getEmail());
            pstmt.setString(5, user.getPhoneNumber());
            pstmt.setString(6, user.getAddress());
            pstmt.setString(7, user.getRole());

            pstmt.setTimestamp(8, new Timestamp(System.currentTimeMillis()));

            pstmt.setTimestamp(9, new Timestamp(System.currentTimeMillis()));

            pstmt.setString(10, user.getPassword());

            i = pstmt.executeUpdate();

            System.out.println(i + " Row is affected.");

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return i;
    }

    
    
    
    

    @Override
    public User getUser(String username, String password) {

        try {

            PreparedStatement pstmt = con.prepareStatement(GET_USER_QUERY);

            pstmt.setString(1, username);
            pstmt.setString(2, password);

            ResultSet userResultSet =
                    pstmt.executeQuery();

            if (userResultSet.next()) {

                User user = new User(
                		
                	userResultSet.getInt("UserID"),
                    userResultSet.getString("firstname"),
                    userResultSet.getString("lastname"),
                    userResultSet.getString("username"),
                    userResultSet.getString("email"),
                    userResultSet.getString("phone"),
                    userResultSet.getString("address"),
                    userResultSet.getString("role"),
                    userResultSet.getTimestamp("lastLoginDate"),
                    userResultSet.getTimestamp("createDate"),
                    userResultSet.getString("password")
                );

                return user;
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return null;
    }
    
    
    
    
    
    
    @Override
    public int deleteUser(int userID) {
    	
    	int i = 0;
    	
    	try {
			PreparedStatement pstmt = con.prepareStatement(DELETE_USER_QUERY);
			pstmt.setInt(1, userID);
			i = pstmt.executeUpdate();
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
    	return i;
    }
    
    
    
    
    @Override
    public User getUserByEmailAndPhoneNumber(String email, String phoneNumber) {
    	 try {
			PreparedStatement pstmt = con.prepareStatement(GET_USER_BY_EMAIL_PHONE_QUERY);
			pstmt.setString(1, email);
			pstmt.setString(2, phoneNumber);
			
			ResultSet userResultSet = pstmt.executeQuery();
			
			if (userResultSet.next()) {

                User user = new User(
                		
                	userResultSet.getInt("UserID"),
                    userResultSet.getString("firstname"),
                    userResultSet.getString("lastname"),
                    userResultSet.getString("username"),
                    userResultSet.getString("email"),
                    userResultSet.getString("phone"),
                    userResultSet.getString("address"),
                    userResultSet.getString("role"),
                    userResultSet.getTimestamp("lastLoginDate"),
                    userResultSet.getTimestamp("createDate"),
                    userResultSet.getString("password")
                );

                return user;
            }
			
		 } catch (SQLException e) {
			 
			e.printStackTrace();
		 }
    	return null;
    }
    
    
    
	@Override
	public int updateUserDetails(User user) {

		int i = 0;
		try {
			PreparedStatement pstmt = con.prepareStatement(UPDATE_USER_DETAILS_QUERY);
			
			pstmt.setString(1, user.getFirstName());
			pstmt.setString(2, user.getLastName());
			pstmt.setString(3, user.getEmail());
			pstmt.setString(4, user.getPhoneNumber());
			pstmt.setString(5, user.getAddress());

			pstmt.setInt(6, user.getUserID());

			i = pstmt.executeUpdate();
		} catch (SQLException e) {

			e.printStackTrace();
		}

		return i;
	}
	
	
	
	@Override
	public int updatePassword(User user) {
		int i = 0;
		try {

			PreparedStatement pstmt = con.prepareStatement(UPDATE_USER_PASSWORD_QUERY);
			pstmt.setString(1, user.getPassword());
			pstmt.setInt(2, user.getUserID());
			i = pstmt.executeUpdate();

		} catch (SQLException e) {

			e.printStackTrace();
		}
		return i;
	}
	
	
	@Override
	public List<User> getAllUsers() {

		List<User> users = new ArrayList<>();

		try {

			PreparedStatement pstmt = con.prepareStatement(GET_ALL_USERS_QUERY);
			ResultSet rs = pstmt.executeQuery();

	        while (rs.next()) {

	            User user = new User(
	                rs.getInt("UserID"),
	                rs.getString("firstname"),
	                rs.getString("lastname"),
	                rs.getString("username"),
	                rs.getString("email"),
	                rs.getString("phone"),
	                rs.getString("address"),
	                rs.getString("role"),
	                rs.getTimestamp("lastLoginDate"),
	                rs.getTimestamp("createDate"),
	                rs.getString("password")
	            );

	            users.add(user);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return users;
	}
	
	
	
	@Override
	public User getUserById(int userID) {

	    User user = null;

	    try {

	        PreparedStatement pstmt =
	                con.prepareStatement(GET_USER_BY_ID_QUERY);

	        pstmt.setInt(1, userID);

	        ResultSet rs = pstmt.executeQuery();

	        if (rs.next()) {

	            user = new User(
	                    rs.getInt("UserID"),
	                    rs.getString("firstname"),
	                    rs.getString("lastname"),
	                    rs.getString("username"),
	                    rs.getString("email"),
	                    rs.getString("phone"),
	                    rs.getString("address"),
	                    rs.getString("role"),
	                    rs.getTimestamp("lastLoginDate"),
	                    rs.getTimestamp("createDate"),
	                    rs.getString("password")
	            );
	        }

	    } catch (SQLException e) {

	        e.printStackTrace();
	    }

	    return user;
	}
	
	
	
	
	
	
	
	@Override
	public List<User> searchUsersByName(String name) {
		List<User> users = new ArrayList<>();

		try {

			PreparedStatement pstmt = con.prepareStatement(SEARCH_USERS_BY_NAME_QUERY);
			pstmt.setString(1, "%" + name + "%");
			ResultSet rs = pstmt.executeQuery();

	        while (rs.next()) {

	            User user = new User(
	                rs.getInt("UserID"),
	                rs.getString("firstname"),
	                rs.getString("lastname"),
	                rs.getString("username"),
	                rs.getString("email"),
	                rs.getString("phone"),
	                rs.getString("address"),
	                rs.getString("role"),
	                rs.getTimestamp("lastLoginDate"),
	                rs.getTimestamp("createDate"),
	                rs.getString("password")
	            );

	            users.add(user);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return users;
	}
	
}