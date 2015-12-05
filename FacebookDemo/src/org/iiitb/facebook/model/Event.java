package org.iiitb.facebook.model;

import java.util.Date;
import java.util.List;

/**
 * @author nitin 
 * @fileName Event.java 
 * @created on 12-Apr-2015
 */
public class Event {
	private int eventId;
	private String eventname;
	private String eventDetails;
	private String place;
	private Date eventDate;
	private String bgPic;
	private int organizer;
	private String organizerName;
	private String privacy;
	private List<User> pplAttending;
	private int going;
	private int invited;
	private int maybe;
	
	public int getEventId() {
		return eventId;
	}
	public void setEventId(int i) {
		this.eventId = i;
	}
	public String getEventname() {
		return eventname;
	}
	public void setEventname(String eventname) {
		this.eventname = eventname;
	}
	public String getEventDetails() {
		return eventDetails;
	}
	public void setEventDetails(String eventDetails) {
		this.eventDetails = eventDetails;
	}
	public String getPlace() {
		return place;
	}
	public void setPlace(String place) {
		this.place = place;
	}
	public Date getEventDate() {
		return eventDate;
	}
	public void setEventDate(Date eventDate) {
		this.eventDate = eventDate;
	}
	public String getBgPic() {
		return bgPic;
	}
	public void setBgPic(String bgPic) {
		this.bgPic = bgPic;
	}
	public List<User> getPplAttending() {
		return pplAttending;
	}
	public void setPplAttending(List<User> pplAttending) {
		this.pplAttending = pplAttending;
	}
	/**
	 * @return the organizer
	 */
	public int getOrganizer() {
		return organizer;
	}
	/**
	 * @param organizer the organizer to set
	 */
	public void setOrganizer(int organizer) {
		this.organizer = organizer;
	}
	public String getOrganizerName() {
		return organizerName;
	}
	public void setOrganizerName(String i) {
		this.organizerName = i;
	}
	public String getPrivacy() {
		return privacy;
	}
	public void setPrivacy(String privacy) {
		this.privacy = privacy;
	}
	/**
	 * @return the going
	 */
	public int getGoing() {
		return going;
	}
	/**
	 * @param going the going to set
	 */
	public void setGoing(int going) {
		this.going = going;
	}
	/**
	 * @return the invited
	 */
	public int getInvited() {
		return invited;
	}
	/**
	 * @param invited the invited to set
	 */
	public void setInvited(int invited) {
		this.invited = invited;
	}
	/**
	 * @return the maybe
	 */
	public int getMaybe() {
		return maybe;
	}
	/**
	 * @param maybe the maybe to set
	 */
	public void setMaybe(int maybe) {
		this.maybe = maybe;
	}
}
