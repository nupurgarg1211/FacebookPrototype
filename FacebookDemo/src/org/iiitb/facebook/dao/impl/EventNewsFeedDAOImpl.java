package org.iiitb.facebook.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.iiitb.facebook.dao.EventNewsFeedDAO;
import org.iiitb.facebook.model.Comment;
import org.iiitb.facebook.model.Like;
import org.iiitb.facebook.model.Post;
import org.iiitb.facebook.util.ConnectionPool;
import org.iiitb.facebook.util.PhotoUtil;
import org.iiitb.facebook.util.StringUtils;

public class EventNewsFeedDAOImpl implements EventNewsFeedDAO {
	public String getNewsQuery="select *  from event_post where user_from=? order by post_date desc";
	public String getUserNewsQuery="select *  from event_post where event_to =? order by post_date desc";
	public String getUserName="select first_name,last_name from user where user_id=?";
	public String getLikeCount="select count(*) as count from event_post_like where post_id=?";
	public String getCommentCount="select count(*) as count from event_post_comment where post_id=?";
	public String getAllLike="select * from event_post_like where post_id=?";
	public String getAllComment="select * from event_post_comment where post_id=? order by date desc";
	
	@Override
	public ArrayList<Post> getNewsFeed(String userId) {
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		Post p=null;
		ArrayList<Post> feedList=new ArrayList<Post>();
		
		try
		{	
			preStmt = conn.prepareStatement(getNewsQuery);
			preStmt.setString(1,userId);
			//preStmt.setString(2, userId);
			ResultSet rs=preStmt.executeQuery();
			while(rs.next()){
				p=new Post();
				p.setPostId(rs.getString("event_post_id"));
				p.setPostDesc(rs.getString("post_description"));
				p.setUserFrom(rs.getString("user_from"));
				p.setUserName(getFullUserName(p.getUserFrom()));
				p.setUserTo(rs.getString("event_to"));
				p.setPostDate(rs.getString("post_date"));
				String picPath=StringUtils.eventRetrivePhotoPath;
				String os=PhotoUtil.getOSName();
				if(rs.getString("pic_name")!=null){
						picPath=picPath+"/"+rs.getString("event_id")+"_"+rs.getString("album_name")+"/"+rs.getString("pic_name");
				}else{
					picPath=null;
				}
				p.setUserProfilePic(profilePicPath(p.getUserFrom()));
				p.setPicPath(picPath);
				p.setLikeCount(getPostLikeCount(p.getPostId()));
				p.setLikeList(getAllPostLike(p.getPostId()));
				p.setCommentCount(getCommentCount(p.getPostId()));
				p.setCommentList(getAllPostComment(p.getPostId()));
				feedList.add(p);
			}
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		} finally
		{
			ConnectionPool.freeConnection(conn);
		}
	
		return feedList;
	}
	
