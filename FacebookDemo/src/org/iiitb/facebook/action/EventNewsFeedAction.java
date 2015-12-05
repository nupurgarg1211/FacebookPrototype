package org.iiitb.facebook.action;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.iiitb.facebook.dao.EventNewsFeedDAO;
import org.iiitb.facebook.dao.GroupDAO;
import org.iiitb.facebook.dao.impl.EventNewsFeedDAOImpl;
import org.iiitb.facebook.dao.impl.GroupDAOImpl;
import org.iiitb.facebook.model.Group;
import org.iiitb.facebook.model.Post;
import org.iiitb.facebook.model.User;

import com.opensymphony.xwork2.ActionSupport;

public class EventNewsFeedAction {
		public ArrayList<Post> feedList;
		public ArrayList<Group> grpList;
		private String group_id;
		private String user_id;
		private String eventId;

		
		public String getUser_id() {
			return user_id;
		}
		public void setUser_id(String user_id) {
			this.user_id = user_id;
		}
			public String getGroup_id() {
			return group_id;
		}
		public void setGroup_id(String group_id) {
			this.group_id = group_id;
		}

		public ArrayList<Group> getGrpList() {
			return grpList;
		}
		public void setGrpList(ArrayList<Group> grpList) {
			this.grpList = grpList;
		}
		public ArrayList<Post> getFeedList() {
			return feedList;
		}
		public void setFeedList(ArrayList<Post> feedList) {
			this.feedList = feedList;
		}
		
		public String getNewsFeed(){
			HttpSession session=ServletActionContext.getRequest().getSession(false);
			EventNewsFeedDAO nf=new EventNewsFeedDAOImpl();
			User user=(User)session.getAttribute("user");
			ArrayList<Post> feedList=nf.getNewsFeed(getEventId());
			setFeedList(feedList);
			GroupDAO grp = new GroupDAOImpl();
			setGrpList(grp.getAllGroups(Integer.parseInt(user.getUserId())));
			return "success";
		}
		
		public ArrayList<Post> getEventNewsFeed(String eventId) {
			HttpSession session=ServletActionContext.getRequest().getSession(false);
			User user=(User)session.getAttribute("user");
			//new grpnews feed dao call 
			EventNewsFeedDAO nf=new EventNewsFeedDAOImpl();
			ArrayList<Post> feedList =nf.getNewsFeed(getEventId());
			return feedList;
		}

		public String getUserNewsFeed(){
			HttpSession session=ServletActionContext.getRequest().getSession(false);
			EventNewsFeedDAO nf=new EventNewsFeedDAOImpl();
			User user=(User)session.getAttribute("user");
			ArrayList<Post> feedList=nf.getUserNewsFeed(getEventId());
			setFeedList(feedList);
			return "success";
		}
			/**
			 * @return the eventId
			 */
			public String getEventId() {
				return eventId;
			}
			/**
			 * @param eventId the eventId to set
			 */
			public void setEventId(String eventId) {
				this.eventId = eventId;
			}
}

