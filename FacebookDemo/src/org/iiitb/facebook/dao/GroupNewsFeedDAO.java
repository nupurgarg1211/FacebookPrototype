package org.iiitb.facebook.dao;

import java.util.ArrayList;

import org.iiitb.facebook.model.Post;

public interface GroupNewsFeedDAO {

	public ArrayList<Post> getNewsFeed(String userId);
}
