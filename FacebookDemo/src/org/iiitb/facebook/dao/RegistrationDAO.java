package org.iiitb.facebook.dao;

public interface RegistrationDAO {

	public boolean createuser(String email,String firstName,String lastName,String dob,String gender,String pass,String create_date);
	public boolean verifyUser(String email);
	public boolean updatePassword(String email,String password);
	public String getUser(String email);
}
