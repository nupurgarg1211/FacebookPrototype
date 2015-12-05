package org.iiitb.facebook.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.iiitb.facebook.action.BlockFriendAction;
import org.iiitb.facebook.dao.SearchDAO;
import org.iiitb.facebook.model.Event;
import org.iiitb.facebook.model.User;
import org.iiitb.facebook.model.UserSearch;
import org.iiitb.facebook.util.ConnectionPool;

/**
 * @author nitin
 * @fileName SearchDAOImpl.java
 * @created on 08-Apr-2015
 */
public class SearchDAOImpl implements SearchDAO {
	List<UserSearch> userList;
	String sql = "select u.user_id, u.first_name,u.last_name,u.profile_pic from user u "
				+"WHERE u.first_name like ? OR u.last_name like ?";
	
	String worksql = "select type, organization,position from work_education where user_id = ?"; 
	
	String eventSql = "SELECT e.event_id,e.event_name,e.event_description,e.start_date,e.location "
			+ "from event e where e.event_name like ?";

	String currentCitySql = "select c.city_name from city c inner join user_location ul on c.city_id = ul.city_id where ul.user_id = ? and ul.is_current_city = 'T'";
	
	@Override
	public List<UserSearch> search(String term) {
		// System.out.println(sql);
		userList = new ArrayList<UserSearch>();
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement ps = null;
		try {
			ps = conn.prepareStatement(sql);
			term = term + "%";
			ps.setString(1, term);
			ps.setString(2, term);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				UserSearch user = new UserSearch();
				user.setName(rs.getString("u.first_name") + " "+ rs.getString("u.last_name"));
				user.setProfilePic(rs.getString("u.profile_pic"));
				user.setUserId(rs.getString("u.user_id"));
				PreparedStatement pstmt = conn.prepareStatement(worksql);
				pstmt.setInt(1,Integer.parseInt(user.getUserId()));
				ResultSet r = pstmt.executeQuery();
				while(r.next()){
					String type = r.getString("type");
					if(("work").equals(type)){
						user.setOrganization(r.getString("organization"));
						user.setPosition(r.getString("position"));
					}else{
						user.setSchool(r.getString("organization"));
					}
				}
				pstmt = conn.prepareStatement(currentCitySql);
				pstmt.setInt(1,Integer.parseInt(user.getUserId()));
				r = pstmt.executeQuery();
				while(r.next()){
					user.setPlace(r.getString("c.city_name"));
				}
				userList.add(user);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			if(conn!=null)
				ConnectionPool.freeConnection(conn);
		}
		
		ArrayList<String> blockedUsers;
		
		BlockFriendAction allblocked = new BlockFriendAction();
		blockedUsers = allblocked.getBlockedFriends();
		
		for(int i=0;i<blockedUsers.size();i++){
			for(int j=0;j<userList.size();j++){
					if(userList.get(j).getUserId().equals(blockedUsers.get(i))){
						userList.remove(j);
						break;
					}
			}
		}			
		return userList;
	}

	@Override
	public Map<String, List> searchAll(String searchTerm) {
		System.out.println(searchTerm);
		Map<String, List> searchMap = new HashMap<String, List>();
		searchMap.put("event", eventSearch(searchTerm));
		searchMap.put("people", search(searchTerm));
		// searchMap.put("group", value);
		return searchMap;
	}

	private List<Event> eventSearch(String searchTerm) {
		List<Event> eventList = new ArrayList<Event>();
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement ps = null;
		try {
			ps = conn.prepareStatement(eventSql);
			searchTerm = searchTerm + "%";
			ps.setString(1, searchTerm);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Event ev = new Event();
				ev.setEventId(rs.getInt("e.event_id"));
				ev.setEventname(rs.getString("e.event_name"));
				ev.setPlace(rs.getString("e.location"));
				ev.setEventDetails(rs.getString("e.event_description"));
				eventList.add(ev);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			if(conn!=null)
				ConnectionPool.freeConnection(conn);
		}
		return eventList;
	}
}