package org.iiitb.facebook.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.LinkedList;
import java.sql.Date;
import java.util.List;

import org.iiitb.facebook.action.BlockFriendAction;
import org.iiitb.facebook.dao.MessageDAO;
import org.iiitb.facebook.model.Conversation;
import org.iiitb.facebook.model.Message;
import org.iiitb.facebook.model.UserDhruvik;
import org.iiitb.facebook.util.ConnectionPool;
import org.iiitb.facebook.util.StringUtils;

public class MessageDAOImpl implements MessageDAO {
	

	@Override
	public ArrayList<UserDhruvik> getNewMsgUsers(int userid) {
		// TODO Auto-generated method stub
		String picPath=StringUtils.RetrivePhotoPath;
		ArrayList<UserDhruvik> userList=new ArrayList<UserDhruvik>();
		Connection conn = ConnectionPool.getConnection();
		String sql="select distinct user_id,first_name,last_name,profile_pic from user u,messages m where user_from in (select distinct(user_from) from messages where user_to = ? and is_seen = ? order by date) and u.user_id = m.user_from";
		PreparedStatement ps = null;
		try {
			 
			ps = conn.prepareStatement(sql);
			ps.setInt(1, userid);
			ps.setString(2, "F");
			
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				UserDhruvik user = new UserDhruvik();
				//user.setName(rs.getString("first_name") + " "
					//	+ rs.getString("last_name"));
				user.setUserid(rs.getInt("user_id"));
				user.setFirst_name(rs.getString("first_name"));
				user.setLast_name(rs.getString("last_name"));
				user.setUserid(rs.getInt("user_id"));
				user.setProfile_pic(picPath+"/"+user.getUserid()+"_profilePicture"+"/"+rs.getString("profile_pic"));
				
				userList.add(user);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			
				ConnectionPool.freeConnection(conn);
		}
		return userList;
		
	}
	
	
	@Override
	public List<UserDhruvik>getFriends(String user_id,String to)
	{
		String picPath=StringUtils.RetrivePhotoPath;
		List<UserDhruvik> userList=new ArrayList<UserDhruvik>();
		Connection conn = ConnectionPool.getConnection();
		String sql="Select user_id,first_name, last_name,profile_pic from user where user_id in (select user_id2 from user_friends where user_id1=?) and (first_name like ? or last_name like ?)";
		PreparedStatement ps = null;
		try {
			
			ps = conn.prepareStatement(sql);
			to = "%"+to + "%";
			ps.setString(1, user_id);
			ps.setString(2, to);
			ps.setString(3, to);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				UserDhruvik user = new UserDhruvik();
				user.setName(rs.getString("first_name") + " "
						+ rs.getString("last_name"));
				user.setFirst_name(rs.getString("first_name"));
				user.setLast_name(rs.getString("last_name"));
				user.setUserid(rs.getInt("user_id"));
				System.out.println(user.getName());
				userList.add(user);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			
				ConnectionPool.freeConnection(conn);
		}
		ArrayList<String> blockedUsers;
		
		BlockFriendAction allblocked = new BlockFriendAction();
		blockedUsers = allblocked.getBlockedFriends();
		
		for(int i=0;i<blockedUsers.size();i++){
			for(int j=0;j<userList.size();j++){
				if(userList.get(j).getUserid() == Integer.parseInt(blockedUsers.get(i))){
					userList.remove(j);
					break;
				}
			}
		}	
		return userList;
		
	}
	public boolean saveMessage(String message, String friendid, String to, String user_id) {
		// TODO Auto-generated method stub
		Connection con = ConnectionPool.getConnection();
		UserDhruvik u = new UserDhruvik();
		// Date dt=new Date();
		ResultSet rs = null;
		boolean result = true;
		int conversation_id = 0;
		String receiver=null; 
		if((to.equals("")))
		{
			receiver=friendid;
		}
		else
		{
			receiver=to;
		}
		String sql1 = "select user_conversation_id from user_conversation where (user_from=? and user_to=?) OR (user_to=? and user_from=?)";
		int count = 0;
		try {
			PreparedStatement ps = con.prepareStatement(sql1);
			ps.setString(1, user_id);
			ps.setString(2, receiver);
			ps.setString(3, user_id);
			ps.setString(4, receiver);
			
				
			rs = ps.executeQuery();
			count = 0;
			while (rs.next()) {
				count++;
			}
			System.out.println("in 1st query and count="+count);

		} catch (SQLException e) {
			e.printStackTrace();
		}
		if (count == 0) {
			System.out.println("new entry in conversation");
			NewConversation(user_id,receiver);
			
		}
		conversation_id=fetchConversationId(user_id,receiver);
		insertMessage(conversation_id,user_id,receiver,message);
			return result;
	}
	
