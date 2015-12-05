package org.iiitb.facebook.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.iiitb.facebook.dao.FriendsDAO;
import org.iiitb.facebook.dao.MessageDAO;
import org.iiitb.facebook.dao.impl.FriendsDAOImpl;
import org.iiitb.facebook.dao.impl.MessageDAOImpl;
import org.iiitb.facebook.dao.impl.UserImageUploadDAOImpl;
//import org.iiitb.facebook.dao.impl.NotificationDAOImpl;
import org.iiitb.facebook.model.UserDhruvik;
import org.iiitb.facebook.model.User;
import org.iiitb.facebook.util.StringUtils;

import com.opensymphony.xwork2.ActionSupport;


public class DisplayAllFriendsAction {
	
	List<UserDhruvik> userData = new ArrayList<UserDhruvik>();
	String LastLogin = "";
	public String friendid; 
	public String user_id;
	UserDhruvik user;
	public int show;
	public int check_if;
	String checkFriend;
	private String uid1;
	private String uid2;
	private String message;
	private String checkNoFriend;
//	private String remove_friend;
	private String add_friend;
	private String pending_friend;
	private String to;
	private String full_name;
	private String profile_pic;
	private String cover_pic;
	String tempUserId;
	private String isFriend;
	private boolean isFromNotification;
	public String suggestid;
	
	public String getSuggestid() {
		return suggestid;
	}
	public void setSuggestid(String suggestid) {
		this.suggestid = suggestid;
	}
	public String getIsFriend() {
		return isFriend;
	}
	public void setIsFriend(String isFriend) {
		this.isFriend = isFriend;
	}
	public String getTempUserId() {
		return tempUserId;
	}

	public void setTempUserId(String tempUserId) {
		this.tempUserId = tempUserId;
	}
	public String getFull_name() {
		return full_name;
	}
	public void setFull_name(String full_name) {
		this.full_name = full_name;
	}
	public String getProfile_pic() {
		return profile_pic;
	}
	public void setProfile_pic(String profile_pic) {
		this.profile_pic = profile_pic;
	}
	public String getCover_pic() {
		return cover_pic;
	}
	public void setCover_pic(String cover_pic) {
		this.cover_pic = cover_pic;
	}
	
	public int isShow() {
		return show;
	}

