package org.iiitb.facebook.action;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.iiitb.facebook.dao.GroupDAO;
import org.iiitb.facebook.dao.NewsFeedDAO;
import org.iiitb.facebook.dao.impl.GroupDAOImpl;
import org.iiitb.facebook.dao.impl.NewsFeedDAOImpl;
import org.iiitb.facebook.model.Group;
import org.iiitb.facebook.model.Post;
import org.iiitb.facebook.model.User;
import org.iiitb.facebook.util.ConnectionPool;

public class GroupAction {
	
	private String grpName;
	private String grpMembers;
	private String icon;
	private ArrayList<User> grpUserList;
	private String group_id;
	private ArrayList<Group> grpList;
	private Group groupDetail;
	private String groupId;
	public ArrayList<Post> feedList;
	private ArrayList<User> grpMemberList;
	private String display_members;
	private String pic;
	private int album_id;
	private ArrayList<User> grpAddUserList;
	public ArrayList<Post> getFeedList() {
		return feedList;
	}
	public void setFeedList(ArrayList<Post> feedList) {
		this.feedList = feedList;
	}	
	
	public Group getgroupDetail() {
		return groupDetail;
	}
	public void setgroupDetail(Group groupDetail) {
		this.groupDetail = groupDetail;
	}
	public String getFriends()
	{
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User u=(User)session.getAttribute("user");
		GroupDAO grp = new GroupDAOImpl();
		setGrpUserList(grp.getUserForGroup(Integer.parseInt(u.getUserId())));
		/*for(int i=0;i<grpUserList.size();i++)
		{
			System.out.println(grpUserList.get(i).getFirst_name());
		}*/
		return "success";
	}
	public String execute() throws NamingException, SQLException
	{
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User u=(User)session.getAttribute("user");
		GroupDAO grp = new GroupDAOImpl();
		System.out.println("icon "+icon);
		setGroup_id(String.valueOf(grp.insertGroupDetails(Integer.parseInt(u.getUserId()),grpName,grpMembers,icon)));
		GroupDAO grp1 = new GroupDAOImpl();
		setGrpList(grp1.getAllGroups(Integer.parseInt(u.getUserId())));
		System.out.println("after creation group id"+group_id);
		return "success";
	}
	
	public String leaveGroup() throws Exception
	{
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User u=(User)session.getAttribute("user");
		GroupDAO grp = new GroupDAOImpl();
		int grp_id = Integer.parseInt(group_id);
		grp.leaveGroup(Integer.parseInt(u.getUserId()),grp_id);
		System.out.println("coming back"+grp_id);
		return "success";
	}
	
