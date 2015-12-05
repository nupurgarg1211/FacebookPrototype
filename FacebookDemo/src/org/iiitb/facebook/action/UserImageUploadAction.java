package org.iiitb.facebook.action;
import java.io.File;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.iiitb.facebook.dao.GroupDAO;
import org.iiitb.facebook.dao.LoginDAO;
import org.iiitb.facebook.dao.NewsFeedDAO;
import org.iiitb.facebook.dao.UserPostDAO;
import org.iiitb.facebook.dao.UserImageUploadDAO;
import org.iiitb.facebook.dao.ViewImageDAO;
import org.iiitb.facebook.dao.impl.GroupDAOImpl;
import org.iiitb.facebook.dao.impl.LoginDAOimpl;
import org.iiitb.facebook.dao.impl.NewsFeedDAOImpl;
import org.iiitb.facebook.dao.impl.UserPostDAOImpl;
import org.iiitb.facebook.dao.impl.UserImageUploadDAOImpl;
import org.iiitb.facebook.dao.impl.ViewImageDAOImpl;
import org.iiitb.facebook.model.Group;
import org.iiitb.facebook.model.Image;
import org.iiitb.facebook.model.Post;
import org.iiitb.facebook.model.User;
import org.iiitb.facebook.util.StringUtils;

import com.opensymphony.xwork2.ActionSupport;

public class UserImageUploadAction  extends ActionSupport{
	
	String friendId;
	private File pic;
	private String picContentType;
	private int albumId;
	private String picFileName;
	public ArrayList<Image> imageList;
	private ArrayList<Group> grpList;
	private Group groupDetail;
	private String group_id;
	public ArrayList<Post> feedList;
	private ArrayList<User> grpMemberList;
	private String user_id;
	
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getGroup_id() {
		return group_id;
	}
	public void setGroup_id(String group_id) {
		this.group_id = group_id;
	}


	
	public ArrayList<Group> getGrpList() {
		return grpList;
	}
	public void setGrpList(ArrayList<Group> grpList) {
		this.grpList = grpList;
	}
	public Group getGroupDetail() {
		return groupDetail;
	}
	public void setGroupDetail(Group groupDetail) {
		this.groupDetail = groupDetail;
	}
	
	public ArrayList<Post> getFeedList() {
		return feedList;
	}
	public void setFeedList(ArrayList<Post> feedList) {
		this.feedList = feedList;
	}
	public ArrayList<User> getGrpMemberList() {
		return grpMemberList;
	}
	public void setGrpMemberList(ArrayList<User> grpMemberList) {
		this.grpMemberList = grpMemberList;
	}
	public ArrayList<Image> getImageList() {
		return imageList;
	}
	public void setImageList(ArrayList<Image> imageList) {
		this.imageList = imageList;
	}
	public int getAlbumId() {
		return albumId;
	}
	public void setAlbumId(int albumId) {
		this.albumId = albumId;
	}
	
