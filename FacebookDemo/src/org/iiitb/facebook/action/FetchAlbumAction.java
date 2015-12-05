package org.iiitb.facebook.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.iiitb.facebook.dao.NewsFeedDAO;
import org.iiitb.facebook.dao.AlbumDAO;
import org.iiitb.facebook.dao.impl.NewsFeedDAOImpl;
import org.iiitb.facebook.dao.impl.AlbumDAOImpl;
import org.iiitb.facebook.dao.impl.UserImageUploadDAOImpl;
import org.iiitb.facebook.model.Post;
import org.iiitb.facebook.model.User;
import org.iiitb.facebook.model.Album;
import org.iiitb.facebook.util.StringUtils;

import com.opensymphony.xwork2.ActionSupport;

public class FetchAlbumAction extends ActionSupport{
	public ArrayList<Album> albumList;
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
	public ArrayList<Album> getAlbumList() {
		return albumList;
	}

	public void setAlbumList(ArrayList<Album> albumList) {
		this.albumList = albumList;
	}
	public String getAlbums()
	{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		AlbumDAO al=new AlbumDAOImpl();
		User user=(User)session.getAttribute("user");
		ArrayList<Album> albumList=al.getAlbum(user_id);
		setAlbumList(albumList);
		request.setAttribute("albumList", albumList);
		
		TimelineHeaderAction tha = new TimelineHeaderAction();
		setFull_name(tha.getFullName(user_id));
		setIsFriend(tha.checkFriend(user.getUserId(), user_id));
		setProfile_pic(tha.getProfilePic(user_id));
		setCover_pic(tha.getCoverPic(user_id));
		
		
		return "success";
	}
	

}
