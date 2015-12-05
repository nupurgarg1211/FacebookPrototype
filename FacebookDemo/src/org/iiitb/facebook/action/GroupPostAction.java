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
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.iiitb.facebook.dao.GroupDAO;
import org.iiitb.facebook.dao.GroupPostDAO;
import org.iiitb.facebook.dao.LoginDAO;
import org.iiitb.facebook.dao.NewsFeedDAO;
import org.iiitb.facebook.dao.UserImageUploadDAO;
import org.iiitb.facebook.dao.UserPostDAO;
import org.iiitb.facebook.dao.impl.GroupDAOImpl;
import org.iiitb.facebook.dao.impl.GroupNewsFeedDAOImpl;
import org.iiitb.facebook.dao.impl.GroupPostDAOImpl;
import org.iiitb.facebook.dao.impl.LoginDAOimpl;
import org.iiitb.facebook.dao.impl.NewsFeedDAOImpl;
import org.iiitb.facebook.dao.impl.UserImageUploadDAOImpl;
import org.iiitb.facebook.dao.impl.UserPostDAOImpl;
import org.iiitb.facebook.model.Comment;
import org.iiitb.facebook.model.Group;
import org.iiitb.facebook.model.Like;
import org.iiitb.facebook.model.Post;
import org.iiitb.facebook.model.User;
import org.iiitb.facebook.util.StringUtils;

import com.mongodb.util.Hash;
import com.opensymphony.xwork2.ActionSupport;

public class GroupPostAction extends ActionSupport{
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
	private String group_id;
	
	//change
	private ArrayList<Group> grpList;
	private Group groupDetail;
	private String groupId;
	public ArrayList<Post> feedList;
	private ArrayList<User> grpMemberList;

	
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

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
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
	public String getGroup_id() {
		return group_id;
	}

