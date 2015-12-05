package org.iiitb.facebook.dao.impl;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.iiitb.facebook.dao.LoginDAO;
import org.iiitb.facebook.model.User;
import org.iiitb.facebook.util.ConnectionPool;

public class LoginDAOimpl implements LoginDAO {
	
	String verifyPassword="select * from user where email_id=? and password=?";
	String verifyUser="select * from user  where email_id=?";
	String updateLogoutTime="update user set last_login=? where user_id=?";
	String getPic="select photo from user where user_id=?";
	@Override
	public User isValidUser(String email,String pass) {
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		User user=new User();
		try
		{
			String veriFlag;
			preStmt = conn.prepareStatement(verifyUser);
			preStmt.setString(1,email);
			ResultSet result = preStmt.executeQuery();
			if (result.next())
			{
				veriFlag=(String)result.getString("isverified");
				if("Y".equalsIgnoreCase(veriFlag)){
					preStmt=conn.prepareStatement(verifyPassword);
					preStmt.setString(1, email);
					preStmt.setString(2, pass);
					ResultSet rs=preStmt.executeQuery();
					if(rs.next()){
						user.setErrorFlag(0);
						user.setErrorMessage("Successfully Login.");
						user.setFirstName(rs.getString("first_name"));
						user.setLastName(rs.getString("last_name"));
						user.setMobno(rs.getString("mobile_no"));
						user.setDob(rs.getDate("dob"));
						user.setGender(rs.getString("gender"));
						user.setCreateDate(rs.getDate("created_date"));
						user.setLastLogin(rs.getDate("last_login"));
						user.setEmail(email);
						user.setUserId(rs.getString("user_id"));
						user.setPassword(pass);
						return user;
					}else{
						user.setErrorFlag(3);
						user.setErrorMessage("UserId or Password is not correct.Please try again.");
						return user;
					}
				}else{
					user.setErrorFlag(2);
					user.setErrorMessage("You account is not verified.Please verify email for verfication link.");
					return user;
				}
			}
			else
			{
				user.setErrorFlag(1);
				user.setErrorMessage("There is no user exist with UserId = "+email);
				return user;
			}
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		} finally
		{
			ConnectionPool.freeConnection(conn);
		}
		user.setErrorFlag(4);
		user.setErrorMessage("Some Error Occurred .Please try again");
		return user;
	}
	
	
	@Override
	public boolean updateLogoutTime(String userId,String date) {
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		try
		{
			System.out.println(userId+" "+date);
			preStmt = conn.prepareStatement(updateLogoutTime);
			preStmt.setString(1, date);
			preStmt.setString(2, userId);
			int n=preStmt.executeUpdate();
			System.out.println(n);
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		} finally
		{
			ConnectionPool.freeConnection(conn);
		}
		return true;
	}

	
	public InputStream displayphoto(String userId){
		Connection conn = ConnectionPool.getConnection();
		InputStream pic=null;
		try
		{
			PreparedStatement stmt = conn.prepareStatement(getPic);
			stmt.setString(1, userId);

			ResultSet rs = stmt.executeQuery();
			
			if (rs.next())
			{
				pic=rs.getBinaryStream("photo");
			}

		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			ConnectionPool.freeConnection(conn);
		}
		return pic;
	}	
}
