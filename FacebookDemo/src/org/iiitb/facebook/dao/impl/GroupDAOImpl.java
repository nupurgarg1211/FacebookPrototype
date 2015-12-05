package org.iiitb.facebook.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
//import java.util.Date;

import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.iiitb.facebook.action.AllNotificationAction;
import org.iiitb.facebook.action.BlockFriendAction;
import org.iiitb.facebook.dao.*;
import org.iiitb.facebook.model.Group;
import org.iiitb.facebook.model.User;
import org.iiitb.facebook.util.ConnectionPool;
import org.iiitb.facebook.util.PhotoUtil;

public class GroupDAOImpl implements GroupDAO {
	Connection con = ConnectionPool.getConnection();
	PreparedStatement ps;

public ArrayList<User> getUserForGroup(int user_id) 
{
		// TODO Auto-generated method stub
		System.out.println("get user for group");
		PreparedStatement stmt;
		ResultSet rs = null;
		ArrayList<User> u = new ArrayList<User>();
		String sql = "Select user_id,first_name, last_name from user where user_id not in (select user_id from user where user_id = ?)";
		try {
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, user_id);
			rs = stmt.executeQuery();
		} catch (Exception e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
		if (rs == null)
			System.out.println("eroorrrrrr");

		try {
			while (rs.next()) {
				User u1 = new User();
				u1.setUserId(rs.getString("user_id"));
				u1.setFirstName(rs.getString("first_name"));
				u1.setLastName(rs.getString("last_name"));
				u.add(u1);
			}

		} 
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally
		{
			ConnectionPool.freeConnection(con);
		}
		//int i=0;
		/*while(i<u.size())
		{
			System.out.println("name"+u.get(i).getFirstName());
			i++;
		}*/
		ArrayList<String> blockedUsers;
		
		BlockFriendAction allblocked = new BlockFriendAction();
		blockedUsers = allblocked.getBlockedFriends();
		
		for(int i=0;i<blockedUsers.size();i++){
			for(int j=0;j<u.size();j++){
				if(u.get(j).getUserId().equals(blockedUsers.get(i))){
					u.remove(j);
					break;
				}
			}
		}	
		return u;
}

