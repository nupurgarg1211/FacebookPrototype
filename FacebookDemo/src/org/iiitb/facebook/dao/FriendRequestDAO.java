package org.iiitb.facebook.dao;

public interface FriendRequestDAO
{
	public boolean rejectFriend(String id1, String id2);
	public boolean acceptFriend(String id1, String id2);
	public boolean removeFriend(String id1, String id2);
	public boolean addFriend(String user_from,String user_to);
	public boolean cancelFriend(String user_from,String user_to);
}
