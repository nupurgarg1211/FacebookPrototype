
package org.iiitb.facebook.action;


import java.sql.Array;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.iiitb.facebook.dao.EventDAO;
import org.iiitb.facebook.dao.EventNewsFeedDAO;
import org.iiitb.facebook.dao.impl.EventDAOImpl;
import org.iiitb.facebook.dao.impl.EventNewsFeedDAOImpl;
import org.iiitb.facebook.dao.impl.NewsFeedDAOImpl;
import org.iiitb.facebook.dao.impl.RegistrationDAOImpl;
import org.iiitb.facebook.model.Event;
import org.iiitb.facebook.model.Post;
import org.iiitb.facebook.model.User;
import org.iiitb.facebook.model.UserSearch;
import org.iiitb.facebook.util.ConnectionPool;
import org.iiitb.facebook.util.PhotoUtil;

import com.opensymphony.xwork2.ActionSupport;

/**
 * @author nitin 
 * @fileName EventAction.java 
 * @created on 12-Apr-2015
 */
public class EventAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	
	private String name;
	private String detail;
	private String place;
	private String date;
	private int eventId;
	private String privacy;
	private List<Event> eventList;
	private List<Post> postList;
	private Map<String,List<Event>> eventMap;
	private List<UserSearch> frndList;
	private List<Integer> invitees;
	private String code;
	List<String> invitedUserList;
	
	public String createEvent(){
		System.out.println("createEvent()");
		HttpSession session = ServletActionContext.getRequest().getSession(false);
		User user=(User)session.getAttribute("user");
		EventDAO event = new EventDAOImpl();
		Event e = new Event();
		e.setEventname(getName());
		System.out.println("from UI: " +getDate());
		SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		Date date =null;
		try {
			date = formatter.parse(getDate());
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		if(date!=null)
			e.setEventDate(date);
		e.setEventDetails(getDetail());
		e.setPlace(getPlace());
		e.setPrivacy(getPrivacy());
		e.setOrganizer(Integer.parseInt(user.getUserId()));
		setEventId(event.createEvent(e));
		
		//create folder for images in event
		String evId = ""+getEventId();																																									
		PhotoUtil.eventFirstTimeAlbumCreation(evId);
		SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String d=sf.format(new Date());
		RegistrationDAOImpl ed=new RegistrationDAOImpl();
		ed.createAlbumForEvent("evprofilePicture", evId, d);	
		ed.createAlbumForEvent("evcoverPicture", evId, d);
		ed.createAlbumForEvent("evtimeline", evId, d);
		//end

		return SUCCESS;
	}
	
	public String displayEventPage(){
		HttpServletRequest request = ServletActionContext.getRequest();
		System.out.println("getEventDetails()");
		EventDAO ev = new EventDAOImpl();
		request.setAttribute("eventId", ""+getEventId());
		setEventList(ev.getEventDetails(getEventId()));
		EventNewsFeedDAO enf = new EventNewsFeedDAOImpl();
		request.setAttribute("feedList", enf.getUserNewsFeed(""+getEventId()));
		return SUCCESS;
	}
	
	public String getEventsList(){
		System.out.println("getEventsList()");
		EventDAO ev = new EventDAOImpl();
		HttpSession session = ServletActionContext.getRequest().getSession(false);
		User user = (User)session.getAttribute("user");
		setEventMap(ev.getEventList(user));
		return SUCCESS;
	}
	
	public String getFriendList(){
		HttpSession session = ServletActionContext.getRequest().getSession(false);
		User user=(User)session.getAttribute("user");
		/*User user = null;
		if(user == null){
			user = new User();
			user.setUserId("33");
		}*/
		EventDAO ev = new EventDAOImpl();
		System.out.println("getEventid() :"+ getEventId());
		setFrndList(ev.getFriendList(user.getUserId(),getEventId()));
		return SUCCESS;
	}
	
	public String inviteFriends(){
		System.out.println("inviteFriends()");
		HttpSession session = ServletActionContext.getRequest().getSession(false);
		User user=(User)session.getAttribute("user");
		EventDAO ed = new EventDAOImpl();
		ed.inviteFriends(getEventId(),getInvitees());
		
		System.out.println(">>>>>>>>>>>>>>>>>"+ getEventId());
		AllNotificationAction aln=new AllNotificationAction(); 
		NewsFeedDAOImpl nnf=new NewsFeedDAOImpl(); 
		DateFormat ddf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
		Date dateobjj = new Date();
		//get the user list of all the persons
		String l = "";
	
		String userSql = "select user_id,first_name , last_name from user where user_id ="+getInvitees().get(0);
				
		
		for(int iter=1;iter<getInvitees().size();iter++){
			userSql += " UNION ";
			userSql += "select user_id,first_name , last_name from user where user_id ="+getInvitees().get(iter);
		}
		
		
		String eventName = "select event_name from event where event_id = "+getEventId();
		System.out.println(userSql);
		System.out.println(eventName);
		Connection conn = ConnectionPool.getConnection();
		Statement stmt;
		try {
			stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(eventName);
			rs.next();
			String evtName = rs.getString("event_name"); 
			rs = stmt.executeQuery(userSql);
			while(rs.next()){
				if(!(user.getUserId()).equals(rs.getString("user_id")))
				aln.addNotification("event", user.getUserId(), rs.getString("user_id"),  user.getFirstName()+" " +user.getLastName() +" has sent you an invite to join "+evtName, "eventList", ddf.format(dateobjj));
				}
			}catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		return SUCCESS;
	}
	public String respondRSPV(){
		System.out.println("action.respondRSVP()");
		HttpSession session = ServletActionContext.getRequest().getSession(false);
		User user=(User)session.getAttribute("user");
		EventDAO ed = new EventDAOImpl();
		ed.repondRSVP(getEventId(), Integer.parseInt(user.getUserId()), getCode());
		
		
		
		
		return SUCCESS;
	}
	
	public String getInvitedStatus(){
		if(getCode() != null){
			System.out.println("action.getInvitedStatus()");
			EventDAO ed = new EventDAOImpl();
			System.out.println(getEventId() +"  "+getCode());
			setInvitedUserList(ed.getInvitedStatus(getEventId(), getCode()));
		}
		return SUCCESS;
	}
	
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	public String getPlace() {
		return place;
	}
	public void setPlace(String place) {
		this.place = place;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}

	public List<Event> getEventList() {
		return eventList;
	}

	public void setEventList(List<Event> eventList) {
		this.eventList = eventList;
	}

	public int getEventId() {
		return eventId;
	}

	public void setEventId(int eventId) {
		this.eventId = eventId;
	}

	public String getPrivacy() {
		return privacy;
	}

	public void setPrivacy(String privacy) {
		this.privacy = privacy;
	}

	public Map<String, List<Event>> getEventMap() {
		return eventMap;
	}

	public void setEventMap(Map<String, List<Event>> eventMap) {
		this.eventMap = eventMap;
	}

	public List<UserSearch> getFrndList() {
		return frndList;
	}

	public void setFrndList(List<UserSearch> list) {
		this.frndList = list;
	}

	public List<Integer> getInvitees() {
		return invitees;
	}

	public void setInvitees(List<Integer> invitees) {
		this.invitees = invitees;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}

	/**
	 * @return the postList
	 */
	public List<Post> getPostList() {
		return postList;
	}

	/**
	 * @param postList the postList to set
	 */
	public void setPostList(List<Post> postList) {
		this.postList = postList;
	}

	/**
	 * @return the invitedUserList
	 */
	public List<String> getInvitedUserList() {
		return invitedUserList;
	}

	/**
	 * @param invitedUserList the invitedUserList to set
	 */
	public void setInvitedUserList(List<String> invitedUserList) {
		this.invitedUserList = invitedUserList;
	}
}
