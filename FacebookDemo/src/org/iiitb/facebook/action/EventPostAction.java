package org.iiitb.facebook.action;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Random;


import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.iiitb.facebook.dao.EventPostDAO;
import org.iiitb.facebook.dao.UserImageUploadDAO;
import org.iiitb.facebook.dao.impl.EventNewsFeedDAOImpl;
import org.iiitb.facebook.dao.impl.EventPostDAOImpl;
import org.iiitb.facebook.dao.impl.NewsFeedDAOImpl;
import org.iiitb.facebook.dao.impl.UserImageUploadDAOImpl;
import org.iiitb.facebook.model.Comment;
import org.iiitb.facebook.model.Like;
import org.iiitb.facebook.model.User;
import org.iiitb.facebook.util.ConnectionPool;
import org.iiitb.facebook.util.StringUtils;

import com.opensymphony.xwork2.ActionSupport;

public class EventPostAction extends ActionSupport {
	private static final long serialVersionUID = 1L;

	private String postDesc;
	private String friendId;
	private File pic;
	private String picContentType;
	private String picFileName;
	private String youtubeLink;
	private String postId;
	private String postUserId;
	private String comment;
	private String liketype;
	private String pcount;
	private String queryType;
	private ArrayList<Like> likeList;
	private ArrayList<Comment> commentList;
	private String commentId;
	private String user_id;
	private String eventId;
	
	public String postOnWall() throws IOException{
		
		System.out.println("Event Post On Wall "+eventId);
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User user=(User)session.getAttribute("user");
		System.out.println("UserPostAction Photo===>"+picFileName);
		System.out.println("UserPostAction Photo===>"+picContentType);
		System.out.println("UserPostAction Photo===>"+pic);
		String imageExtension="";
		if(picContentType!=null && picContentType.contains("jpeg")){
			imageExtension=".jpeg";
		}else if(picContentType!=null && picContentType.contains("png")){
			imageExtension=".png";
		}else if(picContentType!=null && picContentType.contains("gif")){
			imageExtension=".gif";
		}else if(picContentType!=null && picContentType.contains("jpg")){
			imageExtension=".jpg";
		}
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	Date dateobj = new Date();
		EventPostDAO up=new EventPostDAOImpl();
		String destpath="";
		if (picFileName != null) {
			Random randomGenerator = new Random();
			Integer randomInt = randomGenerator.nextInt(1000000);
			picFileName=randomInt.toString()+imageExtension;
	        destpath= StringUtils.eventPhotoPath+File.separator+getEventId()+"_timeline";
	        System.out.println("Server path:" + destpath);
	        File destFile = new File(destpath, picFileName);
	        try {
	          FileUtils.copyFile(pic, destFile);
	          UserImageUploadDAO imu=new UserImageUploadDAOImpl();
	          int albumId=imu.getAlbumId("timeline",Integer.parseInt(getEventId()));
	          imu.uploadImage(df.format(dateobj).toString(),albumId,picFileName);
	        } catch (IOException e) {
	          System.out.println("error occurred");
	          e.printStackTrace();
	          return ERROR;
	        }
		}
		EventNewsFeedDAOImpl nf=new EventNewsFeedDAOImpl();
		up.postOnWall(postDesc, user.getUserId(), eventId,  df.format(dateobj).toString(),picFileName);
		addActionMessage("Content has been posted successfully.");
		/**
		 * notification for post to suscribers
		 */
		AllNotificationAction aln=new AllNotificationAction(); 
		NewsFeedDAOImpl nnf=new NewsFeedDAOImpl(); 
		DateFormat ddf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
		Date dateobjj = new Date();
		//get the user list of all the persons
		String userSql = "select user_id,first_name , last_name from user where user_id "
				+ "in (select user_id from event_members where event_id = "+getEventId()+")";
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
				aln.addNotification("event", user.getUserId(), rs.getString("user_id"),  user.getFirstName()+" " +user.getLastName() +" has posted in event "+evtName, "events?eventId="+getEventId(), df.format(dateobj));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		HttpServletResponse response=ServletActionContext.getResponse();
		String url = StringUtils.hostname+"/FacebookDemo/events?eventId="+eventId;
		response.sendRedirect(url);
		return "success";
	}
	
