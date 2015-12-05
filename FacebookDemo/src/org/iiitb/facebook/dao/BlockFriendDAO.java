package org.iiitb.facebook.dao;

import java.util.ArrayList;


import org.iiitb.facebook.model.About;
import org.iiitb.facebook.model.Education;
import org.iiitb.facebook.model.Relationship;
import org.iiitb.facebook.model.UserDhruvik;
import org.iiitb.facebook.model.Work;
import org.iiitb.facebook.model.WorkEducation;

public interface BlockFriendDAO
{
	public void blockFriend(String blocked_by,String blocked_to);
	public ArrayList<String> getBlockedFriends(String user_id);
	public void unBlockFriend(String blocked_by,String blocked_to);
	public ArrayList<UserDhruvik> getAllBlockedFriendsDisplay(String userId);
}
