package org.iiitb.facebook.model;

public class Album {
	int albumId;
	String albumName;
	int userId;
	int groupId;
	String date;
	String privacyName;
	
	
	public String getPrivacyName() {
		return privacyName;
	}
	public void setPrivacyName(String privacyName) {
		this.privacyName = privacyName;
	}
	public int getAlbumId() {
		return albumId;
	}
	public void setAlbumId(int albumId) {
		this.albumId = albumId;
	}
	public String getAlbumName() {
		return albumName;
	}
	public void setAlbumName(String albumName) {
		this.albumName = albumName;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getGroupId() {
		return groupId;
	}
	public void setGroupId(int groupId) {
		this.groupId = groupId;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	

}