	public String joinGroupAgain()
	{
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User u=(User)session.getAttribute("user");
		GroupDAO grp = new GroupDAOImpl();
		int grp_id = Integer.parseInt(group_id);
		grp.joinGroupAgain(Integer.parseInt(u.getUserId()),grp_id);
		return "success";
	}
	
	
	public String getAllGroups()
	{
		System.out.println("groups");
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User u=(User)session.getAttribute("user");
		GroupDAO grp = new GroupDAOImpl();
		setGrpList(grp.getAllGroups(Integer.parseInt(u.getUserId())));
		int i=0;
		while(i<grpList.size())
		{
			System.out.println(grpList.get(i).getGroup_id());
			i++;
		}
		//HttpServletRequest request=ServletActionContext.getRequest();
		//request.setAttribute("grpList",grpList);
		return "success";
	}
	
	
	public String getGroupDetail()
	{
		GroupDAO grp = new GroupDAOImpl();
		System.out.println("group_id     "+group_id);
		setgroupDetail(null);
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User u=(User)session.getAttribute("user");
		if(!(group_id == null))
		{
			setgroupDetail(grp.getGroupDetails(group_id, Integer.parseInt(u.getUserId())));
			System.out.println("group id"+groupDetail.getGroup_id());
			System.out.println("group name"+groupDetail.getGroup_name());
		}
		NewsFeedAction n=new NewsFeedAction();
		setGrpList(grp.getAllGroups(Integer.parseInt(u.getUserId())));
	setFeedList(n.getGroupNewsFeed(group_id));
		HttpServletRequest request=ServletActionContext.getRequest();
		request.setAttribute("groupDetail",groupDetail);
		request.setAttribute("grpList",grpList);
		request.setAttribute("groupDetail",groupDetail);
		return "success";
		
	}
	
	
	public String getGroupMembers()
	{
		System.out.println("group_id"+group_id);
	if(group_id!=null)
		{
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User u=(User)session.getAttribute("user");
		GroupDAO grp = new GroupDAOImpl();
		setGrpMemberList(grp.getGroupMembers(group_id));
		setDisplay_members("True");
		getGroupDetail();
		int i=0;
		System.out.println("group members");
		while(i<grpMemberList.size())
		{
			System.out.println("member"+grpMemberList.get(i).getFirstName());
			i++;
		}
		}
		return "success";
	}
	public String addMemberToGroup()
	{
		System.out.println("add member to group...............................");
		System.out.println("add member to group .......group_id::::::::::::::::"+group_id);
		GroupDAO grp = new GroupDAOImpl();
		setAlbum_id(grp.addMemberToGroup(group_id,grpMembers));
		getGroupDetail();
		return "success";
	}
	
	public String searchToAddMember()
	{
		System.out.println("search to add member  group_id"+group_id);
		HttpSession session=ServletActionContext.getRequest().getSession(false);
		User u=(User)session.getAttribute("user");
		GroupDAO grp = new GroupDAOImpl();
		setGrpAddUserList(grp.getUserToAddForGroup(Integer.parseInt(u.getUserId()),group_id));
		System.out.println("friends");
		for(int i=0;i<grpAddUserList.size();i++)
		{
			System.out.println(grpAddUserList.get(i).getFirstName());
		}
		return "success";
		
	}
	
	public String getGrpName() {
		return grpName;
	}
	public void setGrpName(String grpName) {
		this.grpName = grpName;
	}
	public String getGrpMembers() {
		return grpMembers;
	}
	public void setGrpMembers(String grpMembers) {
		this.grpMembers = grpMembers;
	}
	public ArrayList<User> getGrpUserList() {
		return grpUserList;
	}

	public void setGrpUserList(ArrayList<User> grpUserList) {
		this.grpUserList = grpUserList;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public String getGroup_id() {
		return group_id;
	}
	public void setGroup_id(String group_id) {
		this.group_id = group_id;
	}
	/*public String getIsAdmin() {
		return isAdmin;
	}
	public void setIsAdmin(String isAdmin) {
		this.isAdmin = isAdmin;
	}  */
	
	public ArrayList<Group> getGrpList() {
		return grpList;
	}

	public void setGrpList(ArrayList<Group> grpList) {
		this.grpList = grpList;
	}
	public String getGroupId() {
		return groupId;
	}
	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}
	public ArrayList<User> getGrpMemberList() {
		return grpMemberList;
	}
	public void setGrpMemberList(ArrayList<User> grpMemberList) {
		this.grpMemberList = grpMemberList;
	}
	public String getDisplay_members() {
		return display_members;
	}
	public void setDisplay_members(String display_members) {
		this.display_members = display_members;
	}
	public String getPic() {
		return pic;
	}
	public void setPic(String pic) {
		this.pic = pic;
	}
	public int getAlbum_id() {
		return album_id;
	}
	public void setAlbum_id(int album_id) {
		this.album_id = album_id;
	}
	public ArrayList<User> getGrpAddUserList() {
		return grpAddUserList;
	}
	public void setGrpAddUserList(ArrayList<User> grpAddUserList) {
		this.grpAddUserList = grpAddUserList;
	}

}
