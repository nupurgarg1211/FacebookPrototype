package org.iiitb.facebook.dao;

import java.util.ArrayList;

import org.iiitb.facebook.model.Album;
import org.iiitb.facebook.model.Post;

public interface AlbumDAO {
	
	public ArrayList<Album> getAlbum(String userId);
	
	public boolean createAlbum(String album_name,String user_id,String date);
	

}
