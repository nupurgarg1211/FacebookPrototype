package org.iiitb.facebook.model;

public class Message {
	
	private String message_id;
	private String message;
	private String user_from;
	private String user_to;
	private String is_seen;
	private String date;
	private String conversation_id; 
	
	public String getConversation_id() {
		return conversation_id;
	}
	public void setConversation_id(String conversation_id) {
		this.conversation_id = conversation_id;
	}
	public String getMessage_id() {
		return message_id;
	}
	public void setMessage_id(String message_id) {
		this.message_id = message_id;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getUser_from() {
		return user_from;
	}
	public void setUser_from(String user_from) {
		this.user_from = user_from;
	}
	public String getUser_to() {
		return user_to;
	}
	public void setUser_to(String user_to) {
		this.user_to = user_to;
	}
	public String getIs_seen() {
		return is_seen;
	}
	public void setIs_seen(String is_seen) {
		this.is_seen = is_seen;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	

}
