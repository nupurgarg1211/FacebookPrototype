package org.iiitb.facebook.dao.impl;

import java.io.File;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import org.iiitb.facebook.action.AllNotificationAction;
import org.iiitb.facebook.action.BlockFriendAction;
import org.iiitb.facebook.dao.FriendsDAO;
//import org.iiitb.facebook.dao.LoginDAO;
import org.iiitb.facebook.model.UserDhruvik;
import org.iiitb.facebook.util.ConnectionPool;
import org.iiitb.facebook.util.StringUtils;

public class FriendsDAOImpl implements FriendsDAO{
	@Override
	public ArrayList<UserDhruvik> getAllFriendsSuggestion(String user_session, String user_id)
	{
		String picPath=StringUtils.RetrivePhotoPath;
		ArrayList<UserDhruvik> userDetails = new ArrayList<UserDhruvik>();
		Connection con = ConnectionPool.getConnection();
		PreparedStatement ps;
//		LoginDAO ld=new LoginDAOimpl();
		ResultSet rs= null;
		try {
			ps = con.prepareStatement("Select distinct user_id,first_name, last_name,profile_pic from user where user_id in (select user_id1 from user_friends where user_id2=?) and user_id not in (select user_id1 from user_friends where user_id2=?) and user_id not in (select user_from from friends where user_to=?) and user_id not in (select user_to from friends where user_from=?)and user_id<>?;");
			ps.setString(1, user_session);
			ps.setString(2, user_id);
			ps.setString(3, user_id);
			ps.setString(4, user_id);
			ps.setString(5, user_id);
			rs = ps.executeQuery();
			while(rs.next()){
				UserDhruvik u = new UserDhruvik();
				u.setUserid(rs.getInt("user_id"));
				u.setFirst_name(rs.getString("first_name"));
				u.setLast_name(rs.getString("last_name"));
				u.setProfile_pic(picPath+"/"+u.getUserid()+"_profilePicture"+"/"+rs.getString("profile_pic"));
				
				userDetails.add(u);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally{
			ConnectionPool.freeConnection(con);
		}	
		// TODO Auto-generated method stub
		
		ArrayList<String> blockedUsers;
		
		BlockFriendAction allblocked = new BlockFriendAction();
		blockedUsers = allblocked.getBlockedFriends();
		
		for(int i=0;i<blockedUsers.size();i++){
			for(int j=0;j<userDetails.size();j++){
				if(userDetails.get(j).getUserid() == Integer.parseInt(blockedUsers.get(i))){
					userDetails.remove(j);
					break;
				}
			}
		}	
		
		
		return userDetails;
	}
	
	public boolean suggestFriend(String user_session, String user_id, String suggestid)
	{
		Connection con = ConnectionPool.getConnection();
		PreparedStatement ps;
		ResultSet rs;
		ResultSet rs1;
		System.out.println("in suggest friend daoimpl user_id="+user_id);
		try {
					
			AllNotificationAction givenoti = new AllNotificationAction();
			ps=con.prepareStatement("select first_name, last_name from user where user_id=?");
			ps.setString(1, suggestid);
			rs=ps.executeQuery();
			ps=con.prepareStatement("select first_name, last_name from user where user_id=?");
			ps.setString(1, user_session);
			rs1=ps.executeQuery();
			while(rs.next())
			{
				rs1.next();
				String suggestedname=rs.getString("first_name")+" "+rs.getString("last_name");
				String user_session_name=rs1.getString("first_name")+" "+rs1.getString("last_name");
				givenoti.addNotification("friend", ""+user_session, ""+user_id, user_session_name+" has suggested "+suggestedname+" as your friend.", "userNewsFeedAction?user_id="+suggestid,""+new Timestamp(new java.util.Date().getTime()));

			}
			
				return true;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally{
			ConnectionPool.freeConnection(con);
		}	
		return false;
	}
	
	
	@Override
	public ArrayList<UserDhruvik> getAllFriends(String userid) {
		String picPath=StringUtils.RetrivePhotoPath;
		ArrayList<UserDhruvik> userDetails = new ArrayList<UserDhruvik>();
		Connection con = ConnectionPool.getConnection();
		PreparedStatement ps;
		System.out.println("in get all friends... here input id is "+userid);
//		LoginDAO ld=new LoginDAOimpl();
		ResultSet rs= null;
		try {
			ps = con.prepareStatement("Select user_id,first_name, last_name,profile_pic from user where user_id in (select user_id2 from user_friends where user_id1=?)");
			ps.setString(1, userid);
			rs = ps.executeQuery();
			
			//picPath=picPath+"/"+userId+"_"+"profilePicture"+"/"+profilePic;
			while(rs.next()){
				UserDhruvik u = new UserDhruvik();
				u.setUserid(rs.getInt("user_id"));
				u.setFirst_name(rs.getString("first_name"));
				u.setLast_name(rs.getString("last_name"));
				u.setProfile_pic(picPath+"/"+u.getUserid()+"_profilePicture"+"/"+rs.getString("profile_pic"));
				userDetails.add(u);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally{
			ConnectionPool.freeConnection(con);
		}	
		ArrayList<String> blockedUsers;
		
		BlockFriendAction allblocked = new BlockFriendAction();
		blockedUsers = allblocked.getBlockedFriends();
		
		for(int i=0;i<blockedUsers.size();i++){
			for(int j=0;j<userDetails.size();j++){
				if(userDetails.get(j).getUserid() == Integer.parseInt(blockedUsers.get(i))){
					userDetails.remove(j);
					break;
				}
			}
		}	
		// TODO Auto-generated method stub
		return userDetails;
	}
	
	@Override
	public ArrayList<UserDhruvik> getAllPendingFriends(String userid) {
		String picPath=StringUtils.RetrivePhotoPath;
		ArrayList<UserDhruvik> userDetails_pending = new ArrayList<UserDhruvik>();
		Connection con = ConnectionPool.getConnection();
		PreparedStatement ps;
//		LoginDAO ld=new LoginDAOimpl();
		ResultSet rs= null;
		try {
			ps = con.prepareStatement("Select user_id,first_name, last_name,profile_pic from user where user_id in (select user_from from friends where user_to=?)");
			ps.setString(1, userid);
			rs = ps.executeQuery();
			while(rs.next()){
				UserDhruvik u = new UserDhruvik();
				u.setUserid(rs.getInt("user_id"));
				u.setFirst_name(rs.getString("first_name"));
				u.setLast_name(rs.getString("last_name"));
				u.setProfile_pic(picPath+"/"+u.getUserid()+"_profilePicture"+"/"+rs.getString("profile_pic"));
				
				userDetails_pending.add(u);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally{
			ConnectionPool.freeConnection(con);
		}	
		// TODO Auto-generated method stub
		return userDetails_pending;
	}
	
	@Override
	public ArrayList<UserDhruvik> getNonFriends(String userid) {
		String picPath=StringUtils.RetrivePhotoPath;
		ArrayList<UserDhruvik> userDetails = new ArrayList<UserDhruvik>();
		Connection con = ConnectionPool.getConnection();
		PreparedStatement ps;
//		LoginDAO ld=new LoginDAOimpl();
		ResultSet rs= null;
		try {
			ps = con.prepareStatement("Select user_id,first_name, last_name,profile_pic from user where user_id not in (select distinct user_id2 from user_friends where user_id1=?) and user_id<>? and user_id in(select user_id1 from user_friends where user_id2 in(select user_id2 from user_friends where user_id1<>?) and user_id not in(select user_to from friends where user_from=?));");
			ps.setString(1, userid);
			ps.setString(2, userid);
			ps.setString(3, userid);
			ps.setString(4, userid);
			rs = ps.executeQuery();
			while(rs.next()){
				UserDhruvik u = new UserDhruvik();
				u.setUserid(rs.getInt("user_id"));
				u.setFirst_name(rs.getString("first_name"));
				u.setLast_name(rs.getString("last_name"));
				u.setProfile_pic(picPath+"/"+u.getUserid()+"_profilePicture"+"/"+rs.getString("profile_pic"));
				
				userDetails.add(u);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally{
			ConnectionPool.freeConnection(con);
		}	
		// TODO Auto-generated method stub
		return userDetails;
	}

	@Override
	public boolean addFriend(int id1, int id2) {
		Connection con = ConnectionPool.getConnection();
		PreparedStatement ps;
		try {
			ps = con.prepareStatement("insert into friends (user_from, user_to, request_status, is_seen) values(?,?,?,?)");
			ps.setInt(1, id1);
			ps.setInt(2, id2);
			ps.setString(3, "P");
			ps.setString(4,"F");
			int n=ps.executeUpdate();
			
			/*ps=con.prepareStatement("insert into student_friends values(?,?)");
			ps.setString(1, id2);
			ps.setString(2, id1);
			int n1=ps.executeUpdate();*/
			
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
	
	
	@Override
	public boolean removeFriend(int id1, int id2) {
		Connection con = ConnectionPool.getConnection();
		PreparedStatement ps;
		try {
			ps = con.prepareStatement("delete from user_friends where user_id1=? and user_id2=?");
			ps.setInt(1, id1);
			ps.setInt(2, id2);
			int n=ps.executeUpdate();
			
			ps=con.prepareStatement("delete from user_friends where user_id1=? and user_id2=?");
			ps.setInt(1, id2);
			ps.setInt(2, id1);
			int n1=ps.executeUpdate();
			
			ps = con.prepareStatement("delete from friends where (user_from=? and user_to=?) or (user_from=? and user_to=?)");
			ps.setInt(1, id1);
			ps.setInt(2, id2);
			ps.setInt(3, id2);
			ps.setInt(4, id1);
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
	
	@Override
	public boolean acceptFriend(int id1, int id2) {
		Connection con = ConnectionPool.getConnection();
		PreparedStatement ps;
		ResultSet rs;
		try {
			ps = con.prepareStatement("insert into user_friends (user_id1, user_id2) values(?,?)");
			ps.setInt(1, id1);
			ps.setInt(2, id2);
			int n=ps.executeUpdate();
			
			ps = con.prepareStatement("insert into user_friends (user_id1, user_id2) values(?,?)");
			ps.setInt(1, id2);
			ps.setInt(2, id1);
			
			int n1=ps.executeUpdate();
			
			ps=con.prepareStatement("delete from friends where user_to=? and user_from=?");
			ps.setInt(1, id1);
			ps.setInt(2, id2);
			int n2=ps.executeUpdate();
			
			AllNotificationAction givenoti = new AllNotificationAction();
			ps=con.prepareStatement("select first_name, last_name from user where user_id=?");
			ps.setInt(1, id1);
			rs=ps.executeQuery();
			while(rs.next())
			{
				String name=rs.getString("first_name")+" "+rs.getString("last_name");
				givenoti.addNotification("friend", ""+id1, ""+id2, name+" accepted your friend request.", "userNewsFeedAction?user_id="+id1,""+new Timestamp(new java.util.Date().getTime()));

			}
			
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
	
	@Override
	public boolean rejectFriend(int id1, int id2) {
		Connection con = ConnectionPool.getConnection();
		PreparedStatement ps;
		try {
						
			
			ps=con.prepareStatement("delete from friends where user_to=? and user_from=?");
			ps.setInt(1, id1);
			ps.setInt(2, id2);
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