	public String getFriendId() {
		return friendId;
	}
	public void setFriendId(String friendId) {
		this.friendId = friendId;
	}
	public File getPic() {
		return pic;
	}
	public void setPic(File pic) {
		this.pic = pic;
	}
	public String getPicContentType() {
		return picContentType;
	}
	public void setPicContentType(String picContentType) {
		this.picContentType = picContentType;
	}
	public String getPicFileName() {
		return picFileName;
	}
	public void setPicFileName(String picFileName) {
		this.picFileName = picFileName;
	}
	public String uploadImage(){
		
		System.out.println("1111"+albumId);
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User user=(User)session.getAttribute("user");
		System.out.println("UserPostAction Photo===>"+picFileName);
		System.out.println("UserPostAction Photo===>"+picContentType);
		System.out.println("UserPostAction Photo===>"+pic);
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	Date dateobj = new Date();
		UserImageUploadDAO up=new UserImageUploadDAOImpl();
		String destpath="";
		String imageExtension="";
		if(picContentType!=null && picContentType.contains("jpeg")){
			imageExtension=".jpeg";
		}else if(picContentType!=null && picContentType.contains("png")){
			imageExtension=".png";
		}else if(picContentType!=null && picContentType.contains("gif")){
			imageExtension=".gif";
		}else if(picContentType!=null && picContentType.contains("jpg")){
			imageExtension=".jpg";
		}
		if (picFileName != null) {
			Random randomGenerator = new Random();
			Integer randomInt = randomGenerator.nextInt(1000000);
			picFileName=randomInt.toString()+imageExtension;
			System.out.println("UserPostAction Photo===>"+picFileName);

			 String name=up.getAlbumName(getAlbumId());
	         destpath= StringUtils.photoPath+File.separator+user.getUserId()+"_"+name;
	        System.out.println("Server path:" + destpath);
	        File destFile = new File(destpath, picFileName);
	        try {
	          FileUtils.copyFile(pic, destFile);
	        } catch (IOException e) {
	          System.out.println("error occurred");
	          e.printStackTrace();
	          return ERROR;
	        }
		}
		//if(friendId==null || friendId=="")
		//{
			user_id = user.getUserId();
			setUser_id(user_id);
			up.uploadImage(df.format(dateobj).toString(),albumId,picFileName);
			Integer aid = albumId;
			HttpServletRequest request = ServletActionContext.getRequest();
			request.setAttribute("albumId", aid.toString());
			request.setAttribute("imageList", imageList);
			
		//}
		//else{
			/*NewsFeedDAOImpl nfd=new NewsFeedDAOImpl();
			String userName=nfd.getFullUserName(friendId);
			
			up.postOnWall(postDesc, user.getUserId(),friendId,  df.format(dateobj).toString(),userName+" status Update","timeline",youtubeLink,picFileName);*/
		//}
		addActionMessage("Content has been posted successfully.");
		return "success";
	}
	
	
public void uploadCoverImage() throws IOException{
		
		System.out.println("1111"+albumId);
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User user=(User)session.getAttribute("user");
		System.out.println("UserPostAction Photo===>"+picFileName);
		System.out.println("UserPostAction Photo===>"+picContentType);
		System.out.println("UserPostAction Photo===>"+pic);
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	Date dateobj = new Date();
		UserImageUploadDAO up=new UserImageUploadDAOImpl();
		
		int albumid=up.getAlbumId("coverPicture", Integer.parseInt(user.getUserId()));
		
		String destpath="";
		String imageExtension="";
		if(picContentType!=null && picContentType.contains("jpeg")){
			imageExtension=".jpeg";
		}else if(picContentType!=null && picContentType.contains("png")){
			imageExtension=".png";
		}else if(picContentType!=null && picContentType.contains("gif")){
			imageExtension=".gif";
		}else if(picContentType!=null && picContentType.contains("jpg")){
			imageExtension=".jpg";
		}
		if (picFileName != null) {
			Random randomGenerator = new Random();
			Integer randomInt = randomGenerator.nextInt(1000000);
			picFileName=randomInt.toString()+imageExtension;
			
			System.out.println("UserPostAction Photo===>"+picFileName);

			 String name="coverPicture";
	         destpath= StringUtils.photoPath+File.separator+user.getUserId()+"_"+name;
	        System.out.println("Server path:" + destpath);
	        File destFile = new File(destpath, picFileName);
	        try {
	          FileUtils.copyFile(pic, destFile);
	        } catch (IOException e) {
	          System.out.println("error occurred");
	          e.printStackTrace();
	          //return ERROR;
	        }
		}
		//if(friendId==null || friendId=="")
		//{
		    up.uploadImage(df.format(dateobj).toString(),albumid,picFileName);
			boolean j=up.updateCoverphoto(user.getUserId(),picFileName);
			LoginDAO ld=new LoginDAOimpl();
			String picPath=StringUtils.RetrivePhotoPath;
			System.out.println("hello1111"+user.getPassword());
			user.setCoverPic(picPath+"/"+user.getUserId()+"_"+"coverPicture"+"/"+picFileName);
			//User user1=ld.isValidUser(user.getUserId(),user.getPassword());
			
			//session.removeAttribute("user");
			//session.setAttribute("user",user);
			//session.setAttribute("login", true);
			
			//System.out.println("helloooooooooooooo"+user1.getUserId()+user1.getCoverPic());
			
			
			
			Integer aid = albumid;
			
			HttpServletRequest request = ServletActionContext.getRequest();
			request.setAttribute("albumId", aid.toString());
			
			//request.setAttribute("imageList", imageList);
			
		//}
		//else{
			/*NewsFeedDAOImpl nfd=new NewsFeedDAOImpl();
			String userName=nfd.getFullUserName(friendId);
			
			up.postOnWall(postDesc, user.getUserId(),friendId,  df.format(dateobj).toString(),userName+" status Update","timeline",youtubeLink,picFileName);*/
		//}
		//addActionMessage("Content has been posted successfully.");
			HttpServletResponse response=ServletActionContext.getResponse();
			response.sendRedirect(StringUtils.hostname+"/FacebookDemo/userNewsFeedAction?user_id="+user.getUserId());
		/*if(j)
		return "success";
		else
			return ERROR;*/
	}


public void uploadProfileImage() throws IOException{
	
	System.out.println("1111"+albumId);
	HttpSession session=ServletActionContext.getRequest().getSession(false);
	User user=(User)session.getAttribute("user");
	System.out.println("UserPostAction Photo===>"+picFileName);
	System.out.println("UserPostAction Photo===>"+picContentType);
	System.out.println("UserPostAction Photo===>"+pic);
	DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	Date dateobj = new Date();
	UserImageUploadDAO up=new UserImageUploadDAOImpl();
	
	int albumid=up.getAlbumId("profilePicture", Integer.parseInt(user.getUserId()));
	
	String destpath="";
	String imageExtension="";
	if(picContentType!=null && picContentType.contains("jpeg")){
		imageExtension=".jpeg";
	}else if(picContentType!=null && picContentType.contains("png")){
		imageExtension=".png";
	}else if(picContentType!=null && picContentType.contains("gif")){
		imageExtension=".gif";
	}else if(picContentType!=null && picContentType.contains("jpg")){
		imageExtension=".jpg";
	}
	if (picFileName != null) {
		Random randomGenerator = new Random();
		Integer randomInt = randomGenerator.nextInt(1000000);
		picFileName=randomInt.toString()+imageExtension;
		
		System.out.println("UserPostAction Photo===>"+picFileName);

		 String name="profilePicture";
         destpath= StringUtils.photoPath+File.separator+user.getUserId()+"_"+name;
        System.out.println("Server path:" + destpath);
        File destFile = new File(destpath, picFileName);
        try {
          FileUtils.copyFile(pic, destFile);
        } catch (IOException e) {
          System.out.println("error occurred");
          e.printStackTrace();
          //return ERROR;
        }
	}
	//if(friendId==null || friendId=="")
	//{
	    up.uploadImage(df.format(dateobj).toString(),albumid,picFileName);
		boolean j=up.updateProfilephoto(user.getUserId(),picFileName);
		LoginDAO ld=new LoginDAOimpl();
		String picPath=StringUtils.RetrivePhotoPath;
		System.out.println("hello1111"+user.getPassword());
		user.setProfilePic(picPath+"/"+user.getUserId()+"_"+"profilePicture"+"/"+picFileName);
		//User user1=ld.isValidUser(user.getUserId(),user.getPassword());
		
		//session.removeAttribute("user");
		//session.setAttribute("user",user);
		//session.setAttribute("login", true);
		
		//System.out.println("helloooooooooooooo"+user1.getUserId()+user1.getCoverPic());
		
		
		
		Integer aid = albumid;
		
		HttpServletRequest request = ServletActionContext.getRequest();
		request.setAttribute("albumId", aid.toString());
		
		//request.setAttribute("imageList", imageList);
		
	//}
	//else{
		/*NewsFeedDAOImpl nfd=new NewsFeedDAOImpl();
		String userName=nfd.getFullUserName(friendId);
		
		up.postOnWall(postDesc, user.getUserId(),friendId,  df.format(dateobj).toString(),userName+" status Update","timeline",youtubeLink,picFileName);*/
	//}
	//addActionMessage("Content has been posted successfully.");
		HttpServletResponse response=ServletActionContext.getResponse();
		response.sendRedirect(StringUtils.hostname+"/FacebookDemo/userNewsFeedAction?user_id="+user.getUserId());
	/*if(j)
	return "success";
	else
		return ERROR;*/
}

	
	
	
public String uploadGroupImage(){
		
		System.out.println("pic upload action............1111111111111111111111111111111"+albumId);
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User user=(User)session.getAttribute("user");
		System.out.println("UserPostAction Photo===>"+picFileName);
		System.out.println("UserPostAction Photo===>"+picContentType);
		System.out.println("UserPostAction Photo===>"+pic);
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	Date dateobj = new Date();
		UserImageUploadDAO up=new UserImageUploadDAOImpl();
		String destpath="";
		String imageExtension="";
		if(picContentType!=null && picContentType.contains("jpeg")){
			imageExtension=".jpeg";
		}else if(picContentType!=null && picContentType.contains("png")){
			imageExtension=".png";
		}else if(picContentType!=null && picContentType.contains("gif")){
			imageExtension=".gif";
		}else if(picContentType!=null && picContentType.contains("jpg")){
			imageExtension=".jpg";
		}
		if (picFileName != null) {
			Random randomGenerator = new Random();
			Integer randomInt = randomGenerator.nextInt(1000000);
			picFileName=randomInt.toString()+imageExtension;
			System.out.println("UserPostAction Photo===>"+picFileName);

			 String name=up.getAlbumName(getAlbumId());
	         destpath= StringUtils.groupPhotoPath+File.separator+group_id+"_"+name;
	          System.out.println("Server path:" + destpath);
	        File destFile = new File(destpath, picFileName);
	        try {
	          FileUtils.copyFile(pic, destFile);
	        } catch (IOException e) {
	          System.out.println("error occurred");
	          e.printStackTrace();
	          return ERROR;
	        }
		}
		up.uploadImage(df.format(dateobj).toString(),albumId,picFileName);
		Integer aid = albumId;
		HttpServletRequest request = ServletActionContext.getRequest();
		request.setAttribute("albumId", aid.toString());
		request.setAttribute("imageList", imageList);
		getGroupDetails();
		//addActionMessage("Content has been posted successfully.");
		System.out.println("action pic upload done................................................");
		return "success";
	}


public String getGroupDetails()
{
	GroupDAO grp = new GroupDAOImpl();
	System.out.println("group_id     "+group_id);
	setGroupDetail(null);
	HttpSession session=ServletActionContext.getRequest().getSession(false);
	User u=(User)session.getAttribute("user");
	if(!(group_id == null))
	{
		setGroupDetail(grp.getGroupDetails(group_id, Integer.parseInt(u.getUserId())));
		System.out.println("group id"+groupDetail.getGroup_id());
		System.out.println("group name"+groupDetail.getGroup_name());
	}
	NewsFeedAction n=new NewsFeedAction();
	setGrpList(grp.getAllGroups(Integer.parseInt(u.getUserId())));
	setFeedList(n.getGroupNewsFeed(group_id));
	int i = 0;
	while(i<grpList.size())
	{
		System.out.println(grpList.get(i).getGroup_id());
		i++;
	}
	i=0;
	System.out.println("post..................");
	while(i<feedList.size())
	{
		System.out.println(feedList.get(i).getPostId());
		i++;
	}
	HttpServletRequest request=ServletActionContext.getRequest();
	request.setAttribute("groupDetail",groupDetail);
	request.setAttribute("grpList",grpList);
	request.setAttribute("groupDetail",groupDetail);
	return "success";
	
}
}
