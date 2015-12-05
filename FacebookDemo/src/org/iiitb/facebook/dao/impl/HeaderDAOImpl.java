package org.iiitb.facebook.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import org.iiitb.facebook.dao.HeaderDAO;
import org.iiitb.facebook.model.Notification;
import org.iiitb.facebook.model.UserDhruvik;
import org.iiitb.facebook.util.ConnectionPool;
import org.iiitb.facebook.util.StringUtils;


public class HeaderDAOImpl implements HeaderDAO {

	@Override
	public ArrayList<Notification> getNotifications(int userid) {
		
		ArrayList<Notification> alnoti = new ArrayList<Notification>();
		Connection con = ConnectionPool.getConnection();
		Notification n;
		
		String sql = "";
		sql = "SELECT notification_id,notification_type,user_from,user_to,message,url,date,is_seen FROM notification where user_to = ? and is_seen = ? order by date desc";
		
		
		try{
			PreparedStatement ps = con.prepareStatement(sql);
		
			ps.setInt(1, userid);
			ps.setString(2, "F");
			
			
			
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				n = new Notification();
				n.setNotification_id(rs.getInt("notification_id"));
				n.setNotification_type(rs.getString("notification_type"));
				n.setUser_from(rs.getInt("user_from")); 
				n.setUser_to(rs.getInt("user_to"));
				n.setMsg(rs.getString("message"));
				n.setUrl(rs.getString("url"));
				Date date = rs.getTimestamp("date");
				String dateString = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
				n.setDate(dateString);
				n.setIs_seen(rs.getString("is_seen"));
				alnoti.add(n);
				
			}
			
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			ConnectionPool.freeConnection(con);
		}
	
		
		
		return alnoti;
	}
	@Override
	public ArrayList<UserDhruvik> getAllPendingFriends(int userid){
		
			String picPath=StringUtils.RetrivePhotoPath;
			ArrayList<UserDhruvik> userDetails_pending = new ArrayList<UserDhruvik>();
			Connection con = ConnectionPool.getConnection();
			PreparedStatement ps;
//			LoginDAO ld=new LoginDAOimpl();
			ResultSet rs= null;
			try {
				ps = con.prepareStatement("Select user_id,first_name, last_name,profile_pic from user where user_id in (select user_from from friends where user_to=? and is_seen=? order by start_date DESC)");
				ps.setInt(1, userid);
				ps.setString(2, "F");
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
	public ArrayList<Notification> getallNotifications(int userid) {
		// TODO Auto-generated method stub
		
		String picPath=StringUtils.RetrivePhotoPath;
		ArrayList<Notification> allnoti = new ArrayList<Notification>();
		Connection con = ConnectionPool.getConnection();
		Notification n;
		
		String sql = "";
		sql = "SELECT notification_id,notification_type,user_from,user_to,message,url,date,is_seen FROM notification where user_to = ? order by date desc";
		
		
		try{
			System.out.println("In all noti");
			PreparedStatement ps = con.prepareStatement(sql);
		
			ps.setInt(1, userid);		
			
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				n = new Notification();
				n.setNotification_id(rs.getInt("notification_id"));
				n.setUser_from(rs.getInt("user_from"));
				n.setNotification_type(rs.getString("notification_type"));
				if(n.getNotification_type().equalsIgnoreCase("like")){
					n.setPicUrl("images/like.jpg");
					
				}
				else if(n.getNotification_type().equalsIgnoreCase("group")){
					n.setPicUrl("images/group.jpg");
				}
				else if(n.getNotification_type().equalsIgnoreCase("post")){
					n.setPicUrl("images/post.jpg");
				}
				else if(n.getNotification_type().equalsIgnoreCase("event")){
					n.setPicUrl("images/event.jpg");
				}
				else if(n.getNotification_type().equalsIgnoreCase("comment")){
					n.setPicUrl("images/comment.png");
				}
				else if(n.getNotification_type().equalsIgnoreCase("friend")){
					
					Connection con1 = ConnectionPool.getConnection();
					
					String sql1 = "SELECT profile_pic from user where user_id = ?";
					
					
					try{
						
						PreparedStatement ps1 = con.prepareStatement(sql1);
					
						ps1.setInt(1, n.getUser_from());		
						
						ResultSet rs1 = ps1.executeQuery();
					
						while(rs1.next()){
							n.setPicUrl(picPath+"/"+n.getUser_from()+"_profilePicture"+"/"+rs1.getString("profile_pic"));
						}
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					finally{
						ConnectionPool.freeConnection(con1);
					}	
					
				}
				 
				n.setUser_to(rs.getInt("user_to"));
				n.setMsg(rs.getString("message"));
				n.setUrl(rs.getString("url"));
				Date date = rs.getTimestamp("date");
				String dateString = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
				n.setDate(dateString);
				n.setIs_seen(rs.getString("is_seen"));
				allnoti.add(n);
				
			}
			
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			ConnectionPool.freeConnection(con);
		}
	
		
		
		return allnoti;
		
	}
	@Override
	public void clearNotifications(int userid) {
		// TODO Auto-generated method stub
		Connection con = ConnectionPool.getConnection();
		String sql = "";
		sql = "update notification set is_seen = ? where user_to = ? and is_seen = ?";
		
		
		try{
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, "T");
			ps.setInt(2, userid);		
			ps.setString(3, "F");
			
			int i = ps.executeUpdate();
			System.out.println("updated : "+i);
			
			
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			ConnectionPool.freeConnection(con);
		}
	
		
		
	}
	
	@Override
	public void insertNewNotification(String notification_type,String user_from, String user_to, String message, String url,String date, String is_seen) {
		// TODO Auto-generated method stub
		Connection con = ConnectionPool.getConnection();
		PreparedStatement ps;
		try {
			ps = con.prepareStatement("insert into notification(notification_type, user_from, user_to, message, url,date,is_seen) values(?,?,?,?,?,?,?)");
			ps.setString(1, notification_type);
			ps.setString(2, user_from);
			ps.setString(3, user_to);
			ps.setString(4, message);
			ps.setString(5, url);
			ps.setTimestamp(6,new Timestamp(new java.util.Date().getTime()));
			ps.setString(7, is_seen);
			
			int n=ps.executeUpdate();
			

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally{
			ConnectionPool.freeConnection(con);
		}	
		
		
	}

}
