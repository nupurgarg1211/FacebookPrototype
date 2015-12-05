package org.iiitb.facebook.model;

import java.util.ArrayList;

public class Post {

	String postId;
	String postDesc;
	String userFrom;
	String userTo;
	String postDate;
	String picPath;
	String UserName;
	String likeCount;
	String commentCount;
	String postType;
	String userProfilePic;
	String youTubeLink;
	ArrayList<Like> likeList;
	ArrayList<Comment> commentList;
	String privacyName;
	
	
	public String getPrivacyName() {
		return privacyName;
	}
	public void setPrivacyName(String privacyName) {
		this.privacyName = privacyName;
	}
	public String getUserProfilePic() {
		return userProfilePic;
	}
	public void setUserProfilePic(String userProfilePic) {
		this.userProfilePic = userProfilePic;
	}
	public String getYouTubeLink() {
		return youTubeLink;
	}
	public void setYouTubeLink(String youTubeLink) {
		this.youTubeLink = youTubeLink;
	}
	public String getPostType() {
		return postType;
	}
	public void setPostType(String postType) {
		this.postType = postType;
	}
	public ArrayList<Like> getLikeList() {
		return likeList;
	}
	public void setLikeList(ArrayList<Like> likeList) {
		this.likeList = likeList;
	}
	public ArrayList<Comment> getCommentList() {
		return commentList;
	}
	public void setCommentList(ArrayList<Comment> commentList) {
		this.commentList = commentList;
	}
	public String getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(String likeCount) {
		this.likeCount = likeCount;
	}
	public String getCommentCount() {
		return commentCount;
	}
	public void setCommentCount(String commentCount) {
		this.commentCount = commentCount;
	}
	
	public String getUserName() {
		return UserName;
	}
	public void setUserName(String userName) {
		UserName = userName;
	}
	public String getPostDate() {
		return postDate;
	}
	public void setPostDate(String postDate) {
		this.postDate = postDate;
	}
	public String getPostId() {
		return postId;
	}
	public void setPostId(String postId) {
		this.postId = postId;
	}
	public String getPostDesc() {
		return postDesc;
	}
	public void setPostDesc(String postDesc) {
		this.postDesc = postDesc;
	}
	
	public String getUserFrom() {
		return userFrom;
	}
	public void setUserFrom(String userFrom) {
		this.userFrom = userFrom;
	}
	public String getUserTo() {
		return userTo;
	}
	public void setUserTo(String userTo) {
		this.userTo = userTo;
	}
	public String getPicPath() {
		return picPath;
	}
	public void setPicPath(String picPath) {
		this.picPath = picPath;
	}
	
	
}
