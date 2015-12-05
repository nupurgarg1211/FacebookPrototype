package org.iiitb.facebook.action;

import org.iiitb.facebook.dao.NewsFeedDAO;
import org.iiitb.facebook.dao.impl.NewsFeedDAOImpl;
import org.iiitb.facebook.dao.impl.UserImageUploadDAOImpl;
import org.iiitb.facebook.util.StringUtils;


public class TimelineHeaderAction
{
	public String checkFriend(String user_from , String user_to)
	{
		NewsFeedDAO nf1=new NewsFeedDAOImpl();
		if(user_from.equals(user_to))
			return "S";
		else
			return (nf1.checkFriend(user_from, user_to));
	}
	public String getProfilePic(String user_id)
	{
		String picPath=StringUtils.RetrivePhotoPath;
		UserImageUploadDAOImpl ip=new UserImageUploadDAOImpl();
		String profile_pic=picPath+"/"+user_id+"_"+"profilePicture"+"/"+ip.getprofilePhoto(user_id);
		return profile_pic;	
	}
	public String getCoverPic(String user_id)
	{
		String picPath=StringUtils.RetrivePhotoPath;
		UserImageUploadDAOImpl ip=new UserImageUploadDAOImpl();
		String cover_pic=picPath+"/"+user_id+"_"+"coverPicture"+"/"+ip.getcoverPhoto(user_id);
		return cover_pic;
	}
	public String getFullName(String user_id)
	{
		NewsFeedDAOImpl nf1=new NewsFeedDAOImpl();
		return nf1.getFullUserName(user_id);
	}
}
