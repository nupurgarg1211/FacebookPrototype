package org.iiitb.facebook.dao;

import java.util.List;
import java.util.Map;

import org.iiitb.facebook.model.Event;
import org.iiitb.facebook.model.User;
import org.iiitb.facebook.model.UserSearch;

/**
 * @author nitin 
 * @fileName EventDAO.java 
 * @created on 12-Apr-2015
 */
public interface EventDAO {
	
	public int createEvent(Event event);
	public Map<String,List<Event>> getEventList(User user);
	public List<Event> getEventDetails(int eventId);
	List<UserSearch> getFriendList(String userId, int eventId);
	public void inviteFriends(int eventId, List<Integer> invitees);
	public void repondRSVP(int eventId, int userId, String code);
	public List<String> getInvitedStatus(int eventId,String code); 
}
