package org.iiitb.facebook.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.iiitb.facebook.dao.NewsFeedDAO;
import org.iiitb.facebook.dao.ViewImageDAO;

import org.iiitb.facebook.dao.impl.NewsFeedDAOImpl;
import org.iiitb.facebook.dao.impl.UserImageUploadDAOImpl;
import org.iiitb.facebook.dao.impl.ViewImageDAOImpl;

import org.iiitb.facebook.model.Post;
import org.iiitb.facebook.model.User;
import org.iiitb.facebook.model.Image;
import org.iiitb.facebook.util.StringUtils;


import com.opensymphony.xwork2.ActionSupport;

public class ViewImageAction extends ActionSupport{
	
	public int albumId;
	public ArrayList<Image> imageList;
	private String full_name;
	private String profile_pic;
	private String cover_pic;
	private String user_id;
	private String isFriend;
	
	public String getIsFriend() {
		return isFriend;
	}
	public void setIsFriend(String isFriend) {
		this.isFriend = isFriend;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getFull_name() {
		return full_name;
	}
	public void setFull_name(String full_name) {
		this.full_name = full_name;
	}
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
	public int getAlbumId() {
		return albumId;
	}
	public void setAlbumId(int albumId) {
		this.albumId = albumId;
	}
	public ArrayList<Image> getImageList() {
		return imageList;
	}
	public void setImageList(ArrayList<Image> imageList) {
		this.imageList = imageList;
	}
	
	public String getImages()
	{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User user=(User)session.getAttribute("user");
		ViewImageDAO im=new ViewImageDAOImpl();
		ArrayList<Image> imageList=im.getImages(getAlbumId());
		setImageList(imageList);
		request.setAttribute("imageList", imageList);
		
		TimelineHeaderAction tha = new TimelineHeaderAction();
		setFull_name(tha.getFullName(user_id));
		setIsFriend(tha.checkFriend(user.getUserId(), user_id));
		setProfile_pic(tha.getProfilePic(user_id));
		setCover_pic(tha.getCoverPic(user_id));
		
		return "success";
	}
	

}
