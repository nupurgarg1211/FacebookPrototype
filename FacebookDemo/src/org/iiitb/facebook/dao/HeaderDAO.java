package org.iiitb.facebook.dao;

import java.util.ArrayList;

import org.iiitb.facebook.model.Notification;
import org.iiitb.facebook.model.UserDhruvik;

public interface HeaderDAO {

	public ArrayList<Notification> getNotifications(int userid);

	public ArrayList<UserDhruvik> getAllPendingFriends(int userid);

	public ArrayList<Notification> getallNotifications(int i);

	public void clearNotifications(int i);
	public void insertNewNotification(String notification_type,String user_from, String user_to, String message, String url,String date, String is_seen);
	
}