	public int insertGroupDetails(int user_id,String grpName, String grpMembers, String icon)
	{
		
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	Date dateobj = new Date();
		System.out.println("inside insert group details");
		System.out.println("group members"+grpMembers);
		int group_id = 0;
		try{
		//SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		//String d=sf.format(new Date());
		//System.out.println("date" + d);
		System.out.println("len" + grpMembers.length());
		List<String> items = Arrays.asList(grpMembers.split("\\xD7"));
		java.sql.Date ourJavaDateObject = new java.sql.Date(Calendar.getInstance().getTime().getTime());
		int l = items.size();
		System.out.println("items length"+l);
		ArrayList<Integer> index = new ArrayList<Integer>();
		for(int i=0;i<l-1;i++)
		{
			int j = Integer.parseInt(items.get(i).substring(items.get(i).lastIndexOf(" ")+1,items.get(i).length()));
			index.add((Integer)j);
			System.out.println(j); 
		}
		//Inserting into groups
		
		String sql = "insert into groups(group_name,created_date,icon) values('"+grpName+"','"+ourJavaDateObject+"','"+icon+"')";
		System.out.println(sql);
		ResultSet rs = null;
		PreparedStatement stmt;
		//System.out.println("date" + d);
		stmt = con.prepareStatement(sql);
		/*stmt.setString(1, grpName);
		stmt.setDate(2, ourJavaDateObject);
		stmt.setString(3, icon);*/
		int res = stmt.executeUpdate();
		System.out.println("result"+res);
		
		//Selecting groupId of created group
		
		String sql1 = "select group_id from groups where group_name = '"+grpName+"' and created_date = '"+ourJavaDateObject+"'";
		PreparedStatement stmt1 = con.prepareStatement(sql1);
		ResultSet rs1 = stmt1.executeQuery();
		while (rs1.next()) {
			group_id = rs1.getInt("group_id");
		}
		System.out.println("group_id"+group_id);
		
		//Inserting admin into group_members
		
		sql = "insert into group_members(group_id,user_id,is_admin,member_request,start_date)values(?,?,?,'A',?)";
		stmt = con.prepareStatement(sql);
		stmt.setInt(1, group_id);
		stmt.setInt(2, user_id);
		stmt.setString(3, "T");
		stmt.setDate(4,ourJavaDateObject);
		int res1 = stmt.executeUpdate();
		
		//Inserting members into group_members
		
		for (int i : index) {
			System.out.println("i11111111111111111=============" + i);
			HttpSession session=ServletActionContext.getRequest().getSession(false);
			User user=(User)session.getAttribute("user");
			UserPostDAOImpl upimpl=new UserPostDAOImpl();
			NewsFeedDAOImpl nf=new NewsFeedDAOImpl();
			AllNotificationAction aln=new AllNotificationAction();
			aln.addNotification("group", user.getUserId(), String.valueOf(i), nf.getFullUserName(user.getUserId())+" has added you on group:"+grpName, "getGroupDetailAction.action?group_id="+group_id, df.format(dateobj));
			
			sql = "insert into group_members(group_id,user_id,is_admin,member_request,start_date)values(?,?,?,'A',?)";
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, group_id);
			stmt.setInt(2, i);
			stmt.setString(3, "F");
			stmt.setDate(4,ourJavaDateObject);
			stmt.executeUpdate();
		}
		sql = "insert into album(album_name,group_id,date) values('profilePicture',?,?)";
		stmt = con.prepareStatement(sql);
		stmt.setInt(1, group_id);
		stmt.setDate(2,ourJavaDateObject);
		stmt.executeUpdate();
		sql = "insert into album(album_name,group_id,date) values('coverPicture',?,?)";
		stmt = con.prepareStatement(sql);
		stmt.setInt(1, group_id);
		stmt.setString(2,df.format(dateobj).toString());
		stmt.executeUpdate();
		sql = "insert into album(album_name,group_id,date) values('timeline',?,?)";
		stmt = con.prepareStatement(sql);
		stmt.setInt(1, group_id);
		stmt.setString(2,df.format(dateobj).toString());
		stmt.executeUpdate();
		
		//get album_id of newly created album for profile album
		
		/*sql = "select album_id from album where album_name = 'profilePicture' and group_id = ?";
		stmt = con.prepareStatement(sql);
		stmt.setInt(1, group_id);
		ResultSet rs2 = stmt.executeQuery();
		int album_profile = 0;
		while(rs2.next())
		{
			album_profile = rs2.getInt("album_id");
		}*/
		PhotoUtil.groupFirstTimeAlbumCreation(String.valueOf(group_id));
		//get album_id of newly created album for profile album
		
		/*sql = "select album_id from album where album_name = 'coverPicture' and group_id = ?";
		stmt = con.prepareStatement(sql);
		stmt.setInt(1, group_id);
		ResultSet rs3 = stmt.executeQuery();
		int album_cover = 0;
		while(rs2.next())
		{
			album_cover = rs3.getInt("album_id");
		}*/
		//PhotoUtil.firstTimeAlbumCreation(String.valueOf(album_cover));
		}
		catch(Exception e){
			
		}
		/*finally
		{
			ConnectionPool.freeConnection(con);
		}*/
		return group_id;
	}
	
	public ArrayList<Group> getAllGroups(int user_id)
	{
		ArrayList<Group> grplist = new ArrayList<Group>();
		String sql = "select a.group_name,a.group_id,a.icon,b.is_admin from groups a INNER JOIN group_members b ON a.group_id = b.group_id WHERE b.user_id = ? and member_request = 'A'";
		PreparedStatement stmt;
		try {
			stmt = con.prepareStatement(sql);
			stmt.setInt(1,user_id);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Group g = new Group();
				g.setGroup_name(rs.getString("group_name"));
				g.setGroup_id(rs.getInt("group_id"));
				g.setIcon(rs.getString("icon"));
				g.setIsAdmin(rs.getString("is_admin"));
				grplist.add(g);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		/*finally
		{
			ConnectionPool.freeConnection(con);
		}*/
		/*int len = grplist.size();
		int i=0;
		while(i<len)
		{
			System.out.println(grplist.get(i).getGroup_name());
			System.out.println(grplist.get(i).getIcon());
			i++;
		}*/
		return grplist;
	}

	@Override
	public void leaveGroup(int user_id, int grp_id) throws Exception{
		// TODO Auto-generated method stub
		System.out.println("group_id 11111 ");
		PreparedStatement stmt;
		String sql = "update group_members set member_request = 'L'  WHERE user_id = ? and group_id = ?";
		System.out.println("group_id "+grp_id );
		try {
			stmt = con.prepareStatement(sql);
			stmt.setInt(1,user_id);
			stmt.setInt(2,grp_id);
			stmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		/*finally
		{
			ConnectionPool.freeConnection(con);
		}*/
		java.sql.Date ourJavaDateObject = new java.sql.Date(Calendar.getInstance().getTime().getTime());
		
		sql = "update group_members set end_date = ?  WHERE user_id = ? and group_id = ?";
		System.out.println("group_id "+grp_id );
		try {
			stmt = con.prepareStatement(sql);
			stmt.setDate(1,ourJavaDateObject);
			stmt.setInt(2,user_id);
			stmt.setInt(3,grp_id);
			stmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally
		{
			ConnectionPool.freeConnection(con);
		}
	}

	@Override
	public Object joinGroupAgain(int user_id, int grp_id) {
		
		String sql = "update group_members set member_request = 'A'  WHERE user_id = ? and group_id = ?";
		PreparedStatement stmt;
		System.out.println("group_id "+grp_id );
		try {
			stmt = con.prepareStatement(sql);
			stmt.setInt(1,user_id);
			stmt.setInt(2,grp_id);
			stmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally
		{
			ConnectionPool.freeConnection(con);
		}
		// TODO Auto-generated method stub
		return null;
	}

	public Group getGroupDetails(String group_id, int user_id) {
		System.out.println("inside daoimpl");
		System.out.println("group "+group_id);
		Group g = new Group();
		//String sql = "select a.group_name,a.group_id,a.icon,b.is_admin,b.member_request from groups a INNER JOIN group_members b ON a.group_id = b.group_id WHERE b.user_id = ? and a.group_id = ?";
		String sql = "select a.group_name,a.group_id,a.icon,b.is_admin,b.member_request ,p.photo_name,c.album_id from groups a INNER JOIN group_members b ON a.group_id = b.group_id LEFT OUTER JOIN album c ON a.group_id = c.group_id LEFT OUTER JOIN photo p ON c.album_id = p.album_id WHERE b.user_id = ? and a.group_id = ? and c.album_name = 'coverPicture' order by p.date desc LIMIT 1"; 
		PreparedStatement stmt;
		try {
			stmt = con.prepareStatement(sql);
			stmt.setInt(1,user_id);
			stmt.setInt(2,Integer.parseInt(group_id.trim()));
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				g.setGroup_name(rs.getString("group_name"));
				g.setGroup_id(rs.getInt("group_id"));
				g.setIcon(rs.getString("icon"));
				g.setIsAdmin(rs.getString("is_admin"));
				g.setMember_request(rs.getString("member_request"));
				g.setCoverPic(rs.getString("photo_name"));
				g.setAlbum_id(rs.getString("album_id"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		/*finally
		{
			ConnectionPool.freeConnection(con);
		}*/
		System.out.println("group details::::::::::::"+g.getMember_request());
		System.out.println(g.getGroup_id());
		System.out.println(g.getGroup_name());
		System.out.println(g.getIcon());
		System.out.println(g.getIsAdmin());
		System.out.println(g.getMember_request());
		System.out.println(g.getAlbum_id());
		System.out.println("photo name cover pic :"+g.getCoverPic());
		return g;
	}

	@Override
	public ArrayList<User> getGroupMembers(String group_id) {
		// TODO Auto-generated method stub
		
		ArrayList<User> grpMembers = new ArrayList<User>();
		String sql = "select u.user_id, u.first_name , u.last_name , u.address, u.profile_pic from group_members g INNER JOIN user u ON g.user_id = u.user_id where group_id = ?";
		PreparedStatement stmt;
		try {
			stmt = con.prepareStatement(sql);
			stmt.setInt(1,Integer.parseInt(group_id));
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				User u = new User();
				u.setFirstName(rs.getString("first_name"));
				u.setLastName(rs.getString("last_name"));
				u.setUserId(rs.getString("user_id"));
				//u.setAddress(rs.getString("address"));
				grpMembers.add(u);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		 
		return grpMembers;
		
	}

	@Override
	public int addMemberToGroup(String group_id, String grpMembers) {
		
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	Date dateobj = new Date();
		System.out.println("len" + grpMembers.length());
		List<String> items = Arrays.asList(grpMembers.split("\\xD7"));
		java.sql.Date ourJavaDateObject = new java.sql.Date(Calendar.getInstance().getTime().getTime());
		int l = items.size();
		ArrayList<Integer> index = new ArrayList<Integer>();
		for(int i=0;i<l-1;i++)
		{
			int j = Integer.parseInt(items.get(i).substring(items.get(i).lastIndexOf(" ")+1,items.get(i).length()));
			index.add((Integer)j);
			System.out.println(j); 
		}
		String sql;
		PreparedStatement stmt;
		for (int i : index) {
			System.out.println("i=============" + i);
			HttpSession session=ServletActionContext.getRequest().getSession(false);
			User user=(User)session.getAttribute("user");
			GroupDAO grp = new GroupDAOImpl();
			Group gr = new Group();
			gr = grp.getGroupDetails(group_id,Integer.parseInt(user.getUserId()));
				
			UserPostDAOImpl upimpl=new UserPostDAOImpl();
			NewsFeedDAOImpl nf=new NewsFeedDAOImpl();
			AllNotificationAction aln=new AllNotificationAction();
			aln.addNotification("group", user.getUserId(), String.valueOf(i), nf.getFullUserName(user.getUserId())+" has added you on group:"+gr.getGroup_name(), "getGroupDetailAction.action?group_id="+group_id, df.format(dateobj));
			
			sql = "insert into group_members(group_id,user_id,is_admin,member_request,start_date)values(?,?,?,'A',?)";
			
			try {
				stmt = con.prepareStatement(sql);
				stmt.setInt(1, Integer.parseInt(group_id));
				stmt.setInt(2, i);
				stmt.setString(3, "F");
				stmt.setDate(4,ourJavaDateObject);
				stmt.executeUpdate();
			} catch (NumberFormatException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}ConnectionPool.freeConnection(con);
		return 0;
	}

	@Override
	public ArrayList<User> getUserToAddForGroup(int parseInt, String group_id) {
		// TODO Auto-generated method stub
				System.out.println("get user for group to add group_id"+group_id);
				PreparedStatement stmt;
				ResultSet rs = null;
				ArrayList<User> u = new ArrayList<User>();
				String sql = "Select user_id,first_name, last_name from user where user_id not in (select user_id from group_members where group_id = ?)";
				try {
					stmt = con.prepareStatement(sql);
					stmt.setInt(1, Integer.parseInt(group_id));
					rs = stmt.executeQuery();
				} catch (Exception e) {
					System.out.println(e.getMessage());
					e.printStackTrace();
				}
				if (rs == null)
					System.out.println("eroorrrrrr");

				try {
					while (rs.next()) {
						User u1 = new User();
						u1.setUserId(rs.getString("user_id"));
						u1.setFirstName(rs.getString("first_name"));
						u1.setLastName(rs.getString("last_name"));
						u.add(u1);
					}

				} 
				catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				finally
				{
					ConnectionPool.freeConnection(con);
				}
				//int i=0;
				/*while(i<u.size())
				{
					System.out.println("name"+u.get(i).getFirstName());
					i++;
				}*/
				ArrayList<String> blockedUsers;
				
				BlockFriendAction allblocked = new BlockFriendAction();
				blockedUsers = allblocked.getBlockedFriends();
				
				for(int i=0;i<blockedUsers.size();i++){
					for(int j=0;j<u.size();j++){
						if(u.get(j).getUserId().equals(blockedUsers.get(i))){
							u.remove(j);
							break;
						}
					}
				}	
				return u;
	}

	/*@Override
	public int changeCoverPic(String group_id, String pic) {
		// TODO Auto-generated method stub
		System.out.println("inside change cover pic impl");
		int album_cover = 0;
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	Date dateobj = new Date();
		java.sql.Date ourJavaDateObject = new java.sql.Date(Calendar.getInstance().getTime().getTime());
		String sql = "select album_id from album where album_name = 'coverPicture' and group_id = ?";
		PreparedStatement stmt;
		try {
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, Integer.parseInt(group_id));
			ResultSet rs = stmt.executeQuery();
			while(rs.next())
			{
				album_cover = rs.getInt("album_id");
			}
			System.out.println("inserting cover     album id"+album_cover);
			sql = "insert into photo(album_id,photo_name,date) value(?,?,?)";
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, album_cover);
			stmt.setString(2,pic);
			//stmt.setDate(3,ourJavaDateObject);
			stmt.setString(3,df.format(dateobj).toString());
			stmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return album_cover;
	}*/

	/*@Override
	public String checkGroupAdmin(int user_id, int grp_id) {
		// TODO Auto-generated method stub
		System.out.println("inside isAdmin");
		String isAdmin = "";
		String sql = "select is_admin from groups a INNER JOIN group_members b ON a.group_id = b.group_id where a.group_id = ? and b.user_id = ?";
		PreparedStatement stmt;
		try {
			stmt = con.prepareStatement(sql);
			stmt.setInt(1,grp_id);
			stmt.setInt(2,user_id);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				isAdmin = rs.getString("is_admin");
			}
			System.out.println("isAdmin"+isAdmin);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return isAdmin;
	}*/
}
