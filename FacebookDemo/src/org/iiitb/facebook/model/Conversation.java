package org.iiitb.facebook.model;

import java.util.List;


public class Conversation
{
	private int id;
	private int conversation_id;
	private int user_id;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getConversation_id() {
		return conversation_id;
	}
	public void setConversation_id(int conversation_id) {
		this.conversation_id = conversation_id;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	
	/*private int id;
	private Message latestMessage;
	private int unreadMessagesCount;
	private List<User> otherParticipants; // Except the logged in user
	private boolean allFriends;
	
	public int getUnreadMessagesCount()
	{
		return unreadMessagesCount;
	}
	public void setUnreadMessagesCount(int unreadMessagesCount)
	{
		this.unreadMessagesCount = unreadMessagesCount;
	}
	public int getId()
	{
		return id;
	}
	public void setId(int id)
	{
		this.id = id;
	}
	public List<User> getOtherParticipants()
	{
		return otherParticipants;
	}
	public void setOtherParticipants(List<User> otherParticipants)
	{
		this.otherParticipants = otherParticipants;
	}
	public boolean isAllFriends()
	{
		return allFriends;
	}
	public void setAllFriends(boolean allFriends)
	{
		this.allFriends = allFriends;
	}
	public Message getLatestMessage()
	{
		return latestMessage;
	}
	public void setLatestMessage(Message latestMessage)
	{
		this.latestMessage = latestMessage;
	}*/
}
