package org.iiitb.facebook.model;

public class Education 
{
	String we_id;
	String user_id;
	String institution_name;
	String studied;
	String start_date;
	String end_date;
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getWe_id() {
		return we_id;
	}
	public void setWe_id(String we_id) {
		this.we_id = we_id;
	}
	public String getInstitution_name() {
		return institution_name;
	}
	public void setInstitution_name(String institution_name) {
		this.institution_name = institution_name;
	}
	public String getStudied() {
		return studied;
	}
	public void setStudied(String studied) {
		this.studied = studied;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	
}
