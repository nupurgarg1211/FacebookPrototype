package org.iiitb.facebook.model;

import java.util.ArrayList;

public class Group {

	private int group_id;
	private String group_name;
	private String icon;
	private String coverPic;
	private ArrayList<User> group_members;
	private String isAdmin;
	private String member_request;
	private String album_id;
	
	public int getGroup_id() {
		return group_id;
	}
	public void setGroup_id(int group_id) {
		this.group_id = group_id;
	}
	public String getGroup_name() {
		return group_name;
	}
	public void setGroup_name(String group_name) {
		this.group_name = group_name;
	}
	public ArrayList<User> getGroup_members() {
		return group_members;
	}
	public void setGroup_members(ArrayList<User> group_members) {
		this.group_members = group_members;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	
	public String getIsAdmin() {
		return isAdmin;
	}
	public void setIsAdmin(String isAdmin) {
		this.isAdmin = isAdmin;
	}
	public String getMember_request() {
		return member_request;
	}
	public void setMember_request(String member_request) {
		this.member_request = member_request;
	}
	public String getCoverPic() {
		return coverPic;
	}
	public void setCoverPic(String coverPic) {
		this.coverPic = coverPic;
	}
	public String getAlbum_id() {
		return album_id;
	}
	public void setAlbum_id(String album_id) {
		this.album_id = album_id;
	}
}
