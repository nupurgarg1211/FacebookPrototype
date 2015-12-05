package org.iiitb.facebook.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.iiitb.facebook.dao.GroupDAO;
import org.iiitb.facebook.dao.GroupNewsFeedDAO;
import org.iiitb.facebook.dao.NewsFeedDAO;
import org.iiitb.facebook.dao.impl.GroupDAOImpl;
import org.iiitb.facebook.dao.impl.GroupNewsFeedDAOImpl;
import org.iiitb.facebook.dao.impl.NewsFeedDAOImpl;
import org.iiitb.facebook.dao.impl.UserImageUploadDAOImpl;
import org.iiitb.facebook.model.Group;
import org.iiitb.facebook.model.Post;
import org.iiitb.facebook.model.User;
import org.iiitb.facebook.model.returnlist_findfriends;
import org.iiitb.facebook.util.StringUtils;

import com.opensymphony.xwork2.ActionSupport;

public class NewsFeedAction extends ActionSupport{

	public ArrayList<Post> feedList;
	public ArrayList<Group> grpList;
	private String group_id;
	private String user_id;
	private String full_name;
	private String profile_pic;
	private String cover_pic;
	private String isFriend;
	ArrayList<returnlist_findfriends> peopleyoumayknow;
	public String getProfile_pic() {
		return profile_pic;
	}
	public void setProfile_pic(String profile_pic) {
		this.profile_pic = profile_pic;
	}
	public String getCover_pic() {
		return cover_pic;
	}
	public void setCover_pic(String cover_pic) {
		this.cover_pic = cover_pic;
	}
	
		public String getIsFriend() {
			return isFriend;
		}
		public void setIsFriend(String isFriend) {
			this.isFriend = isFriend;
		}
		
	
	public String getFull_name() {
			return full_name;
		}
		public void setFull_name(String full_name) {
			this.full_name = full_name;
		}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
		public String getGroup_id() {
		return group_id;
	}
	public void setGroup_id(String group_id) {
		this.group_id = group_id;
	}

	public ArrayList<Group> getGrpList() {
		return grpList;
	}
	public void setGrpList(ArrayList<Group> grpList) {
		this.grpList = grpList;
	}
	public ArrayList<Post> getFeedList() {
		return feedList;
	}
	public void setFeedList(ArrayList<Post> feedList) {
		this.feedList = feedList;
	}
	public ArrayList<returnlist_findfriends> getPeopleyoumayknow() {
		return peopleyoumayknow;
	}

	public void setPeopleyoumayknow(ArrayList<returnlist_findfriends> peopleyoumayknow) {
		this.peopleyoumayknow = peopleyoumayknow;
	}
	
	public String getNewsFeed(){
		try{
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		NewsFeedDAO nf=new NewsFeedDAOImpl();
		User user=(User)session.getAttribute("user");
		ArrayList<Post> feedList=nf.getNewsFeed(user.getUserId());
		setFeedList(feedList);
		GroupDAO grp = new GroupDAOImpl();
		setGrpList(grp.getAllGroups(Integer.parseInt(user.getUserId())));
		FindFriendsAction f = new FindFriendsAction();
		f.execute_homepage();
		setPeopleyoumayknow(f.getPeopleyoumayknow());
		}catch(Exception e){
			e.printStackTrace();
		}
		return "success";
	}
	public ArrayList<Post> getGroupNewsFeed(String group_id) {
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User user=(User)session.getAttribute("user");
		//new grpnews feed dao call 
		GroupNewsFeedDAO nf=new GroupNewsFeedDAOImpl();
		ArrayList<Post> feedList =nf.getNewsFeed(group_id);
		return feedList;
	}
	public String getUserNewsFeed()
	{
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		HttpServletRequest request = ServletActionContext.getRequest();
		NewsFeedDAO nf=new NewsFeedDAOImpl();
		User user=(User)session.getAttribute("user");
		
		TimelineHeaderAction tha = new TimelineHeaderAction();
		setFull_name(tha.getFullName(user_id));
		setIsFriend(tha.checkFriend(user.getUserId(), user_id));
		setProfile_pic(tha.getProfilePic(user_id));
		setCover_pic(tha.getCoverPic(user_id));
		
		ArrayList<Post> feedList=nf.getUserNewsFeed(user_id);
		
		setFeedList(feedList);
		System.out.println("Get User News Feed -> "+isFriend);
		return "success";
	}
}
