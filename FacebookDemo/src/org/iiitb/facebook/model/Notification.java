package org.iiitb.facebook.model;

public class Notification {

	private int notification_id;
	private String notification_type;
	private int user_from;
	private int user_to;
	private String url;
	private String date;
	private String is_seen;
	private String msg;
	private String picUrl;
	
	public String getPicUrl() {
		return picUrl;
	}
	public void setPicUrl(String picUrl) {
		this.picUrl = picUrl;
	}
	public int getNotification_id() {
		return notification_id;
	}
	public void setNotification_id(int notification_id) {
		this.notification_id = notification_id;
	}
	public String getNotification_type() {
		return notification_type;
	}
	public void setNotification_type(String notification_type) {
		this.notification_type = notification_type;
	}
	public int getUser_from() {
		return user_from;
	}
	public void setUser_from(int user_from) {
		this.user_from = user_from;
	}
	public int getUser_to() {
		return user_to;
	}
	public void setUser_to(int user_to) {
		this.user_to = user_to;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getIs_seen() {
		return is_seen;
	}
	public void setIs_seen(String is_seen) {
		this.is_seen = is_seen;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	
	
	
	
}
