package org.iiitb.facebook.dao;
import java.sql.SQLException;
import java.util.ArrayList;

import org.iiitb.facebook.model.Group;
import org.iiitb.facebook.model.User;

public interface GroupDAO {
	public ArrayList<User> getUserForGroup(int user_id);

	public int insertGroupDetails(int user_id, String grpName, String grpMembers, String icon) throws SQLException;

	public ArrayList<Group> getAllGroups(int user_id);

	public void leaveGroup(int user_id, int grp_id) throws Exception;

	public Object joinGroupAgain(int i, int grp_id);
	
	public Group getGroupDetails(String group_id,int user_id);

	public ArrayList<User> getGroupMembers(String group_id);

	public int addMemberToGroup(String group_id, String grpMembers);

	public ArrayList<User> getUserToAddForGroup(int parseInt, String group_id);

	/*public int changeCoverPic(String group_id, String pic);*/

/*	
	public String checkGroupAdmin(int user_id, int grp_id);*/

}
