package org.iiitb.facebook.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.iiitb.facebook.dao.MessageDAO;
import org.iiitb.facebook.dao.impl.MessageDAOImpl;
import org.iiitb.facebook.model.Message;
import org.iiitb.facebook.model.UserDhruvik;
import org.iiitb.facebook.model.User;
import org.iiitb.facebook.util.StringUtils;


public class MessageAction {

	public String to;
	public String message;
	public String friendid;
	public int try_id;
	public int user_id;
	public int friend_id;
	public String user_url;
	public String friend_url;
	public String user_fname;
	public String user_lname;
	public String friend_fname;
	public String friend_lname;
	
	public String errormsg="";
	ArrayList<UserDhruvik> userDetail; 
	public String userId;
	ArrayList<Message> userMessage;
	
	
	public String getFriendid() {
		return friendid;
	}

	public void setFriendid(String friendid) {
		this.friendid = friendid;
	}

	public int getTry_id() {
		return try_id;
	}

	public void setTry_id(int try_id) {
		this.try_id = try_id;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public int getFriend_id() {
		return friend_id;
	}

	public void setFriend_id(int friend_id) {
		this.friend_id = friend_id;
	}

	public String getUser_url() {
		return user_url;
	}

	public void setUser_url(String user_url) {
		this.user_url = user_url;
	}

	public String getFriend_url() {
		return friend_url;
	}

	public void setFriend_url(String friend_url) {
		this.friend_url = friend_url;
	}

	public String getUser_fname() {
		return user_fname;
	}

	public void setUser_fname(String user_fname) {
		this.user_fname = user_fname;
	}

	public String getUser_lname() {
		return user_lname;
	}

	public void setUser_lname(String user_lname) {
		this.user_lname = user_lname;
	}

	public String getFriend_fname() {
		return friend_fname;
	}

	public void setFriend_fname(String friend_fname) {
		this.friend_fname = friend_fname;
	}

	public String getFriend_lname() {
		return friend_lname;
	}

	public void setFriend_lname(String friend_lname) {
		this.friend_lname = friend_lname;
	}

	public ArrayList<Message> getUserMessage() {
		return userMessage;
	}

	public void setUserMessage(ArrayList<Message> userMessage) {
		this.userMessage = userMessage;
	}

	public MessageDAO getItem() {
		return item;
	}

	public void setItem(MessageDAO item) {
		this.item = item;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public ArrayList<UserDhruvik> getUserDetail() {
		return userDetail;
	}

	public void setUserDetail(ArrayList<UserDhruvik> userDetail) {
		this.userDetail = userDetail;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	public String getErrormsg() {
		return errormsg;
	}

	public void setErrormsg(String errormsg) {
		this.errormsg = errormsg;
	}

	public String getTo() {
		return to;
	}

	public void setTo(String to) {
		this.to = to;
	}
	
	MessageDAO item=new MessageDAOImpl();
	
	public void createMessage(){
			
				
				HttpServletRequest request=ServletActionContext.getRequest();
				HttpServletResponse response=ServletActionContext.getResponse();
		
				HttpSession session=ServletActionContext.getRequest().getSession(false);
				User u=(User)session.getAttribute("user");
				
				//boolean res = item.saveMessage(message,friendid,to,u.getUserId());
				System.out.println("in create message,friendid="+friendid);
				boolean res = item.saveMessage(message,friendid,userId,u.getUserId());
				
				try {
					if(friendid.equals("")){
						response.sendRedirect(StringUtils.hostname+"/FacebookDemo/loadMessage?friendid="+userId);
					}
					else{
						response.sendRedirect(StringUtils.hostname+"/FacebookDemo/loadMessage?friendid="+friendid);	
					}
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				/*if(res){
					System.out.println("successful in inserting message");
					setErrormsg("Message Send Successfully");
					try {
						System.out.println("heyyyyy");
						response.sendRedirect("http://localhost:8080/FacebookDemo/loadMessage?friendid="+friendid);
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					return "success";
				}else{
					//setErrormsg("error occured..!!");
					return "error";
				}*/
				
				
			}
			public String getConversation()
			{
				HttpSession session=ServletActionContext.getRequest().getSession(false);
				User u=(User)session.getAttribute("user");
			
				//ArrayList<User> userDetail= item.getPreviousChats(u.getUserId());
				userDetail= item.getPreviousChats(u.getUserId());
				
				
				if(userDetail.size()>0){
					System.out.println("successful in fetching user with whom u chat previously");
					//setErrormsg("Message Send Successfully");
					//getChat();
					return "success";
				}else{
					setErrormsg("no previous chats..!!");
					return "error";
				}
				
			}
			
			public String getChat()
			{
				HttpSession session=ServletActionContext.getRequest().getSession(false);
				User u1=(User)session.getAttribute("user");
				System.out.println(" in aaction getIndividualChat and frienid is="+friendid);
				//setFriendid(friendid);
				HttpServletRequest request=ServletActionContext.getRequest();
				UserDhruvik u = new UserDhruvik();
				u=item.getPersonalDetails(Integer.parseInt(u1.getUserId()));
				user_fname=u.getFirst_name();
				user_lname=u.getLast_name();
				user_url=u.getProfile_pic();
				user_id=1;
				
				setUser_fname(user_fname);
				setUser_lname(user_lname);
				setUser_url(user_url);
				setUser_id(user_id);
				
				
			//	setTo(friendid);
				
				if(u==null)
					System.out.println("No data in u");
				else
					System.out.println("Data in u");
				
				u=item.getPersonalDetails(Integer.parseInt(friendid));
				
				friend_fname=u.getFirst_name();
				friend_lname=u.getLast_name();
				friend_url=u.getProfile_pic();
				friend_id=Integer.parseInt(friendid);
				
				setFriend_fname(friend_fname);
				setFriend_lname(friend_lname);
				setFriend_url(friend_url);
				setFriend_id(friend_id);
				System.out.println("Friend Name is"+friend_fname);
				
				try_id=Integer.parseInt(friendid);
				setTry_id(try_id);
				
				
				if(u.getFirst_name()==null)
					System.out.println("Rajan P");
				else
					System.out.println("Data in u1");
				item.updateMessageSeen(Integer.parseInt(u1.getUserId()),Integer.parseInt(friendid));
				userMessage= item.getPersonalChats(Integer.parseInt(u1.getUserId()),Integer.parseInt(friendid));
				
				setUserMessage(userMessage);
				System.out.println("==>"+friend_id);
				request.setAttribute("userChat",userMessage);
				request.setAttribute("friendsid", friend_id);
				getConversation();
				if(userMessage.size()>0){
					System.out.println("successful in fetching userMessage");
					//setErrormsg("Message Send Successfully");
					return "success";
				}else{
					setErrormsg("no previous chats..!!");
					return "error";
				}
				
				//return "success";
				
			}
			
	
}