	public void NewConversation(String user_id,String receiver)
	{
		Connection con = ConnectionPool.getConnection();
		String sql = "insert into user_conversation(user_from,user_to) values(?,?)";
		try {
			PreparedStatement ps = con.prepareStatement(sql);

			ps.setString(1, user_id);
			ps.setString(2, receiver);
			int r = ps.executeUpdate();
			if(r>0)
				System.out.println("new con_id inserted");
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	public int fetchConversationId(String user_id,String receiver)
	{
		Connection con = ConnectionPool.getConnection();
		String sql = "select user_conversation_id from user_conversation where (user_from=? and user_to=?) OR (user_to=? and user_from=?)";
		ResultSet rs= null;
		int conversation_id=0;
		try {
			PreparedStatement ps = con.prepareStatement(sql);

			ps.setString(1, user_id);
			ps.setString(2, receiver);
			ps.setString(3, user_id );
			ps.setString(4, receiver);

			rs = ps.executeQuery();
			while (rs.next()) {
				conversation_id = rs.getInt("user_conversation_id");

			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("conv id fetched="+conversation_id);
		return conversation_id;
	}
	public void insertMessage(int conversation_id,String user_id,String receiver,String message)
	{
		String sql2 = "insert into messages(message,user_from,user_to,is_seen,date,conversation_id) values(?,?,?,?,?,?)";
		Connection con = ConnectionPool.getConnection();
		boolean result=false;
		try {
			PreparedStatement ps = con.prepareStatement(sql2);

			ps.setString(1, message);
			ps.setString(2, user_id);
			ps.setString(3, receiver);
			ps.setString(4, "F");
			ps.setTimestamp(5, new Timestamp(new java.util.Date().getTime()));
			ps.setInt(6, conversation_id);

			// ps.setString(4, msg.getDate());
			int r = ps.executeUpdate();
			if (r <= 0)
				result = false;
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionPool.freeConnection(con);
		}
		System.out.println("after inserting message ,result=" + result);
	
		
	}
	public ArrayList<UserDhruvik>getPreviousChats(String user_id)
	{
		Connection con = ConnectionPool.getConnection();
		int chat_user_id = 0;
		ArrayList<UserDhruvik> userDetails= new ArrayList<UserDhruvik>();
		String sql = "select user_from from user_conversation where user_conversation_id in(select user_conversation_id from user_conversation where user_to=?)"+
" union "+
"select user_to from user_conversation where user_conversation_id in(select user_conversation_id from user_conversation where user_from=?)";

		try {
			PreparedStatement ps = con.prepareStatement(sql);

			ps.setString(1, user_id);
			
			ps.setString(2, user_id);

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				chat_user_id = rs.getInt(1);
				userDetails.add(getChatPersonDetails(chat_user_id));
				

			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return userDetails;
		
	}
public UserDhruvik getChatPersonDetails(int userid) {
	String picPath=StringUtils.RetrivePhotoPath;
		UserDhruvik u = new UserDhruvik();
		Connection con = ConnectionPool.getConnection();
		PreparedStatement ps;
//		LoginDAO ld=new LoginDAOimpl();
		ResultSet rs= null;
		try {
			ps = con.prepareStatement("Select user_id,first_name, last_name,profile_pic from user where user_id =?");
			ps.setInt(1, userid);
			rs = ps.executeQuery();
			while(rs.next()){
				/*User u = new User();*/
				
				u.setFirst_name(rs.getString("first_name"));
				u.setLast_name(rs.getString("last_name"));
				u.setProfile_pic(picPath+"/"+userid+"_profilePicture"+"/"+rs.getString("profile_pic"));
				u.setUserid(rs.getInt("user_id"));
				//userDetails.add(u);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally{
			ConnectionPool.freeConnection(con);
		}	
		// TODO Auto-generated method stub
		return u;
	}


public UserDhruvik getPersonalDetails(int userid){
	String picPath=StringUtils.RetrivePhotoPath;
	UserDhruvik u = new UserDhruvik(); 
	Connection con = ConnectionPool.getConnection();
	PreparedStatement ps;
//	LoginDAO ld=new LoginDAOimpl();
	ResultSet rs= null;
	try {
		ps = con.prepareStatement("Select first_name, last_name,profile_pic from user where user_id =?");
		ps.setInt(1, userid);
		rs = ps.executeQuery();
		while(rs.next()){
			/*User u = new User();*/
			
			u.setFirst_name(rs.getString("first_name"));
			u.setLast_name(rs.getString("last_name"));
			u.setProfile_pic(picPath+"/"+userid+"_profilePicture"+"/"+rs.getString("profile_pic"));
			
		//	u.setUserid(rs.getInt("user_id"));
			//userDetails.add(u);
		}
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	finally{
		ConnectionPool.freeConnection(con);
	}	
	// TODO Auto-generated method stub
	return u;
	
}
public ArrayList<Message> getPersonalChats(int user1, int user2){
	
	Connection con = ConnectionPool.getConnection();
//	int chat_user_id = 0;
	ArrayList<Message> userMsg= new ArrayList<Message>();
	Message msg = new Message();
	String sql1="update messages SET is_seen='T' where is_seen='F' and (user_from=? and user_to=?) or (user_from=? and user_to=?)";
	String sql ="select message, user_from, user_to from messages where (user_from=? and user_to=?) or (user_from=? and user_to=?) order by date";

		try {
			PreparedStatement ps = con.prepareStatement(sql);

			ps.setInt(1, user1);
			ps.setInt(2, user2);
			ps.setInt(3, user2);
			ps.setInt(4, user1);
			
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				msg=new Message();
				msg.setMessage(rs.getString("message"));
				System.out.println("messges"+msg.getMessage());
				msg.setUser_from(rs.getString("user_from"));
				msg.setUser_to(rs.getString("user_to"));
				userMsg.add(msg);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return userMsg;
		
	}

public void updateMessageSeen(int user1, int user2){
	
	Connection con = ConnectionPool.getConnection();
//	int chat_user_id = 0;
//	ArrayList<Message> userMsg= new ArrayList<Message>();
	Message msg = new Message();
//	String sql1="update messages SET is_seen='T' where is_seen='F' and (user_from=? and user_to=?) or (user_from=? and user_to=?)";
	String sql ="update messages SET is_seen='T' where is_seen='F' and (user_from=? and user_to=?)";

		try {
			PreparedStatement ps = con.prepareStatement(sql);

			
			ps.setInt(1, user2);
			ps.setInt(2, user1);
			
			int rs= ps.executeUpdate();
			System.out.println("updated rows (seen value)="+rs);

		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
}
