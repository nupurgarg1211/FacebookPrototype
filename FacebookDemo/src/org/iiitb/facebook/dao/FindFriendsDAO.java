package org.iiitb.facebook.dao;

import java.util.ArrayList;
import java.sql.Connection;
import java.util.List;

import org.iiitb.facebook.model.returnlist_findfriends;

public interface FindFriendsDAO {
	public ArrayList<returnlist_findfriends> getAllFriends(int user_id);

}
