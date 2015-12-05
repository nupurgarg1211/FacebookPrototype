package org.iiitb.facebook.dao;

import java.io.InputStream;

import org.iiitb.facebook.model.User;



public interface LoginDAO {

	public User isValidUser(String email,String pass);
	public boolean updateLogoutTime(String userId,String date);
	public InputStream displayphoto(String userId);
}