	public void setShow(int show) {
		this.show = show;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String rejectFriendRequests(){
		setIsFromNotification(true);
		rejectFriends();
		setIsFromNotification(false);
		return "success";
	}
	
	public String acceptFriendRequests(){
		setIsFromNotification(true);
		acceptFriends();
		setIsFromNotification(false);
		return "success";
	}
	
	
	public String getsuggestFriends()
	{
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User u=(User)session.getAttribute("user");
		
		HttpServletRequest request=ServletActionContext.getRequest();
		FriendsDAO fetchfriends = new FriendsDAOImpl();
		ArrayList<UserDhruvik> al= fetchfriends.getAllFriendsSuggestion(u.getUserId(),user_id);
		
		setUserData(al);
		request.setAttribute("usersuggestData", al);
		TimelineHeaderAction tha = new TimelineHeaderAction();
		setFull_name(tha.getFullName(user_id));
		setIsFriend(tha.checkFriend(u.getUserId(), user_id));
		setProfile_pic(tha.getProfilePic(user_id));
		setCover_pic(tha.getCoverPic(user_id));
		return "success";
		
	}
	
	public void suggestFriends()
	{
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		HttpServletResponse response=ServletActionContext.getResponse();
		User u=(User)session.getAttribute("user");
		
		FriendsDAO fd=new FriendsDAOImpl();
		
//		boolean f=fd.acceptFriend(u.getUserid(), Integer.parseInt(pending_friend));
		boolean f=fd.suggestFriend(u.getUserId(),user_id,suggestid);
		//return "success";
		System.out.println("in suggest friendaction user_id="+user_id);
		System.out.println("suggestid is"+suggestid);
		
		/*TimelineHeaderAction tha = new TimelineHeaderAction();
		setFull_name(tha.getFullName(user_id));
		setIsFriend(tha.checkFriend(u.getUserId(), user_id));
		setProfile_pic(tha.getProfilePic(user_id));
		setCover_pic(tha.getCoverPic(user_id));*/
		
		
		try {
			if(!getIsFromNotification()){
				response.sendRedirect(StringUtils.hostname+"/FacebookDemo/getSuggestFriend?user_id="+user_id);
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//return "success";
	}
	
	public String getsearchedFriends()
	{
		System.out.println("value11 of to="+to);
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User u=(User)session.getAttribute("user");
		MessageDAO m = new MessageDAOImpl();
		List<UserDhruvik> al=m.getFriends(u.getUserId(),getTo());
		setUserData(al);
		for(int i=0;i<userData.size();i++)
		{
			
			System.out.println("here"+userData.get(i).getFirst_name());
		}
		System.out.println("out of for");
		return "success";
	}
	
	public String populateFriends(){
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User u=(User)session.getAttribute("user");
		show=1;
		check_if=0;
		setShow(show);
		System.out.println("value of show before is"+show);
		HttpServletRequest request=ServletActionContext.getRequest();
//		System.out.println("ans :"+u.getUserId());
		FriendsDAO fetchfriends = new FriendsDAOImpl();
		ArrayList<UserDhruvik> al;
		setTempUserId(u.getUserId());
		System.out.println("in popfrd u.getuid="+u.getUserId());
		System.out.println("and user_id="+user_id);
		if(user_id==null)
		{
			al=fetchfriends.getAllFriends(u.getUserId());
			check_if=1;
		}
		else
		{
			al=fetchfriends.getAllFriends(user_id);
		}
		setUserData(al);
		request.setAttribute("userData", al);
		request.setAttribute("tempUserId", tempUserId);
		System.out.println("user_id is "+user_id);
		System.out.println("sesson valu is"+u.getUserId());
		if(check_if==0)
		{
			if(!(user_id.equals(u.getUserId())))
			{
				show=0;			
			}
		}
		setShow(show);
		System.out.println("value of show after is "+show);
		request.setAttribute("show", show);
		populatePendingFriends();
		
		
		
		TimelineHeaderAction tha = new TimelineHeaderAction();
		setFull_name(tha.getFullName(user_id));
		setIsFriend(tha.checkFriend(u.getUserId(), user_id));
		setProfile_pic(tha.getProfilePic(user_id));
		setCover_pic(tha.getCoverPic(user_id));
//		setLastLogin(fetchfriends.getLastLogin(u.getUserId()));
		return "success";
	}
	
	public String populatePendingFriends(){
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User u=(User)session.getAttribute("user");
		
		HttpServletRequest request=ServletActionContext.getRequest();
//		System.out.println("ans :"+u.getUserId());
		FriendsDAO fetchfriends = new FriendsDAOImpl();
		ArrayList<UserDhruvik> al=fetchfriends.getAllPendingFriends(u.getUserId());
		setUserData(al);
		request.setAttribute("userpendingData", al);
//		setLastLogin(fetchfriends.getLastLogin(u.getUserId()));
		return "success";
	}

	public void removeFriends(){
	//	System.out.println(uid1+" "+uid2);
	//	System.out.println("remove friend");
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		HttpServletResponse response=ServletActionContext.getResponse();
		User u1=(User)session.getAttribute("user");
		UserDhruvik u=new UserDhruvik();
		FriendsDAO fd=new FriendsDAOImpl();
		System.out.println("remove friend1");

		
//		boolean f=fd.removeFriend(u.getUserid(), Integer.parseInt(friendid));
		boolean f=fd.removeFriend(Integer.parseInt(u1.getUserId()), Integer.parseInt(friendid));
		System.out.println("remove friend12");
//		friendid=uid2;
	//return "success";
		try {
			response.sendRedirect(StringUtils.hostname+"/FacebookDemo/getAllFriends?user_id="+u1.getUserId());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	public String populateNonFriends(){
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User u=(User)session.getAttribute("user");
		
		HttpServletRequest request=ServletActionContext.getRequest();
//		System.out.println("ans :"+u.getUserId());
		FriendsDAO fetchfriends = new FriendsDAOImpl();
		ArrayList<UserDhruvik> al=fetchfriends.getNonFriends(u.getUserId());
		setUserData(al);
		request.setAttribute("userData", al);
//		setLastLogin(fetchfriends.getLastLogin(u.getUserId()));
		return "success";
	}
	
	public String addFriends(){
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User u=(User)session.getAttribute("user");
		FriendsDAO fd=new FriendsDAOImpl();
		
	//	boolean f=fd.addFriend(u.getUserid(), Integer.parseInt(friendid));
		boolean f=fd.addFriend(Integer.parseInt(u.getUserId()), Integer.parseInt(friendid));
		//friendid=uid2;

		return "success";
	}
	
	public void acceptFriends(){
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		HttpServletResponse response=ServletActionContext.getResponse();
		User u=(User)session.getAttribute("user");
		
		FriendsDAO fd=new FriendsDAOImpl();
		
//		boolean f=fd.acceptFriend(u.getUserid(), Integer.parseInt(pending_friend));
		boolean f=fd.acceptFriend(Integer.parseInt(u.getUserId()), Integer.parseInt(pending_friend));
		//return "success";
		try {
			if(!getIsFromNotification()){
				response.sendRedirect(StringUtils.hostname+"/FacebookDemo/getAllFriends?user_id="+u.getUserId());
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void rejectFriends(){
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		HttpServletResponse response=ServletActionContext.getResponse();
		User u=(User)session.getAttribute("user");
		
		FriendsDAO fd=new FriendsDAOImpl();
		
//		boolean f=fd.rejectFriend(u.getUserid(), Integer.parseInt(pending_friend));
		boolean f=fd.rejectFriend(Integer.parseInt(u.getUserId()), Integer.parseInt(pending_friend));
		//return "success";
		try {
			if(!getIsFromNotification()){
				response.sendRedirect(StringUtils.hostname+"/FacebookDemo/getAllFriends?user_id="+u.getUserId());
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public List<UserDhruvik> getUserData() {
		return userData;
	}

	public void setUserData(List<UserDhruvik> userData) {
		this.userData = userData;
	}

	public String getLastLogin() {
		return LastLogin;
	}

	public void setLastLogin(String lastLogin) {
		LastLogin = lastLogin;
	}

	public String getFriendid() {
		return friendid;
	}

	public void setFriendid(String friendid) {
		this.friendid = friendid;
	}

	public UserDhruvik getUser() {
		return user;
	}

	public void setUser(UserDhruvik user) {
		this.user = user;
	}

	public String getCheckFriend() {
		return checkFriend;
	}
	public String getTo() {
		return to;
	}

	public void setTo(String to) {
		this.to = to;
	}

	public void setCheckFriend(String checkFriend) {
		this.checkFriend = checkFriend;
	}

	public String getUid1() {
		return uid1;
	}

	public void setUid1(String uid1) {
		this.uid1 = uid1;
	}

	public String getUid2() {
		return uid2;
	}

	public void setUid2(String uid2) {
		this.uid2 = uid2;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getCheckNoFriend() {
		return checkNoFriend;
	}

	public void setCheckNoFriend(String checkNoFriend) {
		this.checkNoFriend = checkNoFriend;
	}

	/*public String getRemove_friend() {
		return remove_friend;
	}

	public void setRemove_friend(String remove_friend) {
		this.remove_friend = remove_friend;
	}*/

	public String getAdd_friend() {
		return add_friend;
	}

	public void setAdd_friend(String add_friend) {
		this.add_friend = add_friend;
	}

	public String getPending_friend() {
		return pending_friend;
	}

	public void setPending_friend(String pending_friend) {
		this.pending_friend = pending_friend;
	}
	public boolean getIsFromNotification() {
		return isFromNotification;
	}
	public void setIsFromNotification(boolean isFromNotification) {
		this.isFromNotification = isFromNotification;
	}

}
