package org.iiitb.facebook.dao;

public interface UserImageUploadDAO {
	
	public boolean uploadImage(String uploadDate,int albumId,String picName);
	
	public String getAlbumName(int albumID);
	
	public int getAlbumId(String albumName,int userId);

	public int getGroupAlbumId(String string, int parseInt);

	public boolean updateCoverphoto(String userId, String picFileName);
	
	public boolean updateProfilephoto(String userId, String picFileName);
	
	public String getprofilePhoto(String userId);
	
	public String getcoverPhoto(String userId);
	
	

}
