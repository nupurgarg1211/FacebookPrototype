package org.iiitb.facebook.dao;

import java.util.ArrayList;

import org.iiitb.facebook.model.Post;

public interface EventNewsFeedDAO {
	public ArrayList<Post> getNewsFeed(String eventId);
	public ArrayList<Post> getUserNewsFeed(String eventId);
}