	public ArrayList<Post> getUserNewsFeed(String userId) 
	{
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		Post p=null;
		ArrayList<Post> feedList=new ArrayList<Post>();
		
		try
		{	
			preStmt = conn.prepareStatement(getUserNewsQuery);
			preStmt.setString(1,userId);
			ResultSet rs=preStmt.executeQuery();
			while(rs.next()){
				p=new Post();
				p.setPostId(rs.getString("event_post_id"));
				p.setPostDesc(rs.getString("post_description"));
				p.setUserFrom(rs.getString("user_from"));
				p.setUserName(getFullUserName(p.getUserFrom()));
				p.setUserTo(rs.getString("event_to"));
				p.setPostDate(rs.getString("post_date"));
				String picPath=StringUtils.eventRetrivePhotoPath;
				String os=PhotoUtil.getOSName();
				/*if(rs.getString("pic_name")!=null){
						picPath=picPath+"/"+rs.getString("event_id")+"_"+rs.getString("album_name")+"/"+rs.getString("pic_name");
				}else{
					picPath=null;
				}
				p.setUserProfilePic(profilePicPath(p.getUserFrom()));
				p.setPicPath(picPath);*/
				p.setLikeCount(getPostLikeCount(p.getPostId()));
				p.setLikeList(getAllPostLike(p.getPostId()));
				p.setCommentCount(getCommentCount(p.getPostId()));
				p.setCommentList(getAllPostComment(p.getPostId()));
				feedList.add(p);
			}
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		} finally
		{
			ConnectionPool.freeConnection(conn);
		}
		return feedList;
	}
	public String getPostLikeCount(String postId){
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		Post p=null;
		ArrayList<Post> feedList=new ArrayList<Post>();
		String likecount="";
		try
		{	
			preStmt = conn.prepareStatement(getLikeCount);
			preStmt.setString(1,postId);
			ResultSet rs=preStmt.executeQuery();
			if(rs.next()){
				likecount=rs.getString("count");
			}
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		} finally
		{
			ConnectionPool.freeConnection(conn);
		}
		return likecount;
	}
	public String getCommentCount(String postId){
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		String commentcount="";
		try
		{	
			preStmt = conn.prepareStatement(getCommentCount);
			preStmt.setString(1,postId);
			ResultSet rs=preStmt.executeQuery();
			if(rs.next()){
				commentcount=rs.getString("count");
			}
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		} finally
		{
			ConnectionPool.freeConnection(conn);
		}
		return commentcount;
	}
	public String profilePicPath(String userId){
		String picPath=StringUtils.eventRetrivePhotoPath;
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		String profilePic="";
		String getProfilePicName="select * from user where user_id=?";
		try
		{	
			preStmt = conn.prepareStatement(getProfilePicName);
			preStmt.setString(1,userId);
			ResultSet rs=preStmt.executeQuery();
			boolean flag=false;
			if(rs.next()){
				profilePic=rs.getString("profile_pic");
				flag=true;
			}
			picPath=picPath+"/"+userId+"_"+"profilePicture"+"/"+profilePic;
			if(flag)
				return picPath;
			else
				return null;
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		} finally
		{
			ConnectionPool.freeConnection(conn);
		}
		return null;
		
	}
	public ArrayList<Like> getAllPostLike(String postId){
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		
		ArrayList<Like> likeList=new ArrayList<Like>();
		Like l=null;
		try
		{	
			preStmt = conn.prepareStatement(getAllLike);
			preStmt.setString(1,postId);
			ResultSet rs=preStmt.executeQuery();
			while(rs.next()){
				l=new Like();
				l.setUserId(rs.getString("user_id"));
				l.setUserName(getFullUserName(l.getUserId()));
				l.setDate(rs.getString("date"));
				l.setPicPath(profilePicPath(rs.getString("user_id")));
				likeList.add(l);
			}
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		} finally
		{
			ConnectionPool.freeConnection(conn);
		}
		return likeList;
	}
	public ArrayList<Comment> getAllPostComment(String postId){
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		
		ArrayList<Comment> commentList=new ArrayList<Comment>();
		Comment l=null;
		try
		{	
			preStmt = conn.prepareStatement(getAllComment);
			preStmt.setString(1,postId);
			ResultSet rs=preStmt.executeQuery();
			while(rs.next()){
				l=new Comment();
				l.setCommentId(rs.getString("event_post_comment_id"));
				l.setUserId(rs.getString("user_id"));
				l.setUserName(getFullUserName(l.getUserId()));
				l.setDate(rs.getString("date"));
				l.setComment(rs.getString("comment"));
				l.setPicPath(profilePicPath(rs.getString("user_id")));
				commentList.add(l);
			}
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		} finally
		{
			ConnectionPool.freeConnection(conn);
		}
		return commentList;
	}
	public String getFullUserName(String userId){
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		String userName="";
		try
		{	
			preStmt = conn.prepareStatement(getUserName);
			preStmt.setString(1,userId);
			ResultSet rs=preStmt.executeQuery();
			if(rs.next()){
				userName=rs.getString("first_name")+" "+rs.getString("last_name");
			}
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		} finally
		{
			ConnectionPool.freeConnection(conn);
		}
		return userName;
	}
	
	
}