	public void setGroup_id(String group_id) {
		this.group_id = group_id;
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

	public String groupPostOnWall(){
		int i=0;
		System.out.println("group_id in post "+group_id);
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
		//UserPostDAO up=new UserPostDAOImpl();
    	GroupPostDAO up = new GroupPostDAOImpl();
		String destpath="";
		if (picFileName != null) {
                 Random randomGenerator = new Random();
				 Integer randomInt = randomGenerator.nextInt(1000000);
				 picFileName=randomInt.toString()+imageExtension;
	         destpath= StringUtils.groupPhotoPath+File.separator+group_id+"_timeline";
	        System.out.println("Server path:" + destpath);
	        File destFile = new File(destpath, picFileName);
	        try {
	          FileUtils.copyFile(pic, destFile);
	          	  UserImageUploadDAO imu=new UserImageUploadDAOImpl();
	        	  int albumId=imu.getAlbumId("timeline",Integer.parseInt(group_id));
	        	  imu.uploadImage(df.format(dateobj).toString(),albumId,picFileName);
	         	          
	        } catch (IOException e) {
	          System.out.println("error occurred");
	          e.printStackTrace();
	          return ERROR;
	        }
		}
		//NewsFeedDAOImpl nf=new NewsFeedDAOImpl();
		up.postOnWall(postDesc, user.getUserId(), group_id,  df.format(dateobj).toString(),user.getFirstName()+" "+user.getLastName()+" Group Post","timeline",youtubeLink,picFileName);
		System.out.println("success");
		getGroupDetail(group_id);
		/*if(friendId==null || friendId==""){
			up.postOnWall(postDesc, user.getUserId(), group_id,  df.format(dateobj).toString(),user.getFirstName()+" "+user.getLastName()+" Status Update","timeline",youtubeLink,picFileName);
		}else{
			NewsFeedDAOImpl nfd=new NewsFeedDAOImpl();
			String userName=nfd.getFullUserName(friendId);
			
			up.postOnWall(postDesc, user.getUserId(),group_id,  df.format(dateobj).toString(),nf.getFullUserName(friendId)+" status Update","timeline",youtubeLink,picFileName);
		}*/
		
		GroupDAO grp = new GroupDAOImpl();
		ArrayList<User> grpMembers = new ArrayList<User>();
		Group gr = new Group();
		grpMembers = grp.getGroupMembers(group_id);
		gr = grp.getGroupDetails(group_id,Integer.parseInt(user.getUserId()));
		AllNotificationAction aln=new AllNotificationAction();
		NewsFeedDAOImpl nf=new NewsFeedDAOImpl();
		System.out.println("group members for notification send"+grpMembers.size());
		while(i<grpMembers.size())
		{
			if(user.getUserId().equalsIgnoreCase(grpMembers.get(i).getUserId())){
				
			}
			else{
			aln.addNotification("post",user.getUserId(),grpMembers.get(i).getUserId(), nf.getFullUserName(user.getUserId())+" has posted in group "+gr.getGroup_name(), "getGroupDetailAction.action?group_id="+group_id, df.format(dateobj));
			}
			i++;
		}
		addActionMessage("Content has been posted successfully.");
		return "success";
	}
	
	
	public String groupLikeCount(){
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User user=(User)session.getAttribute("user");
		GroupPostDAOImpl upimpl=new GroupPostDAOImpl();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	Date dateobj = new Date();
		if(upimpl.increaseLike(postId, user.getUserId(), df.format(dateobj),liketype)){
			setPcount(new GroupNewsFeedDAOImpl().getPostLikeCount(postId));
			getGroupDetail(group_id);
			GroupPostDAOImpl upimpl1=new GroupPostDAOImpl();
			User u1=upimpl1.getPostUserId(postId);
			NewsFeedDAOImpl nf=new NewsFeedDAOImpl();
			AllNotificationAction aln=new AllNotificationAction();
			if(user.getUserId().equalsIgnoreCase(u1.getUserId())){
				
			}else
				aln.addNotification("like", user.getUserId(), u1.getUserId(), nf.getFullUserName(user.getUserId())+" has liked your post", "userNewsFeedAction?user_id="+user.getUserId(), df.format(dateobj));
		
			return "success";
		}else{
			setPcount(new GroupNewsFeedDAOImpl().getPostLikeCount(postId));
			getGroupDetail(group_id);
			return "error";
		}	
	}
	
	public String groupAddComment(){
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User user=(User)session.getAttribute("user");
		GroupPostDAOImpl upimpl=new GroupPostDAOImpl();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	Date dateobj = new Date();
    	System.out.println("Add Comment==>"+postId+" "+comment);
		if(upimpl.addComment(postId, user.getUserId(), df.format(dateobj),comment)){
			getGroupDetail(group_id);
			GroupPostDAOImpl upimpl1=new GroupPostDAOImpl();
			User u1=upimpl1.getPostUserId(postId);
			NewsFeedDAOImpl nf=new NewsFeedDAOImpl();
			AllNotificationAction aln=new AllNotificationAction();
			if(user.getUserId().equalsIgnoreCase(u1.getUserId())){
				
			}else
				aln.addNotification("comment", user.getUserId(), u1.getUserId(), nf.getFullUserName(user.getUserId())+" has commented your post", "userNewsFeedAction?user_id="+user.getUserId(), df.format(dateobj));
		
			return "success";
		}else{
			getGroupDetail(group_id);
			return "error";
		}	
	}
	public String groupDeletePost(){
		GroupPostDAOImpl updo=new GroupPostDAOImpl();
		if(updo.deletePost(postId))
		{
			getGroupDetail(group_id);
			return "success";
		}
		else
		{
			getGroupDetail(group_id);
			return "error";
		}
	}
	
	public String groupDeleteComment(){
		GroupPostDAOImpl updo=new GroupPostDAOImpl();
		if(updo.deleteComment(commentId))
		{
			getGroupDetail(group_id);
			return "success";
		}
		else
		{
			getGroupDetail(group_id);
			return "error";
		}
	}
	
	public String groupEditPost(){
		GroupPostDAOImpl upd=new GroupPostDAOImpl();
		if(upd.updatePost(postId, comment)){
			getGroupDetail(group_id);
			return "success";
		}else{
			getGroupDetail(group_id);
			return "error";
		}
	}
	
	public String groupEditComment(){
		GroupPostDAOImpl upd=new GroupPostDAOImpl();
		if(upd.updateComment(commentId, comment)){
			getGroupDetail(group_id);
			return "success";
		}else{
			getGroupDetail(group_id);
			return "error";
		}
	}
	
	public String groupGetAllPeople(){
		GroupNewsFeedDAOImpl nfd=new GroupNewsFeedDAOImpl();
		System.out.println("post iid..........................."+postId);
		if(queryType!=null && queryType.equalsIgnoreCase("like")){
			setLikeList(nfd.getAllPostLike(postId));
			getGroupDetail(group_id);
		}
		else{
			ArrayList<Comment> al=nfd.getAllPostComment(postId);
			al=groupGetUniqueName(al);
			setCommentList(al);
			getGroupDetail(group_id);
		}			
		
		return "success";
	}
	
	public ArrayList<Comment>  groupGetUniqueName(ArrayList<Comment> al){
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
	public String getGroupDetail(String group_id)
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
		HttpServletRequest request=ServletActionContext.getRequest();
		request.setAttribute("groupDetail",groupDetail);
		request.setAttribute("grpList",grpList);
		request.setAttribute("groupDetail",groupDetail);
		return "success";
		
	}
}
