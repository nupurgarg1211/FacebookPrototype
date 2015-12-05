package org.iiitb.facebook.action;

import java.io.File;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.iiitb.facebook.dao.LoginDAO;
import org.iiitb.facebook.dao.NewsFeedDAO;
import org.iiitb.facebook.dao.UserImageUploadDAO;
import org.iiitb.facebook.dao.UserPostDAO;
import org.iiitb.facebook.dao.impl.LoginDAOimpl;
import org.iiitb.facebook.dao.impl.NewsFeedDAOImpl;
import org.iiitb.facebook.dao.impl.UserImageUploadDAOImpl;
import org.iiitb.facebook.dao.impl.UserPostDAOImpl;
import org.iiitb.facebook.model.Comment;
import org.iiitb.facebook.model.Like;
import org.iiitb.facebook.model.Post;
import org.iiitb.facebook.model.User;
import org.iiitb.facebook.util.StringUtils;

import com.mongodb.util.Hash;
import com.opensymphony.xwork2.ActionSupport;

public class UserPostAction extends ActionSupport{
	String postDesc;
	String friendId;
	private File pic;
	private String picContentType;
	private String picFileName;
	private String youtubeLink;
	private String postId;
	private String postUserId;
	private String comment;
	private String liketype;
	private String pcount;
	private String queryType;
	private ArrayList<Like> likeList;
	private ArrayList<Comment> commentList;
	private String commentId;
	private String user_id;
	private String privacyName;
	
	public String getPrivacyName() {
		return privacyName;
	}

