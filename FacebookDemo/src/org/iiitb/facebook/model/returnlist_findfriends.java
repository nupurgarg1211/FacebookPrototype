package org.iiitb.facebook.model;

import java.util.ArrayList;

public class returnlist_findfriends {
	private String user_id;
	private String first_name;
	private String last_name;
	private String profile_pic;
	private Integer no_of_mutualfriends;
	private ArrayList<String> mutualfriends_first_name = new ArrayList<String>();
	private ArrayList<String> mutualfriends_last_name = new ArrayList<String>();
	private ArrayList<String> mutualfriends_user_id = new ArrayList<String>();
	private ArrayList<String> mutualfriends_profile_pic = new ArrayList<String>();
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getFirst_name() {
		return first_name;
	}
	public void setFirst_name(String first_name) {
		this.first_name = first_name;
	}
	public String getLast_name() {
		return last_name;
	}
	public void setLast_name(String last_name) {
		this.last_name = last_name;
	}
	
	public ArrayList<String> getMutualfriends_user_id() {
		return mutualfriends_user_id;
	}
	public void setMutualfriends_user_id(ArrayList<String> mutualfriends_user_id) {
		this.mutualfriends_user_id = mutualfriends_user_id;
	}
	public Integer getNo_of_mutualfriends() {
		return no_of_mutualfriends;
	}
	public void setNo_of_mutualfriends(Integer no_of_mutualfriends) {
		this.no_of_mutualfriends = no_of_mutualfriends;
	}

	//constructor
	public returnlist_findfriends(String user_id,String first_name,String last_name,String profile_pic,Integer no_of_mutualfriends,ArrayList<String> mutualfriends_first_name,ArrayList<String> mutualfriends_last_name,ArrayList<String> mutualfriends_user_id,ArrayList<String> mutualfriends_profile_pic){
		this.user_id = user_id;
		this.first_name = first_name;
		this.last_name = last_name;
		this.no_of_mutualfriends = no_of_mutualfriends;
		this.mutualfriends_user_id = mutualfriends_user_id;
		this.mutualfriends_first_name = mutualfriends_first_name;
		this.mutualfriends_last_name = mutualfriends_last_name;
		this.profile_pic = profile_pic;
		this.mutualfriends_profile_pic = mutualfriends_profile_pic;
	}
	public ArrayList<String> getMutualfriends_first_name() {
		return mutualfriends_first_name;
	}
	public void setMutualfriends_first_name(ArrayList<String> mutualfriends_first_name) {
		this.mutualfriends_first_name = mutualfriends_first_name;
	}
	public ArrayList<String> getMutualfriends_last_name() {
		return mutualfriends_last_name;
	}
	public void setMutualfriends_last_name(ArrayList<String> mutualfriends_last_name) {
		this.mutualfriends_last_name = mutualfriends_last_name;
	}
	public String getProfile_pic() {
		return profile_pic;
	}
	public void setProfile_pic(String profile_pic) {
		this.profile_pic = profile_pic;
	}
	public ArrayList<String> getMutualfriends_profile_pic() {
		return mutualfriends_profile_pic;
	}
	public void setMutualfriends_profile_pic(
			ArrayList<String> mutualfriends_profile_pic) {
		this.mutualfriends_profile_pic = mutualfriends_profile_pic;
	}
	
}
