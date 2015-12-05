package org.iiitb.facebook.dao;

import java.util.ArrayList;

import org.iiitb.facebook.model.Post;

public interface NewsFeedDAO {

	public ArrayList<Post> getNewsFeed(String userId);
	public ArrayList<Post> getUserNewsFeed(String userId);
	public String checkFriend(String user_from , String user_to);
}
