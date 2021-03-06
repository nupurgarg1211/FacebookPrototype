package org.iiitb.facebook.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.iiitb.facebook.dao.UserPostDAO;
import org.iiitb.facebook.model.User;
import org.iiitb.facebook.util.ConnectionPool;

public class UserPostDAOImpl implements UserPostDAO{

	public String postQuery="insert into user_post(post_description,user_from,user_to,post_date,post_type,album_name,youtube_video_link,pic_name,privacy_name) values(?,?,?,?,?,?,?,?,?)";
	public String postQuery1="insert into user_post(post_description,user_from,user_to,post_date,post_type,album_name,youtube_video_link,pic_name) values(?,?,?,?,?,?,?,?)";
	public String increaseLikeQuery="insert into user_post_like(post_id,user_id,date) values(?,?,?)";
	public String deleteLike="delete from user_post_like where post_id=? and user_id=?";
	public String addCommentQuery="insert into user_post_comment(post_id,user_id,date,comment) values(?,?,?,?)";
	public String deletePostQuery="delete from user_post where user_post_id=?";
	public String updatePostQuery="update user_post set post_description=? where user_post_id=?";
	public String updateCommentQuery="update user_post_comment set comment=? where user_post_comment_id=?";
	public String deleteCommentQuery="delete from user_post_comment where user_post_comment_id=?";
	public String postUserQuery="select * from user_post where user_post_id=?";
	
	@Override
	public boolean postOnWall(String postDesc, String userFrom, String userTo,String postDate,String postType,String albumName,String youTube,String picName,String privacyName) {
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		try
		{
			preStmt = conn.prepareStatement(postQuery);
			preStmt.setString(1, postDesc);
			preStmt.setString(2, userFrom);
			preStmt.setString(3, userTo);
			preStmt.setString(4, postDate);
			preStmt.setString(5, postType);
			preStmt.setString(6, albumName);
			preStmt.setString(7, youTube);
			preStmt.setString(8, picName);
			preStmt.setString(9, privacyName);
			int n=preStmt.executeUpdate();
			
			if(n>0)
				return true;
			else
				return false;
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		} finally
		{
			ConnectionPool.freeConnection(conn);
		}
		return true;
	}
	
	public boolean updatePrivacySetting(String privacyName,String postId){
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		try
		{
			String sql="update user_post set privacy_name=? where user_post_id=?";
			preStmt = conn.prepareStatement(sql);
			preStmt.setString(1, privacyName);
			preStmt.setString(2, postId);
			int n=preStmt.executeUpdate();
			if(n>0)
				return true;
			else
				return false;
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		} finally
		{
			ConnectionPool.freeConnection(conn);
		}
		return true;
	}
	
	public boolean updateAlbumPrivacySetting(String privacyName,String postId){
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		try
		{
			String sql="update album set privacy_name=? where album_id=?";
			preStmt = conn.prepareStatement(sql);
			preStmt.setString(1, privacyName);
			preStmt.setString(2, postId);
			int n=preStmt.executeUpdate();
			if(n>0)
				return true;
			else
				return false;
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		} finally
		{
			ConnectionPool.freeConnection(conn);
		}
		return true;
	}
	public boolean updateAllPrivacySetting(String privacyName,String postId){
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		try
		{
			String sql="update privacysetting set privacy_name=? where privacyId=?";
			preStmt = conn.prepareStatement(sql);
			preStmt.setString(1, privacyName);
			preStmt.setString(2, postId);
			int n=preStmt.executeUpdate();
			if(n>0)
				return true;
			else
				return false;
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		} finally
		{
			ConnectionPool.freeConnection(conn);
		}
		return true;
	}
	
	
	public boolean increaseLike(String postId,String postUserId,String date,String likeType){
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		try
		{
			if(likeType!=null && likeType.equalsIgnoreCase("U")){
				preStmt = conn.prepareStatement(deleteLike);
			}else{
				preStmt = conn.prepareStatement(increaseLikeQuery);
				preStmt.setString(3, date);
			}
			preStmt.setString(1, postId);
			preStmt.setString(2, postUserId);
			
			int n=preStmt.executeUpdate();
			if(n>0)
				return true;
			else
				return false;
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		} finally
		{
			ConnectionPool.freeConnection(conn);
		}
		return true;
	}
	
	public boolean addComment(String postId,String postUserId,String date,String comment){
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		try
		{
			preStmt = conn.prepareStatement(addCommentQuery);
			preStmt.setString(1, postId);
			preStmt.setString(2, postUserId);
			preStmt.setString(3, date);
			preStmt.setString(4, comment);
			int n=preStmt.executeUpdate();
			if(n>0)
				return true;
			else
				return false;
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		} finally
		{
			ConnectionPool.freeConnection(conn);
		}
		return true;
	}
	public boolean deletePost(String postId){
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		try
		{
			preStmt = conn.prepareStatement(deletePostQuery);
			preStmt.setString(1, postId);
			int n=preStmt.executeUpdate();
			if(n>0)
				return true;
			else
				return false;
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		} finally
		{
			ConnectionPool.freeConnection(conn);
		}
		return true;
	}
	public boolean deleteComment(String commentId){
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		try
		{
			preStmt = conn.prepareStatement(deleteCommentQuery);
			preStmt.setString(1, commentId);
			int n=preStmt.executeUpdate();
			if(n>0)
				return true;
			else
				return false;
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		} finally
		{
			ConnectionPool.freeConnection(conn);
		}
		return true;
	}
	
	public boolean updatePost(String postId,String comment){
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		try
		{
			preStmt = conn.prepareStatement(updatePostQuery);
			preStmt.setString(1, comment);
			preStmt.setString(2, postId);
			int n=preStmt.executeUpdate();
			if(n>0)
				return true;
			else
				return false;
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		} finally
		{
			ConnectionPool.freeConnection(conn);
		}
		return true;
		
	}
	public boolean updateComment(String commentId,String comment){
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		try
		{
			preStmt = conn.prepareStatement(updateCommentQuery);
			preStmt.setString(1, comment);
			preStmt.setString(2, commentId);
			int n=preStmt.executeUpdate();
			if(n>0)
				return true;
			else
				return false;
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		} finally
		{
			ConnectionPool.freeConnection(conn);
		}
		return true;
		
	}
	public User getPostUserId(String postid){
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		User u=new User();
		String userId="";
		String userName="";
		try
		{
			preStmt = conn.prepareStatement(postUserQuery);
			preStmt.setString(1, postid);
			ResultSet rs=preStmt.executeQuery();
			if(rs.next())
				u.setUserId(rs.getString("user_from"));
			NewsFeedDAOImpl nf=new NewsFeedDAOImpl();
			u.setFirstName(nf.getFullUserName(userId));
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		} finally
		{
			ConnectionPool.freeConnection(conn);
		}
		return u;
		
	}
	
}
