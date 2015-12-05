package org.iiitb.facebook.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.iiitb.facebook.dao.FriendsDAO;
import org.iiitb.facebook.dao.HeaderDAO;
import org.iiitb.facebook.dao.MessageDAO;
import org.iiitb.facebook.dao.impl.FriendsDAOImpl;
import org.iiitb.facebook.dao.impl.HeaderDAOImpl;
import org.iiitb.facebook.dao.impl.MessageDAOImpl;
import org.iiitb.facebook.model.Message;
import org.iiitb.facebook.model.Notification;
import org.iiitb.facebook.model.UserDhruvik;
import org.iiitb.facebook.model.User;
import org.apache.struts2.ServletActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class getHeadersAction extends ActionSupport {
	
	
	ArrayList<Notification> al_noti;
	ArrayList<UserDhruvik> al_msgs;
	ArrayList<UserDhruvik> al_UserFriend;
	int size_notification;
	int size_messages;
	int size_frndrequest;
	public String name;
	String userid;
	
	public String getName() {
		return name;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public void setName(String name) {
		this.name = name;
	}

	public ArrayList<Notification> getAl_noti() {
		return al_noti;
	}

	public void setAl_noti(ArrayList<Notification> al_noti) {
		this.al_noti = al_noti;
	}

	public ArrayList<UserDhruvik> getAl_msgs() {
		return al_msgs;
	}

	public void setAl_msgs(ArrayList<UserDhruvik> al_msgs) {
		this.al_msgs = al_msgs;
	}

	public ArrayList<UserDhruvik> getAl_UserFriend() {
		return al_UserFriend;
	}

	public void setAl_UserFriend(ArrayList<UserDhruvik> al_UserFriend) {
		this.al_UserFriend = al_UserFriend;
	}

	public int getSize_notification() {
		return size_notification;
	}

	public void setSize_notification(int size_notification) {
		this.size_notification = size_notification;
	}

	public int getSize_messages() {
		return size_messages;
	}

	public void setSize_messages(int size_messages) {
		this.size_messages = size_messages;
	}

	public int getSize_frndrequest() {
		return size_frndrequest;
	}

	public void setSize_frndrequest(int size_frndrequest) {
		this.size_frndrequest = size_frndrequest;
	}


	
	
	public String getNotifications() throws Exception{
		
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User u=(User)session.getAttribute("user");
		setUserid(u.getUserId());
		setName(name);
		HeaderDAO headernoti = new HeaderDAOImpl(); 
		al_noti = headernoti.getNotifications(Integer.parseInt(u.getUserId()));
		getUnreadMsgs(Integer.parseInt(u.getUserId()));	
		getFriendReq(Integer.parseInt(u.getUserId()));
		size_notification = al_noti.size();
		setSize_notification(size_notification);
		
		return "success";
		
		
	}
	
	public void getUnreadMsgs(int userid){
		
		MessageDAO msg_users = new MessageDAOImpl();
		setAl_msgs(msg_users.getNewMsgUsers(userid));
		setSize_messages(getAl_msgs().size());
	}
	
	public void getFriendReq(int userid){
		
//		HttpSession session=ServletActionContext.getRequest().getSession(false);
//		User u=(User)session.getAttribute("user");
		
//		System.out.println("ans :"+u.getUserId());
		HeaderDAO fetchfriends = new HeaderDAOImpl();
		setAl_UserFriend(fetchfriends.getAllPendingFriends(userid));
		setSize_frndrequest(getAl_UserFriend().size());
//		setLastLogin(fetchfriends.getLastLogin(u.getUserId()));
//		return "success";
	}
	

}
