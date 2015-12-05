package org.iiitb.facebook.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.iiitb.facebook.dao.AlbumDAO;
import org.iiitb.facebook.model.Album;
import org.iiitb.facebook.util.ConnectionPool;
import org.iiitb.facebook.util.PhotoUtil;
import org.iiitb.facebook.util.StringUtils;

public class AlbumDAOImpl implements AlbumDAO
{
	public ArrayList<Album> getAlbum(String userId)
	{
		String getAlbumQuery="select * from album where user_id=?";
		ArrayList<Album> albums=new ArrayList<Album>();
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		Album a=null;
		try
		{
		 preStmt = conn.prepareStatement(getAlbumQuery);
		 int uid=Integer.parseInt(userId);
		 preStmt.setInt(1,uid);
		 ResultSet rs=preStmt.executeQuery();
			while(rs.next()){
				a=new Album();
				a.setAlbumId(rs.getInt("album_id"));
				a.setAlbumName(rs.getString("album_name"));
				a.setDate(rs.getString("date"));
				a.setGroupId(rs.getInt("group_id"));
				a.setUserId(rs.getInt("user_id"));
				a.setPrivacyName(rs.getString("privacy_name"));
				albums.add(a);	
			}
			
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		} finally
		{
			ConnectionPool.freeConnection(conn);
		}
		
		return albums;
	}
	public boolean createAlbum(String album_name,String user_id,String date)
	{
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		String sql="insert into album(album_name,user_id,date) values(?,?,?)";
		try
		{
			preStmt = conn.prepareStatement(sql);
			preStmt.setString(1,album_name);
			preStmt.setString(2, user_id);
			preStmt.setString(3, date);
			int n=preStmt.executeUpdate();
			if(n>0){
				return true;
			}
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		} finally
		{
			ConnectionPool.freeConnection(conn);
		}
		return false;
	}
}
