package org.iiitb.facebook.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.iiitb.facebook.dao.EventPostDAO;
import org.iiitb.facebook.util.ConnectionPool;

public class EventPostDAOImpl implements EventPostDAO {
	
	public String postQuery="insert into event_post(post_description,user_from,event_to,post_date,pic_path) values(?,?,?,?,?)";
	public String increaseLikeQuery="insert into event_post_like(post_id,user_id,date) values(?,?,?)";
	public String deleteLike="delete from event_post_like where post_id=? and user_id=?";
	public String addCommentQuery="insert into event_post_comment(post_id,user_id,date,comment) values(?,?,?,?)";
	public String deletePostQuery="delete from event_post where event_post_id=?";
	public String updatePostQuery="update event_post set post_description=? where event_post_id=?";
	public String updateCommentQuery="update event_post_comment set comment=? where event_post_comment_id=?";
	public String deleteCommentQuery="delete from event_post_comment where event_post_comment_id=?";
	
	@Override
	public boolean postOnWall(String postDesc, String userFrom, String userTo,String postDate,String picName) {
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		try
		{
			preStmt = conn.prepareStatement(postQuery);
			preStmt.setString(1, postDesc);
			preStmt.setString(2, userFrom);
			preStmt.setString(3, userTo);
			preStmt.setString(4, postDate);
			preStmt.setString(5, picName);
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
}
