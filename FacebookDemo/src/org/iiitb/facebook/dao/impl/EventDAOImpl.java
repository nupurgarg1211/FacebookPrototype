package org.iiitb.facebook.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.struts2.util.DateFormatter;
import org.iiitb.facebook.dao.EventDAO;
import org.iiitb.facebook.model.Event;
import org.iiitb.facebook.model.User;
import org.iiitb.facebook.model.UserSearch;
import org.iiitb.facebook.util.ConnectionPool;

/**
 * @author nitin 
 * @fileName EventDAOImpl.java 
 * @created on 12-Apr-2015
 */
public class EventDAOImpl implements EventDAO {

	public int createEvent(Event event) {
		int eventId = 0;
		String name = event.getEventname();
		String place = event.getPlace();
		Date date = event.getEventDate();
		System.out.println("from controller: "+date.toString());
		DateFormat formatter = new SimpleDateFormat("yyyy/MM/dd");
		String d = formatter.format(date);
		System.out.println(d);
		String pic = event.getBgPic();
		String details = event.getEventDetails();
		int org = event.getOrganizer();
		String sql = "insert into event(event_name,event_description,start_date,location,privacy)"
				     + " values(?,?,?,?,?)";
		
		String memberSql = "insert into event_members(event_id,user_id,is_admin,member_request,member_status)"
							+" values(?,?,?,?,?)";
		Connection conn = ConnectionPool.getConnection();
		try {
			PreparedStatement ps = conn.prepareStatement(sql,PreparedStatement.RETURN_GENERATED_KEYS);
			ps.setString(1, name);
			ps.setString(2, details);
			ps.setDate(3, new java.sql.Date(date.getTime()));
			ps.setString(4, place);
			ps.setString(5,event.getPrivacy());
			ps.execute();
			ResultSet rs = ps.getGeneratedKeys();
			while(rs.next()){
				eventId = rs.getInt(1);
			}
			System.out.println(eventId);
			ps = conn.prepareStatement(memberSql,PreparedStatement.RETURN_GENERATED_KEYS);
			ps.setInt(1,eventId);
			ps.setInt(2,org);
			ps.setString(3, "T");
			ps.setString(4,"A");
			ps.setString(5,"going");
			ps.execute();
			rs = ps.getGeneratedKeys();
			rs.next();
			int eventMemberId = rs.getInt(1);
			System.out.println("eventId: "+eventId+" eventMemberId: "+eventMemberId);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			if(conn!=null)
				ConnectionPool.freeConnection(conn);
		}
		return eventId;
	}

