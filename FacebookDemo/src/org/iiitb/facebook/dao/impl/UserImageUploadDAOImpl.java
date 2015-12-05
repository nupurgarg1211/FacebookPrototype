package org.iiitb.facebook.dao.impl;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.iiitb.facebook.dao.UserImageUploadDAO;
import org.iiitb.facebook.util.ConnectionPool;

public class UserImageUploadDAOImpl implements UserImageUploadDAO{
	
	public String nameQuery="select album_name from album where album_id=?";
	
	public String idQuery="select album_id from album where album_name=? and user_id=?";
	
	public String idGroupQuery="select album_id from album where album_name=? and group_id=?";
	
	public String postQuery="insert into photo(album_id,photo_name,date) values (?,?,?)";
	
	public String coverpicQuery="update user set cover_pic=? where user_id=?";
	
	public String profilepicQuery="update user set profile_pic=? where user_id=?";
	
	public String getcoverpicQuery="select cover_pic from user where user_id=?";
	
	public String getprofilepicQuery="select profile_pic from user where user_id=?";
	
	
	
	@Override
	public boolean uploadImage(String uploadDate,int albumId,String picName) {
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		try
		{
			preStmt = conn.prepareStatement(postQuery);
			preStmt.setInt(1,albumId);
			preStmt.setString(2,picName);
			preStmt.setString(3,uploadDate);
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
	public String getAlbumName(int albumID)
	{
		String name=null;
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		ResultSet rs;
		try
		{
			preStmt=conn.prepareStatement(nameQuery);
			preStmt.setInt(1,albumID);
			rs=preStmt.executeQuery();
			if(rs.next())
			{
				name=rs.getString("album_name");
				
			}
			
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			
		}
		return name;
	}
	
	public boolean updateCoverphoto(String userId, String picFileName)
	{
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		try
		{
		 preStmt = conn.prepareStatement(coverpicQuery);
		 preStmt.setString(1,picFileName);
		 preStmt.setInt(2,Integer.parseInt(userId));
		 int n=preStmt.executeUpdate();
			if(n>0)
				return true;
			else
				return false;
		 
		 
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			ConnectionPool.freeConnection(conn);
			
		}
		return true;
		
		
	}
	
	
	public boolean updateProfilephoto(String userId, String picFileName)
	{
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		try
		{
		 preStmt = conn.prepareStatement(profilepicQuery);
		 preStmt.setString(1,picFileName);
		 preStmt.setInt(2,Integer.parseInt(userId));
		 int n=preStmt.executeUpdate();
			if(n>0)
				return true;
			else
				return false;
		 
		 
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			ConnectionPool.freeConnection(conn);
			
		}
		return true;
		
		
	}
	
	
	public int getAlbumId(String albumName,int userId)
	{
		int id=0;
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		ResultSet rs;
		try
		{
			preStmt=conn.prepareStatement(idQuery);
			preStmt.setString(1,albumName);
			preStmt.setInt(2,userId);
			rs=preStmt.executeQuery();
			if(rs.next())
			{
				id=rs.getInt("album_id");
				
			}
			
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			ConnectionPool.freeConnection(conn);
		}
		return id;
	}
	
	public String getcoverPhoto(String userId)
	{
		//int id=0;
		String cover_photo="";
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		ResultSet rs;
		try
		{
			preStmt=conn.prepareStatement(getcoverpicQuery);
			
			preStmt.setInt(1,Integer.parseInt(userId));
			rs=preStmt.executeQuery();
			if(rs.next())
			{
				cover_photo=rs.getString("cover_pic");
				if(cover_photo!=null)
					return cover_photo;
				
			}
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			ConnectionPool.freeConnection(conn);
		}
		return cover_photo;
	}
	
	public String getprofilePhoto(String userId)
	{
		//int id=0;
		String profile_photo="";
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		ResultSet rs;
		try
		{
			preStmt=conn.prepareStatement(getprofilepicQuery);
			
			preStmt.setInt(1,Integer.parseInt(userId));
			rs=preStmt.executeQuery();
			if(rs.next())
			{
				profile_photo=rs.getString("profile_pic");
				if(profile_photo!=null)
					return profile_photo;
				
			}
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			ConnectionPool.freeConnection(conn);
		}
		return profile_photo;
	}
	
	
	public int getGroupAlbumId(String albumName,int group_id)
	{
		int id=0;
		System.out.println("group id in getGroupAlbum"+group_id);
		System.out.println("albumName in getGroupAlbum"+albumName);
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		ResultSet rs;
		try
		{
			preStmt=conn.prepareStatement(idGroupQuery);
			preStmt.setString(1,albumName);
			preStmt.setInt(2,group_id);
			rs=preStmt.executeQuery();
			if(rs.next())
			{
				id=rs.getInt("album_id");
				
			}
			
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			ConnectionPool.freeConnection(conn);
		}
		return id;
	}
	
}
