package org.iiitb.facebook.action;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.iiitb.facebook.dao.FriendRequestDAO;
import org.iiitb.facebook.dao.impl.FriendRequestDAOImpl;
import org.iiitb.facebook.dao.impl.NewsFeedDAOImpl;
import org.iiitb.facebook.model.User;
import org.iiitb.facebook.util.StringUtils;

import com.opensymphony.xwork2.ActionSupport;


public class FriendRequestAction extends ActionSupport
{
	private String user_id;

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public void addFriend() throws IOException
	{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User u=(User)session.getAttribute("user");
		FriendRequestDAO frdao = new FriendRequestDAOImpl();
		AllNotificationAction aln=new AllNotificationAction();
		NewsFeedDAOImpl nf=new NewsFeedDAOImpl();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	Date dateobj = new Date();
		frdao.addFriend(u.getUserId(), user_id);
		//aln.addNotification("friend", u.getUserId(), user_id, nf.getFullUserName(u.getUserId())+" has sent you friend request", "userNewsFeedAction?user_id="+user_id, df.format(dateobj));
		response.sendRedirect(StringUtils.hostname+"/FacebookDemo/userNewsFeedAction?user_id="+user_id);
	}
	public void removeFriend() throws IOException
	{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User u=(User)session.getAttribute("user");
		
		FriendRequestDAO frdao = new FriendRequestDAOImpl();
		frdao.removeFriend(u.getUserId(), user_id);
		response.sendRedirect(StringUtils.hostname+"/FacebookDemo/userNewsFeedAction?user_id="+user_id);
	}
	public void acceptFriend() throws IOException
	{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User u=(User)session.getAttribute("user");
		FriendRequestDAO frdao = new FriendRequestDAOImpl();
		AllNotificationAction aln=new AllNotificationAction();
		NewsFeedDAOImpl nf=new NewsFeedDAOImpl();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	Date dateobj = new Date();
		frdao.acceptFriend(u.getUserId(), user_id);
		aln.addNotification("friend", u.getUserId(), user_id , nf.getFullUserName(u.getUserId())+" has accepted you friend request", "userNewsFeedAction?user_id="+user_id, df.format(dateobj));
		response.sendRedirect(StringUtils.hostname+"/FacebookDemo/userNewsFeedAction?user_id="+user_id);
	}
	public void rejectFriend() throws IOException
	{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User u=(User)session.getAttribute("user");
		
		FriendRequestDAO frdao = new FriendRequestDAOImpl();
		frdao.rejectFriend(u.getUserId(), user_id);
		response.sendRedirect(StringUtils.hostname+"/FacebookDemo/userNewsFeedAction?user_id="+user_id);
	}
	public void cancelFriend() throws IOException
	{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User u=(User)session.getAttribute("user");
		System.out.println("In cancel Friend ->"+ user_id);
		FriendRequestDAO frdao = new FriendRequestDAOImpl();
		frdao.cancelFriend(u.getUserId(), user_id);
		response.sendRedirect(StringUtils.hostname+"/FacebookDemo/userNewsFeedAction?user_id="+user_id);
	}
	public String addFriend_peopleyoumayknow() throws IOException
	{
		HttpServletRequest request=ServletActionContext.getRequest();
		
		HttpServletResponse response=ServletActionContext.getResponse();
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User u=(User)session.getAttribute("user");
		FriendRequestDAO frdao = new FriendRequestDAOImpl();
		AllNotificationAction aln=new AllNotificationAction();
		NewsFeedDAOImpl nf=new NewsFeedDAOImpl();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	Date dateobj = new Date();
		frdao.addFriend(u.getUserId(), request.getParameter("user_id"));
		aln.addNotification("friend", u.getUserId(), request.getParameter("user_id"), nf.getFullUserName(u.getUserId())+" has sent you friend request", "userNewsFeedAction?user_id="+request.getParameter("user_id"), df.format(dateobj));
		//response.sendRedirect("http://localhost:8080/FacebookDemo/userNewsFeedAction?user_id="+request.getParameter("user_id"));
		return "success";
	}

}