	public String likeCount(){
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User user=(User)session.getAttribute("user");
		EventPostDAOImpl upimpl=new EventPostDAOImpl();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	Date dateobj = new Date();
		if(upimpl.increaseLike(postId, user.getUserId(), df.format(dateobj),liketype)){
			setPcount(new NewsFeedDAOImpl().getPostLikeCount(postId));
			
			System.out.println(">>>>>>>>>>>>>>>>>"+ getEventId());
			AllNotificationAction aln=new AllNotificationAction(); 
			NewsFeedDAOImpl nnf=new NewsFeedDAOImpl(); 
			DateFormat ddf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
			Date dateobjj = new Date();
			//get the user list of all the persons
			String userSql = "select user_id,first_name , last_name from user where user_id "
					+ "in (select user_id from event_members where event_id = "+getEventId()+")";
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
					aln.addNotification("event", user.getUserId(), rs.getString("user_id"),  user.getFirstName()+" " +user.getLastName() +" has liked a post in "+evtName, "events?eventId="+getEventId(), df.format(dateobj));
					}
				}catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			
			return "success";
		}else{
			setPcount(new NewsFeedDAOImpl().getPostLikeCount(postId));
			return "error";
		}		
	}
	public String addComment(){
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User user=(User)session.getAttribute("user");
		EventPostDAOImpl upimpl=new EventPostDAOImpl();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	Date dateobj = new Date();
    	System.out.println("Add Comment==>"+postId+" "+comment);
		if(upimpl.addComment(postId, user.getUserId(), df.format(dateobj),comment)){
			
			System.out.println(">>>>>>>>>>>>>>>>>"+ getEventId());
			AllNotificationAction aln=new AllNotificationAction(); 
			NewsFeedDAOImpl nnf=new NewsFeedDAOImpl(); 
			DateFormat ddf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
			Date dateobjj = new Date();
			//get the user list of all the persons
			String userSql = "select user_id,first_name , last_name from user where user_id "
					+ "in (select user_id from event_members where event_id = "+getEventId()+")";
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
					aln.addNotification("event", user.getUserId(), rs.getString("user_id"),  user.getFirstName()+" " +user.getLastName() +" has commented on "+evtName, "events?eventId="+getEventId(), df.format(dateobj));
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
			return "success";
		}else{
			return "error";
		}	
	}
	
	public String deletePost(){
		EventPostDAOImpl updo=new EventPostDAOImpl();
		if(updo.deletePost(postId))
			return "success";
		else
			return "error";
	}
	
	public String deleteComment(){
		EventPostDAOImpl updo=new EventPostDAOImpl();
		if(updo.deleteComment(commentId))
			return "success";
		else
			return "error";
	}
	
	public String editPost(){
		EventPostDAOImpl upd=new EventPostDAOImpl();
		if(upd.updatePost(postId, comment)){
			return "success";
		}else{
			return "error";
		}
	}
	public String editComment(){
		EventPostDAOImpl upd=new EventPostDAOImpl();
		if(upd.updateComment(commentId, comment)){
			return "success";
		}else{
			return "error";
		}
	}
	/*public String getAllPeople(){
		NewsFeedDAOImpl nfd=new NewsFeedDAOImpl();
		System.out.println(postId);
		if(queryType!=null && queryType.equalsIgnoreCase("like"))
			setLikeList(nfd.getAllPostLike(postId));
		else{
			ArrayList<Comment> al=nfd.getAllPostComment(postId);
			al=getUniqueName(al);
			setCommentList(al);
		}			
		
		return "success";
	}*/
	
	public ArrayList<Comment>  getUniqueName(ArrayList<Comment> al){
		HashMap<String,Integer> unique=new HashMap<String, Integer>();
		ArrayList<Comment> temp=new ArrayList<Comment>();
		if(al!=null)
			for(int i=0;i<al.size();i++){
				Comment c=al.get(i);
				if(unique.containsKey(c.getUserId())){
					
				}else{
					unique.put(c.getUserId(), 0);
					temp.add(c);
				}
			}
		return temp;
	}
	
	
	public HashMap<String,String> getSuscriber(){
		String userSql = "select user_id,first_name , last_name from user where user_id "
				+ "in (select user_id from event_members where event_id = "+getEventId()+")";
		String eventName = "select event_name from event where event_id = "+getEventId();
		HashMap<String,String> map = new HashMap<String,String>();
		Connection conn = ConnectionPool.getConnection();
		Statement stmt;
		try {
			stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(eventName);
			rs.next();
			String evtName = rs.getString("event_name"); 
			rs = stmt.executeQuery(userSql);
			while(rs.next()){
				map.put(evtName+"_"+rs.getString("user_id"),rs.getString("first_name")+" "+rs.getString("last_name"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return map;
	} 	
	
	
	
	/**
	 * @return the postDesc
	 */
	public String getPostDesc() {
		return postDesc;
	}
	/**
	 * @param postDesc the postDesc to set
	 */
	public void setPostDesc(String postDesc) {
		this.postDesc = postDesc;
	}
	/**
	 * @return the friendId
	 */
	public String getFriendId() {
		return friendId;
	}
	/**
	 * @param friendId the friendId to set
	 */
	public void setFriendId(String friendId) {
		this.friendId = friendId;
	}
	/**
	 * @return the pic
	 */
	public File getPic() {
		return pic;
	}
	/**
	 * @param pic the pic to set
	 */
	public void setPic(File pic) {
		this.pic = pic;
	}
	/**
	 * @return the picContentType
	 */
	public String getPicContentType() {
		return picContentType;
	}
	/**
	 * @param picContentType the picContentType to set
	 */
	public void setPicContentType(String picContentType) {
		this.picContentType = picContentType;
	}
	/**
	 * @return the picFileName
	 */
	public String getPicFileName() {
		return picFileName;
	}
	/**
	 * @param picFileName the picFileName to set
	 */
	public void setPicFileName(String picFileName) {
		this.picFileName = picFileName;
	}
	/**
	 * @return the youtubeLink
	 */
	public String getYoutubeLink() {
		return youtubeLink;
	}
	/**
	 * @param youtubeLink the youtubeLink to set
	 */
	public void setYoutubeLink(String youtubeLink) {
		this.youtubeLink = youtubeLink;
	}
	/**
	 * @return the postId
	 */
	public String getPostId() {
		return postId;
	}
	/**
	 * @param postId the postId to set
	 */
	public void setPostId(String postId) {
		this.postId = postId;
	}
	/**
	 * @return the postUserId
	 */
	public String getPostUserId() {
		return postUserId;
	}
	/**
	 * @param postUserId the postUserId to set
	 */
	public void setPostUserId(String postUserId) {
		this.postUserId = postUserId;
	}
	/**
	 * @return the comment
	 */
	public String getComment() {
		return comment;
	}
	/**
	 * @param comment the comment to set
	 */
	public void setComment(String comment) {
		this.comment = comment;
	}
	/**
	 * @return the liketype
	 */
	public String getLiketype() {
		return liketype;
	}
	/**
	 * @param liketype the liketype to set
	 */
	public void setLiketype(String liketype) {
		this.liketype = liketype;
	}
	/**
	 * @return the pcount
	 */
	public String getPcount() {
		return pcount;
	}
	/**
	 * @param pcount the pcount to set
	 */
	public void setPcount(String pcount) {
		this.pcount = pcount;
	}
	/**
	 * @return the queryType
	 */
	public String getQueryType() {
		return queryType;
	}
	/**
	 * @param queryType the queryType to set
	 */
	public void setQueryType(String queryType) {
		this.queryType = queryType;
	}
	/**
	 * @return the likeList
	 */
	public ArrayList<Like> getLikeList() {
		return likeList;
	}
	/**
	 * @param likeList the likeList to set
	 */
	public void setLikeList(ArrayList<Like> likeList) {
		this.likeList = likeList;
	}
	/**
	 * @return the commentList
	 */
	public ArrayList<Comment> getCommentList() {
		return commentList;
	}
	/**
	 * @param commentList the commentList to set
	 */
	public void setCommentList(ArrayList<Comment> commentList) {
		this.commentList = commentList;
	}
	/**
	 * @return the commentId
	 */
	public String getCommentId() {
		return commentId;
	}
	/**
	 * @param commentId the commentId to set
	 */
	public void setCommentId(String commentId) {
		this.commentId = commentId;
	}
	/**
	 * @return the user_id
	 */
	public String getUser_id() {
		return user_id;
	}
	/**
	 * @param user_id the user_id to set
	 */
	public void setUser_id(String user_id) {
		this.user_id = user_id;
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
