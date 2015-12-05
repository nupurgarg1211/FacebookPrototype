package org.iiitb.facebook.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.iiitb.facebook.dao.RegistrationDAO;
import org.iiitb.facebook.model.User;
import org.iiitb.facebook.util.ConnectionPool;
import org.iiitb.facebook.util.PhotoUtil;

public class RegistrationDAOImpl implements RegistrationDAO{

	public String createUser="insert into user(email_id,first_name,last_name,dob,gender,created_date,password) values(?,?,?,?,?,?,?)";
	public String verifyUser="update user set isverified='Y' where email_id=?";
	public String getUserId="select user_id from user where email_id=?";
	public String insertAlbum="insert into album(album_name,user_id,date) values(?,?,?)";
	public String updatePassword="update user set password=? where email_id=?";
	public String insertAlbumForEvent = "insert into album(album_name,event_id,date) values(?,?,?)";
	@Override
	public boolean createuser(String email,String firstName,String lastName,String dob,String gender,String pass,String create_date) {
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		User user=new User();
	//	String createUser="insert into user(email_id,first_name,last_name,dob,gender,created_date,password) values(?,?,?,?,?,'"+create_date+"',?)";
		
		try
		{
			preStmt = conn.prepareStatement(createUser);
			preStmt.setString(1,email);
			preStmt.setString(2, firstName);
			preStmt.setString(3, lastName);
			preStmt.setString(4,dob );
			preStmt.setString(5, gender);
			preStmt.setString(6,create_date);
			preStmt.setString(7, pass);
			int n=preStmt.executeUpdate();
			if(n>0){
				String userId=getUser(email);
				insertsetting(userId);
				return true;
			}
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		} finally
		{
			ConnectionPool.freeConnection(conn);
		}
		return false;
	}	
	public boolean insertsetting(String userId){
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		String a[]={"timeline","friend","message","about","album"};
		String insertSetting="insert into privacysetting(user_id,privacy_type,privacy_name) values(?,?,?)";
		try
		{
			for(int i=0;i<a.length;i++){
				preStmt = conn.prepareStatement(insertSetting);
				preStmt.setString(1,userId);
				preStmt.setString(2, a[i]);
				preStmt.setString(3, "PUBLIC");
				preStmt.executeUpdate();
			}
			return true;
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		} finally
		{
			ConnectionPool.freeConnection(conn);
		}
		return false;
	}
	public boolean updatePassword(String email,String password){
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		User user=new User();
	//	String createUser="insert into user(email_id,first_name,last_name,dob,gender,created_date,password) values(?,?,?,?,?,'"+create_date+"',?)";
		
		try
		{
			preStmt = conn.prepareStatement(updatePassword);
			preStmt.setString(1,password);
			preStmt.setString(2, email);
			int n=preStmt.executeUpdate();
			if(n>0){
				return true;
			}
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		} finally
		{
			ConnectionPool.freeConnection(conn);
		}
		return false;
	}
	
	public boolean createAlbumForUser(String album_name,String userId,String date){
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		User user=new User();
		try
		{
			preStmt = conn.prepareStatement(insertAlbum);
			preStmt.setString(1,album_name);
			preStmt.setString(2, userId);
			preStmt.setString(3, date);
			int n=preStmt.executeUpdate();
			System.out.println("creatUser====>"+n);
			if(n>0){
				return true;
			}
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		} finally
		{
			ConnectionPool.freeConnection(conn);
		}
		return false;
	}
	
	public boolean verifyUser(String email){
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		try
		{
			preStmt = conn.prepareStatement(verifyUser);
			preStmt.setString(1, email);
			int n=preStmt.executeUpdate();
			if(n>0){
				return true;
			}
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		} finally
		{
			ConnectionPool.freeConnection(conn);
		}
		return false;
	}	
	public String getUser(String email){
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		String userid="";
		try
		{	
			preStmt = conn.prepareStatement(getUserId);
			preStmt.setString(1,email);
			ResultSet rs=preStmt.executeQuery();
			if(rs.next()){
				userid=rs.getString("user_id");
			}
			return userid;
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		} finally
		{
			ConnectionPool.freeConnection(conn);
		}
		return userid;
	}
	public boolean createAlbumForEvent(String album_name,String eventId,String date){
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		try
		{
			preStmt = conn.prepareStatement(insertAlbumForEvent);
			preStmt.setString(1,album_name);
			preStmt.setString(2, eventId);
			preStmt.setString(3, date);
			int n=preStmt.executeUpdate();
			System.out.println("creatEventAlbum====>"+n);
			if(n>0){
				return true;
			}
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		} finally
		{
			ConnectionPool.freeConnection(conn);
		}
		return false;
	}
}