	public Map<String,List<Event>> getEventList(User user) {
		List<Event> hostedEventList = new ArrayList<Event>();
		List<Event> invitedEventList = new ArrayList<Event>();
		List<Event> allEventList = new ArrayList<Event>();
		Map<String,List<Event>> map = new HashMap<String,List<Event>>();
		String hostedEventsql = "select * from event e, event_members em where e.event_id = em.event_id "
				+ "and em.is_admin = 'T' and em.user_id = ?";
		String invitedEventsql = "select * from event e where e.event_id in"
				+ " (select event_id from event_members where user_id = ? and is_admin = 'F' and member_request = 'P')";
		String allEventsql = "select * from event e inner join event_members em on e.event_id = em.event_id " 
							+"where em.user_id = ? and member_status <> 'reject'";
		
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		System.out.println("firstlist");
		try{
			ps = conn.prepareStatement(hostedEventsql);
			ps.setString(1, user.getUserId());
			rs = ps.executeQuery();
			while(rs.next()){
				Event ev = new Event();
				ev.setEventname(rs.getString("e.event_name"));
				//ev.setBgPic(rs.getString(""));
				ev.setEventDate(rs.getDate("e.start_date"));
				ev.setEventDetails(rs.getString("e.event_description"));
				ev.setEventId(rs.getInt("e.event_id"));
				ev.setPlace(rs.getString("e.location"));
				ev.setOrganizer(Integer.parseInt(user.getUserId()));
				ev.setOrganizerName(user.getFirstName() + " " + user.getLastName());
				hostedEventList.add(ev);
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
		System.out.println("secondlist");
		try{
			ps = conn.prepareStatement(invitedEventsql);
			ps.setString(1, user.getUserId());
			rs = ps.executeQuery();
			while(rs.next()){
				Event ev = new Event();
				ev.setEventname(rs.getString("e.event_name"));
				//ev.setBgPic(rs.getString(""));
				ev.setEventDate(rs.getDate("e.start_date"));
				ev.setEventDetails(rs.getString("e.event_description"));
				ev.setEventId(rs.getInt("e.event_id"));
				ev.setPlace(rs.getString("e.location"));
				ev.setOrganizer(Integer.parseInt(user.getUserId()));
				ev.setOrganizerName(user.getFirstName() + " " + user.getLastName());
				invitedEventList.add(ev);
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
		System.out.println("thirdlist");
		try{
			ps = conn.prepareStatement(allEventsql);
			ps.setString(1, user.getUserId());
			rs = ps.executeQuery();
			while(rs.next()){
				Event ev = new Event();
				ev.setEventname(rs.getString("e.event_name"));
				//ev.setBgPic(rs.getString(""));
				ev.setEventDate(rs.getDate("e.start_date"));
				ev.setEventDetails(rs.getString("e.event_description"));
				ev.setEventId(rs.getInt("e.event_id"));
				ev.setPlace(rs.getString("e.location"));
				ev.setOrganizer(Integer.parseInt(user.getUserId()));
				ev.setOrganizerName(user.getFirstName() + " " + user.getLastName());
				allEventList.add(ev);
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			if(conn!=null)
				ConnectionPool.freeConnection(conn);
		}
		map.put("hosting", hostedEventList);
		map.put("invites", invitedEventList);
		map.put("all", allEventList);
		
		return map;
	}
	
	public List<Event> getEventDetails(int eventId){
		List<Event> edList = new ArrayList<Event>();
		String sql = "select e.event_id,e.event_name,e.event_description,e.start_date,e.location from event e where e.event_id = ?";
		String userSql = "select user_id,first_name , last_name from user where user_id "
				+ "in(select user_id from event_members where event_id = ? and is_admin = 'T')";
		String invitedSql = "select user_id,member_status from event_members where event_id = ?";
		Connection conn = ConnectionPool.getConnection();
		try{
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, eventId);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				Event ev = new Event();
				ev.setEventname(rs.getString("e.event_name"));
				//ev.setBgPic(rs.getString("e.bgpic"));
				ev.setEventDate((Date)rs.getDate("e.start_date"));
				System.out.println(ev.getEventDate());
				ev.setEventDetails(rs.getString("e.event_description"));
				ev.setEventId(rs.getInt("e.event_id"));
				ev.setPlace(rs.getString("e.location"));
				PreparedStatement p = conn.prepareStatement(userSql);
				p.setInt(1,ev.getEventId());
				ResultSet r = p.executeQuery();
				while(r.next()){
					ev.setOrganizerName(r.getString("first_name")+" "+r.getString("last_name"));
					ev.setOrganizer(r.getInt("user_id"));
				}
				PreparedStatement pstmt = conn.prepareStatement(invitedSql);
				pstmt.setInt(1, ev.getEventId());
				System.out.println(invitedSql);
				ResultSet rst = pstmt.executeQuery();
				int invited = 0;
				int going = 0;
				int maybe = 0;
				while (rst.next()) {
					String status = rst.getString("member_status");
					if (("going").equals(status)) {
						going++;
					} else if (("maybe").equals(status)) {
						maybe++;
					} 
					invited++;
				}
				ev.setGoing(going);
				ev.setInvited(invited);
				ev.setMaybe(maybe);
				System.out.println(ev.getOrganizerName());
				edList.add(ev);
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			if(conn!=null)
				ConnectionPool.freeConnection(conn);
		}
		return edList;	
	}

	@Override
	public List<UserSearch> getFriendList(String userId,int eventId) {
		String sql = "select uf.user_id2, u.first_name,u.last_name,u.profile_pic from user_friends uf inner join user u on " +
				"uf.user_id2 = u.user_id where uf.user_id1 = ? and uf.user_id2 not in (select user_id from event_members where event_id = ?);";
		System.out.println(userId +" "+eventId);
		List<UserSearch> friendList = new ArrayList<UserSearch>();
		Connection conn = ConnectionPool.getConnection();
		try{
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, Integer.parseInt(userId));
			ps.setInt(2,eventId);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				UserSearch u = new UserSearch();
				u.setUserId(rs.getString("uf.user_id2"));
				u.setFirstName(rs.getString("u.first_name"));
				u.setLastName(rs.getString("u.last_name"));
				u.setProfilePic(rs.getString("u.profile_pic"));
				friendList.add(u);
			}
			System.out.println(friendList.size());
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			if(conn!=null)
				ConnectionPool.freeConnection(conn);
		}
		return friendList;
	}

	@Override
	public void inviteFriends(int eventId, List<Integer> invitees) {
		StringBuilder sql = new StringBuilder("insert into event_members(event_id,user_id,is_admin,member_request) values ");
		for(int i=0;i<invitees.size();i++){
			if(i!=0){
				sql.append(",");
			}
			sql.append("("+eventId+","+invitees.get(i)+",'F','P')");	
		}
		System.out.println(sql.toString());
		Connection conn = ConnectionPool.getConnection();
		try{
			Statement stmt = conn.createStatement();
			Boolean success = stmt.execute(sql.toString());
			System.out.println(success);
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			if(conn!=null)
				ConnectionPool.freeConnection(conn);
		}
	}

	@Override
	public void repondRSVP(int eventId, int userId,String code) {
		System.out.println("dao.repondRSVP()");
		String sql = "update event_members set member_request = 'A', member_status = '"+code+ "' where event_id = "+eventId+" and user_id = " + userId ;
		System.out.println(sql.toString());
		Connection conn = ConnectionPool.getConnection();
		try{
			Statement stmt = conn.createStatement();
			Boolean success = stmt.execute(sql.toString());
			System.out.println(success);
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			if(conn!=null)
				ConnectionPool.freeConnection(conn);
		}
	}

	@Override
	public List<String> getInvitedStatus(int eventId, String code) {
		List<String> list = new ArrayList<String>();
		String goingMaybe = "select first_name,last_name from user where user_id in " +
				"(SELECT user_id FROM facebookdb.event_members where event_id = ? and member_status = ?)";
		String invited = "select first_name,last_name from user where user_id in " +
				"(SELECT user_id FROM facebookdb.event_members where event_id = ? and member_request <> 'R')";
		Connection conn = ConnectionPool.getConnection();
		try{
			PreparedStatement st = null;
			if(code.equals("going") || code.equals("maybe") ){
				st = conn.prepareStatement(goingMaybe);
				st.setInt(1,eventId);
				st.setString(2, code);
			}else{
				st = conn.prepareStatement(invited);
				st.setInt(1, eventId);
			}
		
			ResultSet rs = st.executeQuery();
			while(rs.next()){
				list.add(rs.getString(1)+" "+rs.getString(2));
			}
			System.out.println(list.size());
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			if(conn!=null)
				ConnectionPool.freeConnection(conn);
		}
		
		return list;
	} 
	
	
}
