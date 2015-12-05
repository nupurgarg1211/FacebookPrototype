package org.iiitb.facebook.action;

import com.opensymphony.xwork2.ActionSupport;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.iiitb.facebook.dao.BlockFriendDAO;
import org.iiitb.facebook.dao.impl.BlockFriendDAOImpl;
import org.iiitb.facebook.model.*;
import org.iiitb.facebook.util.StringUtils;

public class BlockFriendAction extends ActionSupport
{
	private String user_id;
	List<UserDhruvik> userData = new ArrayList<UserDhruvik>();
	
	
	public List<UserDhruvik> getUserData() {
		return userData;
	}
	public void setUserData(List<UserDhruvik> userData) {
		this.userData = userData;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public void blockFriend() throws IOException
	{
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User user=(User)session.getAttribute("user");
		BlockFriendDAO bdao = new BlockFriendDAOImpl();
		bdao.blockFriend(user.getUserId(),user_id);
		HttpServletResponse response=ServletActionContext.getResponse();
		response.sendRedirect(StringUtils.hostname+"/FacebookDemo/newsFeedAction");
	}
	public ArrayList<String> getBlockedFriends()
	{
		ArrayList<String> friends = new ArrayList<String>();
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User user=(User)session.getAttribute("user");
		BlockFriendDAO bdao = new BlockFriendDAOImpl();
		friends = bdao.getBlockedFriends(user.getUserId());
		return friends;
	}
	
	public String getAllBlockedFriendsDisplay()
	{
		ArrayList<UserDhruvik> friends;
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		HttpServletRequest request=ServletActionContext.getRequest();
		User user=(User)session.getAttribute("user");
		BlockFriendDAO bdao = new BlockFriendDAOImpl();
		friends = bdao.getAllBlockedFriendsDisplay(user.getUserId());
		request.setAttribute("userData", friends);
		return "success";
	}
	
	public String unBlockFriend() throws IOException
	{
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User user=(User)session.getAttribute("user");
		BlockFriendDAO bdao = new BlockFriendDAOImpl();
		bdao.unBlockFriend(user.getUserId(),user_id);
		getAllBlockedFriendsDisplay();
		return "success";
	}
}
