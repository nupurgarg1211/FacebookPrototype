package org.iiitb.facebook.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import org.iiitb.facebook.dao.NewsFeedDAO;
import org.iiitb.facebook.model.Comment;
import org.iiitb.facebook.model.Like;
import org.iiitb.facebook.model.Post;
import org.iiitb.facebook.util.ConnectionPool;
import org.iiitb.facebook.util.PhotoUtil;
import org.iiitb.facebook.util.StringUtils;


public class NewsFeedDAOImpl implements NewsFeedDAO{

	public String getNewsQuery="select *  from user_post where user_from IN(select user_id2 from user_friends where user_id1=?) or user_from=? order by post_date desc";
	public String getUserNewsQuery="select *  from user_post where user_to =? order by post_date desc";
	public String getUserName="select first_name,last_name from user where user_id=?";
	public String getLikeCount="select count(*) as count from user_post_like where post_id=?";
	public String getCommentCount="select count(*) as count from user_post_comment where post_id=?";
	public String getAllLike="select * from user_post_like where post_id=?";
	public String getAllComment="select * from user_post_comment where post_id=? order by date desc";
	public String getAllGroupFeeds="select * from group_post where group_to In (select group_id from group_members where user_id=?)";
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
			preStmt.setString(2, userId);
			ResultSet rs=preStmt.executeQuery();
			while(rs.next()){
				p=new Post();
				p.setPostId(rs.getString("user_post_id"));
				p.setPostDesc(rs.getString("post_description"));
				p.setUserFrom(rs.getString("user_from"));
				p.setUserName(getFullUserName(p.getUserFrom()));
				p.setUserTo(rs.getString("user_to"));
				p.setPostDate(rs.getString("post_date"));
				p.setPostType(rs.getString("post_type"));
				p.setPrivacyName(rs.getString("privacy_name"));
				String picPath=StringUtils.RetrivePhotoPath;
				String os=PhotoUtil.getOSName();
				
				System.out.println("NewsFeed-->"+picPath);
				if(rs.getString("pic_name")!=null){
						picPath=picPath+"/"+rs.getString("user_from")+"_"+rs.getString("album_name")+"/"+rs.getString("pic_name");
				}else{
					picPath=null;
				}
				System.out.println("NewsFeed-->"+picPath);
				p.setUserProfilePic(profilePicPath(p.getUserFrom()));
				p.setPicPath(picPath);
				p.setYouTubeLink(rs.getString("youtube_video_link"));
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
		
//		try
//		{	
//			preStmt = conn.prepareStatement(getAllGroupFeeds);
//			preStmt.setString(1,userId);
//			ResultSet rs=preStmt.executeQuery();
//			while(rs.next()){
//				p=new Post();
//				p.setPostId(rs.getString("group_post_id"));
//				p.setPostDesc(rs.getString("post_description"));
//				p.setUserFrom(rs.getString("user_from"));
//				p.setUserName(getFullUserName(p.getUserFrom()));
//				p.setUserTo(rs.getString("group_to"));
//				p.setPostDate(rs.getString("post_date"));
//				p.setPostType(rs.getString("post_type"));
//				String picPath=StringUtils.RetrivePhotoPath;
//				String os=PhotoUtil.getOSName();
//				if(rs.getString("pic_name")!=null){
//						picPath=picPath+"/"+rs.getString("user_from")+"_"+rs.getString("album_name")+"/"+rs.getString("pic_name");
//				}else{
//					picPath=null;
//				}
//				p.setUserProfilePic(profilePicPath(p.getUserFrom()));
//				p.setPicPath(picPath);
//				p.setYouTubeLink(rs.getString("youtube_video_link"));
//				p.setLikeCount(getPostLikeCount(p.getPostId()));
//				p.setLikeList(getAllPostLike(p.getPostId()));
//				p.setCommentCount(getCommentCount(p.getPostId()));
//				p.setCommentList(getAllPostComment(p.getPostId()));
//				feedList.add(p);
//			}
//		}
//		catch (SQLException e)
//		{
//			e.printStackTrace();
//		} finally
//		{
//			ConnectionPool.freeConnection(conn);
//		}
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
				p.setPostId(rs.getString("user_post_id"));
				p.setPostDesc(rs.getString("post_description"));
				p.setUserFrom(rs.getString("user_from"));
				p.setUserName(getFullUserName(p.getUserFrom()));
				p.setUserTo(rs.getString("user_to"));
				p.setPostDate(rs.getString("post_date"));
				p.setPostType(rs.getString("post_type"));
				p.setPrivacyName(rs.getString("privacy_name"));
				String picPath=StringUtils.RetrivePhotoPath;
				String os=PhotoUtil.getOSName();
				if(rs.getString("pic_name")!=null){
						picPath=picPath+"/"+rs.getString("user_to")+"_"+rs.getString("album_name")+"/"+rs.getString("pic_name");
				}else{
					picPath=null;
				}
				p.setUserProfilePic(profilePicPath(p.getUserFrom()));
				p.setPicPath(picPath);
				p.setYouTubeLink(rs.getString("youtube_video_link"));
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
		String picPath=StringUtils.RetrivePhotoPath;
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
				l.setCommentId(rs.getString("user_post_comment_id"));
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
	public static  Boolean getJustFriend(String userId1,String userId2){
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		String sql = "select user_id1,user_id2 from user_friends where user_id1 = ? and user_id2 = ?";
		boolean flag=false;
		try
		{	
			preStmt = conn.prepareStatement(sql);
			preStmt.setString(1,userId1);
			preStmt.setString(2, userId2);
			ResultSet rs=preStmt.executeQuery();
			if(rs.next()){
				flag=true;
			}
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		} finally
		{
			ConnectionPool.freeConnection(conn);
		}
		return flag;
	}
	
	public static  ArrayList<String> getPrivacyDetail(){
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		String sql = "select * from privacydetail";
		boolean flag=false;
		ArrayList<String> plist=new ArrayList<String>();
		try
		{	
			preStmt = conn.prepareStatement(sql);
			ResultSet rs=preStmt.executeQuery();
			while(rs.next()){
				plist.add(rs.getString("privacy_name"));
			}
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		} finally
		{
			ConnectionPool.freeConnection(conn);
		}
		return plist;
	}
	
	
	public String checkFriend(String user_from , String user_to)
	{
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		String sql = "select user_id1,user_id2 from user_friends where user_id1 = ? and user_id2 = ?";
		String sql1 = "select user_from,user_to from friends where user_from = ? and user_to = ?";
		String sql2 = "select user_from,user_to from friends where user_from = ? and user_to = ?";
		try
		{
			preStmt = conn.prepareStatement(sql);
			preStmt.setString(1,user_from);
			preStmt.setString(2,user_to);
			ResultSet rs=preStmt.executeQuery();
			if(rs.next())
				return "F";
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
		try
		{
			preStmt = conn.prepareStatement(sql1);
			preStmt.setString(1,user_from);
			preStmt.setString(2,user_to);
			ResultSet rs=preStmt.executeQuery();
			if(rs.next())
				return "P";
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
		try
		{
			preStmt = conn.prepareStatement(sql1);
			preStmt.setString(1,user_to);
			preStmt.setString(2,user_from);
			ResultSet rs=preStmt.executeQuery();
			if(rs.next())
				return "A";
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			ConnectionPool.freeConnection(conn);
		}
		return "N";
	}
	
}