	public void setPrivacyName(String privacyName) {
		this.privacyName = privacyName;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getCommentId() {
		return commentId;
	}

	public void setCommentId(String commentId) {
		this.commentId = commentId;
	}

	public ArrayList<Comment> getCommentList() {
		return commentList;
	}

	public void setCommentList(ArrayList<Comment> commentList) {
		this.commentList = commentList;
	}

	public String getQueryType() {
		return queryType;
	}

	public void setQueryType(String queryType) {
		this.queryType = queryType;
	}

	public ArrayList<Like> getLikeList() {
		return likeList;
	}

	public void setLikeList(ArrayList<Like> likeList) {
		this.likeList = likeList;
	}

	public String getPcount() {
		return pcount;
	}

	public void setPcount(String pcount) {
		this.pcount = pcount;
	}

	public String getLiketype() {
		return liketype;
	}

	public void setLiketype(String liketype) {
		this.liketype = liketype;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public String getPostId() {
		return postId;
	}

	public void setPostId(String postId) {
		this.postId = postId;
	}

	public String getPostUserId() {
		return postUserId;
	}

	public void setPostUserId(String postUserId) {
		this.postUserId = postUserId;
	}

	public String getYoutubeLink() {
		return youtubeLink;
	}

	public void setYoutubeLink(String youtubeLink) {
		this.youtubeLink = youtubeLink;
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

	public String getPostDesc() {
		return postDesc;
	}


	public void setPostDesc(String postDesc) {
		this.postDesc = postDesc;
	}


	public String getFriendId() {
		return friendId;
	}

	public void setFriendId(String friendId) {
		this.friendId = friendId;
	}

	public String postOnWall() throws IOException{
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User user=(User)session.getAttribute("user");
		System.out.println("UserPostAction Photo===>"+picFileName);
		System.out.println("UserPostAction Photo===>"+picContentType);
		System.out.println("UserPostAction Photo===>"+pic);
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
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	Date dateobj = new Date();
		UserPostDAO up=new UserPostDAOImpl();
		String destpath="";
		if (picFileName != null) {
                 Random randomGenerator = new Random();
				 Integer randomInt = randomGenerator.nextInt(1000000);
				 picFileName=randomInt.toString()+imageExtension;
	         destpath= StringUtils.photoPath+File.separator+user.getUserId()+"_timeline";
	        System.out.println("Server path:" + destpath);
	        File destFile = new File(destpath, picFileName);
	        try {
	          FileUtils.copyFile(pic, destFile);

	          //if(friendId==null || friendId=="")

                  
	        	  UserImageUploadDAO imu=new UserImageUploadDAOImpl();
	        	  int albumId=imu.getAlbumId("timeline",Integer.parseInt(user.getUserId()));
	        	  imu.uploadImage(df.format(dateobj).toString(),albumId,picFileName);
	          
	          /*else
	          {
	        	  UserImageUploadDAO imu=new UserImageUploadDAOImpl();
	        	  int albumId=imu.getAlbumId("timeline",Integer.parseInt(friendId));
	        	  imu.uploadImage(df.format(dateobj).toString(),albumId,picFileName);
	          }*/
	          
	        } catch (IOException e) {
	          System.out.println("error occurred");
	          e.printStackTrace();
	          return ERROR;
	        }
		}
		NewsFeedDAOImpl nf=new NewsFeedDAOImpl();
		if(friendId==null || friendId==""){
			up.postOnWall(postDesc, user.getUserId(), user.getUserId(),  df.format(dateobj).toString(),user.getFirstName()+" "+user.getLastName()+" Status Update","timeline",youtubeLink,picFileName,privacyName);
		}else{
			NewsFeedDAOImpl nfd=new NewsFeedDAOImpl();
			String userName=nfd.getFullUserName(friendId);
			up.postOnWall(postDesc, user.getUserId(),friendId,  df.format(dateobj).toString(),nf.getFullUserName(friendId)+" status Update","timeline",youtubeLink,picFileName,privacyName);
		}
		addActionMessage("Content has been posted successfully.");
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		response.sendRedirect(StringUtils.hostname+"/FacebookDemo/newsFeedAction");
		return "success";
	}
	public String postOnUserWall() throws IOException{
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User user=(User)session.getAttribute("user");
		
		user_id = (String)session.getAttribute("tempUserId");
		
		System.out.println("UserPostAction Photo===>"+picFileName);
		System.out.println("UserPostAction Photo===>"+picContentType);
		System.out.println("UserPostAction Photo===>"+pic);
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
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	Date dateobj = new Date();
		UserPostDAO up=new UserPostDAOImpl();
		String destpath="";
		Random randomGenerator = new Random();
		 Integer randomInt = randomGenerator.nextInt(1000000);
		if (picFileName != null) 
		{
                 
				 picFileName=randomInt.toString()+imageExtension;
	         destpath= StringUtils.photoPath+File.separator+user_id+"_timeline";
	        System.out.println("Server path:" + destpath);
	        File destFile = new File(destpath, picFileName);
	        try {
	          FileUtils.copyFile(pic, destFile);

	          //if(friendId==null || friendId=="")

                  
	        	  UserImageUploadDAO imu=new UserImageUploadDAOImpl();
	        	  int albumId=imu.getAlbumId("timeline",Integer.parseInt(user_id));
	        	  imu.uploadImage(df.format(dateobj).toString(),albumId,picFileName);
	          
	          /*else
	          {
	        	  UserImageUploadDAO imu=new UserImageUploadDAOImpl();
	        	  int albumId=imu.getAlbumId("timeline",Integer.parseInt(friendId));
	        	  imu.uploadImage(df.format(dateobj).toString(),albumId,picFileName);
	          }*/
	          
	        } catch (IOException e) {
	          System.out.println("error occurred");
	          e.printStackTrace();
	          return ERROR;
	        }
		}
		NewsFeedDAOImpl nf=new NewsFeedDAOImpl();
		//if(user_id==null || user_id==""){
			//up.postOnWall(postDesc, user.getUserId(), user_id,  df.format(dateobj).toString(),nf.getFullUserName(user_id)+" Status Update","timeline",youtubeLink,picFileName);
		//}else{
			NewsFeedDAOImpl nfd=new NewsFeedDAOImpl();
			String userName=nfd.getFullUserName(user_id);
			if(user.getUserId().equalsIgnoreCase(user_id)){
				up.postOnWall(postDesc, user.getUserId(), user_id,  df.format(dateobj).toString(),nf.getFullUserName(user_id)+" Status Update","timeline",youtubeLink,picFileName,privacyName);
			}else{
				up.postOnWall(postDesc, user.getUserId(), user_id,  df.format(dateobj).toString(),nf.getFullUserName(user.getUserId())+" posted on "+nf.getFullUserName(user_id)+" wall","timeline",youtubeLink,picFileName,privacyName);
				//up.postOnWall(postDesc, user_id, user.getUserId(),  df.format(dateobj).toString(),nf.getFullUserName(user.getUserId())+" posted on "+nf.getFullUserName(user_id)+" wall","timeline",youtubeLink,picFileName);
				
				AllNotificationAction aln=new AllNotificationAction();
				aln.addNotification("post", user.getUserId(), user_id, nf.getFullUserName(user.getUserId())+" has posted on your wall", "userNewsFeedAction?user_id="+user.getUserId(), df.format(dateobj));
				if (picFileName != null) 
				{
		                
						 picFileName=randomInt.toString()+imageExtension;
			         destpath= StringUtils.photoPath+"/"+user.getUserId()+"_timeline";
			        System.out.println("Server path:" + destpath);
			        File destFile = new File(destpath, picFileName);
			        try {
			          FileUtils.copyFile(pic, destFile);

			          //if(friendId==null || friendId=="")

		                  
			        	  UserImageUploadDAO imu=new UserImageUploadDAOImpl();
			        	  int albumId=imu.getAlbumId("timeline",Integer.parseInt(user.getUserId()));
			        	  imu.uploadImage(df.format(dateobj).toString(),albumId,picFileName);
			          
			          /*else
			          {
			        	  UserImageUploadDAO imu=new UserImageUploadDAOImpl();
			        	  int albumId=imu.getAlbumId("timeline",Integer.parseInt(friendId));
			        	  imu.uploadImage(df.format(dateobj).toString(),albumId,picFileName);
			          }*/
			          
			        } catch (IOException e) {
			          System.out.println("error occurred");
			          e.printStackTrace();
			          return ERROR;
			        }
				}

			}
			
		//	up.postOnWall(postDesc, user.getUserId(),user_id,  df.format(dateobj).toString(),nf.getFullUserName(friendId)+" status Update","timeline",youtubeLink,picFileName);
		//}
		addActionMessage("Content has been posted successfully.");
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		response.sendRedirect(StringUtils.hostname+"/FacebookDemo/userNewsFeedAction?user_id="+user_id);
		return "success";
	}
	
	public String updatePrivacySetting(){
		UserPostDAOImpl up=new UserPostDAOImpl();
		up.updatePrivacySetting(privacyName, postId);
		return "success";
	}
	public String updateAlbumPrivacySetting(){
		UserPostDAOImpl up=new UserPostDAOImpl();
		up.updateAlbumPrivacySetting(privacyName, postId);
		return "success";
	}
	public String updateAllPrivacySetting(){
		UserPostDAOImpl up=new UserPostDAOImpl();
		up.updateAllPrivacySetting(privacyName, postId);
		return "success";
	}
	public String likeCount(){
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User user=(User)session.getAttribute("user");
		UserPostDAOImpl upimpl=new UserPostDAOImpl();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	Date dateobj = new Date();
		if(upimpl.increaseLike(postId, user.getUserId(), df.format(dateobj),liketype)){
			setPcount(new NewsFeedDAOImpl().getPostLikeCount(postId));
			User u1=upimpl.getPostUserId(postId);
			NewsFeedDAOImpl nf=new NewsFeedDAOImpl();
			AllNotificationAction aln=new AllNotificationAction();
			if(user.getUserId().equalsIgnoreCase(u1.getUserId())){
				
			}else
				aln.addNotification("like", user.getUserId(), u1.getUserId(), nf.getFullUserName(user.getUserId())+" has liked your post", "userNewsFeedAction?user_id="+u1.getUserId(), df.format(dateobj));
			return "success";
		}else{
			setPcount(new NewsFeedDAOImpl().getPostLikeCount(postId));
			return "error";
		}		
	}
	public String addComment(){
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User user=(User)session.getAttribute("user");
		UserPostDAOImpl upimpl=new UserPostDAOImpl();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	Date dateobj = new Date();
    	System.out.println("Add Comment==>"+postId+" "+comment);
		if(upimpl.addComment(postId, user.getUserId(), df.format(dateobj),comment)){
			User u1=upimpl.getPostUserId(postId);
			NewsFeedDAOImpl nf=new NewsFeedDAOImpl();
			AllNotificationAction aln=new AllNotificationAction();
			if(user.getUserId().equalsIgnoreCase(u1.getUserId())){
				
			}else
				aln.addNotification("comment", user.getUserId(), u1.getUserId(), nf.getFullUserName(user.getUserId())+" has commented your post", "userNewsFeedAction?user_id="+u1.getUserId(), df.format(dateobj));
		
			return "success";
		}else{
			return "error";
		}	
	}
	public String deletePost(){
		UserPostDAOImpl updo=new UserPostDAOImpl();
		if(updo.deletePost(postId))
			return "success";
		else
			return "error";
	}
	
	public String deleteComment(){
		UserPostDAOImpl updo=new UserPostDAOImpl();
		if(updo.deleteComment(commentId))
			return "success";
		else
			return "error";
	}
	
	public String editPost(){
		UserPostDAOImpl upd=new UserPostDAOImpl();
		if(upd.updatePost(postId, comment)){
			return "success";
		}else{
			return "error";
		}
	}
	public String editComment(){
		UserPostDAOImpl upd=new UserPostDAOImpl();
		if(upd.updateComment(commentId, comment)){
			return "success";
		}else{
			return "error";
		}
	}
	public String getAllPeople(){
		NewsFeedDAOImpl nfd=new NewsFeedDAOImpl();
		System.out.println(postId);
		if(queryType!=null && queryType.equalsIgnoreCase("like"))
			setLikeList(nfd.getAllPostLike(postId));
		else{
			ArrayList<Comment> al=nfd.getAllPostComment(postId);
			al=getUniqueName(al);
			setCommentList(al);
		}			
		
		return "success";
	}
	public ArrayList<Comment>  getUniqueName(ArrayList<Comment> al){
		HashMap<String,Integer> unique=new HashMap<String, Integer>();
		ArrayList<Comment> temp=new ArrayList<Comment>();
		if(al!=null)
			for(int i=0;i<al.size();i++){
				Comment c=al.get(i);
				if(unique.containsKey(c.getUserId())){
					
				}else{
					unique.put(c.getUserId(), 0);
					temp.add(c);
				}
			}
		return temp;
	}
}
