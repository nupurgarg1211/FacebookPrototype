package org.iiitb.facebook.dao;

import java.util.ArrayList;
import java.util.List;

import org.iiitb.facebook.model.Conversation;
import org.iiitb.facebook.model.Message;
import org.iiitb.facebook.model.UserDhruvik;

public interface MessageDAO {

	/*public List<Conversation> getConversations(int user);*/
	
	
	public boolean saveMessage(String message, String friendid, String to,String user_id);	
	public ArrayList<UserDhruvik>getPreviousChats(String user_id);
	public List<UserDhruvik> getFriends(String user_id,String to);
	public UserDhruvik getPersonalDetails(int userid);
	public ArrayList<Message> getPersonalChats(int user1, int user2);
	public void updateMessageSeen(int user1, int user2);
	public ArrayList<UserDhruvik> getNewMsgUsers(int userid);
	

}
