package org.iiitb.facebook.dao.impl;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.ArrayList;
import java.util.List;

import org.iiitb.facebook.model.Relationship;
import org.iiitb.facebook.util.ConnectionPool;
import org.iiitb.facebook.dao.FriendRequestDAO;


public class FriendRequestDAOImpl implements FriendRequestDAO
{
	public boolean addFriend(String user_from,String user_to)
	{
		Connection con = ConnectionPool.getConnection();
		String sql = "insert into friends (user_from, user_to, request_status, is_seen) values(?,?,?,?)";
		try
		{
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, user_from);
			ps.setString(2, user_to);
			ps.setString(3, "P");
			ps.setString(4,"F");
			int n=ps.executeUpdate();
			if(n>0)
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
	public boolean removeFriend(String id1, String id2) 
	{
		Connection con = ConnectionPool.getConnection();
		PreparedStatement ps;
		try {
			ps = con.prepareStatement("delete from user_friends where user_id1=? and user_id2=?");
			ps.setString(1, id1);
			ps.setString(2, id2);
			int n=ps.executeUpdate();
			
			ps=con.prepareStatement("delete from user_friends where user_id1=? and user_id2=?");
			ps.setString(1, id2);
			ps.setString(2, id1);
			int n1=ps.executeUpdate();
			
			if(n>0 && n1>0)
				return true;
			else 
				return false;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally{
			ConnectionPool.freeConnection(con);
		}	
		
		return false;
	}
	
	public boolean acceptFriend(String id1, String id2) 
	{
		Connection con = ConnectionPool.getConnection();
		PreparedStatement ps;
		try {
			ps = con.prepareStatement("insert into user_friends (user_id1, user_id2) values(?,?)");
			ps.setString(1, id1);
			ps.setString(2, id2);
			int n=ps.executeUpdate();
			
			ps = con.prepareStatement("insert into user_friends (user_id1, user_id2) values(?,?)");
			ps.setString(1, id2);
			ps.setString(2, id1);
			
			int n1=ps.executeUpdate();
			
			ps=con.prepareStatement("delete from friends where user_to=? and user_from=?");
			ps.setString(1, id1);
			ps.setString(2, id2);
			int n2=ps.executeUpdate();
			
			if(n>0 && n1>0 && n2>0)
				return true;
			else 
				return false;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally{
			ConnectionPool.freeConnection(con);
		}	
		return false;
	}
	
	public boolean rejectFriend(String id1, String id2)
	{
		Connection con = ConnectionPool.getConnection();
		PreparedStatement ps;
		try {
						
			
			ps=con.prepareStatement("delete from friends where user_to=? and user_from=?");
			ps.setString(1, id1);
			ps.setString(2, id2);
			int n=ps.executeUpdate();
			
			if(n>0)
				return true;
			else 
				return false;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally{
			ConnectionPool.freeConnection(con);
		}	
		return false;
	}
	public boolean cancelFriend(String user_from,String user_to)
	{
		Connection con = ConnectionPool.getConnection();
		PreparedStatement ps;
		try {
						
			
			ps=con.prepareStatement("delete from friends where user_from=? and user_to=?");
			ps.setString(1, user_from);
			ps.setString(2, user_to);
			int n=ps.executeUpdate();
			
			if(n>0)
				return true;
			else 
				return false;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally{
			ConnectionPool.freeConnection(con);
		}	
		return false;
	}
}
