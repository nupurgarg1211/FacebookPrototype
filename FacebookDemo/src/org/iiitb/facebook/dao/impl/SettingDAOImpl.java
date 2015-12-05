package org.iiitb.facebook.dao.impl;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.ArrayList;
import java.util.List;

import org.iiitb.facebook.model.*;
import org.iiitb.facebook.util.ConnectionPool;
import org.iiitb.facebook.dao.SettingDAO;


public class SettingDAOImpl implements SettingDAO
{
	
	public About getSetting(String user_id)
	{
		Connection con = ConnectionPool.getConnection();
		About about = new About();
		String sql = "select first_name,last_name,dob,password from user where user_id = ?";
		try
		{
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, user_id);
			ResultSet rs = ps.executeQuery();
			while(rs.next())
			{
				about.setFirst_name(rs.getString("first_name"));
				about.setLast_name(rs.getString("last_name"));
				about.setDob(rs.getString("dob"));
				about.setPassword(rs.getString("password"));
			}
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			ConnectionPool.freeConnection(con);
		}
		return about;
	}
	public boolean saveSetting(String user_id,String first_name, String last_name, String dob, String password)
	{
		Connection con = ConnectionPool.getConnection();
		String sql;
		if(dob.equals(""))
			dob = null;
		sql = "update user set first_name = ?,last_name = ?,dob = ?,password = ? where user_id = ?";
		try
		{
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, first_name);
			ps.setString(2, last_name);
			ps.setString(3, dob);
			ps.setString(4, password);
			ps.setString(5, user_id);
			int t = ps.executeUpdate();
			if(t>0)
				return true;
			else
				return false;
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			ConnectionPool.freeConnection(con);
		}
		return false;
	}
	public static ArrayList<Setting> getPrivacySetting(String userId){
		Connection con = ConnectionPool.getConnection();
		String sql = "select * from privacysetting where user_id=?";
		ArrayList<Setting> al=new ArrayList<Setting>();
		Setting s=null;
		try
		{
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, userId);
			ResultSet rs=ps.executeQuery();
			while(rs.next()){
				s=new Setting();
				s.setPrivacyId(rs.getString("privacyId"));
				s.setUserId(rs.getString("user_id"));
				s.setPrivacyName(rs.getString("privacy_name"));
				s.setPrivacyType(rs.getString("privacy_type"));
				al.add(s);
			}
			
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			ConnectionPool.freeConnection(con);
		}
		return al;
	}
	public static String getPrivacySettingByType(String userId,String type){
		Connection con = ConnectionPool.getConnection();
		String sql = "select * from privacysetting where user_id=? and privacy_type=?";
		ArrayList<Setting> al=new ArrayList<Setting>();
		Setting s=null;
		String ans="";
		try
		{
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, userId);
			ps.setString(2, type);
			ResultSet rs=ps.executeQuery();
			if(rs.next()){
				ans=rs.getString("privacy_name");
			}
			
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			ConnectionPool.freeConnection(con);
		}
		return ans;
	}
}
