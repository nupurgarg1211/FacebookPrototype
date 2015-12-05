package org.iiitb.facebook.dao;

import java.util.ArrayList;

import org.iiitb.facebook.model.UserDhruvik;

public interface FriendsDAO {
	public ArrayList<UserDhruvik> getAllFriends(String userid);
	public ArrayList<UserDhruvik> getNonFriends(String userid);
	public ArrayList<UserDhruvik> getAllPendingFriends(String userid);
	public boolean addFriend(int id1,int id2);
	public boolean removeFriend(int id1,int id2);
	public boolean acceptFriend(int id1,int id2);
	public boolean rejectFriend(int id1, int id2);
	public ArrayList<UserDhruvik> getAllFriendsSuggestion(String user_session, String user_id);
	public boolean suggestFriend(String user_session, String user_id, String suggestid);
}
