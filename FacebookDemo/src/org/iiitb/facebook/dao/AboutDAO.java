package org.iiitb.facebook.dao;

import java.util.ArrayList;


import org.iiitb.facebook.model.About;
import org.iiitb.facebook.model.Education;
import org.iiitb.facebook.model.Relationship;
import org.iiitb.facebook.model.Work;
import org.iiitb.facebook.model.WorkEducation;

public interface AboutDAO
{
	public ArrayList<Relationship> getRelations();
	public About about_details(String user_id);
	public ArrayList<Work> work_details(String user_id);
	public ArrayList<Education> education_details(String user_id);
	public void update_about_details(String user_id, String first_name, String last_name, String gender,String dob, String mobile,String current_city,String hometown,String address,String relatioship);
	public void update_we_details(String we_id, String organization, String position, String start_date,String end_date);
	public WorkEducation get_we_details(String we_id);
	public boolean addWorkEducation(String userId,String type,String organization,String position,String start_date,String end_date);
	public boolean deleteWorkEducation(String we_id);
}
