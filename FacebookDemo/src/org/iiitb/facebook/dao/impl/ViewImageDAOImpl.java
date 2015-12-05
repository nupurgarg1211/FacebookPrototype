package org.iiitb.facebook.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.iiitb.facebook.dao.ViewImageDAO;
import org.iiitb.facebook.model.Image;
import org.iiitb.facebook.model.Post;
import org.iiitb.facebook.util.ConnectionPool;
import org.iiitb.facebook.util.StringUtils;

public class ViewImageDAOImpl implements ViewImageDAO{
	
	public String getImageQuery="select * from photo where album_id=?";
	public String getAlbumName="select user_id,album_name from album where album_id=?";
	
	public ArrayList<Image> getImages(int albumId)
	{
		Connection conn = ConnectionPool.getConnection();
		PreparedStatement preStmt;
		Image i=null;
		ArrayList<Image> imageList=new ArrayList<Image>();
		try
		{
			preStmt = conn.prepareStatement(getImageQuery);
			preStmt.setInt(1,albumId);
			ResultSet rs=preStmt.executeQuery();
			while(rs.next())
			{
				i=new Image();
				String picPath=StringUtils.RetrivePhotoPath;
				if(rs.getString("photo_name")!=null){
					Connection conn1 = ConnectionPool.getConnection();
					PreparedStatement preStmt1=conn1.prepareStatement(getAlbumName);
					preStmt1.setInt(1, albumId);
					ResultSet rs1=preStmt1.executeQuery();
					String album_name=null;
					String user_id=null;
					if(rs1.next())
					{
						album_name=rs1.getString("album_name");
						user_id=(rs1.getString("user_id"));
					}
					
					
					picPath=picPath+"/"+user_id+"_"+album_name+"/"+rs.getString("photo_name");
			}else{
				picPath=null;
			}
				i.setPath(picPath);
				i.setAlbumId(rs.getInt("album_id"));
				i.setDate(rs.getString("date"));
				imageList.add(i);
				
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
		return imageList;
	}

}
