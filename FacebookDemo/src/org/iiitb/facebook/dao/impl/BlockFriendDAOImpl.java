package org.iiitb.facebook.dao.impl;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.iiitb.facebook.model.UserDhruvik;
import org.iiitb.facebook.util.ConnectionPool;
import org.iiitb.facebook.util.StringUtils;
import org.iiitb.facebook.dao.BlockFriendDAO;


public class BlockFriendDAOImpl implements BlockFriendDAO
{
	public void blockFriend(String blocked_by,String blocked_to)
	{
		Connection con = ConnectionPool.getConnection();
		String sql = "insert into blocked(blocked_by,blocked_to) values(?,?) ";
		String removeFromUserFriend = "delete from user_friends where user_id1 = ? and user_id2 = ?";
		String removeFromFriend = "delete from friends where user_from = ? and user_to = ?";
		try
		{
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,blocked_by);
			ps.setString(2,blocked_to);
			ps.executeUpdate();
			
			ps = con.prepareStatement(removeFromUserFriend);
			ps.setString(1,blocked_by);
			ps.setString(2,blocked_to);
			ps.executeUpdate();
			
			ps = con.prepareStatement(removeFromUserFriend);
			ps.setString(1,blocked_to);
			ps.setString(2,blocked_by);
			ps.executeUpdate();
			
			ps = con.prepareStatement(removeFromFriend);
			ps.setString(1,blocked_to);
			ps.setString(2,blocked_by);
			ps.executeUpdate();
			
			ps = con.prepareStatement(removeFromFriend);
			ps.setString(1,blocked_by);
			ps.setString(2,blocked_to);
			ps.executeUpdate();
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			ConnectionPool.freeConnection(con);
		}
	}
	public ArrayList<String> getBlockedFriends(String user_id)
	{
		Connection con = ConnectionPool.getConnection();
		ArrayList<String> friends = new ArrayList<String>();
		String sql = "select blocked_to from blocked where blocked_by = ?";
		String sql1 = "select blocked_by from blocked where blocked_to = ?";
		try
		{
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,user_id);
			ResultSet rs = ps.executeQuery();
			while(rs.next())
			{
				friends.add(rs.getString("blocked_to"));
			}
			ps = con.prepareStatement(sql1);
			ps.setString(1,user_id);
			rs = ps.executeQuery();
			while(rs.next())
			{
				friends.add(rs.getString("blocked_by"));
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
		return friends;
	}
	public void unBlockFriend(String blocked_by,String blocked_to)
	{
		Connection con = ConnectionPool.getConnection();
		String unBlock = "delete from blocked where blocked_by = ? and blocked_to = ?";
		try
		{
			PreparedStatement ps = con.prepareStatement(unBlock);
			ps.setString(1,blocked_by);
			ps.setString(2,blocked_to);
			ps.executeUpdate();
			
			ps = con.prepareStatement(unBlock);
			ps.setString(1,blocked_to);
			ps.setString(2,blocked_by);
			ps.executeUpdate();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			ConnectionPool.freeConnection(con);
		}
	}
	@Override
	public ArrayList<UserDhruvik> getAllBlockedFriendsDisplay(String user_id) {
		// TODO Auto-generated method stub
		
		String picPath=StringUtils.RetrivePhotoPath;
		ArrayList<UserDhruvik> userDetails = new ArrayList<UserDhruvik>();
		Connection con = ConnectionPool.getConnection();
		//ArrayList<String> friends = new ArrayList<String>();
		String sql = "select user_id,first_name,last_name,profile_pic from user where user_id in (select blocked_to from blocked where blocked_by = ?)";
	//	String sql1 = "select user_id,first_name,last_name,profile_pic from user where user_id in (select blocked_by from blocked where blocked_to = ?)";
		try
		{
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,user_id);
			ResultSet rs = ps.executeQuery();
			while(rs.next())
			{
				UserDhruvik u = new UserDhruvik();
				u.setUserid(rs.getInt("user_id"));
				u.setFirst_name(rs.getString("first_name"));
				u.setLast_name(rs.getString("last_name"));
				u.setProfile_pic(picPath+"/"+u.getUserid()+"_profilePicture"+"/"+rs.getString("profile_pic"));
				userDetails.add(u);
			}
			/*ps = con.prepareStatement(sql1);
			ps.setString(1,user_id);
			rs = ps.executeQuery();
			while(rs.next())
			{
				UserDhruvik u = new UserDhruvik();
				u.setUserid(rs.getInt("user_id"));
				u.setFirst_name(rs.getString("first_name"));
				u.setLast_name(rs.getString("last_name"));
				u.setProfile_pic(picPath+"/"+u.getUserid()+"_profilePicture"+"/"+rs.getString("profile_pic"));
				userDetails.add(u);
			}*/
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			ConnectionPool.freeConnection(con);
		}
		return userDetails;
	}
}
